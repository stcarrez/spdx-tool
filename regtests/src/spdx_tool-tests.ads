-- --------------------------------------------------------------------
--  spdx_tool-tests -- Tests for spdx-tool executable
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Tests;
package SPDX_Tool.Tests is

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite);

   type Test is new Util.Tests.Test with null record;

   --  Test launching spdx-tool and checking its usage.
   procedure Test_Usage (T : in out Test);

   procedure Test_Report_Licenses (T : in out Test);
   procedure Test_Report_Files (T : in out Test);
   procedure Test_Report_Only_Licenses_Files (T : in out Test);
   procedure Test_Report_Ignore_Licenses_Files (T : in out Test);
   procedure Test_Identify (T : in out Test);
   procedure Test_Identify_Licenses (T : in out Test);
   procedure Test_Identify_Languages (T : in out Test);
   procedure Test_Json_Report (T : in out Test);
   procedure Test_Xml_Report (T : in out Test);
   procedure Test_Print_License_Apache (T : in out Test);
   procedure Test_Print_License_Gnat (T : in out Test);
   procedure Test_Print_License_Bsd (T : in out Test);
   procedure Test_Print_License_Ocaml (T : in out Test);
   procedure Test_Print_License_None (T : in out Test);
   procedure Test_Print_License_Antlr (T : in out Test);
   procedure Test_Print_License_Blessing (T : in out Test);
   procedure Test_Print_License_Chinese (T : in out Test);
   procedure Test_Print_License_Apache_Bug (T : in out Test);

   --  Test spdx-tool --update option on various languages
   procedure Test_Update_License_Ada (T : in out Test);
   procedure Test_Update_License_C (T : in out Test);
   procedure Test_Update_License_XHTML (T : in out Test);
   procedure Test_Update_License_JSP (T : in out Test);

end SPDX_Tool.Tests;
