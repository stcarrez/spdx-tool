-- --------------------------------------------------------------------
--  spdx_tool-licenses-tests -- Tests for licenses package
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with GNAT.Source_Info;
with Util.Test_Caller;
with SPDX_Tool.Files;
with SPDX_Tool.Token_Counters;
with SPDX_Tool.Licenses.Manager;
with SPDX_Tool.Licenses.Templates;
with SPDX_Tool.Languages;
with SPDX_Tool.Infos;
package body SPDX_Tool.Licenses.Manager.Tests is

   use SPDX_Tool.Infos;
   use SPDX_Tool.Languages;

   procedure Check_License (T        : in out Test;
                            Filename : in String;
                            License  : in String;
                            Expect   : in String;
                            Source   : in String := GNAT.Source_Info.File;
                            Line     : in Natural := GNAT.Source_Info.Line);

   function Get_Path (Name : in String) return File_Info is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/" & Name);
   begin
      return File_Info '(Len => Path'Length, Path => Path, others => <>);
   end Get_Path;

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Licenses");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (fixed)",
                       Test_Find_License_Fixed'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (variable)",
                       Test_Find_License_Var'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (SPDX)",
                       Test_Find_License_SPDX'Access);
   end Add_Tests;

   procedure Check_License (T        : in out Test;
                            Filename : in String;
                            License  : in String;
                            Expect   : in String;
                            Source   : in String := GNAT.Source_Info.File;
                            Line     : in Natural := GNAT.Source_Info.Line) is
      Data    : File_Info := Get_Path ("files/identify/" & Filename);
      Manager : SPDX_Tool.Licenses.Manager.License_Manager (1);
      File    : SPDX_Tool.Files.File_Type (100);
      Result  : License_Match;
   begin
      --  Load only one license to simplify the debugging in case of problem.
      --  Manager.Load_License ("licenses/" & License);
      Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
      --Result := Manager.Find_License (File);
      --Util.Tests.Assert_Equals (T, Expect, Result.Info.Name,
      --                          "Invalid license found", Source, Line);
   end Check_License;

   --  ------------------------------
   --  Test Find_License with simple license files
   --  ------------------------------
   procedure Test_Find_License_Fixed (T : in out Test) is
   begin
      Check_License (T, "apache-2.0-1.ads", "Apache-2.0-alt.txt", "Apache-2.0");
   end Test_Find_License_Fixed;

   procedure Test_Find_License_Var (T : in out Test) is
   begin
      --  License contains variable part.
      --  Check_License (T, "apache-2.0-2.ads", "standard/Apache-2.0.txt", "Apache-2.0");
      Check_License (T, "lgpl-2.1.c", "standard/LGPL-2.1+.txt", "LGPL-2.1+");
      Check_License (T, "bsd-3-clause.c", "standard/BSD-3-Clause.txt", "BSD-3-Clause");
   end Test_Find_License_Var;

   procedure Test_Find_License_SPDX (T : in out Test) is
   begin
      Check_License (T, "gpl-2.0-only-1.sh", "standard/LGPL-2.1+.txt", "GPL-2.0-only");
      Check_License (T, "mit-2.c", "standard/LGPL-2.1+.txt", "MIT");
      Check_License (T, "gpl-2.0-or-bsd.c", "standard/LGPL-2.1+.txt", "GPL-2.0+ OR BSD-3-Clause");

      declare
         Start : Util.Measures.Stamp;
         T : SPDX_Tool.Token_Counters.Token_Maps.Map;
         First : Buffer_Index := 1;
         Last  : Buffer_Index;
      begin
         for I in SPDX_Tool.Licenses.Templates.Token_Pos'Range loop
            Last := First + Buffer_Size (SPDX_Tool.Licenses.Templates.Token_Pos (I) - 1);
            T.Insert (SPDX_Tool.Licenses.Templates.Tokens (First .. Last),
                      SPDX_Tool.Token_Index (I));
            First := Last + 1;
         end loop;
         Util.Measures.Report (Start, "Fill map with tokens");
      end;
   end Test_Find_License_SPDX;

end SPDX_Tool.Licenses.Manager.Tests;
