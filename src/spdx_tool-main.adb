-- --------------------------------------------------------------------
--  spdx_tool-main -- main for spdx_tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with System.Multiprocessors;
with Ada.Command_Line;
with Ada.Directories;
with GNAT.Command_Line;
with GNAT.Strings;

with Util.Files.Walk;
with Util.Log.Loggers;
with Util.Strings;

with PT.Drivers.Texts;
with PT.Drivers.Texts.GNAT_IO;
with PT.Colors;

with SPDX_Tool.Infos;
with SPDX_Tool.Licenses;
with SPDX_Tool.Reports;
procedure SPDX_Tool.Main is

   package GC renames GNAT.Command_Line;
   package AD renames Ada.Directories;

   use type GNAT.Strings.String_Access;
   use type AD.File_Kind;

   procedure Setup;
   procedure Print_Report (Files : in SPDX_Tool.Infos.File_Map);

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Main");

   Command_Config    : GC.Command_Line_Configuration;

   procedure Setup is
      Default_Tasks : constant String := " (" & Util.Strings.Image (Opt_Tasks) & ")";
   begin
      GC.Set_Usage (Config => Command_Config,
                    Usage  => "[options] [files|directories]",
                    Help   => -("spdx-tool - SPDX license management tool"));
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
                        Output => Opt_Debug'Access,
                        Switch => "-vv",
                        Long_Switch => "--debug",
                        Help   => -("Enable debug execution"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_No_Color'Access,
                        Long_Switch => "--no-color",
                        Help   => -("Disable colors in output"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Check'Access,
                        Switch => "-c",
                        Long_Switch => "--check",
                        Help   => -("Check and gather licenses used in source files"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Update'Access,
                        Switch => "-u",
                        Long_Switch => "--update",
                        Help   => -("Update the license to use a SPDX-License tag"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Files'Access,
                        Switch => "-f",
                        Long_Switch => "--files",
                        Help   => -("List files grouped by license name"));
      GC.Define_Switch (Config => Command_Config,
                        Output => SPDX_Tool.Licenses.License_Dir'Access,
                        Switch => "-l:",
                        Long_Switch => "--license-dir=",
                        Argument => "PATH",
                        Help   => -("Path of a directory with JSON licenses"));
      GC.Define_Switch (Config => Command_Config,
                        Output => Opt_Tasks'Access,
                        Switch => "-t:",
                        Long_Switch => "--thread=",
                        Argument => "COUNT",
                        Initial  => Opt_Tasks,
                        Help   => -("Number of threads to process the files")
                         & Default_Tasks);
   end Setup;

   procedure Print_Report (Files : in SPDX_Tool.Infos.File_Map) is
      Styles    : SPDX_Tool.Reports.Style_Configuration;
      Driver    : PT.Drivers.Texts.Printer_Type := PT.Drivers.Texts.Create (Width => 80);
   begin
      if not Opt_No_Color then
         Styles.Title := Driver.Create_Style (PT.Colors.White);
         Styles.Default := Driver.Create_Style (PT.Colors.White);
         Styles.Marker1 := Driver.Create_Style (PT.Colors.Green);
         Styles.Marker2 := Driver.Create_Style (PT.Colors.Grey);
         Driver.Set_Font (Styles.Title, PT.F_BOLD);
      else
         Styles.Title := Driver.Create_Style;
         Styles.Default := Styles.Title;
         Styles.Marker1 := Styles.Title;
         Styles.Marker2 := Styles.Title;
      end if;
      Driver.Set_Fill (Styles.Marker2, PT.Drivers.Texts.F_HLINE2);
      Driver.Set_Fill (Styles.Marker1, PT.Drivers.Texts.F_HLINE2);
      Driver.Set_Flush (PT.Drivers.Texts.GNAT_IO.Flush'Access);
      if Opt_Check then
         SPDX_Tool.Reports.Print_Licenses (Driver, Styles, Files);
      end if;
      if Opt_Files then
         SPDX_Tool.Reports.Print_Files (Driver, Styles, Files);
      end if;
   end Print_Report;

   procedure Report_Summary is new SPDX_Tool.Licenses.Report (Print_Report);

   F : Util.Files.Walk.Filter_Type;
begin
   Opt_Tasks := Integer (System.Multiprocessors.Number_Of_CPUs);
   Setup;
   Configure_Logs (False, False);
   GC.Initialize_Option_Scan (Stop_At_First_Non_Switch => True);
   GC.Getopt (Config => Command_Config);
   if Opt_Debug or Opt_Verbose then
      Configure_Logs (Opt_Debug, Opt_Verbose);
   end if;
   if not (Opt_Tasks in Task_Count'Range) then
      Log.Error (-("Invalid number of tasks: {0}"),
                 Util.Strings.Image (Opt_Tasks));
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;
   end if;
   if not Opt_Files and not Opt_Check and not Opt_Update then
      Opt_Check := True;
   end if;
   declare
      Manager : SPDX_Tool.Licenses.License_Manager (Opt_Tasks);
   begin
      F.Exclude (".git");
      if Licenses.License_Dir /= null
        and then Licenses.License_Dir.all /= ""
      then
         Manager.Configure (Licenses.SCAN_LICENSES,
                            Task_Count (Opt_Tasks));
         F.Include ("*.jsonld");
         F.Exclude ("*");
         Manager.Scan (Licenses.License_Dir.all, F);
      elsif Opt_Update then
         Manager.Configure (Licenses.UPDATE_LICENSES,
                            Task_Count (Opt_Tasks));
      else
         Manager.Configure (Licenses.READ_LICENSES,
                            Task_Count (Opt_Tasks));
      end if;
      loop
         declare
            Arg : constant String := GC.Get_Argument;
         begin
            exit when Arg'Length = 0;
            if not AD.Exists (Arg) then
               Log.Error (-("path '{0}' does not exist"), Arg);
               Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
            elsif AD.Kind (Arg) = AD.Directory then
               Manager.Scan (Arg, F);
            else
               Manager.Analyze (Arg);
            end if;
         end;
      end loop;
      Manager.Wait;
      Report_Summary (Manager);
      begin
         Manager.Print_Header;
      end;
      --  SPDX_Tool.Files.Report;
   end;

exception
   when GNAT.Command_Line.Exit_From_Command_Line |
        GNAT.Command_Line.Invalid_Switch =>
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

   when E : others =>
      Log.Error (-("some internal error occurred"), E);
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

end SPDX_Tool.Main;
