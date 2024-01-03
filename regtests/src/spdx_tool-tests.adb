-- --------------------------------------------------------------------
--  spdx_tool-tests -- Tests for spdx-tool executable
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Directories;
with Util.Assertions;
with Util.Test_Caller;
package body SPDX_Tool.Tests is

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Tests");

   function Tool return String is ("bin/spdx-tool");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Usage",
                       Test_Usage'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --check",
                       Test_Report_Licenses'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --files",
                       Test_Report_Files'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --only-licenses",
                       Test_Report_Only_Licenses_Files'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --ignore-licenses",
                       Test_Report_Ignore_Licenses_Files'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --identify",
                       Test_Identify'Access);
   end Add_Tests;

   --  ------------------------------
   --  Test launching spdx-tool and checking its usage.
   --  ------------------------------
   procedure Test_Usage (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --help", Result, 1);
      Util.Tests.Assert_Matches (T, "spdx-tool - SPDX license management tool.*",
                                 Result, "Invalid usage");
   end Test_Usage;

   procedure Test_Report_Licenses (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color regtests/src", Result, 0);
      Util.Tests.Assert_Matches (T, ".*Apache-2.0.*[0-9]+.*100.0.*",
                                 Result, "Invalid result");
   end Test_Report_Licenses;

   procedure Test_Report_Files (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color -f regtests/src", Result, 0);
      Util.Tests.Assert_Matches (T, ".*Apache-2.0.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/src/spdx_tool-files-tests.adb.*",
                                 Result, "missing file");
      Util.Tests.Assert_Matches (T, ".*regtests/src/spdx_tool-tests.ads.*",
                                 Result, "missing file");
   end Test_Report_Files;

   procedure Test_Report_Only_Licenses_Files (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color --only-licenses None -f regtests", Result, 0);
      Util.Tests.Assert_Matches (T, ".*None.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/alire.toml.*",
                                 Result, "missing file");
      Util.Tests.Assert_Matches (T, ".*regtests/spdx_tool_tests.gpr.*",
                                 Result, "missing file");
   end Test_Report_Only_Licenses_Files;

   procedure Test_Report_Ignore_Licenses_Files (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color --ignore-licenses None,Unkown,Apache-2.0 -f regtests",
                 Result, 0);
      Util.Tests.Assert_Matches (T, ".*GPL-3.0.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/expect/replace-gnat-3.0.ads.*",
                                 Result, "missing file");
      Util.Tests.Assert_Matches (T, ".*MIT.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/expect/replace-mit-1.tex.*",
                                 Result, "missing file");
   end Test_Report_Ignore_Licenses_Files;

   procedure Test_Identify (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --identify regtests/files/identify/bsd-3-clause.c",
                 Result, 0);
      Util.Tests.Assert_Matches (T, "BSD-3-Clause", Result,
                                "Identify failed");
   end Test_Identify;

end SPDX_Tool.Tests;
