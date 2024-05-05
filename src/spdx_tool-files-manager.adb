-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;

with Util.Log.Loggers;
with Util.Files;
package body SPDX_Tool.Files.Manager is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Files");

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
         Log.Error (-("cannot identify mime type for '{0}'"), File.Path);
   end Find_Mime_Type;

   --  ------------------------------
   --  Open the file and read the first data block (4K) to identify the
   --  language and comment headers.
   --  ------------------------------
   procedure Open (Manager   : in File_Manager;
                   Data      : in out File_Type;
                   File      : in out SPDX_Tool.Infos.File_Info;
                   Languages : in SPDX_Tool.Languages.Manager.Language_Manager) is
   begin
      Log.Debug ("Open file {0}", File.Path);

      Data.File.Open (Mode => Ada.Streams.Stream_IO.In_File, Name => File.Path);
      Data.Buffer := Create_Buffer (4096);
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
         Languages.Find_Language (File, Data, Analyzer);
         SPDX_Tool.Languages.Boxed_License (Data.Lines (Data.Lines'First .. Data.Count),
                                            Buf.Data, Data.Boxed);
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
                   License : in String) is
      Buf       : constant Buffer_Accessor := File.Buffer.Value;
      Tmp_Path  : constant String := Path & ".tmp";
      Pos       : constant Buffer_Index := Buf.Data'First;
      Output    : Util.Streams.Files.File_Stream;
      First_Pos : Buffer_Index;
      Next_Pos  : Buffer_Index;
      Spaces    : Buffer_Size;
      Length    : Buffer_Size;
   begin
      Log.Info ("Writing license {0} in {1}", License, Path);

      Output.Create (Ada.Streams.Stream_IO.Out_File, Name => Tmp_Path);

      if File.Lines (First).Comment = LINE_COMMENT then
         First_Pos := File.Lines (First).Style.Text_Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         if File.Lines (First).Style.Boxed then
            Next_Pos := File.Lines (Last).Style.Text_Last;
            while Next_Pos > First_Pos
              and then not Is_Space (Buf.Data (Next_Pos - 1))
            loop
               Next_Pos := Next_Pos - 1;
            end loop;
         else
            Next_Pos := File.Lines (Last).Style.Last + 1;
         end if;

      elsif File.Lines (First).Comment = LINE_BLOCK_COMMENT then
         First_Pos := File.Lines (First).Style.Text_Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         Next_Pos := File.Lines (Last).Style.Text_Last - 1;
      else
         First_Pos := File.Lines (First).Style.Text_Start;
         if First_Pos > Pos then
            Output.Write (Buf.Data (Buf.Data'First .. First_Pos - 1));
         end if;
         Next_Pos := File.Lines (Last).Style.Text_Last + 1;
      end if;

      Spaces := Languages.Common_Start_Length (File.Lines, Buf.Data, First, Last);
      for I in 1 .. Spaces loop
         Output.Write (" ");
      end loop;
      Output.Write ("SPDX-License-Identifier: " & License);
      if File.Lines (First).Style.Boxed then
         Length := Languages.Max_Length (File.Lines, First, Last);
         Spaces := Length - License'Length - String '("SPDX-License-Identifier: ")'Length - Spaces;
         Spaces := Spaces - (File.Lines (First).Style.Text_Start - File.Lines (First).Line_Start);
         Spaces := Spaces - (File.Lines (Last).Line_End - Next_Pos + 1);
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

end SPDX_Tool.Files.Manager;
