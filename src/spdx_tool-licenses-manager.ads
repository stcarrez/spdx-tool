-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Exceptions;
with Ada.Directories;

with Util.Files.Walk;
with Util.Strings.Sets;
with SPDX_Tool.Files;
with SPDX_Tool.Infos;
private with Util.Executors;
private with Util.Concurrent.Counters;
package SPDX_Tool.Licenses.Manager is

   package UFW renames Util.Files.Walk;

   type Job_Type is (READ_LICENSES, UPDATE_LICENSES, LOAD_LICENSES);

   type License_Manager (Count : Task_Count) is
   limited new UFW.Walker_Type with private;

   --  Configure the license manager.
   procedure Configure (Manager : in out License_Manager;
                        Job     : in Job_Type);

   --  Load the license templates defined in the directory for the license
   --  identification and analysis.
   procedure Load_Licenses (Manager : in out License_Manager;
                            Path    : in String);

   --  Get the path of a file that can be read to get a list of files to ignore
   --  in the given directory (ie, .gitignore).
   overriding
   function Get_Ignore_Path (Walker : License_Manager;
                             Path   : String) return String;

   --  Called when a file is found during the directory tree walk.
   overriding
   procedure Scan_File (Manager : in out License_Manager;
                        Path    : String) with
     Pre'Class => Path'Length > 0 and then Ada.Directories.Exists (Path);

   function Get_Stats (Manager : in License_Manager) return Count_Maps.Map;

   procedure Wait (Manager : in out License_Manager);

   procedure Print_Header (Manager : in out License_Manager);

   --  Load the license template from the given path.
   procedure Load_License (Manager : in out License_Manager;
                           Path    : in String);

   procedure Load_Jsonld_License (Manager : in out License_Manager;
                                  Path    : in String);

   --  Define the list of SPDX license names or list of language filters
   --  to ignore.
   procedure Set_Filter (Manager  : in out License_Manager;
                         List     : in String;
                         Language : in Boolean;
                         Exclude  : in Boolean);

   --  Returns true if the license is filtered.
   function Is_Filtered (Manager : in License_Manager;
                         File    : in SPDX_Tool.Infos.File_Info) return Boolean;

   --  Analyze the file to find license information in the header comment.
   procedure Analyze (Manager  : in out License_Manager;
                      Path     : in String);

   --  Analyze the content to find license information in the header comment.
   procedure Analyze (Manager  : in out License_Manager;
                      File_Mgr : in out SPDX_Tool.Files.File_Manager;
                      File     : in out SPDX_Tool.Infos.File_Info);

   generic
      with procedure Process (Map : in SPDX_Tool.Infos.File_Map);
   procedure Report (Manager : in out License_Manager);

private

   package AF renames Ada.Finalization;

   type License_Manager_Access is access all License_Manager;

   type License_Job_Type is record
      Manager : License_Manager_Access;
      File    : SPDX_Tool.Infos.File_Info_Access;
   end record;

   procedure Execute (Job : in out License_Job_Type);

   procedure Error (Job : in out License_Job_Type;
                    Ex  : in Ada.Exceptions.Exception_Occurrence);

   package Executors is new Util.Executors (Work_Type => License_Job_Type,
                                            Execute => Execute,
                                            Error => Error,
                                            Default_Queue_Size => 100);
   subtype Executor_Manager is Executors.Executor_Manager;
   subtype Executor_Manager_Access is Executors.Executor_Manager_Access;

   type File_Manager_Array is array (Positive range <>)
     of aliased SPDX_Tool.Files.File_Manager;

   type License_Manager (Count : Task_Count) is
   limited new UFW.Walker_Type with record
      Manager  : License_Manager_Access;
      Max_Fill : Natural := 0;
      Started  : Boolean := False;
      Job      : Job_Type := READ_LICENSES;
      Stats    : License_Stats;
      Mgr_Idx  : Util.Concurrent.Counters.Counter;
      File_Mgr : File_Manager_Array (1 .. Count);
      Executor : Executor_Manager (Count);
      Files    : SPDX_Tool.Infos.File_Map;
      Include_Filters : Util.Strings.Sets.Set;
      Exclude_Filters : Util.Strings.Sets.Set;
      Include_Languages : Util.Strings.Sets.Set;
      Exclude_Languages : Util.Strings.Sets.Set;
      Licenses : License_Template;
   end record;

   function Find_License (Manager : in License_Manager;
                          File    : in SPDX_Tool.Files.File_Type)
                          return License_Match;

   overriding
   procedure Finalize (Manager : in out License_Manager);

   function Get_File_Manager (Manager : in out License_Manager)
                              return SPDX_Tool.Files.File_Manager_Access;

end SPDX_Tool.Licenses.Manager;