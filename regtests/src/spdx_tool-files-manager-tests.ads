-- --------------------------------------------------------------------
--  spdx_tool-files-tests -- Tests for reading/scanning files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Tests;
package SPDX_Tool.Files.Manager.Tests is

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite);

   type Test is new Util.Tests.Test with null record;

   --  Test reading a file, identifying lines and comments.
   procedure Test_Open (T : in out Test);

   --  Test reading a file with multiline comments.
   procedure Test_Multiline_Comment (T : in out Test);

   --  Test reading and replacing Ada header comment.
   procedure Test_Save_Ada (T : in out Test);
   procedure Test_Save_Ada_Boxed (T : in out Test);
   procedure Test_Save_C (T : in out Test);
   procedure Test_Save_CPP (T : in out Test);
   procedure Test_Save_Shell (T : in out Test);
   procedure Test_Save_Tex (T : in out Test);
   procedure Test_Save_OCaml (T : in out Test);
   procedure Test_Save_Erlang (T : in out Test);
   procedure Test_Save_Java (T : in out Test);
   procedure Test_Save_XHTML (T : in out Test);

end SPDX_Tool.Files.Manager.Tests;
