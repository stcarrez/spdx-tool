-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;

with Util.Log.Loggers;
with Util.Files;
with SPDX_Tool.Extensions;

package body SPDX_Tool.Languages is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Languages");

   use type Infos.License_Kind;

   procedure Set_Language (Result     : in out Detector_Result;
                           Language   : in String;
                           Confidence : in Natural := 1) is
   begin
      Result.Languages.Append (Language);
   end Set_Language;

   --  Get the language that was resolved.
   function Get_Language (Result : in Detector_Result) return String is
   begin
      if not Result.Languages.Is_Empty then
         return Result.Languages.First_Element;
      else
         return "";
      end if;
   end Get_Language;

   overriding
   procedure Find_Comment (Analyzer : in Line_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is
   begin
      if Comment.Mode = BLOCK_COMMENT then
         return;
      end if;
      declare
         Len : constant Buffer_Size := Analyzer.Len;
         Pos : Buffer_Index := From;
      begin
         while Pos + Len <= Last loop
            if Buffer (Pos .. Pos + Len - 1) = Analyzer.Comment_Start then
               Comment := (Analyzer   => null,
                    Start      => Pos + Len,
                    Last       => Pos,
                    Head       => Pos,
                    Text_Start => Pos + Len,
                    Text_Last  => Skip_Backward_Spaces (Buffer, Pos, Last),
                    Trailer => 0,
                    Length  => 0,
                    Mode    => LINE_COMMENT,
                    Boxed   => False);
               return;
            end if;
            Pos := Pos + 1;
         end loop;
         Comment.Mode := NO_COMMENT;
      end;
   end Find_Comment;

   overriding
   procedure Find_Comment (Analyzer : in Block_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is
      Len : constant Buffer_Size := Analyzer.Len_Start;
      Pos : Buffer_Index := From;
   begin
      if Comment.Mode in START_COMMENT | BLOCK_COMMENT then
         declare
            Len : constant Buffer_Size := Analyzer.Len_End;
         begin
            Comment.Start := Pos;
            Comment.Head := Pos;
            if Pos <= Last - 1 then
               --  Ignore a ' * ' or ' + ' presentation in code blocks.
               Comment.Text_Start := Skip_Presentation (Buffer, Pos, Last - 1);
            else
               --  Empty line
               Comment.Text_Start := Pos;
            end if;
            Comment.Text_Last := Last - 1;
            while Pos + Len <= Last loop
               if Buffer (Pos .. Pos + Len - 1) = Analyzer.Comment_End then
                  Comment.Mode := END_COMMENT;
                  Comment.Trailer := Len;
                  Comment.Text_Last := Pos - 1;
                  return;
               end if;
               Pos := Pos + 1;
            end loop;
            Comment.Mode := BLOCK_COMMENT;
            return;
         end;
      end if;
      while Pos + Len <= Last loop
         if Buffer (Pos .. Pos + Len - 1) = Analyzer.Comment_Start then
            declare
               Len_End : constant Buffer_Size := Analyzer.Len_End;
            begin
               Comment.Mode := START_COMMENT;
               Comment.Start := Pos;
               Comment.Text_Start := Pos + Len;
               Comment.Head := Pos;
               Comment.Trailer := 0;
               Comment.Text_Last := Skip_Backward_Spaces (Buffer, Pos + Len, Last);
               Pos := Pos + Len;
               while Pos + Len_End <= Last loop
                  if Buffer (Pos .. Pos + Len_End - 1) = Analyzer.Comment_End then
                     Comment.Mode := LINE_BLOCK_COMMENT;
                     Comment.Trailer := Len_End;
                     Comment.Text_Last := Pos - Len_End + 1;
                     exit;
                  end if;
                  Pos := Pos + 1;
               end loop;
               Comment.Last := Last;
               return;
            end;
         end if;
         Pos := Pos + 1;
      end loop;
      Comment.Mode := NO_COMMENT;
   end Find_Comment;

   overriding
   procedure Find_Comment (Analyzer : in Combined_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is
   begin
      if Comment.Analyzer /= null and then Comment.Mode in START_COMMENT | BLOCK_COMMENT then
         Comment.Analyzer.Find_Comment (Buffer, From, Last, Comment);
      else
         Comment.Analyzer := null;
         for Current of Analyzer.Analyzers loop
            if Current /= null then
               Current.Find_Comment (Buffer, From, Last, Comment);
               if Comment.Mode /= NO_COMMENT then
                  if Comment.Analyzer = null then
                     Comment.Analyzer := Current;
                  end if;
                  return;
               end if;
            end if;
         end loop;
      end if;
   end Find_Comment;

   function Get_Language_From_Extension (Path : in String) return String is
      Ext  : constant String := Ada.Directories.Extension (Path);
      Kind : access constant String := SPDX_Tool.Extensions.Get_Mapping (Ext);
   begin
      if Kind /= null then
         return Kind.all;
      end if;
      if Kind = null and then Util.Strings.Ends_With (Ext, "~") then
         Kind := SPDX_Tool.Extensions.Get_Mapping (Ext (Ext'First .. Ext'Last - 1));
      end if;
      if Kind /= null then
         return Kind.all;
      end if;
      return "";
   end Get_Language_From_Extension;

   procedure Find_Comments (Analyzer : in Analyzer_Type'Class;
                            Buffer   : in Buffer_Type;
                            Lines    : in out Line_Array;
                            Count    : in Infos.Line_Count) is
      Len      : constant Buffer_Size := Buffer'Length;
      Pos      : Buffer_Index := Buffer'First;
      First    : Buffer_Index;
      Style    : Comment_Info := (Mode => NO_COMMENT, others => <>);
   begin
      for Line_No in 1 .. Count loop
         First := Lines (Line_No).Line_Start;
         Pos := Lines (Line_No).Line_End + 1;
         Analyzer.Find_Comment (Buffer, First, Pos, Style);
         if Style.Text_Last < Style.Text_Start then
            Style.Text_Last := Style.Text_Start - 1;
         end if;
         Style.Length := Printable_Length (Buffer, First, Pos);
         Lines (Line_No).Style := (Start => Style.Start, Last => Style.Last,
                                   Head => Style.Head, Text_Start => Style.Text_Start,
                                   Text_Last => Style.Text_Last, Trailer => Style.Trailer,
                                   Length => Style.Length, Mode => Style.Mode, Boxed => Style.Boxed);
         if Style.Mode /= NO_COMMENT then
            Lines (Line_No).Comment := Style.Mode;
            Lines (Line_No).Style.Last := Pos - 1;
            Extract_Line_Tokens (Buffer, Lines (Line_No));
         else
            Lines (Line_No).Comment := NO_COMMENT;
         end if;
      end loop;
   end Find_Comments;

   --  ------------------------------
   --  Find lines in the buffer and setup the line array with indexes giving
   --  the start and end position of each line.
   --  ------------------------------
   procedure Find_Lines (Buffer   : in Buffer_Type;
                         Lines    : in out Line_Array;
                         Count    : out Infos.Line_Count) is
      Len      : constant Buffer_Size := Buffer'Length;
      Pos      : Buffer_Index := Buffer'First;
      First    : Buffer_Index;
      Line_No  : Infos.Line_Count := 0;
   begin
      while Pos <= Len loop
         First := Pos;
         Pos := Find_Eol (Buffer (Pos .. Len), Pos);
         Line_No := Line_No + 1;
         Lines (Line_No).Line_Start := First;
         Lines (Line_No).Line_End := Pos - 1;
         exit when Line_No = Lines'Last or else Pos > Len;
         if Buffer (Pos) = CR
            and then Pos + 1 <= Len
            and then Buffer (Pos + 1) = LF
         then
            Pos := Pos + 2;
         else
            Pos := Pos + 1;
         end if;
      end loop;
      Count := Line_No;
   end Find_Lines;

   --  ------------------------------
   --  Compute maximum length of lines between From..To as byte count.
   --  ------------------------------
   function Max_Length (Lines : in Line_Array;
                        From  : in Infos.Line_Number;
                        To    : in Infos.Line_Number) return Buffer_Size is
      Max : Buffer_Size := 0;
   begin
      for I in From .. To loop
         declare
            Len : constant Buffer_Size
              := Lines (I).Line_End - Lines (I).Line_Start + 1;
         begin
            if Len > Max then
               Max := Len;
            end if;
         end;
      end loop;
      return Max;
   end Max_Length;

   --  ------------------------------
   --  Check if Lines (From..To) are of the same length.
   --  ------------------------------
   function Is_Same_Length (Lines : in Line_Array;
                            From  : in Infos.Line_Number;
                            To    : in Infos.Line_Number) return Boolean is
      Line_Length : constant Natural := Lines (From).Style.Length;
   begin
      return Line_Length > 0
        and then (for all I in From + 1 .. To =>
                    Lines (I).Style.Length = Line_Length);
   end Is_Same_Length;

   --  ------------------------------
   --  Check if we have the same byte for every line starting from the
   --  end of the line with the given offset.
   --  ------------------------------
   function Is_Same_Byte (Lines  : in Line_Array;
                          Buffer : in Buffer_Type;
                          From   : in Infos.Line_Number;
                          To     : in Infos.Line_Number;
                          Offset : in Buffer_Size) return Boolean is
      C : constant Byte := Buffer (Lines (From).Line_End - Offset);
   begin
      return (for all I in From + 1 .. To =>
                Buffer (Lines (I).Line_End - Offset) = C);
   end Is_Same_Byte;

   --  ------------------------------
   --  Find the common length at end of each line between From and To.
   --  ------------------------------
   function Common_End_Length (Lines  : in Line_Array;
                               Buffer : in Buffer_Type;
                               From   : in Infos.Line_Number;
                               To     : in Infos.Line_Number) return Buffer_Size is
      Line_Length : constant Buffer_Size :=
        Lines (From).Line_End - Lines (From).Line_Start;
      Len : Buffer_Size := 0;
   begin
      while Len < Line_Length loop
         if not Is_Same_Byte (Lines, Buffer, From, To, Len) then
            exit;
         end if;
         Len := Len + 1;
      end loop;
      return Len;
   end Common_End_Length;

   --  ------------------------------
   --  Find the common length of spaces at beginning of each line
   --  between From and To.  We don't need to have identical length
   --  for each line.
   --  ------------------------------
   function Common_Start_Length (Lines  : in Line_Array;
                                 Buffer : in Buffer_Type;
                                 From   : in Infos.Line_Number;
                                 To     : in Infos.Line_Number) return Buffer_Size is
      Line_Length : constant Buffer_Size := Max_Length (Lines, From, To);
      Len         : Buffer_Size := 0;
   begin
      while Len < Line_Length loop
         for I in From .. To loop
            declare
               Pos : constant Buffer_Index
                 := Lines (I).Style.Text_Start + Len;
            begin
               --  Ignore lines which are not a comment or too short.
               if Lines (I).Comment /= NO_COMMENT
                 and then Pos <= Lines (I).Line_End
                 and then not Is_Space (Buffer (Pos))
               then
                  return Len;
               end if;
            end;
         end loop;
         Len := Len + 1;
      end loop;
      return Len;
   end Common_Start_Length;

   --  ------------------------------
   --  Check if the comment line is only a presentation line: it is either
   --  empty or contains the same presentation character.
   --  ------------------------------
   function Is_Presentation_Line (Lines  : in Line_Array;
                                  Buffer : in Buffer_Type;
                                  Line   : in Infos.Line_Number) return Boolean is
      Info : Files.Comment_Info renames Lines (Line).Style;
   begin
      return (for all I in Info.Text_Start .. Info.Text_Last
                => Is_Space_Or_Punctuation (Buffer (I)));
   end Is_Presentation_Line;

   --  ------------------------------
   --  Identify boundaries of a license with a boxed presentation.
   --  Having identified such boxed presentation, update the lines Text_Last
   --  position to indicate the last position of the text for each line
   --  to ignore the boxed presentation.
   --  ------------------------------
   procedure Boxed_License (Lines  : in out Line_Array;
                            Buffer : in Buffer_Type;
                            Boxed  : out Boolean) is
      Limit  : constant Infos.Line_Count := (Lines'Length / 2);
      Common : Buffer_Size;
      Common_Start : Buffer_Size;
   begin
      for I in Lines'First .. Limit loop
         if Lines (I).Comment /= NO_COMMENT then
            for J in reverse I + 3 .. Lines'Last loop
               if Lines (J).Comment /= NO_COMMENT
                 and then Is_Same_Length (Lines, I, J)
               then
                  Boxed := True;
                  Common := Common_End_Length (Lines, Buffer, I, J);
                  Common_Start := Common_Start_Length (Lines, Buffer, I, J);
                  for K in I .. J loop
                     Lines (K).Style.Boxed := True;
                     Lines (K).Style.Text_Last := Lines (K).Style.Last - Common;
                     Lines (K).Style.Text_Start := Lines (K).Style.Text_Start + Common_Start;
                  end loop;
                  return;
               end if;
            end loop;
         end if;
      end loop;
   end Boxed_License;

   --  ------------------------------
   --  Extract from the given line in the comment the list of tokens used.
   --  Such list can be used by the license decision tree to find a matching license.
   --  ------------------------------
   procedure Extract_Line_Tokens (Buffer : in Buffer_Type;
                                  Line   : in out Line_Type) is
      Last  : constant Buffer_Index := Line.Style.Text_Last;
      Pos   : Buffer_Index := Line.Style.Text_Start;
      First : Buffer_Index;
   begin
      while Pos <= Last loop
         First := Skip_Spaces (Buffer, Pos, Last);
         exit when First > Last;
         Pos := Next_Space (Buffer, First, Last);
         if First <= Pos then
            Line.Tokens.Include (Buffer (First .. Pos));
         end if;
         Pos := Pos + 1;
      end loop;
   end Extract_Line_Tokens;

   --  ------------------------------
   --  Extract from the header the license text that was found.
   --  When no license text was clearly identified, extract the text
   --  found in the header comment.
   --  ------------------------------
   function Extract_License (Lines   : in Line_Array;
                             Buffer  : in Buffer_Type;
                             License : in Infos.License_Info)
                             return Infos.License_Text_Access is
      First_Line      : Infos.Line_Count;
      Last_Line       : Infos.Line_Count;
      Size, Len, Skip : Buffer_Size;
   begin
      if License.Match /= Infos.NONE then
         First_Line := License.First_Line;
         Last_Line := License.Last_Line;
      else
         First_Line := Lines'First;
         Last_Line := Lines'Last;
         while First_Line > Last_Line
           and then Lines (First_Line).Comment = NO_COMMENT
         loop
            First_Line := First_Line + 1;
         end loop;
         Last_Line := First_Line + 1;
         while Last_Line <= Lines'Last
           and then Lines (Last_Line).Comment /= NO_COMMENT
         loop
            Last_Line := Last_Line + 1;
         end loop;
         Last_Line := Last_Line - 1;
         if Is_Presentation_Line (Lines, Buffer, First_Line) then
            First_Line := First_Line + 1;
         end if;
         if Is_Presentation_Line (Lines, Buffer, Last_Line) then
            Last_Line := Last_Line - 1;
         end if;
      end if;
      if First_Line > Last_Line then
         return null;
      end if;
      Skip := Common_Start_Length (Lines, Buffer, First_Line, Last_Line);
      Size := Buffer_Size (Last_Line - First_Line + 1);
      for I in First_Line .. Last_Line loop
         Len := Lines (I).Style.Text_Last
           - Lines (I).Style.Text_Start + 1;
         if Len > Skip then
            Len := Len - Skip;
         end if;
         Size := Size + Len;
      end loop;
      declare
         Text  : constant Infos.License_Text_Access := new Infos.License_Text (Len => Size);
         Pos   : Buffer_Index := 1;
         Start : Buffer_Index;
         Last  : Buffer_Index;
      begin
         for I in First_Line .. Last_Line loop
            Start := Lines (I).Style.Text_Start;
            Last := Lines (I).Style.Text_Last;
            Len := Last - Start + 1;
            if Len > Skip then
               Start := Start + Skip;
               Len := Len - Skip;
            end if;
            Text.Content (Pos .. Pos + Len - 1) := Buffer (Start .. Last);
            Pos := Pos + Len;
            Text.Content (Pos) := LF;
            Pos := Pos + 1;
         end loop;
         return Text;
      end;
   end Extract_License;

end SPDX_Tool.Languages;
