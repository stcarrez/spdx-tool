-- --------------------------------------------------------------------
--  spdx_tool-languages-tests -- Tests for languages package
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with GNAT.Source_Info;
with Util.Test_Caller;
with SPDX_Tool.Infos;
with SPDX_Tool.Languages.Shell;
with SPDX_Tool.Languages.Modelines;
package body SPDX_Tool.Languages.Tests is

   use SPDX_Tool.Infos;
   subtype File_Info is Infos.File_Info;

   procedure Check_Shell (T        : in out Test;
                          Content  : in String;
                          Expect   : in String;
                          Source   : in String := GNAT.Source_Info.File;
                          Line     : in Natural := GNAT.Source_Info.Line);
   procedure Check_Modeline (T        : in out Test;
                             Content  : in String;
                             Expect   : in String;
                             Source   : in String := GNAT.Source_Info.File;
                             Line     : in Natural := GNAT.Source_Info.Line);

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Languages");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Shell",
                       Test_Shell_Detector'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Languages.Modeline",
                       Test_Modeline_Detector'Access);
   end Add_Tests;

   procedure Check_Modeline (T        : in out Test;
                             Content  : in String;
                             Expect   : in String;
                             Source   : in String := GNAT.Source_Info.File;
                             Line     : in Natural := GNAT.Source_Info.Line) is
      File     : File_Info (1);
      Data     : File_Type (100);
      Result   : Detector_Result;
      Modeline : Languages.Modelines.Modeline_Detector_Type;
   begin
      Data.Buffer := Create_Buffer (Content);
      Data.Last_Offset := Content'Length;
      Find_Lines (Data.Buffer.Value.Data, Data.Lines, Data.Count);
      Modeline.Detect (File, Data, Result);
      T.Assert_Equals (Expect, Get_Language (Result), "Invalid detection", Source, Line);
   end Check_Modeline;

   procedure Check_Shell (T        : in out Test;
                          Content  : in String;
                          Expect   : in String;
                          Source   : in String := GNAT.Source_Info.File;
                          Line     : in Natural := GNAT.Source_Info.Line) is
      File    : File_Info (1);
      Data    : File_Type (100);
      Result  : Detector_Result;
      Shell   : Languages.Shell.Shell_Detector_Type;
   begin
      Data.Buffer := Create_Buffer (Content);
      Data.Last_Offset := Content'Length;
      Find_Lines (Data.Buffer.Value.Data, Data.Lines, Data.Count);
      Shell.Detect (File, Data, Result);
      T.Assert_Equals (Expect, Get_Language (Result), "Invalid detection", Source, Line);
   end Check_Shell;

   --  ------------------------------
   --  Test shell detector on several patterns.
   --  ------------------------------
   procedure Test_Shell_Detector (T : in out Test) is
   begin
      Check_Shell (T, "#!/bin/sh", "Shell");
      Check_Shell (T, "#! /bin/bash", "Shell");
      Check_Shell (T, "#!  /bin/dash", "Shell");
      Check_Shell (T, "#!  /bin/sh x", "Shell");
      Check_Shell (T, "#!  /bin/perl x", "Perl");
      Check_Shell (T, "", "");
      Check_Shell (T, "#", "");
      Check_Shell (T, "#!", "");
      Check_Shell (T, "#! ", "");
      Check_Shell (T, "#! a", "");
   end Test_Shell_Detector;

   --  ------------------------------
   --  Test the emacs/vim modeline detector on several patterns.
   --  ------------------------------
   procedure Test_Modeline_Detector (T : in out Test) is
   begin
      Check_Modeline (T, "# -*-lisp-*-", "Common Lisp");
      Check_Modeline (T, "# -*-C++-*-", "C++");
      Check_Modeline (T, "# -*-mode:Java-*-", "Java");
      Check_Modeline (T, "# -*- tabs:8;mode:Perl-*-", "Perl");
      Check_Modeline (T, "# -*- tabs:8 ; mode: Perl-*-", "Perl");
      Check_Modeline (T, "# -*- tabs:8 ; mode : Perl-*-", "Perl");
      Check_Modeline (T, "# -*- tabs:8 ; mode : Perl -*-", "Perl");
      Check_Modeline (T, "# -*- tabs:4 ; mode : ada ; indend: full-*-", "Ada");
      Check_Modeline (T, "# -*- Python-*-", "Python");
      Check_Modeline (T, "# -*- tabs:4;mode:Forth;indent:none-*-", "Forth");
      Check_Modeline (T, "# -*- tabs:4;mode:Forth;indent:none", "");
      Check_Modeline (T, "# -*- tabs:4;indent:none-*-", "");
   end Test_Modeline_Detector;

end SPDX_Tool.Languages.Tests;
