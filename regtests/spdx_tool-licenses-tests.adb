-- --------------------------------------------------------------------
--  spdx_tool-licenses-tests -- Tests for licenses package
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with GNAT.Source_Info;
with Util.Assertions;
with Util.Test_Caller;
with SPDX_Tool.Files;
package body SPDX_Tool.Licenses.Tests is

   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Files.Comment_Style);

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Licenses");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (fixed)",
                       Test_Find_License_Fixed'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (variable)",
                       Test_Find_License_Var'Access);
   end Add_Tests;

   procedure Check_License (T        : in out Test;
                            Filename : in String;
                            License  : in String;
                            Expect   : in String;
                            Source   : in String := GNAT.Source_Info.File;
                            Line     : in Natural := GNAT.Source_Info.Line) is
      Path    : constant String := Util.Tests.Get_Path ("regtests/files/identify/" & Filename);
      Manager : License_Manager (1);
      File    : SPDX_Tool.Files.File_Type (100);
      Result  : License_Match;
   begin
      --  Load only one license to simplify the debugging in case of problem.
      Manager.Load_License ("licenses/" & License);
      File.Open (Path);
      Result := Manager.Find_License (File);
      Util.Tests.Assert_Equals (T, Expect, Result.License,
                                "Invalid license found", Source, Line);
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
   end Test_Find_License_Var;

end SPDX_Tool.Licenses.Tests;
