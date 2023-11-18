-- --------------------------------------------------------------------
--  spdx_tool-files-tests -- Tests for reading/scanning files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Directories;
with Util.Assertions;
with Util.Test_Caller;
package body SPDX_Tool.Files.Tests is

   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Comment_Style);
   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Comment_Mode);
   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Buffer_Index);

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Languages");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Open",
                       Test_Open'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Open",
                       Test_Multiline_Comment'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (Ada)",
                       Test_Save_Ada'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (C)",
                       Test_Save_C'Access);
   end Add_Tests;

   --  ------------------------------
   --  Test reading a file, identifying lines and comments.
   --  ------------------------------
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

      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Util.Tests.Get_Path
                    ("regtests/files/identify/gnat-3.0.ads"));
         Util.Tests.Assert_Equals (T, 24, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, ADA_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");

         for I in 1 .. 24 loop
            Assert_Equals (T, LINE_COMMENT, Info.Lines (I).Comment,
                           "Invalid identification at" & I'Image);
         end loop;
      end;

      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Util.Tests.Get_Path
                    ("regtests/files/identify/gpl-2.0-1.C"));
         Util.Tests.Assert_Equals (T, 35, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, CPP_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");

         for I in 1 .. 35 loop
            Assert_Equals (T, LINE_COMMENT, Info.Lines (I).Comment,
                           "Invalid identification at" & I'Image);
         end loop;
      end;
   end Test_Open;

   --  ------------------------------
   --  Test reading a file with multiline comments.
   --  ------------------------------
   procedure Test_Multiline_Comment (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/gpl-3.0.c");
      Manager : File_Manager;
   begin
      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Path);
         Util.Tests.Assert_Equals (T, 16, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, C_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, START_COMMENT, Info.Lines (1).Comment,
                        "Invalid identification at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 32, Info.Lines (1).Style.Last,
                        "Invalid last at 1");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (2).Comment,
                        "Invalid identification at 2");
         Assert_Equals (T, 37, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 90, Info.Lines (2).Style.Last,
                        "Invalid last at 2");

         Assert_Equals (T, END_COMMENT, Info.Lines (15).Comment,
                        "Invalid identification at 15");
         Assert_Equals (T, 665, Info.Lines (15).Style.Start,
                        "Invalid start at 15");
         Assert_Equals (T, 738, Info.Lines (15).Style.Last,
                        "Invalid last at 25");
      end;

      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Util.Tests.Get_Path
                    ("regtests/files/identify/apache-2.0-3.c"));
         Util.Tests.Assert_Equals (T, 16, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, C_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, START_COMMENT, Info.Lines (1).Comment,
                        "Invalid identification at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 39, Info.Lines (1).Style.Last,
                        "Invalid last at 1");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (2).Comment,
                        "Invalid identification at 2");
         Assert_Equals (T, 45, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 102, Info.Lines (2).Style.Last,
                        "Invalid last at 2");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (15).Comment,
                        "Invalid identification at 15");
         Assert_Equals (T, 699, Info.Lines (15).Style.Start,
                        "Invalid start at 15");
         Assert_Equals (T, 728, Info.Lines (15).Style.Last,
                        "Invalid last at 15");

         Assert_Equals (T, END_COMMENT, Info.Lines (16).Comment,
                        "Invalid identification at 16");
         Assert_Equals (T, 731, Info.Lines (16).Style.Start,
                        "Invalid start at 16");
         Assert_Equals (T, 731, Info.Lines (16).Style.Last,
                        "Invalid last at 16");
      end;
   end Test_Multiline_Comment;

   --  ------------------------------
   --  Test reading and replacing Ada header comment.
   --  ------------------------------
   procedure Test_Save_Ada (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/apache-2.0-1.ads");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0.1.ads");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 5, 16, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0.1.ads"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Ada;

   procedure Test_Save_C (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/apache-2.0-3.c");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0.3.c");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 5, 15, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0.3.c"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_C;

end SPDX_Tool.Files.Tests;
