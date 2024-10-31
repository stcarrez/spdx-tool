-- --------------------------------------------------------------------
--  spdx_tool-genlicenses -- Read JSONLD license files and generate license texts
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Text_IO;
with Ada.Directories;
with Ada.Command_Line;
with Util.Files;
with SPDX_Tool.Licenses;
with SPDX_Tool.Licenses.Reader;
procedure SPDX_Tool.Genlicenses is

   package AD renames Ada.Directories;
   use type AD.File_Kind;

   procedure Import (Export_Dir : in String;
                     Except_Dir : in String;
                     Path       : in String);

   procedure Scan (Path       : in String;
                   Export_Dir : in String;
                   Except_Dir : in String);

   Idx      : License_Index := 0;

   procedure Import (Export_Dir : in String;
                     Except_Dir : in String;
                     Path       : in String) is
      License   : SPDX_Tool.Licenses.Reader.License_Type;
   begin
      SPDX_Tool.Licenses.Reader.Load_JSON (License, Path);
      declare
         Name   : constant String := To_String (License.Name);
         Target : constant String := Util.Files.Compose
           ((if License.Is_Exception then Except_Dir else Export_Dir), Name & ".txt");
      begin
         if Length (License.Template) > 0 and then Name'Length > 0 then
            SPDX_Tool.Licenses.Reader.Save_License (License, Target);
            Idx := Idx + 1;
         end if;
      end;
   end Import;

   procedure Scan (Path       : in String;
                   Export_Dir : in String;
                   Except_Dir : in String) is
      Dir_Filter  : constant AD.Filter_Type := (AD.Ordinary_File => True,
                                                AD.Directory     => True,
                                                others           => False);
      Ent    : AD.Directory_Entry_Type;
      Search : AD.Search_Type;
   begin
      AD.Start_Search (Search, Directory => Path,
                       Pattern => "*", Filter => Dir_Filter);
      while AD.More_Entries (Search) loop
         AD.Get_Next_Entry (Search, Ent);
         declare
            Full_Name : constant String := AD.Full_Name (Ent);
         begin
            if AD.Kind (Ent) /= AD.Directory then
               Import (Export_Dir, Except_Dir, Full_Name);
            end if;
         end;
      end loop;
   end Scan;

   Arg_Count : constant Natural := Ada.Command_Line.Argument_Count;
begin
   if Arg_Count /= 3 then
      Ada.Text_IO.Put_Line ("Usage: spdx_tool-genlicenses <jsonld directory> <target dir> <exception dir>");
      Ada.Command_Line.Set_Exit_Status (1);
      return;
   end if;
   Scan (Ada.Command_Line.Argument (1),
         Ada.Command_Line.Argument (2),
         Ada.Command_Line.Argument (3));
end SPDX_Tool.Genlicenses;
