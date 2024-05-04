-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Streams.Files;
with SPDX_Tool.Buffer_Sets;
with SPDX_Tool.Counter_Arrays;
with SPDX_Tool.Infos;
package SPDX_Tool.Files is

   subtype Line_Number is Infos.Line_Number;
   subtype Line_Count is Infos.Line_Count;

   type Comment_Mode is (NO_COMMENT,
                         LINE_COMMENT,
                         LINE_BLOCK_COMMENT,
                         START_COMMENT,
                         BLOCK_COMMENT,
                         END_COMMENT);

   type Comment_Category is (UNKNOWN, EMPTY, PRESENTATION, MODELINE, INTERPRETER, TEXT);
   type Comment_Index is new Natural;

   type Comment_Info is record
      Start      : Buffer_Index := 1;
      Last       : Buffer_Size := 0;
      Head       : Buffer_Index := 1;
      Text_Start : Buffer_Index := 1;
      Text_Last  : Buffer_Size := 0;
      Trailer    : Buffer_Size := 0;
      Length     : Natural := 0;
      Mode       : Comment_Mode := NO_COMMENT;
      Boxed      : Boolean := False;
      Category   : Comment_Category := UNKNOWN;
   end record;

   type Line_Type is record
      Comment    : Comment_Mode := NO_COMMENT;
      Style      : Comment_Info;
      Line_Start : Buffer_Index := 1;
      Line_End   : Buffer_Size := 0;
      Tokens     : SPDX_Tool.Counter_Arrays.Array_Type; --  SPDX_Tool.Buffer_Sets.Set;
      Licenses   : License_Index_Map := SPDX_Tool.EMPTY_MAP;
   end record;
   type Line_Array is array (Infos.Line_Number range <>) of Line_Type;

   type File_Type (Max_Lines : Infos.Line_Count) is limited record
      File         : Util.Streams.Files.File_Stream;
      Buffer       : Buffer_Ref;
      Last_Offset  : Buffer_Size;
      Count        : Line_Count := 0;
      Cmt_Style    : Comment_Mode := NO_COMMENT;
      Lines        : Line_Array (1 .. Max_Lines);
      Boxed        : Boolean;
   end record;

   --  Extract from the header the list of tokens used.  Such list
   --  can be used by the license decision tree to find a matching license.
   --  We could extract more tokens such as tokens which are not really part
   --  of the license header but this is not important as the decision tree
   --  tries to find a best match.
   procedure Extract_Tokens (File    : in File_Type;
                             First   : in Line_Number;
                             Last    : in Line_Number;
                             Tokens  : in out SPDX_Tool.Buffer_Sets.Set);

end SPDX_Tool.Files;
