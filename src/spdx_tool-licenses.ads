-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Exceptions;
with Ada.Directories;
with Ada.Containers.Indefinite_Ordered_Maps;
with Ada.Containers.Indefinite_Ordered_Sets;
with Ada.Containers.Vectors;

with GNAT.Strings;
with GNAT.Regpat;

with Util.Files.Walk;
with Util.Strings.Sets;
with SPDX_Tool.Files;
with SPDX_Tool.Infos;
private with Util.Executors;
private with Util.Concurrent.Counters;
package SPDX_Tool.Licenses is

   package UFW renames Util.Files.Walk;

   SPDX_License_Tag : constant String := "SPDX-License-Identifier:";
   Unknown_License  : constant String := "Unknown";
   No_License       : constant String := "None";
   Empty_File       : constant String := "Empty file";

   License_Dir     : aliased GNAT.Strings.String_Access;
   Ignore_Licenses : aliased GNAT.Strings.String_Access;
   Only_Licenses   : aliased GNAT.Strings.String_Access;

   package Count_Maps is new Ada.Containers.Indefinite_Ordered_Maps
     (Key_Type     => String,
      Element_Type => Natural);

   type Job_Type is (READ_LICENSES, UPDATE_LICENSES, LOAD_LICENSES, SCAN_LICENSES);

   type License_Manager (Count : Task_Count) is
   limited new UFW.Walker_Type with private;

   --  Configure the license manager.
   procedure Configure (Manager : in out License_Manager;
                        Job     : in Job_Type;
                        Tasks   : in Task_Count);

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

   type License_Info is record
      First_Line : Natural := 0;
      Last_Line  : Natural := 0;
      Name       : UString;
   end record;

   type License_Type is tagged limited private;

   procedure Load (License : in out License_Type;
                   Path    : in String);

   function Get_Name (License : License_Type) return String;
   function Get_Template (License : License_Type) return String;

   --  Define the list of SPDX license names to ignore.
   procedure Set_Filter (Manager : in out License_Manager;
                         List    : in String;
                         Exclude : in Boolean);

   --  Returns true if the license is filtered.
   function Is_Filtered (Manager : in License_Manager;
                         Name    : in String) return Boolean;

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

   --  Load the license template from the given path.
   procedure Load_License (Manager : in out License_Manager;
                           Path    : in String);
   procedure Load_License (Manager : in out License_Manager;
                           Name    : in String;
                           Content : in Buffer_Type);

   package AF renames Ada.Finalization;

   type Line_Stat (Len : Buffer_Size) is record
      Count    : Positive := 1;
      Content  : Buffer_Type (1 .. Len);
   end record;

   function "<" (Left, Right : Line_Stat) return Boolean
      is (Left.Count > Right.Count
          or else (Left.Count = Right.Count and then Left.Len < Right.Len)
          or else (Left.Count = Right.Count and then Left.Len = Right.Len
            and then Left.Content < Right.Content));

   package Line_Maps is new Ada.Containers.Indefinite_Ordered_Maps
    (Key_Type => Buffer_Type, Element_Type => Positive, "<" => "<", "=" => "=");

   package Line_Sets is new Ada.Containers.Indefinite_Ordered_Sets
    (Element_Type    => Line_Stat, "<" => "<", "=" => "=");

   package Line_Vectors is new Ada.Containers.Vectors
    (Index_Type => Positive, Element_Type => Line_Maps.Map, "=" => Line_Maps."=");

   protected type License_Stats is

      procedure Increment (Name : in String);

      procedure Add_Header (File : in Files.File_Type);

      function Get_Stats return Count_Maps.Map;

      procedure Print_Header;

   private
      Map   : Count_Maps.Map;
      Lines : Line_Vectors.Vector;
      Unknown_Count : Natural := 0;
      Max_Line : Natural := 0;
   end License_Stats;

   --  The license templates are read within a tree of tokens.  To find a
   --  license match, the license text in the source file header is split in
   --  tokens and we start from the license manager root token.  We move to
   --  the next token if there is a match.  We look for alternate tokens when
   --  there is no match.  Some special tokens exists to check optional matches
   --  or to match regular expressions.  The license token tree look like:
   --
   --  Tokens -> "Copyright" [Next] -> "(c)" -> ".*" -> ...
   --                | [Alternate]
   --            "Licensed"  -> "under" -> "the" -> "Apache" -> ...
   --                                                  |
   --                                               "Open" -> ...
   --
   --  While matching tokens we try to take into account the SPDX license
   --  match recommendations:
   --  - spaces are ignored,
   --  - punctuation must match,
   --  - Copyright, (c) and "©" are considered identical,
   type Token_Type is tagged;
   type Token_Access is access all Token_Type'Class;
   type License_Access is access all License_Type;

   type Token_Kind is (TOK_WORD,
                       TOK_COPYRIGHT,
                       TOK_OPTIONAL,
                       TOK_VAR,
                       TOK_LICENSE);

   type Token_Type (Len : Buffer_Size) is tagged limited record
      Next      : Token_Access;
      Previous  : Token_Access;
      Alternate : Token_Access;
      Content   : Buffer_Type (1 .. Len);
   end record;

   function Matches (Token : in Token_Type;
                     Word  : in Buffer_Type) return Boolean;

   function Kind (Token : in Token_Type)
                  return Token_Kind is (TOK_WORD);

   type Regpat_Token_Type (Len  : Buffer_Size;
                           Plen : GNAT.Regpat.Program_Size)
   is new Token_Type (Len) with record
      Pattern   : GNAT.Regpat.Pattern_Matcher (Plen);
   end record;

   overriding
   function Kind (Token : in Regpat_Token_Type)
                  return Token_Kind is (TOK_VAR);

   overriding
   function Matches (Token : in Regpat_Token_Type;
                     Word  : in Buffer_Type) return Boolean;

   type Final_Token_Type (Len : Buffer_Size)
   is new Token_Type (Len) with record
      License   : UString;
   end record;

   overriding
   function Kind (Token : in Final_Token_Type)
                  return Token_Kind is (TOK_LICENSE);

   type License_Type is tagged limited record
      Name         : UString;
      Template     : UString;
      OSI_Approved : Boolean := False;
      FSF_Libre    : Boolean := False;
   end record;

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
      Job      : Job_Type := SCAN_LICENSES;
      Stats    : License_Stats;
      Tokens   : Token_Access;
      Mgr_Idx  : Util.Concurrent.Counters.Counter;
      File_Mgr : File_Manager_Array (1 .. Count);
      Executor : Executor_Manager (Count);
      Files    : SPDX_Tool.Infos.File_Map;
      Include_Filters : Util.Strings.Sets.Set;
      Exclude_Filters : Util.Strings.Sets.Set;
   end record;

   function Find_License (Manager : in License_Manager;
                          Content : in Buffer_Type;
                          Lines   : in SPDX_Tool.Files.Line_Array)
                          return Infos.License_Info;

   function Find_License (Manager : in License_Manager;
                          File    : in SPDX_Tool.Files.File_Type)
                          return Infos.License_Info;

   overriding
   procedure Finalize (Manager : in out License_Manager);

end SPDX_Tool.Licenses;
