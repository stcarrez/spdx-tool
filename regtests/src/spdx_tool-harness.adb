-----------------------------------------------------------------------
--  spdx_tool-harness -- Unit tests
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Environment_Variables;
with Util.Tests;
with SPDX_Tool.Testsuite;

procedure SPDX_Tool.Harness is

   procedure Harness is new Util.Tests.Harness (SPDX_Tool.Testsuite.Suite);

begin
   --  Force the language to be English since some tests will verify some message.
   Ada.Environment_Variables.Set ("LANG", "en");
   Ada.Environment_Variables.Set ("LANGUAGE", "en");
   Harness ("spdx_tool-tests.xml");
end SPDX_Tool.Harness;
