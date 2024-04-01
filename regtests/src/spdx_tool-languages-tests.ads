-- --------------------------------------------------------------------
--  spdx_tool-languages-tests -- Tests for languages package
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Tests;
package SPDX_Tool.Languages.Tests is

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite);

   type Test is new Util.Tests.Test with null record;

   --  Test shell detector on several patterns.
   procedure Test_Shell_Detector (T : in out Test);

end SPDX_Tool.Languages.Tests;
