-- --------------------------------------------------------------------
--  spdx_tool-tests -- Tests for spdx-tool executable
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;
with GNAT.Source_Info;
with Util.Test_Caller;
package body SPDX_Tool.Tests is

   procedure Test_Print_License (T      : in out Test;
                                 Name   : in String;
                                 File   : in String;
                                 Source : in String := GNAT.Source_Info.File;
                                 Line   : in Natural := GNAT.Source_Info.Line);

   procedure Test_Update_License (T       : in out Test;
                                  Name    : in String;
                                  File    : in String;
                                  Pattern : in String;
                                  Source  : in String := GNAT.Source_Info.File;
                                  Line    : in Natural := GNAT.Source_Info.Line);

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Tests");

   function Tool return String is ("bin/spdx-tool");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Usage",
                       Test_Usage'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --check",
                       Test_Report_Licenses'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --files",
                       Test_Report_Files'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --only-licenses",
                       Test_Report_Only_Licenses_Files'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --ignore-licenses",
                       Test_Report_Ignore_Licenses_Files'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --identify",
                       Test_Identify'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --identify --licenses",
                       Test_Identify_Licenses'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --identify --languages",
                       Test_Identify_Languages'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --output-json",
                       Test_Json_Report'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --output-xml",
                       Test_Xml_Report'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --print-license (Apache)",
                       Test_Print_License_Apache'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --print-license (GNAT, boxed)",
                       Test_Print_License_Gnat'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --print-license (BSD, C)",
                       Test_Print_License_Bsd'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --print-license (Ocaml, boxed)",
                       Test_Print_License_Ocaml'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --print-license (None)",
                       Test_Print_License_None'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --line-number --print-license (Antlr)",
                       Test_Print_License_Antlr'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --print-license (Blessing)",
                       Test_Print_License_Blessing'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --update (Ada)",
                       Test_Update_License_Ada'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --update (C)",
                       Test_Update_License_C'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --update (XHTML)",
                       Test_Update_License_XHTML'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool --update (JSP)",
                       Test_Update_License_JSP'Access);
   end Add_Tests;

   --  ------------------------------
   --  Test launching spdx-tool and checking its usage.
   --  ------------------------------
   procedure Test_Usage (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --help", Result, 1);
      Util.Tests.Assert_Matches (T, "spdx-tool - SPDX license management tool.*",
                                 Result, "Invalid usage");
   end Test_Usage;

   procedure Test_Report_Licenses (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color regtests/src", Result, 0);
      Util.Tests.Assert_Matches (T, ".*Apache-2.0.*SPDX.*100.0.*",
                                 Result, "Invalid result");
   end Test_Report_Licenses;

   procedure Test_Report_Files (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color -f regtests/src", Result, 0);
      Util.Tests.Assert_Matches (T, ".*Apache-2.0.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/src/spdx_tool-files-manager-tests.adb.*",
                                 Result, "missing file");
      Util.Tests.Assert_Matches (T, ".*regtests/src/spdx_tool-tests.ads.*",
                                 Result, "missing file");
   end Test_Report_Files;

   procedure Test_Report_Only_Licenses_Files (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color --only-licenses None -f regtests", Result, 0);
      Util.Tests.Assert_Matches (T, ".*None.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/files/identify/none.keywords.*",
                                 Result, "missing file");
      Util.Tests.Assert_Matches (T, ".*regtests/spdx_tool_tests.gpr.*",
                                 Result, "missing file");
   end Test_Report_Only_Licenses_Files;

   procedure Test_Report_Ignore_Licenses_Files (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --no-color --ignore-licenses None,Unkown,Apache-2.0 -f regtests",
                 Result, 0);
      Util.Tests.Assert_Matches (T, ".*GPL-3.0.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/expect/replace-gnat-3.0.ads.*",
                                 Result, "missing file");
      Util.Tests.Assert_Matches (T, ".*MIT.*",
                                 Result, "wrong license");
      Util.Tests.Assert_Matches (T, ".*regtests/expect/replace-mit-1.tex.*",
                                 Result, "missing file");
   end Test_Report_Ignore_Licenses_Files;

   procedure Test_Identify (T : in out Test) is
      Result : UString;
   begin
      T.Execute (Tool & " --identify regtests/files/identify/bsd-3-clause.c",
                 Result, 0);
      Util.Tests.Assert_Matches (T, "BSD-3-Clause", Result,
                                "Identify failed");
   end Test_Identify;

   procedure Test_Identify_Licenses (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Test_Path ("identify-licenses.txt");
      Result : UString;
   begin
      T.Execute (Tool & " --identify --licenses regtests/files/identify",
                 "", Path,
                 Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/identify-licenses.txt"),
         Test    => Path,
         Message => "Invalid identify licenses list");
   end Test_Identify_Licenses;

   procedure Test_Identify_Languages (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Test_Path ("identify-languages.txt");
      Result : UString;
   begin
      T.Execute (Tool & " --identify --languages regtests/files/identify",
                 "", Path,
                 Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/identify-languages.txt"),
         Test    => Path,
         Message => "Invalid identify languages list");
   end Test_Identify_Languages;

   procedure Test_Json_Report (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Test_Path ("report.json");
      Result : UString;
   begin
      T.Execute (Tool & " --mimes --output-json " & Path & " regtests/files/identify",
                 Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/report.json"),
         Test    => Path,
         Message => "Invalid json report");
   end Test_Json_Report;

   procedure Test_Xml_Report (T : in out Test) is
      Path : constant String
        := Util.Tests.Get_Test_Path ("report.xml");
      Result : UString;
   begin
      T.Execute (Tool & " --mimes --output-xml " & Path & " regtests/files/identify",
                 Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/report.xml"),
         Test    => Path,
         Message => "Invalid XML report");
   end Test_Xml_Report;

   procedure Test_Print_License (T      : in out Test;
                                 Name   : in String;
                                 File   : in String;
                                 Source : in String := GNAT.Source_Info.File;
                                 Line   : in Natural := GNAT.Source_Info.Line) is
      Path : constant String := Util.Tests.Get_Test_Path (Name);
      Result : UString;
   begin
      T.Execute (Tool & " --no-color -p regtests/files/identify/" & File, "",
                 Path, Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/" & Name),
         Test    => Path,
         Message => "Invalid license extraction",
         Source  => Source,
         Line    => Line);
   end Test_Print_License;

   procedure Test_Print_License_Apache (T : in out Test) is
   begin
      Test_Print_License (T, "print-apache.txt", "apache-2.0-1.ads");
   end Test_Print_License_Apache;

   procedure Test_Print_License_Gnat (T : in out Test) is
   begin
      Test_Print_License (T, "print-gnat.txt", "gnat-3.0.ads");
   end Test_Print_License_Gnat;

   procedure Test_Print_License_Bsd (T : in out Test) is
   begin
      Test_Print_License (T, "print-bsd.txt", "bsd-3-clause.c");
   end Test_Print_License_Bsd;

   procedure Test_Print_License_Ocaml (T : in out Test) is
   begin
      Test_Print_License (T, "print-ocaml.txt", "lgpl-2.1.ml");
   end Test_Print_License_Ocaml;

   procedure Test_Print_License_None (T : in out Test) is
   begin
      Test_Print_License (T, "print-none.txt", "none.keywords");
   end Test_Print_License_None;

   procedure Test_Print_License_Antlr (T : in out Test) is
      Path : constant String := Util.Tests.Get_Test_Path ("print-antlr.txt");
      Result : UString;
   begin
      --  Print license for two files with line numbers.
      T.Execute (Tool & " --print-license --line-number regtests/files/identify/antlr-pd-1.c "
                 & " regtests/files/identify/antlr-pd-2.c", "",
                 Path, Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/print-antlr.txt"),
         Test    => Path,
         Message => "Invalid license extraction");
   end Test_Print_License_Antlr;

   procedure Test_Print_License_Blessing (T : in out Test) is
   begin
      Test_Print_License (T, "print-blessing-2.txt", "blessing-2.ads");
   end Test_Print_License_Blessing;

   --  Test spdx-tool --update option on various languages
   procedure Test_Update_License (T       : in out Test;
                                  Name    : in String;
                                  File    : in String;
                                  Pattern : in String;
                                  Source  : in String := GNAT.Source_Info.File;
                                  Line    : in Natural := GNAT.Source_Info.Line) is
      Path : constant String := Util.Tests.Get_Test_Path (Name);
      Dst_Path : constant String := Util.Tests.Get_Test_Path ("update-" & File);
      Src_Path : constant String := Util.Tests.Get_Path ("regtests/files/identify/" & File);
      Result : UString;
   begin
      if Ada.Directories.Exists (Dst_Path) then
         Ada.Directories.Delete_File (Dst_Path);
      end if;
      Ada.Directories.Copy_File (Src_Path, Dst_Path);
      T.Execute (Tool & " --update " & Pattern & " " & Dst_Path, "",
                 Path, Result, 0);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/" & Name),
         Test    => Path,
         Message => "Invalid license update",
         Source  => Source,
         Line    => Line);
      Util.Tests.Assert_Equal_Files
        (T       => T,
         Expect  => Util.Tests.Get_Path ("regtests/expect/update-" & File),
         Test    => Dst_Path,
         Message => "Invalid update replacement",
         Source  => Source,
         Line    => Line);
   end Test_Update_License;

   procedure Test_Update_License_Ada (T : in out Test) is
   begin
      Test_Update_License (T, "update-apache-2.0-1.txt", "apache-2.0-1.ads", "1..2,spdx");
   end Test_Update_License_Ada;

   procedure Test_Update_License_C (T : in out Test) is
   begin
      Test_Update_License (T, "update-bsd-3-clause.txt", "bsd-3-clause.c", "1,spdx");
   end Test_Update_License_C;

   procedure Test_Update_License_XHTML (T : in out Test) is
   begin
      Test_Update_License (T, "update-apache-2.0-5.txt", "apache-2.0-5.xhtml", "spdx");
   end Test_Update_License_XHTML;

   procedure Test_Update_License_JSP (T : in out Test) is
   begin
      Test_Update_License (T, "update-apache-2.0-6.txt", "apache-2.0-6.jsp", "1,spdx");
   end Test_Update_License_JSP;

end SPDX_Tool.Tests;
