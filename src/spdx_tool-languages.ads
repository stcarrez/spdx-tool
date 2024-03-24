-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Files.Filters;
with SPDX_Tool.Infos;
with SPDX_Tool.Buffer_Sets;
with SPDX_Tool.Configs;
private with Ada.Strings.Hash;
private with Ada.Containers.Indefinite_Hashed_Maps;
package SPDX_Tool.Languages is

   --  Mapper to guess language from path extension (result is the language name).
   package Language_Mappers is
      new Util.Files.Filters (Element_Type => String);

   use type Infos.Line_Count;

   type Analyzer_Type is limited interface;
   type Analyzer_Access is access all Analyzer_Type'Class;

   type Comment_Mode is (NO_COMMENT,
                         LINE_COMMENT,
                         LINE_BLOCK_COMMENT,
                         START_COMMENT,
                         BLOCK_COMMENT,
                         END_COMMENT);

   type Comment_Index is new Natural;

   type Comment_Info is record
      Analyzer   : Analyzer_Access;
      Start      : Buffer_Index := 1;
      Last       : Buffer_Index := 1;
      Head       : Buffer_Index := 1;
      Text_Start : Buffer_Index := 1;
      Text_Last  : Buffer_Index := 1;
      Trailer    : Buffer_Size := 0;
      Length     : Natural := 0;
      Mode       : Comment_Mode := NO_COMMENT;
      Boxed      : Boolean := False;
   end record;

   --  Find and identify the comment from the line represented by Buffer (From .. Last).
   --  When a comment is found:
   --  * `Text_Start` and `Text_Last` are setup so that Buffer (Text_Start .. Text_Last)
   --    contains the text within the comment,
   --  * `Head` and `Last` are setup to include the comment markers
   --  * `Trailer` indicates the length of the comment marker after `Text_Start`.
   procedure Find_Comment (Analyzer : in Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is abstract
      with Pre'Class => From <= Last and then From >= Buffer'First and then Last <= Buffer'Last;

   type Line_Type is record
      Comment    : Comment_Mode := NO_COMMENT;
      Style      : Comment_Info;
      Line_Start : Buffer_Index := 1;
      Line_End   : Buffer_Size := 0;
      Tokens     : SPDX_Tool.Buffer_Sets.Set;
   end record;
   type Line_Array is array (Infos.Line_Number range <>) of Line_Type;

   --  Compute maximum length of lines between From..To as byte count.
   function Max_Length (Lines : in Line_Array;
                        From  : in Infos.Line_Number;
                        To    : in Infos.Line_Number) return Buffer_Size;

   --  Check if Lines (From..To) are of the same length.
   function Is_Same_Length (Lines : in Line_Array;
                            From  : in Infos.Line_Number;
                            To    : in Infos.Line_Number) return Boolean
     with Pre => From <= To;

   --  Check if we have the same byte for every line starting from the
   --  end of the line with the given offset.
   function Is_Same_Byte (Lines  : in Line_Array;
                          Buffer : in Buffer_Type;
                          From   : in Infos.Line_Number;
                          To     : in Infos.Line_Number;
                          Offset : in Buffer_Size) return Boolean
     with Pre => Is_Same_Length (Lines, From, To);

   --  Find the common length at end of each line between From and To.
   function Common_End_Length (Lines  : in Line_Array;
                               Buffer : in Buffer_Type;
                               From   : in Infos.Line_Number;
                               To     : in Infos.Line_Number) return Buffer_Size
     with Pre => Is_Same_Length (Lines, From, To);

   --  Find the common length of spaces at beginning of each line
   --  between From and To.  We don't need to have identical length
   --  for each line.
   function Common_Start_Length (Lines  : in Line_Array;
                                 Buffer : in Buffer_Type;
                                 From   : in Infos.Line_Number;
                                 To     : in Infos.Line_Number) return Buffer_Size
     with Pre => From <= To;

   --  Check if the comment line is only a presentation line: it is either
   --  empty or contains the same presentation character.
   function Is_Presentation_Line (Lines  : in Line_Array;
                                  Buffer : in Buffer_Type;
                                  Line   : in Infos.Line_Number) return Boolean;

   --  Identify boundaries of a license with a boxed presentation.
   --  Having identified such boxed presentation, update the lines Text_Last
   --  position to indicate the last position of the text for each line
   --  to ignore the boxed presentation.
   procedure Boxed_License (Lines  : in out Line_Array;
                            Buffer : in Buffer_Type;
                            Boxed  : out Boolean);

   type Language_Manager is tagged limited private;

   --  Initialize the language manager with the given configuration.
   procedure Initialize (Manager : in out Language_Manager;
                         Config  : in SPDX_Tool.Configs.Config_Type);

   --  Extract from the given line in the comment the list of tokens used.
   --  Such list can be used by the license decision tree to find a matching license.
   procedure Extract_Line_Tokens (Buffer : in Buffer_Type;
                                  Line   : in out Line_Type)
     with Pre => Line.Comment /= NO_COMMENT
       and then Line.Style.Text_Start >= Buffer'First
       and then Line.Style.Text_Last <= Buffer'Last;

   --  Guess the language based on the file extension.
   function Get_Language_From_Extension (Path : in String) return String;

   --  Identify the language used by the given file.  The identification can be
   --  made by looking at the file extension, the mime type or by looking at
   --  the first 4K block of the file.
   procedure Find_Language (Manager  : in Language_Manager;
                            File     : in out SPDX_Tool.Infos.File_Info;
                            Buffer   : in Buffer_Type;
                            Analyzer : out Analyzer_Access);

   procedure Find_Comments (Analyzer : in Analyzer_Type'Class;
                            Buffer   : in Buffer_Type;
                            Lines    : in out Line_Array;
                            Count    : out Infos.Line_Count);

   --  Extract from the header the license text that was found.
   --  When no license text was clearly identified, extract the text
   --  found in the header comment.
   function Extract_License (Lines   : in Line_Array;
                             Buffer  : in Buffer_Type;
                             License : in Infos.License_Info)
                             return Infos.License_Text_Access;

private

   subtype Comment_Configuration is Configs.Comment_Configuration;
   subtype Language_Configuration is Configs.Language_Configuration;

   --  Analyzer for line oriented comments.
   type Line_Analyzer_Type (Len : Buffer_Size) is new Analyzer_Type with record
      Comment_Start : Buffer_Type (1 .. Len);
   end record;

   overriding
   procedure Find_Comment (Analyzer : in Line_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info);

   --  Analyzer for block style comments with a start and end delimiter.
   type Block_Analyzer_Type (Len_Start, Len_End : Buffer_Size) is new Analyzer_Type with record
      Comment_Start : Buffer_Type (1 .. Len_Start);
      Comment_End   : Buffer_Type (1 .. Len_End);
   end record;

   overriding
   procedure Find_Comment (Analyzer : in Block_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info);

   --  Multi-style analyzer, check comment with each analyzer until one succeeds.
   type Analyzer_Array is array (Positive range <>) of Analyzer_Access;
   type Combined_Analyzer_Type (Count : Positive) is new Analyzer_Type with record
      Analyzers : Analyzer_Array (1 .. Count);
   end record;
   type Combined_Analyzer_Access is access all Combined_Analyzer_Type;

   overriding
   procedure Find_Comment (Analyzer : in Combined_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info);

   type Language_Descriptor is record
      Analyzer : Analyzer_Access;
      Config   : Comment_Configuration;
   end record;

   --  Map which gives the analyzer to use for a given language.
   package Language_Maps is
      new Ada.Containers.Indefinite_Hashed_Maps (Key_Type     => String,
                                                 Element_Type => Language_Descriptor,
                                                 Hash         => Ada.Strings.Hash,
                                                 Equivalent_Keys => "=");

   type Language_Manager is tagged limited record
      File_Mapper   : Language_Mappers.Filter_Type;
      Languages     : Language_Maps.Map;
   end record;

   function Guess_Language (Manager : in Language_Manager;
                            File    : in SPDX_Tool.Infos.File_Info;
                            Buffer  : in Buffer_Type) return String;

   function Create_Analyzer (Manager : in Language_Manager;
                             Conf    : in Comment_Configuration) return Analyzer_Access;

   function Find_Analyzer (Manager : in Language_Manager;
                           Name    : in String) return Analyzer_Access;

end SPDX_Tool.Languages;
