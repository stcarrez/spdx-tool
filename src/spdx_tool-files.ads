-- --------------------------------------------------------------------
--  spdx_tool-files -- basic language analysis
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Streams.Files;
package SPDX_Tool.Files is

   type Comment_Style is (NO_COMMENT,
                          ADA_COMMENT,
                          C_COMMENT,
                          CPP_COMMENT,
                          SHELL_COMMENT,
                          M4_COMMENT,
                          LATEX_COMMENT,
                          XML_COMMENT);

   type Comment_Mode is (NO_COMMENT,
                         LINE_COMMENT,
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

   type Language_Type is record
      Style         : Comment_Style;
      Comment_Start : Buffer_Ref;
      Comment_End   : Buffer_Ref;
      Is_Block      : Boolean;
   end record;
   type Language_Array is array (Comment_Index range <>) of Language_Type;

   type File_Type (Max_Lines : Positive) is tagged limited record
      File         : Util.Streams.Files.File_Stream;
      Buffer       : Buffer_Ref;
      Last_Offset  : Buffer_Index;
      Count        : Natural := 0;
      Cmt_Style    : Comment_Style := NO_COMMENT;
      Lines        : Line_Array (1 .. Max_Lines);
   end record;

   function Find_Comment_Style (Data : in Buffer_Accessor;
                                From : in Buffer_Index) return Comment_Info;

   procedure Open (File     : in out File_Type;
                   Path     : in String);

   procedure Save (File    : in out File_Type;
                   Path    : in String;
                   First   : in Natural;
                   Last    : in Natural;
                   License : in String);

end SPDX_Tool.Files;
