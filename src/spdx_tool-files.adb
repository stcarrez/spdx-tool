-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;
with Ada.Directories;

with Util.Log.Loggers;
with Util.Files;
with Util.Strings;
with SPDX_Tool.Files.Extensions;
package body SPDX_Tool.Files is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Files");

   use type Infos.License_Kind;

   procedure Find_Comment (Buffer : in Buffer_Type;
                           From   : in Buffer_Index;
                           Last   : in Buffer_Index;
                           Result : out Comment_Info);
   function Find_End_Comment (Buffer   : in Buffer_Type;
                              From     : in Buffer_Index;
                              Last     : in Buffer_Index;
                              Language : in Language_Type) return Buffer_Index;

   Line_Comments : constant Language_Array :=
     ((Style         => ADA_COMMENT,
       Comment_Start => Create_Buffer ("--"),
       Comment_End   => Null_Buffer,
       Is_Block      => False),
      (Style         => CPP_COMMENT,
       Comment_Start => Create_Buffer ("//"),
       Comment_End   => Null_Buffer,
       Is_Block      => False),
      (Style         => SHELL_COMMENT,
       Comment_Start => Create_Buffer ("#"),
       Comment_End   => Null_Buffer,
       Is_Block      => False),
      (Style         => LATEX_COMMENT,
       Comment_Start => Create_Buffer ("%%"),
       Comment_End   => Null_Buffer,
       Is_Block      => False),
      (Style         => LATEX_COMMENT,
       Comment_Start => Create_Buffer ("%"),
       Comment_End   => Null_Buffer,
       Is_Block      => False)
     );

   Block_Comments : constant Language_Array :=
     ((Style         => C_COMMENT,
       Comment_Start => Create_Buffer ("/*"),
       Comment_End   => Create_Buffer ("*/"),
       Is_Block      => True),
      (Style         => XML_COMMENT,
       Comment_Start => Create_Buffer ("<!--"),
       Comment_End   => Create_Buffer ("-->"),
       Is_Block      => True),
      (Style         => OCAML_COMMENT,
       Comment_Start => Create_Buffer ("(*"),
       Comment_End   => Create_Buffer ("*)"),
       Is_Block      => True)
     );

   function Block_Comment_Length (Index : Comment_Index) return Natural is
     (Natural (Block_Comments (Index).Comment_Start.Value.Len
      + Block_Comments (Index).Comment_End.Value.Len));

   procedure Find_Comment (Buffer : in Buffer_Type;
                           From   : in Buffer_Index;
                           Last   : in Buffer_Index;
                           Result : out Comment_Info) is
      Pos : Buffer_Index := From;
   begin
      --  Look first for a line comment
      for Index in Line_Comments'Range loop
         declare
            Comment : Language_Type renames Line_Comments (Index);
            Cmt : constant Buffer_Accessor := Comment.Comment_Start.Value;
         begin
            if From + Cmt.Len <= Last
              and then Buffer (From .. From + Cmt.Len - 1) = Cmt.Data
            then
               Result := (Style   => Comment.Style,
                          Start   => From + Cmt.Len,
                          Last    => From,
                          Head    => From,
                          Text_Start => From + Cmt.Len,
                          Text_Last  => Skip_Backward_Spaces (Buffer, From, Last),
                          Trailer => 0,
                          Length  => 0,
                          Index   => Index,
                          Mode    => LINE_COMMENT,
                          Boxed   => False);
               return;
            end if;
         end;
      end loop;
      while Pos <= Last loop
         for Index in Block_Comments'Range loop
            declare
               Comment : Language_Type renames Block_Comments (Index);
               Cmt : constant Buffer_Accessor := Comment.Comment_Start.Value;
            begin
               if Pos + Cmt.Len <= Last
                  and then Buffer (Pos .. Pos + Cmt.Len - 1) = Cmt.Data
               then
                  Result := (Style   => Comment.Style,
                             Start   => From + Cmt.Len,
                             Last    => From,
                             Head    => From,
                             Text_Start => From + Cmt.Len,
                             Text_Last  => Skip_Backward_Spaces (Buffer, From, Last),
                             Trailer => 0,
                             Length  => 0,
                             Index   => Index,
                             Mode    => START_COMMENT,
                             Boxed   => False);
                  return;
               end if;
            end;
         end loop;
         Pos := Pos + 1;
      end loop;
      Result := (NO_COMMENT, others => <>);
   end Find_Comment;

   function Find_End_Comment (Buffer   : in Buffer_Type;
                              From     : in Buffer_Index;
                              Last     : in Buffer_Index;
                              Language : in Language_Type) return Buffer_Index is
      Cmt : constant Buffer_Accessor := Language.Comment_End.Value;
      Pos : Buffer_Index := From;
   begin
      while Pos <= Last loop
         if Pos + Cmt.Len <= Last
            and then Buffer (Pos .. Pos + Cmt.Len - 1) = Cmt.Data
         then
            return Pos + Cmt.Len - 1;
         end if;
         Pos := Pos + 1;
      end loop;
      return From;
   end Find_End_Comment;

   --  Identify the language used by the given file.
   procedure Find_Language (Manager : in File_Manager;
                            File     : in out File_Type;
                            Path     : in String) is
      Len  : constant Buffer_Size := File.Last_Offset;
      Ext  : constant String := Ada.Directories.Extension (Path);
      Kind : constant access constant String
        := SPDX_Tool.Files.Extensions.Get_Mapping (Ext);
   begin
      if Kind /= null then
         File.Language := To_UString (Kind.all);
      elsif Len = 0 then
         File.Language := To_UString ("Empty file");
         return;
      end if;
      if Len > 0 and then Manager.Magic_Manager.Is_Initialized then
         declare
            Buf  : constant Buffer_Accessor := File.Buffer.Value;
            Mime : constant String
              := Manager.Magic_Manager.Identify (Buf.Data (Buf.Data'First .. Len));
         begin
            File.Ident.Mime := To_UString (Mime);
            if Kind = null then
               if Util.Strings.Starts_With (Mime, "text/") then
                  File.Language := To_UString ("Text file");
               elsif Util.Strings.Starts_With (Mime, "image/") then
                  File.Language := To_UString ("Image");
               elsif Util.Strings.Starts_With (Mime, "video/") then
                  File.Language := To_UString ("Video");
               elsif Util.Strings.Starts_With (Mime, "application/pdf") then
                  File.Language := To_UString ("PDF");
               elsif Util.Strings.Starts_With (Mime, "application/zip") then
                  File.Language := To_UString ("ZIP");
               elsif Util.Strings.Starts_With (Mime, "application/x-tar") then
                  File.Language := To_UString ("TAR");
               end if;
            end if;
         end;
      end if;

   exception
      when others =>
         Log.Error (-("cannot identify mime type for '{0}'"), Path);
   end Find_Language;

   procedure Open (Manager  : in File_Manager;
                   File     : in out File_Type;
                   Path     : in String) is
   begin
      Log.Debug ("Open file {0}", Path);

      File.File.Open (Mode => Ada.Streams.Stream_IO.In_File, Name => Path);
      File.Buffer := Create_Buffer (4096);
      File.Count := 0;
      File.Cmt_Style := NO_COMMENT;
      declare
         Buf     : constant Buffer_Accessor := File.Buffer.Value;
         Len     : Buffer_Size;
         Pos     : Buffer_Index := Buf.Data'First;
         First   : Buffer_Index;
         Last    : Buffer_Index;
         Line_No : Natural := 0;
         Style   : Comment_Info := (NO_COMMENT, Mode => NO_COMMENT, others => <>);
      begin
         File.File.Read (Into => Buf.Data, Last => Len);
         File.Last_Offset := Len;
         Manager.Find_Language (File, Path);
         while Pos <= Len loop
            First := Pos;
            Line_No := Line_No + 1;
            File.Lines (Line_No).Line_Start := First;
            Pos := Find_Eol (Buf.Data (Pos .. Len), Pos);
            if Style.Mode in START_COMMENT | BLOCK_COMMENT then
               Style.Start := First;
               Style.Text_Start := First;
               Style.Text_Last := Pos - 1;
               Last := Find_End_Comment (Buf.Data, First, Pos, Block_Comments (Style.Index));
               if Last > First then
                  Style.Mode := END_COMMENT;
                  Style.Trailer := Block_Comments (Style.Index).Comment_End.Value.Len;
                  Style.Text_Last := Last - Style.Trailer;
               else
                  Style.Mode := BLOCK_COMMENT;
                  Last := Pos;
               end if;
               if First < Last then
                  First := Skip_Presentation (Buf.Data, First, Last);
                  Style.Start := First;
                  Style.Text_Start := First;
               end if;
            else
               Find_Comment (Buf.Data, First, Pos, Style);
               if Style.Mode = START_COMMENT then
                  Last := Find_End_Comment (Buf.Data, First, Pos, Block_Comments (Style.Index));
                  if Last > First then
                     Style.Mode := LINE_BLOCK_COMMENT;
                     Style.Trailer := Block_Comments (Style.Index).Comment_End.Value.Len;
                     Style.Text_Last := Last - Style.Trailer;
                  end if;
               end if;
            end if;
            if Style.Text_Last < Style.Text_Start then
               Style.Text_Last := Style.Text_Start - 1;
            end if;
            Style.Length := Printable_Length (Buf.Data, First, Pos);
            File.Lines (Line_No).Style := Style;
            if Style.Style /= NO_COMMENT then
               File.Lines (Line_No).Comment := Style.Mode;
               File.Lines (Line_No).Style.Last := Pos - 1;
               if File.Cmt_Style = NO_COMMENT then
                  File.Cmt_Style := Style.Style;
               end if;
            else
               File.Lines (Line_No).Comment := NO_COMMENT;
            end if;
            File.Lines (Line_No).Line_End := Pos - 1;
            exit when Line_No = File.Max_Lines or else Pos > Len;
            if Buf.Data (Pos) = CR
              and then Pos + 1 <= Len
              and then Buf.Data (Pos + 1) = LF
            then
               Pos := Pos + 2;
            else
               Pos := Pos + 1;
            end if;
         end loop;
         File.Count := Line_No;
         Boxed_License (File.Lines (File.Lines'First .. Line_No),
                        Buf.Data, File.Boxed);
      end;
   end Open;

   --  ------------------------------
   --  Compute maximum length of lines between From..To as byte count.
   --  ------------------------------
   function Max_Length (Lines : in Line_Array;
                        From  : in Positive;
                        To    : in Positive) return Buffer_Size is
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
                            From  : in Positive;
                            To    : in Positive) return Boolean is
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
                          From   : in Positive;
                          To     : in Positive;
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
                               From   : in Positive;
                               To     : in Positive) return Buffer_Size is
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
                                 From   : in Positive;
                                 To     : in Positive) return Buffer_Size is
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
                                  Line   : in Positive) return Boolean is
      Info : Comment_Info renames Lines (Line).Style;
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
      Limit  : constant Natural := (Lines'Length / 2);
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

   procedure Boxed_License (Lines  : in Line_Array;
                            Buffer : in Buffer_Type;
                            First  : in Positive;
                            Last   : in Positive;
                            Spaces : out Natural;
                            Boxed  : out Boolean;
                            Length : out Natural) is
      Line_Length : constant Buffer_Size :=
        Lines (First).Line_End - Lines (First).Line_Start;
      Pos : Buffer_Index;
   begin
      Spaces := 0;
      Boxed := True;
      Length := Natural (Line_Length);
      for I in First .. Last loop
         if Lines (I).Line_End - Lines (I).Line_Start /= Line_Length then
            Boxed := False;
         end if;
         if Lines (I).Style.Start < Lines (I).Style.Last then
            Pos := Skip_Spaces (Buffer, Lines (I).Style.Start, Lines (I).Style.Last);
            if Pos /= Lines (I).Style.Start then
               Spaces := Spaces + Natural (Pos - Lines (I).Style.Start);
            end if;
         end if;
      end loop;
      Spaces := (Spaces + Last - First) / (Last - First + 1);
      if Length > Spaces then
         Length := Length - Spaces;
      end if;
   end Boxed_License;

   procedure Save (Manager : in File_Manager;
                   File    : in out File_Type;
                   Path    : in String;
                   First   : in Natural;
                   Last    : in Natural;
                   License : in String) is
      Buf       : constant Buffer_Accessor := File.Buffer.Value;
      Tmp_Path  : constant String := Path & ".tmp";
      Pos       : constant Buffer_Index := Buf.Data'First;
      Output    : Util.Streams.Files.File_Stream;
      First_Pos : Buffer_Index;
      Next_Pos  : Buffer_Index;
      Spaces    : Natural;
      Is_Boxed  : Boolean;
      Length    : Natural;
   begin
      Log.Info ("Writing license {0} in {1}", License, Path);

      Output.Create (Ada.Streams.Stream_IO.Out_File, Name => Tmp_Path);
      Boxed_License (File.Lines, Buf.Data, First, Last, Spaces, Is_Boxed, Length);

      if File.Lines (First).Comment = LINE_COMMENT then
         First_Pos := File.Lines (First).Style.Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         if Is_Boxed then
            Next_Pos := File.Lines (Last).Style.Last;
            while Next_Pos > First_Pos
              and then not Is_Space (Buf.Data (Next_Pos - 1))
            loop
               Next_Pos := Next_Pos - 1;
            end loop;
         else
            Next_Pos := File.Lines (Last).Style.Last + 1;
         end if;

      elsif File.Lines (First).Comment = LINE_BLOCK_COMMENT then
         First_Pos := File.Lines (First).Style.Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         Next_Pos := File.Lines (Last).Style.Last - 1;
      else
         First_Pos := File.Lines (First).Style.Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         Next_Pos := File.Lines (Last).Style.Last + 1;
      end if;

      if Spaces > 0 then
         while Spaces > 0 loop
            Output.Write (" ");
            Spaces := Spaces - 1;
         end loop;
      end if;
      Output.Write ("SPDX-License-Identifier: " & License);
      if Is_Boxed then
         Spaces := Length - License'Length - String '("SPDX-License-Identifier: ")'Length;
         Spaces := Spaces - Block_Comment_Length (File.Lines (Last).Style.Index) + 1;
         while Spaces > 0 loop
            Output.Write (" ");
            Spaces := Spaces - 1;
         end loop;
      end if;

      if Next_Pos < File.Last_Offset then
         Output.Write (Buf.Data (Next_Pos .. File.Last_Offset));
      end if;

      --  Copy the rest of the file unmodified.
      Util.Streams.Copy (From => File.File, Into => Output);
      Output.Close;
      Util.Files.Rename (Old_Name => Tmp_Path, New_Name => Path);
   end Save;

   --  ------------------------------
   --  Extract from the header the license text that was found.
   --  When no license text was clearly identified, extract the text
   --  found in the header comment.
   --  ------------------------------
   function Extract_License (File    : in File_Type;
                             License : in Infos.License_Info)
                             return Infos.License_Text_Access is
      Buf             : constant Buffer_Accessor := File.Buffer.Value;
      First_Line      : Natural;
      Last_Line       : Natural;
      Size, Len, Skip : Buffer_Size;
   begin
      if License.Match /= Infos.NONE then
         First_Line := License.First_Line;
         Last_Line := License.Last_Line;
      else
         First_Line := 1;
         while First_Line > Last_Line
           and then File.Lines (First_Line).Comment = NO_COMMENT
         loop
            First_Line := First_Line + 1;
         end loop;
         Last_Line := First_Line + 1;
         while Last_Line <= File.Count
           and then File.Lines (Last_Line).Comment /= NO_COMMENT
         loop
            Last_Line := Last_Line + 1;
         end loop;
         Last_Line := Last_Line - 1;
         if Is_Presentation_Line (File.Lines, Buf.Data, First_Line) then
            First_Line := First_Line + 1;
         end if;
         if Is_Presentation_Line (File.Lines, Buf.Data, Last_Line) then
            Last_Line := Last_Line - 1;
         end if;
      end if;
      if First_Line > Last_Line then
         return null;
      end if;
      Skip := Common_Start_Length (File.Lines, Buf.Data, First_Line, Last_Line);
      Size := Buffer_Size (Last_Line - First_Line + 1);
      for I in First_Line .. Last_Line loop
         Len := File.Lines (I).Style.Text_Last
           - File.Lines (I).Style.Text_Start + 1;
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
            Start := File.Lines (I).Style.Text_Start;
            Last := File.Lines (I).Style.Text_Last;
            Len := Last - Start + 1;
            if Len > Skip then
               Start := Start + Skip;
               Len := Len - Skip;
            end if;
            Text.Content (Pos .. Pos + Len - 1) := Buf.Data (Start .. Last);
            Pos := Pos + Len;
            Text.Content (Pos) := LF;
            Pos := Pos + 1;
         end loop;
         return Text;
      end;
   end Extract_License;

   --  ------------------------------
   --  Extract from the header the list of tokens used.  Such list
   --  can be used by the license decision tree to find a matching license.
   --  We could extract more tokens such as tokens which are not really part
   --  of the license header but this is not important as the decision tree
   --  tries to find a best match.
   --  ------------------------------
   procedure Extract_Tokens (File    : in File_Type;
                             Tokens  : in out SPDX_Tool.Buffer_Sets.Set) is
      Buf   : constant Buffer_Accessor := File.Buffer.Value;
      Pos   : Buffer_Index;
      First : Buffer_Index;
      Last  : Buffer_Index;
   begin
      for Line of File.Lines (1 .. File.Count) loop
         if Line.Comment /= NO_COMMENT then
            Pos := Line.Style.Text_Start;
            Last := Line.Style.Text_Last;
            while Pos <= Last loop
               First := Skip_Spaces (Buf.Data, Pos, Last);
               exit when First > Last;
               Pos := Next_Space (Buf.Data, First, Last);
               if First <= Pos - 1 then
                  Tokens.Include (Buf.Data (First .. Pos - 1));
               end if;
            end loop;
         end if;
      end loop;
   end Extract_Tokens;

   --  ------------------------------
   --  Initialize the file manager and prepare the libmagic library.
   --  ------------------------------
   procedure Initialize (Manager : in out File_Manager;
                         Path    : in String) is
   begin
      Magic_Manager.Initialize (Manager.Magic_Manager, Path);
   end Initialize;

end SPDX_Tool.Files;
