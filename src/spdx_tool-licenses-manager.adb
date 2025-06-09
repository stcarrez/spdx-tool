-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Strings.Fixed;
with Ada.Unchecked_Deallocation;
with Ada.IO_Exceptions;
with Interfaces.C.Strings;

with Util.Systems.Os;
with Util.Strings;
with Util.Strings.Tokenizers;
with Util.Log.Loggers;

with SPDX_Tool.Configs.Default;
package body SPDX_Tool.Licenses.Manager is

   use all type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   function Is_Info_Log return Boolean
      is (Util.Log.Loggers.Get_Level (Log) <= Util.Log.INFO_LEVEL);

   function Is_Git_Submodule (Path : in String) return Boolean;

   File_Mgr : SPDX_Tool.Files.Manager.File_Manager_Access := null with Thread_Local_Storage;

   function Hash (Item : in File_Id_Type) return Ada.Containers.Hash_Type is
      use Interfaces;

      V : Interfaces.Unsigned_64 := Interfaces.Unsigned_64 (Item.St_Ino);
   begin
      V := V xor Interfaces.Unsigned_64 (Item.St_Dev);
      return Ada.Containers.Hash_Type (V and 16#ffffffff#);
   end Hash;

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
         elsif Path = "spdx-tool:ignore-images.txt" then
            Load_Ignore_Content (Path, SPDX_Tool.Configs.Default.ignore_images);
         elsif Path = "spdx-tool:ignore-bin.txt" then
            Load_Ignore_Content (Path, SPDX_Tool.Configs.Default.ignore_bin);
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
      Stamp   : Util.Measures.Stamp;
   begin
      Manager.Configure (Config);
      Manager.Languages.Initialize (Config, (if Job = FIND_LANGUAGES
                                               then Languages.Manager.IDENTIFY_LANGUAGE
                                               else Languages.Manager.IDENTIFY_COMMENTS));

      Manager.Repository.Initialize_Tokens;
      if Job in FIND_LICENSES | UPDATE_LICENSES then
         Manager.Repository.Configure_Frequencies;
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

   --  ------------------------------
   --  Load the license template from the given path.
   --  ------------------------------
   procedure Load_License (Manager : in out License_Manager;
                           Path    : in String) is
      License : License_Index;
   begin
      Log.Info ("load license template {0}", Path);
      Manager.Repository.Read_License (Path, License);
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

   exception
      when Ada.IO_Exceptions.Use_Error =>
         Log.Error ("error while scanning {0}", Path);
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
      if not Opt_Scan_Submodules and then Is_Git_Submodule (Path) then
         return;
      end if;
      declare
         Id   : File_Id_Type;
         St   : aliased Util.Systems.Types.Stat_Type;
         Name : Util.Systems.Os.Ptr := Interfaces.C.Strings.New_String (Path);
         Res  : Integer;
      begin
         Res := Util.Systems.Os.Sys_Stat (Name, St'Unchecked_Access);
         Interfaces.C.Strings.Free (Name);

         if Res /= 0 then
            return;
         end if;

         Id.St_Dev := St.st_dev;
         Id.St_Ino := St.st_ino;
         if Id.St_Ino > 0 and then Walker.Dir_Scanned.Contains (Id) then
            return;
         end if;

         Walker.Dir_Scanned.Include (Id);
         Util.Files.Walk.Walker_Type (Walker).Scan_Subdir (Path, Filter, Match);
      end;
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

   function Find_License (Manager : in License_Manager;
                          File    : in out SPDX_Tool.Files.File_Type)
                          return License_Match is
      use type Infos.Confidence_Type;
      procedure Find_Exception_Template (Para : in Infos.Line_Range_Type);
      function Find_License_Template (Para : in Infos.Line_Range_Type) return License_Match;

      Buf     : constant Buffer_Accessor := File.Buffer.Value;
      Result  : License_Match := (Last => null, Depth => 0, others => <>);
      Match   : License_Match;
      Stamp   : Util.Measures.Stamp;
      First_Line : Line_Number;
      Last_Line  : Line_Number;
      Checked    : License_Index_Map := EMPTY_MAP;

      procedure Find_Exception_Template (Para : in Infos.Line_Range_Type) is
         Except_Match   : License_Match;
      begin
         for Line in Para.First_Line .. Para.Last_Line loop
            declare
               List  : constant License_Index_Array
                 := Manager.Repository.Find_License_Templates (File.Lines, Line,
                                                               Para.Last_Line, True);
            begin
               for License of List loop
                  if not Is_Set (Checked, License) then
                     Except_Match := Look_License (Manager.Repository.Get_License (License),
                                                   File, First_Line, Last_Line);
                     if Except_Match.Info.Match in Infos.TEMPLATE_LICENSE then
                        Log.Error ("Found exception match {0}",
                                   To_String (Except_Match.Info.Name));
                        return;
                     end if;
                     Set_License (Checked, License);
                  end if;
               end loop;
            end;
         end loop;
         null;
      end Find_Exception_Template;

      function Find_License_Template (Para : in Infos.Line_Range_Type) return License_Match is
         Best : License_Match := (Last => null, Depth => 0, others => <>);
      begin
         for Line in Para.First_Line .. Para.Last_Line loop
            declare
               List  : constant License_Index_Array
                 := Manager.Repository.Find_License_Templates (File.Lines, Line,
                                                               Para.Last_Line, False);
            begin
               for License of List loop
                  if not Is_Set (Checked, License) then
                     Match := Look_License (Manager.Repository.Get_License (License),
                                            File, First_Line, Last_Line);
                     if Match.Info.Match = Infos.TEMPLATE_LICENSE then
                        if Match.Count = 1 then
                           return Match;
                        end if;
                        if Match.Count > 1 then
                           Find_Exception_Template ((Match.Sections (2).Start.Line,
                                                     Match.Sections (2).Last.Line));
                        end if;
                     end if;
                     if Is_Best (Match, Best) then
                        Best := Match;
                     end if;
                     Set_License (Checked, License);
                  end if;
               end loop;
            end;
         end loop;
         return Best;
      end Find_License_Template;

      Best : License_Match := (Last => null, Depth => 0, others => <>);
   begin
      if File.Cmt_Style = NO_COMMENT or else File.Count = 0 then
         Result.Info.Match := Infos.NONE;
         return Result;
      end if;
      Languages.Find_Headers (Buf.Data, File.Lines, File.Count, First_Line, Last_Line);
      Match := Look_SPDX_License (Buf.Data, File.Lines, First_Line, Last_Line);
      if Match.Info.Match = Infos.SPDX_LICENSE then
         return Match;
      end if;
      Manager.Repository.Find_Possible_Licenses (File.Lines, First_Line, Last_Line);
      for Line in First_Line .. Last_Line loop
         Match := Find_License_Template ((Line, Last_Line));
         if Match.Info.Match = Infos.TEMPLATE_LICENSE and then Match.Confidence = 1.0 then
            SPDX_Tool.Licenses.Report (Stamp, "Find license from template");
            return Match;
         end if;
         if Is_Best (Match, Best) then
            Best := Match;
         end if;
      end loop;
      if Best.Depth > 0 then
         Log.Info ("No exact match on {0} licenses, best match {1}"
                   & " with {2} token match at lines {3}",
                   Util.Strings.Image (Get_Count (Checked)),
                   To_String (Best.Info.Name),
                   Infos.Percent_Image (Best.Confidence),
                   Infos.Image (Best.Info.Lines));
      else
         Log.Info ("No exact match and no best lisence on {0} licenses",
                   Util.Strings.Image (Get_Count (Checked)));
      end if;

      declare
         use type Files.Comment_Category;
         Line      : Line_Number := First_Line;
         Next_Line : Line_Number;
      begin
         while Line <= Last_Line loop
            if File.Lines (Line).Style.Category = Files.TEXT then
               Next_Line := Line;
               while Next_Line < Last_Line
                 and then File.Lines (Next_Line).Style.Category in Files.TEXT | Files.EMPTY
                 and then File.Lines (Next_Line + 1).Style.Category in Files.TEXT | Files.EMPTY
               loop
                  Next_Line := Next_Line + 1;
               end loop;
               Match := Find_License_Template ((Line, Next_Line));
               if Match.Info.Match = Infos.TEMPLATE_LICENSE then
                  SPDX_Tool.Licenses.Report (Stamp, "Find license from template");
                  return Match;
               end if;

               Match := Manager.Repository.Guess_License (File.Lines, Line, Next_Line);
               if Match.Info.Match = Infos.GUESSED_LICENSE
                 and then (Result.Info.Match /= Infos.GUESSED_LICENSE
                           or else Match.Info.Confidence > Result.Info.Confidence)
                 and then Match.Info.Lines.First_Line < Match.Info.Lines.Last_Line
               then
                  Result := Match;
               end if;
               exit when Next_Line = Last_Line;
               First_Line := Next_Line + 1;
               Line := Next_Line + 1;
            else
               exit when Line = Last_Line;
               Line := Line + 1;
            end if;
         end loop;
      end;
      if Result.Info.Match /= Infos.GUESSED_LICENSE then
         Result.Info.Lines.First_Line := First_Line;
         Result.Info.Lines.Last_Line := Last_Line;
      else
         SPDX_Tool.Licenses.Report (Stamp, "Find license guessed");
      end if;
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

      File_Mgr.Open (Manager.Repository.Token_Counters.Tokens, Data, File, Manager.Languages);
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
                   First   => File.License.Lines.First_Line,
                   Last    => File.License.Lines.Last_Line,
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
   begin
      Log.Debug ("License manager stopping, max fill {0}",
                 Util.Strings.Image (Manager.Max_Fill));
      Free (Manager.Executor);

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
