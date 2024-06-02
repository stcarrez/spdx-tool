-- --------------------------------------------------------------------
--  spdx_tool-main -- main for spdx_tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with System.Multiprocessors;
with Ada.Command_Line;
with Ada.Directories;
with Ada.Exceptions;
with Ada.Text_IO;
with GNAT.Command_Line;
with GNAT.Strings;

with Intl;

with Util.Files.Walk;
with Util.Log.Loggers;
with Util.Strings;

with PT.Drivers.Texts;
with PT.Drivers.Texts.GNAT_IO;
with PT.Texts;
with PT.Colors;

with SPDX_Tool.Infos;
with SPDX_Tool.Licenses.Manager;
with SPDX_Tool.Reports;
with SPDX_Tool.Configs.Defaults;
procedure SPDX_Tool.Main is

   package GC renames GNAT.Command_Line;
   package AD renames Ada.Directories;

   use type GNAT.Strings.String_Access;
   use type AD.File_Kind;

   subtype License_Manager is SPDX_Tool.Licenses.Manager.License_Manager;

   procedure Load_Configuration;
   procedure Setup;
   procedure Print_Report (Files : in SPDX_Tool.Infos.File_Map);
   procedure Save_Report (Files : in SPDX_Tool.Infos.File_Map);
   procedure Read_Licenses (Manager : in out License_Manager;
                            Path    : in String);
   function Is_Empty (Arg : in GNAT.Strings.String_Access)
                   return Boolean is (Arg = null or else Arg.all = "");

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Main");

   Command_Config    : GC.Command_Line_Configuration;
   Tool_Config       : SPDX_Tool.Configs.Config_Type;

   procedure Setup is
      Default_Tasks : constant String := " (" & Util.Strings.Image (Opt_Tasks) & ")";
   begin
      Intl.Initialize ("spdx-tool", Configs.Defaults.PREFIX & "/share/locale");

      GC.Set_Usage (Config => Command_Config,
                    Usage  => "[options] [files|directories]",
                    Help   => -("spdx-tool - SPDX license management tool"));

      --  Global configuration.
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Configs.Config_Path'Access,
                        Switch => "-c:",
                        Long_Switch => "--config=",
                        Argument => "PATH",
                        Help   => -("Path of the spdx-tool configuration file"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_No_Color'Access,
                        Long_Switch => "--help",
                        Help   => -("Print program usage"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_No_Color'Access,
                        Long_Switch => "--no-color",
                        Help   => -("Disable colors in output"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.Opt_No_Builtin'Access,
                        Long_Switch => "--no-builtin-licenses",
                        Help   => -("Disable internal builtin license repository"));
      if Configs.Defaults.DEBUG then
         GC.Define_Switch (Config => Command_Config,
                           Output => SPDX_Tool.Licenses.Opt_Perf_Report'Access,
                           Long_Switch => "--print-perf-report",
                           Help   => "Print performance report (debugging)");
      end if;
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Tasks'Access,
                        Switch => "-t:",
                        Long_Switch => "--thread=",
                        Argument => "COUNT",
                        Initial  => Opt_Tasks,
                        Help   => -("Number of threads to process the files")
                        & Default_Tasks);
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Version'Access,
                        Switch => "-V",
                        Long_Switch => "--version",
                        Help   => -("Print the version"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Verbose'Access,
                        Switch => "-v",
                        Long_Switch => "--verbose",
                        Help   => -("Verbose execution mode"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Verbose2'Access,
                        Switch => "-vv",
                        Help   => -("More verbose execution mode"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Debug'Access,
                        Switch => "-vvv",
                        Long_Switch => "--debug",
                        Help   => -("Enable debug execution"));

      --  Global configuration.
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Files'Access,
                        Switch => "-f",
                        Long_Switch => "--files",
                        Help   => -("List files grouped by license name"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Identify'Access,
                        Switch => "-i",
                        Long_Switch => "--identify",
                        Help   => -("Identify the license and only print the SPDX license"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Languages'Access,
                        Switch => "-L",
                        Long_Switch => "--languages",
                        Help   => -("Print languages used in files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Check'Access,
                        Switch => "-l",
                        Long_Switch => "--licenses",
                        Help   => -("Check and gather licenses used in source files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Mimes'Access,
                        Switch => "-m",
                        Long_Switch => "--mimes",
                        Help   => -("Identify mime types of files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Print_Lineno'Access,
                        Switch => "-n",
                        Long_Switch => "--line-number",
                        Help   => -("Add line number when printing license text"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Print'Access,
                        Switch => "-p",
                        Long_Switch => "--print-license",
                        Help   => -("Print license found in header files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.Update_Pattern'Access,
                        Long_Switch => "--update=",
                        Argument => "PATTERN",
                        Help   => -("Update the license to use the SPDX license tag"));

      --  Filtering options
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.Ignore_Languages'Access,
                        Long_Switch => "--ignore-languages=",
                        Argument => "NAMES",
                        Help   => -("Ignore the files with languages in the given list"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.Ignore_Licenses'Access,
                        Long_Switch => "--ignore-licenses=",
                        Argument => "NAMES",
                        Help   => -("Ignore the files with licenses in the given list"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.Only_Languages'Access,
                        Long_Switch => "--only-languages=",
                        Argument => "NAMES",
                        Help   => -("Only consider files with languages in the given list"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.Only_Licenses'Access,
                        Long_Switch => "--only-licenses=",
                        Argument => "NAMES",
                        Help   => -("Only consider files with licenses in the given list"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Reports.Json_Path'Access,
                        Long_Switch => "--output-json=",
                        Argument => "PATH",
                        Help   => -("Generic a JSON report with licenses and files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Reports.Xml_Path'Access,
                        Long_Switch => "--output-xml=",
                        Argument => "PATH",
                        Help   => -("Generic a XML report with licenses and files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.License_Dir'Access,
                        Long_Switch => "--templates=",
                        Argument => "PATH",
                        Help   => -("Path of a license template or a directory with templates"));
      if Configs.Defaults.DEBUG then
         GC.Define_Switch (Config => Command_Config,
                           Output => SPDX_Tool.Licenses.Export_Dir'Access,
                           Long_Switch => "--export=",
                           Argument => "PATH",
                           Help   => "Export the licenses in the directory");
      end if;
   end Setup;

   procedure Print_Report (Files : in SPDX_Tool.Infos.File_Map) is
      Styles : SPDX_Tool.Reports.Style_Configuration;
      Screen : constant PT.Dimension_Type := PT.Drivers.Texts.Screen_Dimension;
      Driver : PT.Drivers.Texts.Printer_Type := PT.Drivers.Texts.Create (Screen);
      Writer : PT.Texts.Printer_Type := PT.Texts.Create (Driver);
   begin
      if not Opt_No_Color then
         Styles.Title := Driver.Create_Style (PT.Colors.White);
         Styles.Default := Driver.Create_Style (PT.Colors.White);
         Styles.Marker1 := Driver.Create_Style (PT.Colors.Green);
         Styles.Marker2 := Driver.Create_Style (PT.Colors.Grey);
         Styles.With_Progress := True;
         Driver.Set_Font (Styles.Title, PT.F_BOLD);
      else
         Styles.Title := Driver.Create_Style;
         Styles.Default := Styles.Title;
         Styles.Marker1 := Styles.Title;
         Styles.Marker2 := Styles.Title;
         Styles.With_Progress := False;
      end if;
      Driver.Set_Fill (Styles.Marker2, PT.Drivers.Texts.F_HLINE2);
      Driver.Set_Fill (Styles.Marker1, PT.Drivers.Texts.F_HLINE2);
      Driver.Set_Flush (PT.Drivers.Texts.GNAT_IO.Flush'Access);
      if Opt_Check then
         SPDX_Tool.Reports.Print_Licenses (Driver, Styles, Files);
      elsif Opt_Identify then
         SPDX_Tool.Reports.Print_Identify (Driver, Styles, Files);
      end if;
      if Opt_Files then
         if Opt_Check then
            Writer.New_Line;
         end if;
         SPDX_Tool.Reports.Print_Files (Driver, Styles, Files);
      end if;
      if Opt_Mimes then
         if Opt_Check or else Opt_Files then
            Writer.New_Line;
         end if;
         SPDX_Tool.Reports.Print_Mimes (Driver, Styles, Files);
      end if;
      if Opt_Languages then
         if Opt_Check or else Opt_Files or else Opt_Mimes then
            Writer.New_Line;
         end if;
         SPDX_Tool.Reports.Print_Languages (Driver, Styles, Files);
      end if;
      if Opt_Print then
         if Opt_Check or else Opt_Files or else Opt_Mimes then
            Writer.New_Line;
         end if;
         SPDX_Tool.Reports.Print_Texts (Driver, Styles, Files, Opt_Print_Lineno);
      end if;
   end Print_Report;

   procedure Save_Report (Files : in SPDX_Tool.Infos.File_Map) is
   begin
      if not Is_Empty (SPDX_Tool.Reports.Json_Path) then
         SPDX_Tool.Reports.Write_Json (SPDX_Tool.Reports.Json_Path.all, Files);
      end if;
      if not Is_Empty (SPDX_Tool.Reports.Xml_Path) then
         SPDX_Tool.Reports.Write_Xml (SPDX_Tool.Reports.Xml_Path.all, Files);
      end if;
   end Save_Report;

   procedure Report_Summary is
     new SPDX_Tool.Licenses.Manager.Report (Print_Report);
   procedure Save_Summary is
     new SPDX_Tool.Licenses.Manager.Report (Save_Report);

   procedure Read_Licenses (Manager : in out License_Manager;
                            Path    : in String) is
      Filter : Util.Files.Walk.Filter_Type;
   begin
      Manager.Configure (Tool_Config, Licenses.Manager.LOAD_LICENSES);
      Filter.Include ("*.jsonld");
      Filter.Include ("*.txt");
      Filter.Exclude ("*");
      if not AD.Exists (Path) then
         Log.Error ("path '{0}' does not exist", Path);
         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      elsif AD.Kind (Path) = AD.Directory then
         Manager.Scan (Path, Filter);
      else
         Manager.Load_License (Path);
      end if;
   end Read_Licenses;

   procedure Load_Configuration is
   begin
      if Configs.Config_Path.all /= "" then
         if not Ada.Directories.Exists (Configs.Config_Path.all) then
            Log.Error ("configuration file '{0}' does not exist.",
                       Configs.Config_Path.all);
            Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
            raise GNAT.Command_Line.Exit_From_Command_Line;
         end if;
         Tool_Config.Read (Configs.Config_Path.all);
      else
         Tool_Config.Load_Default;
      end if;
   end Load_Configuration;

begin
   Opt_Tasks := Integer (System.Multiprocessors.Number_Of_CPUs);
   Setup;
   Configure_Logs (False, False);
   GC.Initialize_Option_Scan (Stop_At_First_Non_Switch => True);
   GC.Getopt (Config => Command_Config);
   if Opt_Debug or Opt_Verbose then
      Configure_Logs (Opt_Debug, Opt_Verbose);
   end if;
   if Opt_Version then
      Ada.Text_IO.Put_Line ("SPDX tool " & Configs.Defaults.VERSION);
      return;
   end if;
   if not (Opt_Tasks in Task_Count'Range) then
      Log.Error ("invalid number of tasks: {0}",
                 Util.Strings.Image (Opt_Tasks));
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;
   end if;
   Load_Configuration;
   if Opt_Identify or else Opt_Print then
      Opt_No_Color := True;
   end if;
   if not Opt_Files and not Opt_Check and not Opt_Update
     and not Opt_Print and not Opt_Identify
     and not Opt_Languages
   then
      Opt_Check := True;
   end if;
   declare
      Manager : License_Manager (Opt_Tasks);
      Filter  : Util.Files.Walk.Filter_Type;
   begin
      if Licenses.Only_Licenses /= null then
         Manager.Set_Filter (List     => Licenses.Only_Licenses.all,
                             Language => False,
                             Exclude  => False);
      end if;
      if Licenses.Ignore_Licenses /= null then
         Manager.Set_Filter (List     => Licenses.Ignore_Licenses.all,
                             Language => False,
                             Exclude  => True);
      end if;
      if Licenses.Only_Languages /= null then
         Manager.Set_Filter (List     => Licenses.Only_Languages.all,
                             Language => True,
                             Exclude  => False);
      end if;
      if Licenses.Ignore_Languages /= null then
         Manager.Set_Filter (List     => Licenses.Ignore_Languages.all,
                             Language => True,
                             Exclude  => True);
      end if;
      if Licenses.License_Dir /= null
        and then Licenses.License_Dir.all /= ""
      then
         Read_Licenses (Manager, Licenses.License_Dir.all);
      end if;
      if SPDX_Tool.Licenses.Update_Pattern /= null
        and then SPDX_Tool.Licenses.Update_Pattern.all /= ""
      then
         Manager.Configure (Tool_Config, Licenses.Manager.UPDATE_LICENSES);
         Manager.Set_Update_Pattern (SPDX_Tool.Licenses.Update_Pattern.all);
      else
         Manager.Configure (Tool_Config, Licenses.Manager.READ_LICENSES);
      end if;
      Filter.Exclude (".git");
      loop
         declare
            Arg : constant String := GC.Get_Argument;
         begin
            exit when Arg'Length = 0;
            if not AD.Exists (Arg) then
               Log.Error ("path '{0}' does not exist", Arg);
               Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
            elsif AD.Kind (Arg) = AD.Directory then
               Manager.Scan (Arg, Filter);
            else
               Manager.Analyze (Arg);
            end if;
         end;
      end loop;
      Manager.Wait;
      if not Is_Empty (SPDX_Tool.Reports.Json_Path)
        or else not Is_Empty (SPDX_Tool.Reports.Xml_Path)
      then
         Save_Summary (Manager);
      else
         Report_Summary (Manager);
      end if;
   end;
   if Configs.Defaults.DEBUG and then SPDX_Tool.Licenses.Opt_Perf_Report then
      SPDX_Tool.Licenses.Performance_Report;
   end if;

exception
   when E : SPDX_Tool.Licenses.Manager.Invalid_Pattern =>
      Log.Error ("invalid option --update: {}", Ada.Exceptions.Exception_Message (E));
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

   when SPDX_Tool.Configs.Error |
        GNAT.Command_Line.Exit_From_Command_Line |
        GNAT.Command_Line.Invalid_Switch =>
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

   when E : others =>
      Log.Error ("some internal error occurred", E);
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

end SPDX_Tool.Main;
