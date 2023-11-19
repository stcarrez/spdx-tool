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
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (Ada-Boxed)",
                       Test_Save_Ada_Boxed'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (C)",
                       Test_Save_C'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (C++)",
                       Test_Save_CPP'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (Shell)",
                       Test_Save_Shell'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (Tex)",
                       Test_Save_Tex'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (OCaml)",
                       Test_Save_OCaml'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (Erlang)",
                       Test_Save_Erlang'Access);
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

      declare
         Info : File_Type (100);
      begin
         Manager.Open (Info, Util.Tests.Get_Path
                    ("regtests/files/identify/lgpl-2.1.ml"));
         Util.Tests.Assert_Equals (T, 16, Info.Count,
                                   "Invalid number of lines");
         Assert_Equals (T, OCAML_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Lines (1).Comment,
                        "Invalid identification at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 76, Info.Lines (1).Style.Last,
                        "Invalid last at 1");

         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Lines (2).Comment,
                        "Invalid identification at 2");
         Assert_Equals (T, 80, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 153, Info.Lines (2).Style.Last,
                        "Invalid last at 2");

         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Lines (15).Comment,
                        "Invalid identification at 15");
         Assert_Equals (T, 1081, Info.Lines (15).Style.Start,
                        "Invalid start at 15");
         Assert_Equals (T, 1154, Info.Lines (15).Style.Last,
                        "Invalid last at 15");
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

   procedure Test_Save_Ada_Boxed (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/gnat-3.0.ads");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-gnat-3.0.ads");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 11, 19, "GPL-3.0");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-gnat-3.0.ads"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Ada_Boxed;

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

   procedure Test_Save_CPP (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/gpl-2.0-1.C");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-gpl-2.0-1.C");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 12, 27, "GPL-2.0");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-gpl-2.0-1.C"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_CPP;

   procedure Test_Save_Shell (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/gpl-3.0-1.sub");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-gpl-3.0-1.sub");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 9, 27, "GPL-3.0");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-gpl-3.0-1.sub"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Shell;

   procedure Test_Save_Tex (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/mit-1.tex");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-mit-1.tex");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 22, 33, "MIT");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-mit-1.tex"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Tex;

   procedure Test_Save_OCaml (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/lgpl-2.1.ml");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-lgpl-2.1.ml");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 11, 13, "LGPL-2.1");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-lgpl-2.1.ml"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_OCaml;

   procedure Test_Save_Erlang (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/files/identify/apache-2.0-4.erl");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0-4.erl");
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Manager.Open (Info, Path);
      Manager.Save (Info, Result, 6, 20, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Path), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0-4.erl"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Erlang;

end SPDX_Tool.Files.Tests;
