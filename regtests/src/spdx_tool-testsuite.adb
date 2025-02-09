-- --------------------------------------------------------------------
--  spdx_tool-testsuite -- SPDX Tool testsuite
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with SPDX_Tool.Tests;
with SPDX_Tool.Files.Manager.Tests;
with SPDX_Tool.Licenses.Manager.Tests;
with SPDX_Tool.Languages.Tests;
package body SPDX_Tool.Testsuite is

   Tests : aliased Util.Tests.Test_Suite;

   function Suite return Util.Tests.Access_Test_Suite is
   begin
      --  Executed in reverse order
      SPDX_Tool.Tests.Add_Tests (Tests'Access);
      SPDX_Tool.Licenses.Manager.Tests.Add_Tests (Tests'Access);
      SPDX_Tool.Files.Manager.Tests.Add_Tests (Tests'Access);
      SPDX_Tool.Languages.Tests.Add_Tests (Tests'Access);
      return Tests'Access;
   end Suite;

end SPDX_Tool.Testsuite;
