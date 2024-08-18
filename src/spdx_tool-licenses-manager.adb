-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;
with Ada.Strings.Fixed;
with Ada.Unchecked_Deallocation;

with Util.Strings;
with Util.Strings.Tokenizers;
with Util.Log.Loggers;
with Util.Streams.Files;

with SCI.Similarities.COO_Arrays;
with SPDX_Tool.Configs.Default;
with SPDX_Tool.Licenses.Templates;
with SPDX_Tool.Licenses.Reader;
package body SPDX_Tool.Licenses.Manager is

   use all type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;
   use type GNAT.Strings.String_Access;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   function Is_Info_Log return Boolean
      is (Util.Log.Loggers.Get_Level (Log) <= Util.Log.INFO_LEVEL);

   function To_Float (Value : Float) return Float is (Value);
   function Is_Git_Submodule (Path : in String) return Boolean;

   package Similarities is
      new SCI.Similarities.COO_Arrays (Arrays      => Freq_Transformers.Frequency_Arrays,
                                       Conversions => Confidence_Conversions,
                                       To_Float    => To_Float);

   File_Mgr : SPDX_Tool.Files.Manager.File_Manager_Access := null with Thread_Local_Storage;

   --  ------------------------------
   --  Setup the update pattern when the tool must replace the existing license
   --  with an SPDX-License tag.  The pattern allows to define a set of lines to
   --  keep before and after the SPDX-License tag.  The pattern format is:
   --     {[line|line-range](.:,)}spdx{(.:,)[line|line-range]}
   --  Example:
   --     spdx
   --     1..3:spdx
   --     1,spdx,2
   --  ------------------------------
   procedure Set_Update_Pattern (Manager : in out License_Manager;
                                 Pattern : in String) is
      function Is_Separator (C : Character) return Boolean
         is (C in '.' | ',' | ':');
      Pos : constant Natural := Ada.Strings.Fixed.Index (Pattern, "spdx");
   begin
      if Pos = 0 then
         raise Invalid_Pattern with -("missing 'spdx' tag in the pattern");
      end if;

      if Pos = Pattern'First then
         Manager.Before.First_Line := 0;
         Manager.Before.Last_Line := 0;
      elsif not Is_Separator (Pattern (Pos - 1)) or else Pos - 1 = Pattern'First then
         raise Invalid_Pattern with -("invalid update pattern");
      else
         Manager.Before := Infos.Get_Range (Pattern (Pattern'First .. Pos - 2));
      end if;

      if Pos + 3 = Pattern'Last then
         Manager.After.First_Line := 0;
         Manager.After.Last_Line := 0;
      elsif not Is_Separator (Pattern (Pos + 4)) or else Pos + 4 = Pattern'Last then
         raise Invalid_Pattern with -("invalid update pattern");
      else
         Manager.After := Infos.Get_Range (Pattern (Pos + 5 .. Pattern'Last));
      end if;
   end Set_Update_Pattern;

   --  ------------------------------
   --  Configure the license manager.
   --  ------------------------------
   procedure Configure (Manager : in out License_Manager;
                        Config  : in SPDX_Tool.Configs.Config_Type) is
      procedure Set_Ignore (Pattern : in String);
      procedure Load_Ignore_File (Path : in String);
      procedure Load_Ignore_Content (Label   : in String;
                                     Content : in String);

      procedure Set_Ignore (Pattern : in String) is
      begin
         if Pattern'Length > 0 then
            if Pattern (Pattern'First) = '!' then
               if Opt_Verbose2 then
                  Log.Info ("Include pattern {0}",
                  Pattern (Pattern'First + 1 .. Pattern'Last));
               end if;
               Manager.Ignore_Files_Filter.Include
                 (Pattern (Pattern'First + 1 .. Pattern'Last));
            else
               if Opt_Verbose2 then
                  Log.Info ("Exclude pattern {0}", Pattern);
               end if;
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
            Log.Error ("invalid builtin ignore file {0}", Path);
         elsif Ada.Directories.Exists (Path) then
            Util.Files.Walk.Load_Ignore (Manager.Ignore_Files_Filter, Path);
         else
            Log.Error ("ignore file {} not found", Path);
         end if;
      end Load_Ignore_File;

   begin
      Configs.Configure (Config,
                         Configs.Names.IGNORE,
                         Set_Ignore'Access);
      Configs.Configure (Config,
                         Configs.Names.IGNORE_FILES,
                         Load_Ignore_File'Access);
      --  Manager.Languages.Initialize (Config, (if Job = FIND_LANGUAGES
      --                                         then Languages.Manager.IDENTIFY_LANGUAGE
      --                                         else Languages.Manager.IDENTIFY_COMMENTS));
   end Configure;

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
               if Opt_Verbose2 then
                  Log.Info ("Include pattern {0}",
                  Pattern (Pattern'First + 1 .. Pattern'Last));
               end if;
               Manager.Ignore_Files_Filter.Include
                 (Pattern (Pattern'First + 1 .. Pattern'Last));
            else
               if Opt_Verbose2 then
                  Log.Info ("Exclude pattern {0}", Pattern);
               end if;
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
            Log.Error ("invalid builtin ignore file {0}", Path);
         elsif Ada.Directories.Exists (Path) then
            Util.Files.Walk.Load_Ignore (Manager.Ignore_Files_Filter, Path);
         else
            Log.Error ("ignore file {} not found", Path);
         end if;
      end Load_Ignore_File;

      Stamp   : Util.Measures.Stamp;
   begin
      Manager.Configure (Config);
      Manager.Languages.Initialize (Config, (if Job = FIND_LANGUAGES
                                               then Languages.Manager.IDENTIFY_LANGUAGE
                                               else Languages.Manager.IDENTIFY_COMMENTS));

      --  Setup the list of license tokens
      if not Opt_No_Builtin and then Job /= FIND_LANGUAGES then
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
            Manager.Token_Frequency.Cells.Clear;
            Freq_Transformers.TIDF (From     => Manager.Token_Counters,
                                    Doc_Freq => F,
                                    Into     => Manager.Token_Frequency);
            Manager.License_Frequency := new Freq_Transformers.Frequency_Array '(F);
            Manager.License_Squares := new Float_Array (Licenses.Templates.List'Range);

            --  Pre-compute for each license, the Sqrt of sum of square of token frequencies.
            for I in Manager.License_Squares'Range loop
               Manager.License_Squares (I)
                  := Similarities.Sqrt_Square (Manager.Token_Frequency, I);
            end loop;
         end;
      end if;
      if not Manager.Started then
         declare
            Path : constant String := (if Opt_Mimes then "/usr/share/misc/magic" else "");
         begin
            for I in Manager.File_Mgr'Range loop
               Manager.File_Mgr (I).Initialize (Path);
            end loop;
         end;
         Manager.Executor.Start;
         Manager.Started := True;
      end if;
      Manager.Job := Job;
      Util.Measures.Set_Current (Perf'Access);
      SPDX_Tool.Licenses.Report (Stamp, "configure license manager");
   end Configure;

   --  ------------------------------
   --  Load a .spdxtool configuration file at the root of a project with
   --  the given path.
   --  ------------------------------
   procedure Load_Project_Configuration (Manager : in out License_Manager;
                                         Path    : in String) is
      Config_Path : constant String := Util.Files.Compose (Path, ".spdxtool");
   begin
      if not Ada.Directories.Exists (Config_Path) then
         return;
      end if;
      declare
         Config : SPDX_Tool.Configs.Config_Type;
      begin
         Config.Read (Config_Path);
         Manager.Configure (Config);
      end;
   end Load_Project_Configuration;

   --  ------------------------------
   --  Load the license templates defined in the directory for the license
   --  identification and analysis.
   --  ------------------------------
   procedure Load_Licenses (Manager : in out License_Manager;
                            Path    : in String) is
      Filter : Util.Files.Walk.Filter_Type;
   begin
      Log.Info ("loading licenses from {0}", Path);

      Filter.Include ("*.txt");
      Filter.Exclude ("*");
      Manager.Job := LOAD_LICENSES;
      Manager.Scan (Path, Filter);
      Manager.Job := FIND_LICENSES;
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
               Reader.Load_License (Name, Buffer, L);
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
      Log.Info ("load license template {0}", Path);
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
            Reader.Load_License (Name, Buffer (1 .. Last), Manager.Licenses);
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

   --  ------------------------------
   --  Load the file that contains a list of files to ignore.  The default
   --  implementation reads patterns as defined in `.gitignore` files.
   --  ------------------------------
   overriding
   procedure Load_Ignore (Walker : in out License_Manager;
                          Path   : in String;
                          Filter : in out Util.Files.Walk.Filter_Type'Class) is
   begin
      Log.Info ("Reading ignore file {0}", Path);

      Util.Files.Walk.Walker_Type (Walker).Load_Ignore (Path, Filter);
   end Load_Ignore;

   --  Called when a file is found during the directory tree walk.
   overriding
   procedure Scan_File (Manager : in out License_Manager;
                        Path    : in String) is
      use SPDX_Tool.Infos;
      Job   : License_Job_Type;
      Count : Natural;
      First : Natural;
   begin
      Log.Info ("scan file {0}", Path);
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
            begin
               Manager.Files.Insert (Path (First .. Path'Last), Job.File);
            exception
               when others =>
                  Log.Error ("Exception for " & Path (First .. Path'Last));
            end;
            Manager.Executor.Execute (Job);
            Count := Manager.Executor.Get_Count;
            if Count > Manager.Max_Fill then
               Manager.Max_Fill := Count;
            end if;
      end case;
   end Scan_File;

   function Is_Git_Submodule (Path : in String) return Boolean is
      Git : constant String := Util.Files.Compose (Path, ".git");
   begin
      return Ada.Directories.Exists (Git);
   end Is_Git_Submodule;

   overriding
   procedure Scan_Subdir_For_Ignore (Walker    : in out License_Manager;
                                     Path      : in String;
                                     Scan_Path : in String;
                                     Rel_Path  : in String;
                                     Level     : in Natural;
                                     Filter    : in Util.Files.Walk.Filter_Context_Type) is
   begin
      if Level = 0 then
         Walker.Load_Project_Configuration (Path);
      end if;
      Util.Files.Walk.Walker_Type (Walker).Scan_Subdir_For_Ignore
        (Path, Scan_Path, Rel_Path, Level, Filter);
   end Scan_Subdir_For_Ignore;

   --  ------------------------------
   --  Called when a directory is found during a directory tree walk.
   --  We overide it to check for .git directory or file and skip
   --  that subdirectory unless an option tells us to scan other repos.
   --  ------------------------------
   overriding
   procedure Scan_Subdir (Walker : in out License_Manager;
                          Path   : in String;
                          Filter : in Util.Files.Walk.Filter_Context_Type;
                          Match  : in Util.Files.Walk.Filter_Result) is
   begin
      if Opt_Scan_Submodules or else not Is_Git_Submodule (Path) then
         Util.Files.Walk.Walker_Type (Walker).Scan_Subdir (Path, Filter, Match);
      end if;
   end Scan_Subdir;

   --  ------------------------------
   --  Returns true if the path corresponds to a root path for a project:
   --  * it contains a `.git` directory
   --  ------------------------------
   overriding
   function Is_Root (Walker : in License_Manager;
                     Path   : in String) return Boolean is
   begin
      return Is_Git_Submodule (Path);
   end Is_Root;

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
                  Log.Debug ("Token {0} used by {1} licenses list",
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
      if Util.Log.Loggers.Get_Level (Log) >= Util.Log.DEBUG_LEVEL then
         for Line in From .. To loop
            Log.Debug ("Line {0}: {1}", Util.Strings.Image (Natural (Line)),
                       To_String (To_License_Index_Array (Lines (Line).Licenses)));
         end loop;
      end if;
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

   MIN_CONFIDENCE : constant := 500 * Confidence_Type'Small;

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
      if not Counters.Cells.Is_Empty and then Manager.License_Frequency /= null then
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
                  C := Similarities.Cosine (Freqs, 1, Manager.Token_Frequency, License,
                                            Manager.License_Squares (License));
                  SPDX_Tool.Licenses.Report (Cosine_Stamp, "Cosine");
               end;
               if Opt_Verbose2 then
                  Log.Info ("Confidence with {0} -> {1}",
                            Get_License_Name (License), C'Image);
               end if;
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
            C := Similarities.Cosine (Freqs, 1, Manager.Token_Frequency, Guess,
                                      Manager.License_Squares (Guess));
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
      Checked    : License_Index_Map := EMPTY_MAP;
   begin
      if File.Cmt_Style = NO_COMMENT or else File.Count = 0 then
         Result.Info.Match := Infos.NONE;
         return Result;
      end if;
      Languages.Find_Headers (Buf.Data, File.Lines, File.Count, First_Line, Last_Line);
      Match := Look_SPDX_License (Buf.Data, File.Lines, First_Line, Last_Line);
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
                  if not Is_Set (Checked, License) then
                     Match := Look_License (License, File, First_Line, Last_Line);
                     if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
                        SPDX_Tool.Licenses.Report (Stamp, "Find license from template");
                        return Match;
                     end if;
                     Set_License (Checked, License);
                  end if;
               end loop;
            end;
         end loop;
         Log.Info ("No exact match on {0} licenses",
                   Util.Strings.Image (Get_Count (Checked)));
      end if;
      for Line in First_Line .. Last_Line loop
         if File.Lines (Line).Comment /= NO_COMMENT then
            Match := Look_License_Tree (Manager.Licenses.Root, Buf.Data,
                                        File.Lines, Line, Last_Line);
            if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
               return Match;
            end if;
            if Match.Last /= null then
               if Match.Info.First_Line + 1 < Match.Info.Last_Line then
                  Log.Info ("license missmatch at line{0} after {1} lines ({2} matched)",
                            Match.Info.Last_Line'Image,
                            Infos.Image (Match.Info.Last_Line - Match.Info.First_Line),
                            Infos.Percent_Image (Match.Confidence));
               end if;
               Match.Depth := Match.Last.Depth;
               if Result.Last = null or else Match.Depth > Result.Depth then
                  Result.Last := Match.Last;
                  Result.Depth := Match.Depth;
               end if;
            end if;
         end if;
      end loop;
      for Line in First_Line .. Last_Line loop
         Match := Manager.Guess_License (File.Lines, Line, Last_Line);
         if Match.Info.Match = Infos.GUESSED_LICENSE then
            SPDX_Tool.Licenses.Report (Stamp, "Find license guessed");
            return Match;
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
      function Translate (Token : in String) return String;

      --  Allow users to type these two keywords in their native language.
      Unknown_Label : constant String := -("Unknown");
      None_Label : constant String := -("None");

      function Translate (Token : in String) return String is
      begin
         if Token = None_Label then
            return "None";
         elsif Token = Unknown_Label then
            return "Unknown";
         else
            return Token;
         end if;
      end Translate;

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
               Manager.Exclude_Filters.Include (Translate (Token));
            else
               Manager.Include_Filters.Include (Translate (Token));
            end if;
         end if;
         Done := False;
      end Process;
   begin
      Util.Strings.Tokenizers.Iterate_Tokens (List, ",", Process'Access);
   end Set_Filter;

   --  ------------------------------
   --  Returns true if the language is filtered.
   --  ------------------------------
   function Is_Language_Filtered (Manager : in License_Manager;
                                  File    : in SPDX_Tool.Infos.File_Info) return Boolean is
      Language : constant String := To_String (File.Language);
   begin
      if Manager.Include_Languages.Contains (Language) then
         return False;
      end if;
      if Manager.Exclude_Languages.Contains (Language) then
         return True;
      end if;
      return not Manager.Include_Languages.Is_Empty;
   end Is_Language_Filtered;

   --  ------------------------------
   --  Returns true if the license is filtered.
   --  ------------------------------
   function Is_License_Filtered (Manager : in License_Manager;
                                 File    : in SPDX_Tool.Infos.File_Info) return Boolean is
      Name     : constant String := To_String (File.License.Name);
   begin
      if Manager.Include_Filters.Contains (Name) then
         return False;
      end if;
      if Manager.Exclude_Filters.Contains (Name) then
         return True;
      end if;
      return not Manager.Include_Filters.Is_Empty;
   end Is_License_Filtered;

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
      use type Util.Files.Walk.Filter_Mode;
      Data   : SPDX_Tool.Files.File_Type (100);
      Result : License_Match;
      Filter : Util.Files.Walk.Filter_Mode;
   begin
      Filter := Manager.Ignore_Files_Filter.Match (File.Path);
      if Filter = Util.Files.Walk.Excluded then
         File.Filtered := True;
         Log.Info ("excluded file {0}", File.Path);
         return;
      end if;

      File_Mgr.Open (Data, File, Manager.Languages);
      if File.Filtered then
         return;
      end if;

      --  Check if the language is filtered (no need to identify the license).
      File.Filtered := Manager.Is_Language_Filtered (File);
      if File.Filtered then
         if Is_Info_Log then
            Log.Info ("{0}: {1} (ignored)", File.Path, To_String (File.Language));
         end if;
         return;
      end if;

      if Manager.Job = FIND_LANGUAGES then
         return;
      end if;

      Result := Manager.Find_License (Data);
      File.License := Result.Info;
      if Opt_Print then
         File.Text := SPDX_Tool.Languages.Extract_License
            (Data.Lines, Data.Buffer.Value.Data, File.License);
      end if;
      if File.License.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE | Infos.GUESSED_LICENSE
      then
         File.Filtered := Manager.Is_License_Filtered (File);
         if Is_Info_Log then
            declare
               Name : constant String := To_String (File.License.Name);
               Pos  : constant String := Infos.Lines_Image (File.License);
            begin
               if File.Filtered then
                  Log.Info ("{0}: {1} (ignored at lines {2})", File.Path, Name, Pos);
               else
                  Log.Info ("{0}: {1} at lines {2}", File.Path, Name, Pos);
               end if;
            end;
         end if;
         if not File.Filtered then
            --  Manager.Stats.Increment (Name);
            if Manager.Job = UPDATE_LICENSES and then File.License.Match /= Infos.SPDX_LICENSE then
               File_Mgr.Save
                  (File    => Data,
                   Path    => File.Path,
                   First   => File.License.First_Line,
                   Last    => File.License.Last_Line,
                   Before  => Manager.Before,
                   After   => Manager.After,
                   License => To_String (File.License.Name));
            end if;
         end if;
      elsif Data.Last_Offset = 0 then
         File.License.Name := To_UString (Empty_File);
         File.Filtered := Manager.Is_License_Filtered (File);
         if File.Filtered then
            Log.Info ("{0}: {1} (ignored)", File.Path, Empty_File);
         else
            Log.Info ("{0}: {1}", File.Path, Empty_File);
         end if;
      elsif Data.Cmt_Style = NO_COMMENT then
         File.License.Name := To_UString (No_License);
         File.Filtered := Manager.Is_License_Filtered (File);
         if File.Filtered then
            Log.Info ("{0}: {1} (ignored)", File.Path, No_License);
         else
            Log.Info ("{0} is {1}: {2} lines no comment", File.Path,
                      To_String (File.Language),
                      Image (Data.Count));
         end if;
      else
         File.License.Name := To_UString (Unknown_License);
         File.License.Match := Infos.UNKNOWN_LICENSE;
         File.Filtered := Manager.Is_License_Filtered (File);
         if File.Filtered then
            Log.Info ("{0}: {1} (ignored)", File.Path, Unknown_License);
         else
            Log.Info ("{0} is {1}: {2} lines {3} cmt", File.Path,
                      To_String (File.Language),
                      Image (Data.Count),
                      Image (Data.Cmt_Count));
         end if;
      end if;
   end Analyze;

   procedure Report (Manager : in out License_Manager) is
   begin
      Process (Manager.Files);
   end Report;

   overriding
   procedure Initialize (Manager : in out License_Manager) is
   begin
      Manager.Manager := Manager'Unchecked_Access;
      Manager.Executor := new Executor_Manager (Manager.Count);
   end Initialize;

   overriding
   procedure Finalize (Manager : in out License_Manager) is
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Executor_Manager'Class,
                                         Name   => Executor_Manager_Access);
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Freq_Transformers.Frequency_Array,
                                         Name   => Frequency_Array_Access);
   begin
      Log.Debug ("License manager stopping, max fill {0}",
                 Util.Strings.Image (Manager.Max_Fill));
      Free (Manager.Executor);
      Free (Manager.License_Frequency);

   exception
      when E : others =>
         Log.Error ("exception", E);
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
      Log.Error ("job {0} failed", Job.File.Path);
      Log.Error ("exception", Ex, True);
   end Error;

end SPDX_Tool.Licenses.Manager;
