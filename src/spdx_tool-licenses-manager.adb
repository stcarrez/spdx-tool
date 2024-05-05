-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;

with Util.Strings;
with Util.Strings.Tokenizers;
with Util.Log.Loggers;
with Util.Streams.Files;

with SCI.Similarities.COO_Arrays;
with SPDX_Tool.Licenses.Files;
with SPDX_Tool.Licenses.Reader;
with SPDX_Tool.Configs.Default;
with SPDX_Tool.Licenses.Templates;
package body SPDX_Tool.Licenses.Manager is

   use all type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;
   use type GNAT.Strings.String_Access;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   File_Mgr : SPDX_Tool.Files.Manager.File_Manager_Access := null with Thread_Local_Storage;

   --  ------------------------------
   --  Configure the license manager.
   --  ------------------------------
   procedure Configure (Manager : in out License_Manager;
                        Config  : in SPDX_Tool.Configs.Config_Type;
                        Job     : in Job_Type) is
      procedure Set_Ignore (Pattern : in String);
      procedure Load_Ignore_File (Path : in String);
      procedure Load_Ignore_Content (Label   : in String;
                                     Content : in String);

      procedure Set_Ignore (Pattern : in String) is
      begin
         if Pattern'Length > 0 then
            if Pattern (Pattern'First) = '!' then
               Log.Debug ("Include pattern {0}",
                          Pattern (Pattern'First + 1 .. Pattern'Last));
               Manager.Ignore_Files_Filter.Include
                 (Pattern (Pattern'First + 1 .. Pattern'Last));
            else
               Log.Debug ("Exclude pattern {0}", Pattern);
               Manager.Ignore_Files_Filter.Exclude (Pattern);
            end if;
         end if;
      end Set_Ignore;

      procedure Load_Ignore_Content (Label   : in String;
                                     Content : in String) is
         procedure String_Reader (Process : not null access procedure (Line : in String));

         procedure String_Reader (Process : not null access procedure (Line : in String)) is
            Pos   : Natural := Content'First;
            First : Natural;
         begin
            while Pos <= Content'Last loop
               First := Pos;
               while Pos <= Content'Last and then not (Content (Pos) in ASCII.CR | ASCII.LF) loop
                  Pos := Pos + 1;
               end loop;
               if Pos < Content'Last then
                  Process (Content (First .. Pos - 1));
               elsif not (Content (Content'Last) in ASCII.CR | ASCII.LF) then
                  Process (Content (First .. Content'Last));
               end if;
               Pos := Pos + 1;
            end loop;
         end String_Reader;
      begin
         Manager.Ignore_Files_Filter.Load_Ignore (Label, String_Reader'Access);
      end Load_Ignore_Content;

      procedure Load_Ignore_File (Path : in String) is
      begin
         if Path = "spdx-tool:ignore.txt" then
            Load_Ignore_Content (Path, SPDX_Tool.Configs.Default.ignore);
         elsif Path = "spdx-tool:ignore-docs.txt" then
            Load_Ignore_Content (Path, SPDX_Tool.Configs.Default.ignore_docs);
         elsif Util.Strings.Starts_With (Path, "spdx-tool:") then
            Log.Error ("Invalid builtin ignore file {0}", Path);
         elsif Ada.Directories.Exists (Path) then
            Util.Files.Walk.Load_Ignore (Manager.Ignore_Files_Filter, Path);
         else
            Log.Error ("Ignore file {} not found", Path);
         end if;
      end Load_Ignore_File;

   begin
      Configs.Configure (Config,
                         Configs.Names.IGNORE,
                         Set_Ignore'Access);
      Configs.Configure (Config,
                         Configs.Names.IGNORE_FILES,
                         Load_Ignore_File'Access);
      Manager.Languages.Initialize (Config);

      --  Setup the list of license tokens
      if not Opt_No_Builtin then
         Manager.Token_Counters.Default := 0;
         Manager.Token_Frequency.Default := 0.0;
         for I in Licenses.Templates.List'Range loop
            declare
               Tokens : constant Token_Array_Access := Licenses.Templates.List (I);
            begin
               Counter_Arrays.Fill (Manager.Token_Counters, I, Tokens.all);
            end;
         end loop;
         declare
            F : constant Freq_Transformers.Frequency_Array
               := Freq_Transformers.IDF (Manager.Token_Counters);
         begin
            Freq_Transformers.TIDF (From     => Manager.Token_Counters,
                                    Doc_Freq => F,
                                    Into     => Manager.Token_Frequency);
            Manager.License_Frequency := new Freq_Transformers.Frequency_Array '(F);
         end;
      end if;
      if not Manager.Started then
         if Opt_Mimes then
            for I in Manager.File_Mgr'Range loop
               Manager.File_Mgr (I).Initialize ("/usr/share/misc/magic");
            end loop;
         end if;
         Manager.Manager := Manager'Unchecked_Access;
         Manager.Executor.Start;
         Manager.Started := True;
      end if;
      Manager.Job := Job;
   end Configure;

   --  ------------------------------
   --  Load the license templates defined in the directory for the license
   --  identification and analysis.
   --  ------------------------------
   procedure Load_Licenses (Manager : in out License_Manager;
                            Path    : in String) is
      Filter : Util.Files.Walk.Filter_Type;
   begin
      Log.Info ("Loading licenses from {0}", Path);

      Filter.Include ("*.txt");
      Filter.Exclude ("*");
      Manager.Job := LOAD_LICENSES;
      Manager.Scan (Path, Filter);
      Manager.Job := READ_LICENSES;
   end Load_Licenses;

   procedure Load_Jsonld_License (Manager : in out License_Manager;
                                  Path    : in String) is
      License : Reader.License_Type;
   begin
      Reader.Load (License, Path);
      if Length (License.Name) = 0 then
         Log.Error ("{0}: no license found", Path);
         return;
      end if;
      declare
         Name : constant String := To_String (License.Name);
      begin
         Log.Info ("{0}: {1}", Path, Name);
         if Length (License.Template) > 0
           and then Export_Dir /= null
           and then Export_Dir.all /= ""
         then
            Reader.Save_License (License,
                                 Util.Files.Compose (Export_Dir.all, Name & ".txt"));
         else
            declare
               Content : String := To_String (License.Template);
               Buffer  : Buffer_Type (1 .. Content'Length);
               for Buffer'Address use Content'Address;
               L : License_Template;
            begin
               Load_License (Name, Buffer, L);
            end;
         end if;
      end;
   end Load_Jsonld_License;

   --  ------------------------------
   --  Load the license template from the given path.
   --  ------------------------------
   procedure Load_License (Manager : in out License_Manager;
                           Path    : in String) is
      Name : constant String := Ada.Directories.Base_Name (Path);
      Ext  : constant String := Ada.Directories.Extension (Path);
   begin
      Log.Info ("Load license template {0}", Path);
      if Ext = "jsonld" then
         Manager.Load_Jsonld_License (Path);
      else
         declare
            File   : Util.Streams.Files.File_Stream;
            Buffer : Buffer_Type (1 .. 4096);
            Last   : Ada.Streams.Stream_Element_Offset;
         begin
            File.Open (Mode => Ada.Streams.Stream_IO.In_File, Name => Path);
            File.Read (Into => Buffer, Last => Last);
            Load_License (Name, Buffer (1 .. Last), Manager.Licenses);
         end;
      end if;
   end Load_License;

   --  ------------------------------
   --  Get the path of a file that can be read to get a list of files to ignore
   --  in the given directory (ie, .gitignore).
   --  ------------------------------
   overriding
   function Get_Ignore_Path (Walker : License_Manager;
                             Path   : String) return String is
   begin
      return Util.Files.Compose (Path, ".gitignore");
   end Get_Ignore_Path;

   --  Called when a file is found during the directory tree walk.
   overriding
   procedure Scan_File (Manager : in out License_Manager;
                        Path    : in String) is
      use SPDX_Tool.Infos;
      use type Util.Files.Walk.Filter_Mode;
      Job   : License_Job_Type;
      Count : Natural;
      First : Natural;
      Filter : Util.Files.Walk.Filter_Mode;
   begin
      Filter := Manager.Ignore_Files_Filter.Match (Path);
      if Filter = Util.Files.Walk.Excluded then
         Log.Info ("Excluded file {0}", Path);
         return;
      end if;

      Log.Info ("Scan file {0}", Path);
      case Manager.Job is
         when LOAD_LICENSES =>
            Manager.Load_License (Path);

         when others =>
            if Util.Strings.Starts_With (Path, "./") then
               First := Path'First + 2;
            else
               First := Path'First;
            end if;
            Job.File := new File_Info '(Len  => Path'Last - First + 1,
                                        Path => Path (First .. Path'Last),
                                        others => <>);
            Job.Manager := Manager.Manager;
            Manager.Files.Insert (Path (First .. Path'Last), Job.File);
            Manager.Executor.Execute (Job);
            Count := Manager.Executor.Get_Count;
            if Count > Manager.Max_Fill then
               Manager.Max_Fill := Count;
            end if;
      end case;
   end Scan_File;

   function Get_Stats (Manager : in License_Manager) return Count_Maps.Map is
   begin
      return Manager.Stats.Get_Stats;
   end Get_Stats;

   procedure Wait (Manager : in out License_Manager) is
   begin
      Manager.Executor.Stop;
      Manager.Executor.Wait;
   end Wait;

   function Find_License_Templates (Manager : in License_Manager;
                                    Line    : in SPDX_Tool.Languages.Line_Type)
                                     return License_Index_Map is
      pragma Unreferenced (Manager);

      Result : License_Index_Map := SPDX_Tool.EMPTY_MAP;
      First  : Boolean := True;
   begin
      for Token in Line.Tokens.Cells.Iterate loop
         declare
            Item : Index_Type;
            R    : Algorithms.Result_Type;
         begin
            Item.Token := Counter_Arrays.Maps.Key (Token).Column;
            R := Algorithms.Find (Licenses.Templates.Index, Item);
            if R.Found then
               declare
                  List : constant License_Index_Array_Access := Templates.Index (R.Position).List;
               begin
                  Log.Debug ("Token [{1}] has {2} licenses list",
                             Util.Strings.Image (Natural (Item.Token)),
                             Util.Strings.Image (Natural (List'Length)));
                  if First then
                     Set_Licenses (Result, List.all);
                     First := False;
                  else
                     And_Licenses (Result, List.all);
                  end if;
               end;
            else
               Log.Debug ("Token {0} not found in index",
                          Util.Strings.Image (Natural (Item.Token)));
            end if;
         end;
      end loop;
      return Result;
   end Find_License_Templates;

   procedure Find_License_Templates (Manager : in License_Manager;
                                     Lines   : in out SPDX_Tool.Languages.Line_Array;
                                     From    : in Line_Number;
                                     To      : in Line_Number) is
   begin
      for Line in From .. To loop
         Lines (Line).Licenses := Manager.Find_License_Templates (Lines (Line));
      end loop;
   end Find_License_Templates;

   function Find_License_Templates (Lines   : in SPDX_Tool.Languages.Line_Array;
                                    From    : in Line_Number;
                                    To      : in Line_Number) return License_Index_Array is
      First    : Boolean := True;
      Licenses : License_Index_Map := EMPTY_MAP;
   begin
      for Line in From .. To loop
         if Get_Count (Lines (Line).Licenses) > 0 then
            if First then
               Licenses := Lines (Line).Licenses;
               First := False;
            else
               And_Licenses (Licenses, Lines (Line).Licenses);
            end if;
            exit when Get_Count (Licenses) < 10;
         end if;
      end loop;
      return To_License_Index_Array (Licenses);
   end Find_License_Templates;

   MIN_CONFIDENCE : constant := 700 * Confidence_Type'Small;

   function Compute_Frequency (Manager : in License_Manager;
                               Lines   : in SPDX_Tool.Languages.Line_Array;
                               From    : in Line_Number;
                               To      : in Line_Number) return Frequency_Arrays.Array_Type is
      function Update (First, Second : Count_Type) return Count_Type is (First + Second);
      Stamp    : Util.Measures.Stamp;
      Counters : SPDX_Tool.Counter_Arrays.Array_Type;
      Freqs    : Frequency_Arrays.Array_Type;
   begin
      Counters.Default := 0;
      Freqs.Default := 0.0;
      for Line in From .. To loop
         SPDX_Tool.Counter_Arrays.Merge (Counters, Lines (Line).Tokens, Update'Access);
      end loop;
      if not Counters.Cells.Is_Empty then
         Freq_Transformers.TIDF (From     => Counters,
                                 Doc_Freq => Manager.License_Frequency.all,
                                 Into => Freqs);
      end if;
      SPDX_Tool.Licenses.Report (Stamp, "Compute TIDF");
      return Freqs;
   end Compute_Frequency;

   function Guess_License (Manager : in License_Manager;
                           Lines   : in SPDX_Tool.Languages.Line_Array;
                           From    : in Line_Number;
                           To      : in Line_Number) return License_Match is
      package Similarities is
         new SCI.Similarities.COO_Arrays (Arrays => Freq_Transformers.Frequency_Arrays,
                                          Conversions => Confidence_Conversions);
      function To_Float (Value : Float) return Float is (Float (Value));
      function Cosine is
         new Similarities.Cosine (To_Float => To_Float);

      Guess : License_Index := 0;
      Confidence : Confidence_Type := 0.0;
      C : Confidence_Type;
      Result  : License_Match := (Last => null, Depth => 0, others => <>);
      Stamp   : Util.Measures.Stamp;
      Freqs   : Frequency_Arrays.Array_Type := Manager.Compute_Frequency (Lines, From, To);
   begin
      if not Freqs.Cells.Is_Empty then
         declare
            Licenses : constant License_Index_Array
               := Find_License_Templates (Lines, From, To);
         begin
            for License of Licenses loop
               declare
                  Cosine_Stamp   : Util.Measures.Stamp;
               begin
                  C := Cosine (Freqs, 1, Manager.Token_Frequency, License);
                  SPDX_Tool.Licenses.Report (Cosine_Stamp, "Cosine");
               end;
               Log.Debug ("Confidence with {0} -> {1}",
                          Get_License_Name (License), C'Image);
               if Confidence < C then
                  Confidence := C;
                  Guess := License;
               end if;
            end loop;
         end;
      end if;
      if Confidence >= MIN_CONFIDENCE then
         Result.Info.First_Line := From;
         Result.Info.Last_Line := To;
         for Line in From + 1 .. To - 1 loop
            Freqs := Manager.Compute_Frequency (Lines, Line, To);
            exit when Freqs.Cells.Is_Empty;
            C := Cosine (Freqs, 1, Manager.Token_Frequency, Guess);
            exit when Confidence > C;
            Result.Info.First_Line := Line;
            Confidence := C;
         end loop;
         Result.Info.Match := Infos.GUESSED_LICENSE;
         Result.Info.Confidence := Confidence;
         Result.Info.Name := To_UString (Get_License_Name (Guess));
         SPDX_Tool.Licenses.Report (Stamp, "Guess license");
      end if;
      return Result;
   end Guess_License;

   function Find_License (Manager : in License_Manager;
                          File    : in out SPDX_Tool.Files.File_Type)
                          return License_Match is
      Buf     : constant Buffer_Accessor := File.Buffer.Value;
      Result  : License_Match := (Last => null, Depth => 0, others => <>);
      Match   : License_Match;
      Stamp   : Util.Measures.Stamp;
      First_Line : Line_Number;
      Last_Line  : Line_Number;
   begin
      if File.Cmt_Style = NO_COMMENT or else File.Count = 0 then
         Result.Info.Match := Infos.NONE;
         return Result;
      end if;
      Languages.Find_Headers (Buf.Data, File.Lines, File.Count, First_Line, Last_Line);
      Match := Find_SPDX_License (Buf.Data, File.Lines, First_Line, Last_Line);
      if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
         return Match;
      end if;
      if not Opt_No_Builtin then
         Manager.Find_License_Templates (File.Lines, First_Line, Last_Line);
         for Line in First_Line .. Last_Line loop
            declare
               List  : constant License_Index_Array
                     := Find_License_Templates (File.Lines, Line, Last_Line);
            begin
               for License of List loop
                  Match := Find_License (License, File, First_Line, Last_Line);
                  if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
                     SPDX_Tool.Licenses.Report (Stamp, "Find license from template");
                     return Match;
                  end if;
               end loop;
            end;
         end loop;
         for Line in First_Line .. Last_Line loop
            Match := Manager.Guess_License (File.Lines, Line, Last_Line);
            if Match.Info.Match = Infos.GUESSED_LICENSE then
               --  Match.Info.First_Line := First_Line;
               --  Match.Info.Last_Line := Last_Line;
               SPDX_Tool.Licenses.Report (Stamp, "Find license guessed");
               return Match;
            end if;
         end loop;
      end if;
      for Line in First_Line .. Last_Line loop
         if File.Lines (Line).Comment /= NO_COMMENT then
            Match := Find_License (Manager.Licenses.Root, Buf.Data,
                                   File.Lines, Line, Last_Line);
            if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
               return Match;
            end if;
            if Match.Last /= null then
               Match.Depth := Match.Last.Depth;
               if Result.Last = null or else Match.Depth > Result.Depth then
                  Result.Last := Match.Last;
                  Result.Depth := Match.Depth;
               end if;
            end if;
         end if;
      end loop;
      Result.Info.First_Line := First_Line;
      Result.Info.Last_Line := Last_Line;
      return Result;
   end Find_License;

   --  ------------------------------
   --  Define the list of SPDX license names to ignore.
   --  ------------------------------
   procedure Set_Filter (Manager  : in out License_Manager;
                         List     : in String;
                         Language : in Boolean;
                         Exclude  : in Boolean) is
      procedure Process (Token : in String; Done : out Boolean);
      procedure Process (Token : in String; Done : out Boolean) is
      begin
         if Language then
            if Exclude then
               Manager.Exclude_Languages.Include (Token);
            else
               Manager.Include_Languages.Include (Token);
            end if;
         else
            if Exclude then
               Manager.Exclude_Filters.Include (Token);
            else
               Manager.Include_Filters.Include (Token);
            end if;
         end if;
         Done := False;
      end Process;
   begin
      Util.Strings.Tokenizers.Iterate_Tokens (List, ",", Process'Access);
   end Set_Filter;

   --  ------------------------------
   --  Returns true if the license is filtered.
   --  ------------------------------
   function Is_Filtered (Manager : in License_Manager;
                         File    : in SPDX_Tool.Infos.File_Info) return Boolean is
      Name     : constant String := To_String (File.License.Name);
      Language : constant String := To_String (File.Language);
   begin
      if Manager.Include_Filters.Contains (Name) then
         return False;
      end if;
      if Manager.Exclude_Filters.Contains (Name) then
         return True;
      end if;
      if Manager.Include_Languages.Contains (Language) then
         return False;
      end if;
      if Manager.Exclude_Languages.Contains (Language) then
         return True;
      end if;
      return not Manager.Include_Filters.Is_Empty;
   end Is_Filtered;

   --  ------------------------------
   --  Analyze the file to find license information in the header comment.
   --  ------------------------------
   procedure Analyze (Manager  : in out License_Manager;
                      Path     : in String) is
   begin
      Manager.Scan_File (Path);
   end Analyze;

   procedure Analyze (Manager  : in out License_Manager;
                      File_Mgr : in out SPDX_Tool.Files.Manager.File_Manager;
                      File     : in out SPDX_Tool.Infos.File_Info) is
      Data   : SPDX_Tool.Files.File_Type (100);
      Result : License_Match;
   begin
      File_Mgr.Open (Data, File, Manager.Languages);
      Result := Manager.Find_License (Data);
      File.License := Result.Info;
      if Opt_Print then
         File.Text := SPDX_Tool.Languages.Extract_License
            (Data.Lines, Data.Buffer.Value.Data, File.License);
      end if;
      if File.License.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE | Infos.GUESSED_LICENSE
      then
         declare
            Name : constant String := To_String (File.License.Name);
         begin
            File.Filtered := Manager.Is_Filtered (File);
            if File.Filtered then
               Log.Info ("{0}: {1} (ignored)", File.Path, Name);
            else
               Log.Info ("{0}: {1}", File.Path, Name);
               Manager.Stats.Increment (Name);
               if Manager.Job = UPDATE_LICENSES then
                  File_Mgr.Save
                    (File    => Data,
                     Path    => File.Path,
                     First   => File.License.First_Line,
                     Last    => File.License.Last_Line,
                     License => Name);
               end if;
            end if;
         end;
      elsif Data.Last_Offset = 0 then
         File.License.Name := To_UString (Empty_File);
         File.Filtered := Manager.Is_Filtered (File);
         if File.Filtered then
            Log.Info ("{0}: {1} (ignored)", File.Path, Empty_File);
         else
            Log.Info ("{0}: {1}", File.Path, Empty_File);
         end if;
      else
         if Result.Last /= null then
            declare
               procedure Print_License (License : in Token_Access);
               procedure Print_License (License : in Token_Access) is
                  Token : Token_Access := License;
               begin
                  while Token /= null loop
                     if Token.Alternate /= null then
                        Print_License (Token.Alternate);
                     end if;
                     if Token.Kind = TOK_LICENSE then
                        Log.Error ("Possible license: {0}",
                                   To_String (Final_Token_Type (Token.all).License));
                     end if;
                     Token := Token.Next;
                  end loop;
               end Print_License;
            begin
               Print_License (Result.Last);
            end;
         end if;
         declare
            Cmt_Count : Natural := 0;
         begin
            for I in Data.Lines'Range loop
               if Data.Lines (I).Comment /= NO_COMMENT then
                  Cmt_Count := Cmt_Count + 1;
               end if;
            end loop;
            if Cmt_Count = 0 then
               File.License.Name := To_UString (No_License);
               File.Filtered := Manager.Is_Filtered (File);
               if File.Filtered then
                  Log.Info ("{0}: {1} (ignored)", File.Path, No_License);
               else
                  Log.Info ("{0} is {1}: {2} lines no comment", File.Path,
                            To_String (File.Language),
                            Image (Data.Count));
                  Manager.Stats.Increment (To_String (File.Mime));
               end if;
            else
               File.License.Name := To_UString (Unknown_License);
               File.Filtered := Manager.Is_Filtered (File);
               if File.Filtered then
                  Log.Info ("{0}: {1} (ignored)", File.Path, Unknown_License);
               else
                  Log.Info ("{0} is {1}: {2} lines {3} cmt", File.Path,
                            To_String (File.Language),
                            Image (Data.Count),
                            Util.Strings.Image (Cmt_Count));
                  Manager.Stats.Increment ("unknown " & To_String (File.Mime));
                  Manager.Stats.Add_Header (Data);
               end if;
            end if;
         end;
      end if;
   end Analyze;

   procedure Report (Manager : in out License_Manager) is
   begin
      Process (Manager.Files);
   end Report;

   overriding
   procedure Finalize (Manager : in out License_Manager) is
   begin
      Log.Info ("License manager stopping, max fill {0}",
                Util.Strings.Image (Manager.Max_Fill));
   end Finalize;

   function Get_File_Manager (Manager : in out License_Manager)
                              return SPDX_Tool.Files.Manager.File_Manager_Access is
      Value : Integer;
   begin
      Util.Concurrent.Counters.Increment (Manager.Mgr_Idx, Value);
      return Manager.File_Mgr (Value + 1)'Unchecked_Access;
   end Get_File_Manager;

   procedure Execute (Job : in out License_Job_Type) is
      use type SPDX_Tool.Files.Manager.File_Manager_Access;
   begin
      if File_Mgr = null then
         File_Mgr := Job.Manager.Get_File_Manager;
      end if;
      Job.Manager.Analyze (File_Mgr.all, Job.File.all);
   end Execute;

   procedure Error (Job : in out License_Job_Type;
                    Ex  : in Ada.Exceptions.Exception_Occurrence) is
   begin
      Log.Error ("Job {0} failed", Job.File.Path);
      Log.Error ("Exception", Ex, True);
   end Error;

   procedure Print_Header (Manager : in out License_Manager) is
   begin
      Manager.Stats.Print_Header;
   end Print_Header;

end SPDX_Tool.Licenses.Manager;
