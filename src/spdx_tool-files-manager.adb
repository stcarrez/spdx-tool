-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;
with Ada.IO_Exceptions;
with Interfaces.C.Strings;

with Util.Log.Loggers;
with Util.Files;
with Util.Streams.Files;
with Util.Systems.Types;
with Util.Systems.Os;
with Util.Systems.Constants;
package body SPDX_Tool.Files.Manager is

   use type SPDX_Tool.Infos.Line_Count;

   Log : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("SPDX_Tool.Files");

   --  ------------------------------
   --  Identify the language used by the given file.
   --  ------------------------------
   procedure Find_Mime_Type (Manager : in File_Manager;
                             File    : in out SPDX_Tool.Infos.File_Info;
                             Buffer  : in Buffer_Type) is
   begin
      if Buffer'Length > 0 and then Manager.Magic_Manager.Is_Initialized then
         declare
            Mime : constant String
              := Manager.Magic_Manager.Identify (Buffer);
         begin
            File.Mime := To_UString (Mime);
         end;
      end if;

   exception
      when others =>
         Log.Error ("cannot identify mime type for '{0}'", File.Path);
   end Find_Mime_Type;

   --  ------------------------------
   --  Open the file and read the first data block (4K) to identify the
   --  language and comment headers.
   --  ------------------------------
   procedure Open (Manager   : in File_Manager;
                   Tokens    : in SPDX_Tool.Token_Counters.Token_Maps.Map;
                   Data      : in out File_Type;
                   File      : in out SPDX_Tool.Infos.File_Info;
                   Languages : in SPDX_Tool.Languages.Manager.Language_Manager) is
      use Util.Systems.Constants;
      use type Util.Systems.Types.File_Type;
      use type Interfaces.C.int;

      Fd         : Util.Systems.Types.File_Type := Util.Systems.Os.NO_FILE;
      P          : Interfaces.C.Strings.chars_ptr;
      Flags      : constant Interfaces.C.int := O_CLOEXEC + O_RDONLY;
   begin
      Log.Debug ("Open file {0}", File.Path);

      P := Interfaces.C.Strings.New_String (File.Path);
      Fd := Util.Systems.Os.Sys_Open (P, Flags, 0);
      Interfaces.C.Strings.Free (P);
      if Fd = Util.Systems.Os.NO_FILE then
         raise Ada.IO_Exceptions.Name_Error with File.Path;
      end if;
      Data.File.Initialize (File => Fd);
      Data.Buffer := Manager.Buffer;
      Data.Count := 0;
      declare
         Buf      : constant Buffer_Accessor := Data.Buffer.Value;
         Analyzer : SPDX_Tool.Languages.Analyzer_Access;
         Len      : Buffer_Size;
      begin
         Data.File.Read (Into => Buf.Data, Last => Len);
         Data.Last_Offset := Len;
         SPDX_Tool.Languages.Find_Lines (Buf.Data (Buf.Data'First .. Len), Data.Lines, Data.Count);
         Manager.Find_Mime_Type (File, Buf.Data (Buf.Data'First .. Len));
         Languages.Find_Language (Tokens, File, Data, Analyzer);
      end;
   end Open;

   --  ------------------------------
   --  Save the file to replace the header license template by the corresponding
   --  SPDX license header.
   --  ------------------------------
   procedure Save (Manager : in File_Manager;
                   File    : in out File_Type;
                   Path    : in String;
                   First   : in Infos.Line_Number;
                   Last    : in Infos.Line_Number;
                   Before  : in Line_Range_Type;
                   After   : in Line_Range_Type;
                   License : in String) is
      procedure Copy_Line (Line : in Line_Count);

      Buf       : constant Buffer_Accessor := File.Buffer.Value;
      Tmp_Path  : constant String := Path & ".tmp";
      Pos       : constant Buffer_Index := Buf.Data'First;
      Output    : Util.Streams.Files.File_Stream;
      First_Pos : Buffer_Size;
      Next_Pos  : Buffer_Index;
      Last_Pos  : Buffer_Index;
      Spaces    : Buffer_Size;
      Length    : Buffer_Size;
      Line      : Line_Count := First;
      Spaces_After : Buffer_Size := 0;

      procedure Copy_Line (Line : in Line_Count) is
         Start_Pos : constant Buffer_Index := File.Lines (Line).Line_Start;
         Last_Pos  : constant Buffer_Index := File.Lines (Line + 1).Line_Start - 1;
      begin
         Output.Write (Buf.Data (Start_Pos .. Last_Pos));
      end Copy_Line;
   begin
      Log.Info ("writing license {0} in {1}", License, Path);

      Output.Create (Ada.Streams.Stream_IO.Out_File, Name => Tmp_Path);

      --  Keep some license lines before the inserted SPDX license tag.
      if Before.First_Line = 1 then
         Line := Line + Before.Last_Line;
         if Line > File.Lines'Last then
            Line := File.Lines'Last;
         end if;
      end if;

      if File.Lines (Line).Comment = LINE_COMMENT then
         if Before.First_Line <= 1 then
            First_Pos := File.Lines (Line).Style.Text_Start;
         else
            First_Pos := File.Lines (Line).Line_Start;
            First_Pos := First_Pos - 1;
         end if;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;

         --  Some license lines are dropped but we must keep some others
         --  before the SPDX license tag.
         if Before.First_Line > 1 then
            Line := First + Before.First_Line - 1;
            if Line < File.Lines'Last then
               First_Pos := File.Lines (Line - 1).Line_End + 1;
               Line := First + Before.Last_Line;
               if Line > File.Lines'Last then
                  Line := File.Lines'Last;
               end if;
               Next_Pos := File.Lines (Line).Style.Text_Start;
               if Next_Pos > First_Pos then
                  Output.Write (Buf.Data (First_Pos .. Next_Pos - 1));
               end if;
               First_Pos := Next_Pos;
            end if;
         end if;
         if File.Lines (First).Style.Boxed then
            Next_Pos := File.Lines (Line).Style.Text_Last;
            Last_Pos := File.Lines (Last).Style.Text_Last;
            while Next_Pos > First_Pos
              and then not Is_Space (Buf.Data (Next_Pos - 1))
            loop
               Next_Pos := Next_Pos - 1;
            end loop;
         else
            Next_Pos := File.Lines (Line).Style.Last + 1;
            Last_Pos := File.Lines (Last).Style.Last + 1;
         end if;
         Spaces := Languages.Common_Start_Length (File.Lines, Buf.Data, First, Last);

      elsif File.Lines (Line).Comment = LINE_BLOCK_COMMENT then
         First_Pos := File.Lines (Line).Style.Text_Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         Next_Pos := File.Lines (Last).Style.Text_Last - 1;
         Last_Pos := Next_Pos;
         if Line > 1 then
            Spaces := File.Lines (Line - 1).Style.Text_Start
                         - File.Lines (Line - 1).Line_Start + 1;
         else
            Spaces := Languages.Common_Start_Length (File.Lines, Buf.Data, First, Last);
         end if;
      else
         First_Pos := File.Lines (Line).Style.Text_Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         Next_Pos := File.Lines (Last).Style.Text_Last + 1;
         Last_Pos := Next_Pos;
         if File.Lines (Last).Comment = END_COMMENT then
            Spaces_After := 1;
         else
            Spaces_After := 0;
         end if;
         if Line > 1 then
            Spaces := File.Lines (Line - 1).Style.Text_Start
                         - File.Lines (Line - 1).Line_Start + 1;
            Length := File.Lines (Line).Style.Text_Start
                         - File.Lines (Line).Line_Start + 1;
            if Length >= Spaces then
               Spaces := 0;
            else
               Spaces := Spaces - Length;
            end if;
         else
            Spaces := Languages.Common_Start_Length (File.Lines, Buf.Data, First, Last);
         end if;
      end if;

      for I in 1 .. Spaces loop
         Output.Write (" ");
      end loop;
      Output.Write ("SPDX-License-Identifier: " & License);
      if File.Lines (First).Style.Boxed then
         Length := Languages.Max_Length (File.Lines, First, Last);
         Spaces := Length - License'Length - String '("SPDX-License-Identifier: ")'Length - Spaces;
         Spaces := Spaces - (File.Lines (First).Style.Text_Start - File.Lines (First).Line_Start);
         Spaces := Spaces - (File.Lines (Last).Line_End - Last_Pos + 1);
         while Spaces > 0 loop
            Output.Write (" ");
            Spaces := Spaces - 1;
         end loop;
      elsif Spaces_After > 0 then
         Output.Write (" ");
      end if;

      if After.First_Line > 0 and then Line + 1 <= File.Lines'Last then
         declare
            Keep_Pos : constant Buffer_Index := File.Lines (Line + 1).Line_Start - 1;
         begin
            if Next_Pos <= Keep_Pos then
               Output.Write (Buf.Data (Next_Pos .. Keep_Pos));
            end if;
         end;
         Line := First + After.First_Line - 1;
         while Line <= File.Lines'Last loop
            Copy_Line (Line);
            Line := Line + 1;
            exit when Line >= First + After.Last_Line;
         end loop;
         Last_Pos := Last_Pos + 1;
      end if;
      if Last_Pos < File.Last_Offset then
         Output.Write (Buf.Data (Last_Pos .. File.Last_Offset));
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
      if Path'Length > 0 then
         Magic_Manager.Initialize (Manager.Magic_Manager, Path);
      end if;
      Manager.Buffer := Create_Buffer (8192);
   end Initialize;

end SPDX_Tool.Files.Manager;
