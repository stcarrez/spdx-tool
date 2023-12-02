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
      Caller.Add_Test (Suite, "Test SPDX_Tool.Scan",
                       Test_Report_Licenses'Access);
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

end SPDX_Tool.Tests;
