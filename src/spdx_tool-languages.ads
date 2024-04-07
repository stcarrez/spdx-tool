-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Containers.Vectors;
with Util.Files.Filters;
with SPDX_Tool.Infos;
with SPDX_Tool.Configs;
with SPDX_Tool.Files;
private with Ada.Strings.Hash;
private with Ada.Containers.Indefinite_Hashed_Maps;
package SPDX_Tool.Languages is

   --  Mapper to guess language from path extension (result is the language name).
   package Language_Mappers is
      new Util.Files.Filters (Element_Type => String);

   use type Infos.Line_Count;
   use all type Files.Comment_Mode;
   subtype Line_Count is Infos.Line_Count;
   subtype Line_Number is Infos.Line_Number;
   subtype File_Info is Infos.File_Info;
   subtype Line_Array is Files.Line_Array;
   subtype Line_Type is Files.Line_Type;
   subtype File_Type is Files.File_Type;

   type Analyzer_Type is limited interface;
   type Analyzer_Access is access all Analyzer_Type'Class;

   type Comment_Info is record
      Analyzer   : Analyzer_Access;
      Start      : Buffer_Index := 1;
      Last       : Buffer_Size := 0;
      Head       : Buffer_Index := 1;
      Text_Start : Buffer_Index := 1;
      Text_Last  : Buffer_Size := 0;
      Trailer    : Buffer_Size := 0;
      Length     : Natural := 0;
      Mode       : Files.Comment_Mode := NO_COMMENT;
      Boxed      : Boolean := False;
      Category   : Files.Comment_Category := Files.EMPTY;
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

   --  Extract from the given line in the comment the list of tokens used.
   --  Such list can be used by the license decision tree to find a matching license.
   procedure Extract_Line_Tokens (Buffer : in Buffer_Type;
                                  Line   : in out Line_Type)
     with Pre => Line.Comment /= Files.NO_COMMENT
       and then Line.Style.Text_Start >= Buffer'First
       and then Line.Style.Text_Last <= Buffer'Last;

   procedure Find_Comments (Analyzer : in Analyzer_Type'Class;
                            Buffer   : in Buffer_Type;
                            Lines    : in out Line_Array;
                            Count    : in Infos.Line_Count);

   --  Extract from the header the license text that was found.
   --  When no license text was clearly identified, extract the text
   --  found in the header comment.
   function Extract_License (Lines   : in Line_Array;
                             Buffer  : in Buffer_Type;
                             License : in Infos.License_Info)
                             return Infos.License_Text_Access;

   --  Find lines in the buffer and setup the line array with indexes giving
   --  the start and end position of each line.
   procedure Find_Lines (Buffer   : in Buffer_Type;
                         Lines    : in out Line_Array;
                         Count    : out Infos.Line_Count);

   --  Find the first and last line header boundaries which could contain
   --  license information.
   procedure Find_Headers (Buffer  : in Buffer_Type;
                           Lines   : in Line_Array;
                           Count   : in Line_Count;
                           First   : out Line_Number;
                           Last    : out Line_Number);

   function Find_Category (Buffer : in Buffer_Type;
                           From   : in Buffer_Index;
                           Last   : in Buffer_Size) return Files.Comment_Category;

private

   subtype Comment_Configuration is Configs.Comment_Configuration;
   subtype Language_Configuration is Configs.Language_Configuration;
   subtype Confidence_Type is Infos.Confidence_Type;

   type Detected_Language is record
      Language   : UString;
      Confidence : Confidence_Type;
   end record;

   package Detected_Language_Vectors is
      new Ada.Containers.Vectors (Element_Type => Detected_Language, Index_Type => Positive);

   type Detector_Result is record
      Languages : Detected_Language_Vectors.Vector;
   end record;

   --  Update the language detection result with the language and the given confidence.
   --  Confidence are added
   procedure Set_Language (Result     : in out Detector_Result;
                           Language   : in String;
                           Confidence : in Confidence_Type);

   --  If the languages string is not null, add every language that is contains
   --  Languages are separated by ','.
   procedure Set_Languages (Result     : in out Detector_Result;
                            Languages  : access constant String;
                            Confidence : in Confidence_Type);
   procedure Set_Languages (Result     : in out Detector_Result;
                            Languages  : in String;
                            Confidence : in Confidence_Type);

   --  Get the language that was resolved.
   function Get_Language (Result : in Detector_Result) return String;

   type Detector_Type is limited interface;
   type Detector_Access is access all Detector_Type'Class;

   --  Detect the language of the file.  The detection can be based file name,
   --  or file content as well as past detections from previous detectors.
   --  We stop calling the detectors when they found a language with a
   --  higher confidence.
   procedure Detect (Detector : in Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result) is abstract;

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

end SPDX_Tool.Languages;
