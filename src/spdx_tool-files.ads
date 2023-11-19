-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Streams.Files;
with SPDX_Tool.Magic;
package SPDX_Tool.Files is

   type Identification is record
      Mime     : UString;
      Language : UString;
   end record;

   type Comment_Style is (NO_COMMENT,
                          ADA_COMMENT,
                          C_COMMENT,
                          CPP_COMMENT,
                          SHELL_COMMENT,
                          LATEX_COMMENT,
                          XML_COMMENT,
                          OCAML_COMMENT);

   type Comment_Mode is (NO_COMMENT,
                         LINE_COMMENT,
                         LINE_BLOCK_COMMENT,
                         START_COMMENT,
                         BLOCK_COMMENT,
                         END_COMMENT);

   type Comment_Index is new Natural;

   type Comment_Info is record
      Style    : Comment_Style := NO_COMMENT;
      Start    : Buffer_Index := 1;
      Last     : Buffer_Index := 1;
      Head     : Buffer_Index := 1;
      Index    : Comment_Index := 0;
      Mode     : Comment_Mode := NO_COMMENT;
   end record;

   type Line_Type is record
      Comment    : Comment_Mode := NO_COMMENT;
      Style      : Comment_Info;
      Line_Start : Buffer_Index := 1;
      Line_End   : Buffer_Size := 0;
   end record;
   type Line_Array is array (Positive range <>) of Line_Type;

   type File_Type (Max_Lines : Positive) is limited record
      File         : Util.Streams.Files.File_Stream;
      Buffer       : Buffer_Ref;
      Last_Offset  : Buffer_Size;
      Count        : Natural := 0;
      Ident        : Identification;
      Cmt_Style    : Comment_Style := NO_COMMENT;
      Lines        : Line_Array (1 .. Max_Lines);
   end record;

   type File_Manager is tagged limited private;
   type File_Manager_Access is access all File_Manager;

   --  Initialize the file manager and prepare the libmagic library.
   procedure Initialize (Manager : in out File_Manager;
                         Path    : in String);

   --  Open the file and read the first data block (4K) to identify the
   --  language and comment headers.
   procedure Open (Manager  : in File_Manager;
                   File     : in out File_Type;
                   Path     : in String);

   --  Save the file to replace the header license template by the corresponding
   --  SPDX license header.
   procedure Save (Manager : in File_Manager;
                   File    : in out File_Type;
                   Path    : in String;
                   First   : in Natural;
                   Last    : in Natural;
                   License : in String);

private

   type Language_Type is record
      Style         : Comment_Style;
      Comment_Start : Buffer_Ref;
      Comment_End   : Buffer_Ref;
      Is_Block      : Boolean;
   end record;
   type Language_Array is array (Comment_Index range <>) of Language_Type;

   type Identifier is tagged limited null record;

   procedure Identify (Plugin : in Identifier;
                       File   : in out File_Type;
                       Result : out Identification) is null;

   type File_Manager is tagged limited record
      Magic_Manager : Magic.Magic_Manager;
   end record;

   --  Check if the license is using some boxed presentation.
   procedure Boxed_License (Lines  : in Line_Array;
                            Buffer : in Buffer_Type;
                            First  : in Positive;
                            Last   : in Positive;
                            Spaces : out Natural;
                            Boxed  : out Boolean;
                            Length : out Natural) with
     Pre => First < Last;

end SPDX_Tool.Files;
