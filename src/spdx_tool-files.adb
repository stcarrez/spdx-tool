-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;

with Util.Log.Loggers;
with Util.Files;
with SPDX_Tool.Files.Extensions;
package body SPDX_Tool.Files is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Files");

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
                          Trailer => 0,
                          Index   => Index,
                          Mode    => LINE_COMMENT);
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
                             Trailer => 0,
                             Index   => Index,
                             Mode    => START_COMMENT);
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
         if Len > 0 and then Manager.Magic_Manager.Is_Initialized then
            begin
               File.Ident.Mime := To_UString
                 (Manager.Magic_Manager.Identify (Buf.Data (Buf.Data'First .. Len)));

            exception
               when others =>
                  Log.Error (-("cannot identify mime type for '{0}'"), Path);
            end;
         end if;
         while Pos <= Len loop
            First := Pos;
            Line_No := Line_No + 1;
            File.Lines (Line_No).Line_Start := First;
            Pos := Find_Eol (Buf.Data (Pos .. Len), Pos);
            if Style.Mode in START_COMMENT | BLOCK_COMMENT then
               Style.Start := First;
               Last := Find_End_Comment (Buf.Data, First, Pos, Block_Comments (Style.Index));
               if Last > First then
                  Style.Mode := END_COMMENT;
                  Style.Trailer := Block_Comments (Style.Index).Comment_End.Value.Len;
               else
                  Style.Mode := BLOCK_COMMENT;
                  Last := Pos;
               end if;
               if First < Last then
                  First := Skip_Presentation (Buf.Data, First, Last);
                  Style.Start := First;
               end if;
            else
               Find_Comment (Buf.Data, First, Pos, Style);
               if Style.Mode = START_COMMENT then
                  Last := Find_End_Comment (Buf.Data, First, Pos, Block_Comments (Style.Index));
                  if Last > First then
                     Style.Mode := LINE_BLOCK_COMMENT;
                     Style.Trailer := Block_Comments (Style.Index).Comment_End.Value.Len;
                  end if;
               end if;
            end if;
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
      end;
   end Open;

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
   --  Initialize the file manager and prepare the libmagic library.
   --  ------------------------------
   procedure Initialize (Manager : in out File_Manager;
                         Path    : in String) is
   begin
      Magic_Manager.Initialize (Manager.Magic_Manager, Path);
   end Initialize;

end SPDX_Tool.Files;
