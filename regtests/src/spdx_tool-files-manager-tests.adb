-- --------------------------------------------------------------------
--  spdx_tool-files-tests -- Tests for reading/scanning files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Directories;
with Util.Assertions;
with Util.Test_Caller;
with SPDX_Tool.Configs;
with SPDX_Tool.Languages.Manager;
package body SPDX_Tool.Files.Manager.Tests is

   use SPDX_Tool.Languages.Manager;
   subtype File_Info is Infos.File_Info;

   --  procedure Assert_Equals is
   --  new Util.Assertions.Assert_Equals_T (Value_Type => Comment_Style);
   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Comment_Mode);
   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Buffer_Index);
   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => Infos.Line_Count);

   function Get_Path (Name : in String) return File_Info is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/" & Name);
   begin
      return File_Info '(Len => Path'Length, Path => Path, others => <>);
   end Get_Path;

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
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (Java)",
                       Test_Save_Java'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Save (XHTML)",
                       Test_Save_XHTML'Access);
   end Add_Tests;

   --  ------------------------------
   --  Test reading a file, identifying lines and comments.
   --  ------------------------------
   procedure Test_Open (T : in out Test) is
      Config    : SPDX_Tool.Configs.Config_Type;
      Manager   : File_Manager;
      Languages : Language_Manager;
   begin
      Languages.Initialize (Config);
      declare
         Data : File_Info := Get_Path ("files/identify/apache-2.0-1.ads");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 17, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("Ada", Data.Language,
                          "Invalid language");
      end;

      declare
         Data : File_Info := Get_Path ("files/identify/gnat-3.0.ads");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 24, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("Ada", Data.Language, "Invalid language");
         Assert_Equals (T, LINE_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");

         for I in Infos.Line_Number (1) .. 24 loop
            Assert_Equals (T, LINE_COMMENT, Info.Lines (I).Comment,
                           "Invalid identification at" & I'Image);
         end loop;
      end;

      declare
         Data : File_Info := Get_Path ("files/identify/gpl-2.0-1.C");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 35, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("C++", Data.Language, "Invalid language");
         Assert_Equals (T, LINE_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");

         for I in Infos.Line_Number (1) .. 35 loop
            Assert_Equals (T, LINE_COMMENT, Info.Lines (I).Comment,
                           "Invalid identification at" & I'Image);
         end loop;
      end;

      declare
         Data : File_Info := Get_Path ("files/identify/gpl-3.0-1.sub");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 29, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("Shell", Data.Language, "Invalid language");
         Assert_Equals (T, LINE_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
      end;
   end Test_Open;

   --  ------------------------------
   --  Test reading a file with multiline comments.
   --  ------------------------------
   procedure Test_Multiline_Comment (T : in out Test) is
      Config    : SPDX_Tool.Configs.Config_Type;
      Languages : Language_Manager;
      Manager   : File_Manager;
   begin
      Languages.Initialize (Config);
      declare
         Data : File_Info := Get_Path ("files/identify/gpl-3.0.c");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 16, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("C", Data.Language, "Invalid language");
         Assert_Equals (T, START_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, START_COMMENT, Info.Lines (1).Comment,
                        "Invalid identification at 1");
         Assert_Equals (T, 1, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Text_Start,
                        "Invalid text start at 1");
         Assert_Equals (T, 32, Info.Lines (1).Style.Text_Last,
                        "Invalid text last at 1");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (2).Comment,
                        "Invalid identification at 2");
         Assert_Equals (T, 34, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 37, Info.Lines (2).Style.Text_Start,
                        "Invalid start at 2");
         Assert_Equals (T, 90, Info.Lines (2).Style.Text_Last,
                        "Invalid last at 2");

         Assert_Equals (T, END_COMMENT, Info.Lines (15).Comment,
                        "Invalid identification at 15");
         Assert_Equals (T, 662, Info.Lines (15).Style.Start,
                        "Invalid start at 15");
         Assert_Equals (T, 665, Info.Lines (15).Style.Text_Start,
                        "Invalid start at 15");
         Assert_Equals (T, 738, Info.Lines (15).Style.Last,
                        "Invalid last at 25");
         Assert_Equals (T, 736, Info.Lines (15).Style.Text_Last,
                        "Invalid last at 25");
      end;

      declare
         Data : File_Info := Get_Path ("files/identify/apache-2.0-3.c");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 16, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("C", Data.Language, "Invalid language");
         Assert_Equals (T, START_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, START_COMMENT, Info.Lines (1).Comment,
                        "Invalid identification at 1");
         Assert_Equals (T, 1, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Text_Start,
                        "Invalid start at 1");
         Assert_Equals (T, 39, Info.Lines (1).Style.Last,
                        "Invalid last at 1");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (2).Comment,
                        "Invalid identification at 2");
         Assert_Equals (T, 41, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 45, Info.Lines (2).Style.Text_Start,
                        "Invalid start at 2");
         Assert_Equals (T, 102, Info.Lines (2).Style.Last,
                        "Invalid last at 2");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (15).Comment,
                        "Invalid identification at 15");
         Assert_Equals (T, 695, Info.Lines (15).Style.Start,
                        "Invalid start at 15");
         Assert_Equals (T, 699, Info.Lines (15).Style.Text_Start,
                        "Invalid start at 15");
         Assert_Equals (T, 728, Info.Lines (15).Style.Last,
                        "Invalid last at 15");

         Assert_Equals (T, END_COMMENT, Info.Lines (16).Comment,
                        "Invalid identification at 16");
         Assert_Equals (T, 730, Info.Lines (16).Style.Start,
                        "Invalid start at 16");
         Assert_Equals (T, 731, Info.Lines (16).Style.Text_Start,
                        "Invalid start at 16");
         Assert_Equals (T, 731, Info.Lines (16).Style.Last,
                        "Invalid last at 16");
      end;

      declare
         Data : File_Info := Get_Path ("files/identify/lgpl-2.1.ml");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 16, Info.Count,
                        "Invalid number of lines");
         T.Assert_Equals ("OCaml", Data.Language,
                          "Invalid language");
         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Lines (1).Comment,
                        "Invalid identification at 1");
         Assert_Equals (T, 1, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Text_Start,
                        "Invalid start at 1");
         Assert_Equals (T, 76, Info.Lines (1).Style.Last,
                        "Invalid last at 1");

         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Lines (2).Comment,
                        "Invalid identification at 2");
         Assert_Equals (T, 78, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 80, Info.Lines (2).Style.Text_Start,
                        "Invalid start at 2");
         Assert_Equals (T, 153, Info.Lines (2).Style.Last,
                        "Invalid last at 2");

         Assert_Equals (T, LINE_BLOCK_COMMENT, Info.Lines (15).Comment,
                        "Invalid identification at 15");
         Assert_Equals (T, 1079, Info.Lines (15).Style.Start,
                        "Invalid start at 15");
         Assert_Equals (T, 1081, Info.Lines (15).Style.Text_Start,
                        "Invalid start at 15");
         Assert_Equals (T, 1154, Info.Lines (15).Style.Last,
                        "Invalid last at 15");
      end;

      declare
         Data : File_Info := Get_Path ("files/identify/lgpl-2.1.java");
         Info : File_Type (100);
      begin
         Manager.Open (Info, Data, Languages);
         Assert_Equals (T, 18, Info.Count,
                        "Invalid number of lines");
         Assert_Equals (T, START_COMMENT, Info.Cmt_Style,
                        "Invalid comment style");
         Assert_Equals (T, START_COMMENT, Info.Lines (1).Style.Mode,
                        "Invalid identification at 1");
         Assert_Equals (T, 1, Info.Lines (1).Style.Start,
                        "Invalid start at 1");
         Assert_Equals (T, 3, Info.Lines (1).Style.Text_Start,
                        "Invalid start at 1");
         Assert_Equals (T, 2, Info.Lines (1).Style.Last,
                        "Invalid last at 1");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (2).Style.Mode,
                        "Invalid identification at 2");
         Assert_Equals (T, 4, Info.Lines (2).Style.Start,
                        "Invalid start at 2");
         Assert_Equals (T, 8, Info.Lines (2).Style.Text_Start,
                        "Invalid start at 2");
         Assert_Equals (T, 30, Info.Lines (2).Style.Last,
                        "Invalid last at 2");

         Assert_Equals (T, BLOCK_COMMENT, Info.Lines (3).Style.Mode,
                        "Invalid identification at 3");
         Assert_Equals (T, 32, Info.Lines (3).Style.Start,
                        "Invalid start at 3");
         Assert_Equals (T, 36, Info.Lines (3).Style.Text_Start,
                        "Invalid start at 3");
         Assert_Equals (T, 68, Info.Lines (3).Style.Last,
                        "Invalid last at 3");

         Assert_Equals (T, END_COMMENT, Info.Lines (18).Style.Mode,
                        "Invalid identification at 18");
         Assert_Equals (T, 804, Info.Lines (18).Style.Start,
                        "Invalid start at 18");
         Assert_Equals (T, 806, Info.Lines (18).Style.Text_Start,
                        "Invalid start at 18");
         Assert_Equals (T, 806, Info.Lines (18).Style.Last,
                        "Invalid last at 18");
      end;
   end Test_Multiline_Comment;

   --  ------------------------------
   --  Test reading and replacing Ada header comment.
   --  ------------------------------
   procedure Test_Save_Ada (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/apache-2.0-1.ads");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0.1.ads");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 5, 16, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0.1.ads"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Ada;

   procedure Test_Save_Ada_Boxed (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/gnat-3.0.ads");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-gnat-3.0.ads");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 11, 19, "GPL-3.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-gnat-3.0.ads"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Ada_Boxed;

   procedure Test_Save_C (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/apache-2.0-3.c");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0.3.c");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 5, 15, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0.3.c"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_C;

   procedure Test_Save_CPP (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/gpl-2.0-1.C");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-gpl-2.0-1.C");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 12, 27, "GPL-2.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-gpl-2.0-1.C"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_CPP;

   procedure Test_Save_Shell (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/gpl-3.0-1.sub");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-gpl-3.0-1.sub");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 9, 27, "GPL-3.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-gpl-3.0-1.sub"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Shell;

   procedure Test_Save_Tex (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/mit-1.tex");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-mit-1.tex");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 3, 22, "MIT");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-mit-1.tex"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Tex;

   procedure Test_Save_OCaml (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/lgpl-2.1.ml");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-lgpl-2.1.ml");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 11, 13, "LGPL-2.1");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-lgpl-2.1.ml"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_OCaml;

   procedure Test_Save_Erlang (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/apache-2.0-4.erl");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0-4.erl");
      Languages : Language_Manager;
      Manager : File_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 6, 16, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0-4.erl"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Erlang;

   procedure Test_Save_Java (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Data   : File_Info := Get_Path ("files/identify/lgpl-2.1.java");
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-lgpl-2.1.java");
      Manager : File_Manager;
      Languages : Language_Manager;
      Info : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 5, 17, "LGPL-2.1");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-lgpl-2.1.java"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_Java;

   procedure Test_Save_XHTML (T : in out Test) is
      Config : SPDX_Tool.Configs.Config_Type;
      Result : constant String
        := Util.Tests.Get_Test_Path ("replace-apache-2.0-5.xhtml");
      Languages : Language_Manager;
      Manager   : File_Manager;
      Data      : File_Info := Get_Path ("files/identify/apache-2.0-5.xhtml");
      Info      : File_Type (100);
   begin
      Languages.Initialize (Config);
      Manager.Open (Info, Data, Languages);
      Manager.Save (Info, Result, 5, 15, "Apache-2.0");
      T.Assert (Ada.Directories.Exists (Result), "File not created");
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/replace-apache-2.0-5.xhtml"),
         Test    => Result,
         Message => "Invalid replacement");
   end Test_Save_XHTML;

end SPDX_Tool.Files.Manager.Tests;
