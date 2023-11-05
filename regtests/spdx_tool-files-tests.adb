-- --------------------------------------------------------------------
--  spdx_tool-files-tests -- Tests for reading/scanning files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Assertions;
with Util.Test_Caller;
package body SPDX_Tool.Files.Tests is

   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Comment_Style);

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Languages");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Open",
                       Test_Open'Access);
   end Add_Tests;

   --  Test reading a file, identifying lines and comments.
   procedure Test_Open (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/apache-2.0-1.ads");
      Manager : File_Manager;
   begin
      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Path);
         Util.Tests.Assert_Equals (T, 17, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, ADA_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
      end;

      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Util.Tests.Get_Path
                    ("regtests/files/identify/gpl-3.0-1.sub"));
         Util.Tests.Assert_Equals (T, 29, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, SHELL_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
      end;
   end Test_Open;

end SPDX_Tool.Files.Tests;
