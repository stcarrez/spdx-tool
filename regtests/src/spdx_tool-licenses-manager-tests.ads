-- --------------------------------------------------------------------
--  spdx_tool-licenses-tests -- Tests for licenses package
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Tests;
package SPDX_Tool.Licenses.Manager.Tests is

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite);

   type Test is new Util.Tests.Test with null record;

   --  Test parsing various update patterns.
   procedure Test_Set_Update_Pattern (T : in out Test);

   --  Test reading and loading a license template.
   procedure Test_Load_Template (T : in out Test);

   --  Test reading a template and matching fix content.
   procedure Test_Template_Fixed (T : in out Test);
   procedure Test_Template_Var (T : in out Test);
   procedure Test_Template_Var2 (T : in out Test);
   procedure Test_Template_Optional (T : in out Test);

   --  Test reading a JSONLD template a match a fix content.
   procedure Test_JSONLD_Template (T : in out Test);

   --  Test Find_License with simple license files
   procedure Test_Find_License_Fixed (T : in out Test);
   procedure Test_Find_License_Var (T : in out Test);
   procedure Test_Find_License_Optional (T : in out Test);
   procedure Test_Find_License_SPDX (T : in out Test);

   procedure Test_Find_Root (T : in out Test);

end SPDX_Tool.Licenses.Manager.Tests;
