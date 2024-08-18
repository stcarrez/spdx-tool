-- --------------------------------------------------------------------
--  spdx_tool-licenses-manager -- licenses manager
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Exceptions;
with Ada.Directories;

with Util.Files.Walk;
with Util.Strings.Sets;
with SPDX_Tool.Files.Manager;
with SPDX_Tool.Infos;
with SPDX_Tool.Configs;
with SCI.Vectorizers.Transformers;
with SCI.Numbers;
with SPDX_Tool.Token_Counters;
private with SPDX_Tool.Languages.Manager;
private with SPDX_Tool.Licenses.Repository;
private with Util.Executors;
private with Util.Concurrent.Counters;
package SPDX_Tool.Licenses.Manager is

   package UFW renames Util.Files.Walk;

   Invalid_Pattern : exception;

   type Job_Type is (FIND_LANGUAGES, FIND_LICENSES, UPDATE_LICENSES, LOAD_LICENSES);

   type License_Manager (Count : Task_Count) is
   limited new UFW.Walker_Type with private;

   --  Setup the update pattern when the tool must replace the existing license
   --  with an SPDX-License tag.  The pattern allows to define a set of lines to
   --  keep before and after the SPDX-License tag.  The pattern format is:
   --     {[line|line-range](.:,)}spdx{(.:,)[line|line-range]}
   --  Example:
   --     spdx
   --     1..3:spdx
   --     1,spdx,2
   procedure Set_Update_Pattern (Manager : in out License_Manager;
                                 Pattern : in String);

   --  Configure the license manager.
   procedure Configure (Manager : in out License_Manager;
                        Config  : in SPDX_Tool.Configs.Config_Type);
   procedure Configure (Manager : in out License_Manager;
                        Config  : in SPDX_Tool.Configs.Config_Type;
                        Job     : in Job_Type);

   --  Load the license templates defined in the directory for the license
   --  identification and analysis.
   procedure Load_Licenses (Manager : in out License_Manager;
                            Path    : in String);

   --  Load a .spdxtool configuration file at the root of a project with
   --  the given path.
   procedure Load_Project_Configuration (Manager : in out License_Manager;
                                         Path    : in String);

   --  Get the path of a file that can be read to get a list of files to ignore
   --  in the given directory (ie, .gitignore).
   overriding
   function Get_Ignore_Path (Walker : in License_Manager;
                             Path   : in String) return String;

   --  Load the file that contains a list of files to ignore.  The default
   --  implementation reads patterns as defined in `.gitignore` files.
   overriding
   procedure Load_Ignore (Walker : in out License_Manager;
                          Path   : in String;
                          Filter : in out Util.Files.Walk.Filter_Type'Class);

   overriding
   procedure Scan_Subdir_For_Ignore (Walker    : in out License_Manager;
                                     Path      : in String;
                                     Scan_Path : in String;
                                     Rel_Path  : in String;
                                     Level     : in Natural;
                                     Filter    : in Util.Files.Walk.Filter_Context_Type);

   --  Called when a file is found during the directory tree walk.
   overriding
   procedure Scan_File (Manager : in out License_Manager;
                        Path    : in String) with
     Pre'Class => Path'Length > 0 and then Ada.Directories.Exists (Path);

   --  Called when a directory is found during a directory tree walk.
   --  We overide it to check for .git directory or file and skip
   --  that subdirectory unless an option tells us to scan other repos.
   overriding
   procedure Scan_Subdir (Walker : in out License_Manager;
                          Path   : in String;
                          Filter : in Util.Files.Walk.Filter_Context_Type;
                          Match  : in Util.Files.Walk.Filter_Result) with
     Pre => Path'Length > 0 and then Ada.Directories.Exists (Path);

   --  Returns true if the path corresponds to a root path for a project:
   --  * it contains a `.git` directory
   overriding
   function Is_Root (Walker : in License_Manager;
                     Path   : in String) return Boolean;

   procedure Wait (Manager : in out License_Manager);

   --  Load the license template from the given path.
   procedure Load_License (Manager : in out License_Manager;
                           Path    : in String);

   --  Define the list of SPDX license names or list of language filters
   --  to ignore.
   procedure Set_Filter (Manager  : in out License_Manager;
                         List     : in String;
                         Language : in Boolean;
                         Exclude  : in Boolean);

   --  Returns true if the language is filtered.
   function Is_Language_Filtered (Manager : in License_Manager;
                                  File    : in SPDX_Tool.Infos.File_Info) return Boolean;

   function Is_License_Filtered (Manager : in License_Manager;
                                 File    : in SPDX_Tool.Infos.File_Info) return Boolean;

   --  Analyze the file to find license information in the header comment.
   procedure Analyze (Manager  : in out License_Manager;
                      Path     : in String);

   --  Analyze the content to find license information in the header comment.
   procedure Analyze (Manager  : in out License_Manager;
                      File_Mgr : in out SPDX_Tool.Files.Manager.File_Manager;
                      File     : in out SPDX_Tool.Infos.File_Info);

   generic
      with procedure Process (Map : in SPDX_Tool.Infos.File_Map);
   procedure Report (Manager : in out License_Manager);

private

   subtype Confidence_Type is Infos.Confidence_Type;
   use type Infos.Confidence_Type;
   function To_Float (Value : in Count_Type) return Float is (Float (Value));

   --  ??? Mul and Div seem necessary as "*" and "/" fail to instantiate
   function Mul (Left, Right : Confidence_Type) return Confidence_Type is (Left * Right);
   function Div (Left, Right : Confidence_Type) return Confidence_Type is (Left / Right);
   function From_Integer (Value : in Integer) return Confidence_Type is (Confidence_Type (Value));
   function From_Float (Value : in Float) return Confidence_Type is (Confidence_Type (Value));
   package Confidence_Numbers is new SCI.Numbers.Number (Confidence_Type, "*" => Mul, "/" => Div);
   package Confidence_Conversions is new SCI.Numbers.Conversion (Confidence_Numbers);

   package Freq_Transformers is
      new SCI.Vectorizers.Transformers (Frequency_Type => Float,
                                        Arrays         => SPDX_Tool.Counter_Arrays,
                                        Convert        => To_Float);
   package Frequency_Arrays renames Freq_Transformers.Frequency_Arrays;

   type Frequency_Array_Access is access all Freq_Transformers.Frequency_Array;

   type Float_Array is array (License_Index range <>) of Float;
   type Float_Array_Access is access all Float_Array;

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
     of aliased SPDX_Tool.Files.Manager.File_Manager;

   type License_Manager (Count : Task_Count) is
   limited new UFW.Walker_Type with record
      Manager   : License_Manager_Access;
      Languages : SPDX_Tool.Languages.Manager.Language_Manager;
      Max_Fill  : Natural := 0;
      Started   : Boolean := False;
      Job       : Job_Type := FIND_LICENSES;

      --  Filters to identify license files (ex: COPYING, LICENSE.txt, ...)
      --  Filters to ignore files when looking at file headers.  The two filters
      --  are configured from a configuration file.
      License_Files_Filter : Util.Files.Walk.Filter_Type;
      Ignore_Files_Filter  : Util.Files.Walk.Filter_Type;

      --  Include/exclude licenses and languages.  These options are configured
      --  from command line and affect how to produce reports and whether we
      --  apply the update command.
      Include_Filters      : Util.Strings.Sets.Set;
      Exclude_Filters      : Util.Strings.Sets.Set;
      Include_Languages    : Util.Strings.Sets.Set;
      Exclude_Languages    : Util.Strings.Sets.Set;
      Licenses             : License_Template;
      Repository           : SPDX_Tool.Licenses.Repository.Repository_Type;

      --  A map of tokens used in license templates.
      Token_Counters       : SPDX_Tool.Token_Counters.Vectorizer_Type;
      Token_Frequency      : Frequency_Arrays.Array_Type;
      License_Squares      : Float_Array_Access;
      License_Frequency    : Frequency_Array_Access;

      --  Replacement information
      Before   : SPDX_Tool.Infos.Line_Range_Type;
      After    : SPDX_Tool.Infos.Line_Range_Type;

      Files    : SPDX_Tool.Infos.File_Map;

      Mgr_Idx  : Util.Concurrent.Counters.Counter;
      File_Mgr : File_Manager_Array (1 .. Count);
      Executor : Executor_Manager_Access;
   end record;

   function Compute_Frequency (Manager : in License_Manager;
                               Lines   : in SPDX_Tool.Languages.Line_Array;
                               From    : in Line_Number;
                               To      : in Line_Number) return Frequency_Arrays.Array_Type;

   function Find_License_Templates (Manager : in License_Manager;
                                    Line    : in SPDX_Tool.Languages.Line_Type)
                                     return License_Index_Map;

   procedure Find_License_Templates (Manager : in License_Manager;
                                     Lines   : in out SPDX_Tool.Languages.Line_Array;
                                     From    : in Line_Number;
                                     To      : in Line_Number);

   function Find_License_Templates (Lines   : in SPDX_Tool.Languages.Line_Array;
                                    From    : in Line_Number;
                                    To      : in Line_Number) return License_Index_Array;

   function Find_License (Manager : in License_Manager;
                          File    : in out SPDX_Tool.Files.File_Type)
                          return License_Match;

   overriding
   procedure Initialize (Manager : in out License_Manager);

   overriding
   procedure Finalize (Manager : in out License_Manager);

   function Get_File_Manager (Manager : in out License_Manager)
                              return SPDX_Tool.Files.Manager.File_Manager_Access;

   function Guess_License (Manager : in License_Manager;
                           Lines   : in SPDX_Tool.Languages.Line_Array;
                           From    : in Line_Number;
                           To      : in Line_Number) return License_Match;

end SPDX_Tool.Licenses.Manager;
