-- --------------------------------------------------------------------
--  spdx_tool-licenses-tests -- Tests for licenses package
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Tags;
with GNAT.Source_Info;
with Util.Test_Caller;
with Util.Assertions;
with SPDX_Tool.Configs;
with SPDX_Tool.Files;
with SPDX_Tool.Infos;
package body SPDX_Tool.Licenses.Manager.Tests is

   use SPDX_Tool.Infos;
   subtype File_Info is Infos.File_Info;

   procedure Assert_Equals is
     new Util.Assertions.Assert_Equals_T (Value_Type => License_Kind);

   procedure Check_License (T        : in out Test;
                            Filename : in String;
                            License  : in String;
                            Expect   : in String;
                            Kind     : in License_Kind;
                            Start    : in Positive;
                            Finish   : in Positive;
                            Source   : in String := GNAT.Source_Info.File;
                            Line     : in Natural := GNAT.Source_Info.Line);
   function Get_Path (Name : in String) return File_Info;

   function Get_Path (Name : in String) return File_Info is
      Path : constant String
        := Util.Tests.Get_Path ("regtests/" & Name);
   begin
      return File_Info '(Len => Path'Length, Path => Path, others => <>);
   end Get_Path;

   package Caller is new Util.Test_Caller (Test, "SPDX_Tool.Licenses");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Load_License (token)",
                       Test_Load_Template'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Load_License (fixed)",
                       Test_Template_Fixed'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Load_License (variable)",
                       Test_Template_Var'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Load_License (variable2)",
                       Test_Template_Var2'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Load_License (optional)",
                       Test_Template_Optional'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (fixed)",
                       Test_Find_License_Fixed'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (variable)",
                       Test_Find_License_Var'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (optional)",
                       Test_Find_License_Optional'Access);
      Caller.Add_Test (Suite, "Test SPDX_Tool.Licenses.Find_License (SPDX)",
                       Test_Find_License_SPDX'Access);
   end Add_Tests;

   procedure Check_License (T        : in out Test;
                            Filename : in String;
                            License  : in String;
                            Expect   : in String;
                            Kind     : in License_Kind;
                            Start    : in Positive;
                            Finish   : in Positive;
                            Source   : in String := GNAT.Source_Info.File;
                            Line     : in Natural := GNAT.Source_Info.Line) is
      Config  : SPDX_Tool.Configs.Config_Type;
      Data    : File_Info := Get_Path ("files/identify/" & Filename);
      Manager : SPDX_Tool.Licenses.Manager.License_Manager (1);
      File    : SPDX_Tool.Files.File_Type (100);
      Result  : License_Match;
   begin
      Manager.Languages.Initialize (Config);

      --  Load only one license to simplify the debugging in case of problem.
      Manager.Load_License ("licenses/" & License);
      Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
      Result := Manager.Find_License (File);
      Util.Tests.Assert_Equals (T, Expect, Result.Info.Name,
                                "Invalid license found", Source, Line);
      Assert_Equals (T, Kind, Result.Info.Match, "Invalid match kind");
      Util.Tests.Assert_Equals (T, Start, Natural (Result.Info.First_Line), "Invalid first line");
      Util.Tests.Assert_Equals (T, Finish, Natural (Result.Info.Last_Line), "Invalid last line");
      T.Assert (Result.Info.Confidence = 1.0,
                "Invalid confidence:" & Result.Info.Confidence'Image);
   end Check_License;

   --  ------------------------------
   --  Test reading and loading a license template.
   --  ------------------------------
   procedure Test_Load_Template (T : in out Test) is
      procedure Test_Load (Content : in String; Count : in Natural);

      procedure Test_Load (Content : in String; Count : in Natural) is
         Result  : License_Template;
      begin
         Manager.Load_License ("token", To_Buffer (Content), Result);
         T.Assert (Result.Root /= null, "Template not loaded");

         declare
            Node : Token_Access := Result.Root;
         begin
            for I in 1 .. Count loop
               T.Assert (Node /= null, "Template not loaded");
               Util.Tests.Assert_Equals (T, "SPDX_TOOL.LICENSES.TOKEN_TYPE",
                                         Ada.Tags.Expanded_Name (Node'Tag),
                                         "Invalid token at " & I'Image);
               Node := Node.Next;
            end loop;
            T.Assert (Node /= null, "Template not loaded");
            Util.Tests.Assert_Equals (T, "SPDX_TOOL.LICENSES.FINAL_TOKEN_TYPE",
                                      Ada.Tags.Expanded_Name (Node'Tag),
                                      "Invalid final token");
         end;
      end Test_Load;
   begin
      Test_Load ("token", 1);
      Test_Load ("  token   ", 1);
      Test_Load (" token1  token2", 2);
      Test_Load (" token1 token2 token3", 3);
      Test_Load ("(token)", 3);
      Test_Load ("( token )", 3);
      Test_Load ("{(.)}", 5);
      Test_Load ("token1.", 2);
   end Test_Load_Template;

   --  ------------------------------
   --  Test reading a template and matching fix content.
   --  ------------------------------
   procedure Test_Template_Fixed (T : in out Test) is
      Data    : File_Info := Get_Path ("files/templates/text.ads");
      Config  : SPDX_Tool.Configs.Config_Type;
      Manager : SPDX_Tool.Licenses.Manager.License_Manager (1);
      File    : SPDX_Tool.Files.File_Type (100);
      Result  : License_Match;
   begin
      Manager.Languages.Initialize (Config);
      Manager.Load_License ("regtests/files/templates/text.txt");
      Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
      declare
         Buf : constant Buffer_Accessor := File.Buffer.Value;
      begin
         Result := Manager.Find_License (Buf.Data, File.Lines, 1, 2);
      end;
      Util.Tests.Assert_Equals (T, "text", Result.Info.Name,
                                "Invalid license found");
   end Test_Template_Fixed;

   --  ------------------------------
   --  Test reading a template and matching fix content.
   --  ------------------------------
   procedure Test_Template_Var (T : in out Test) is
      Data    : File_Info := Get_Path ("files/templates/variable.ads");
      Config  : SPDX_Tool.Configs.Config_Type;
      Manager : SPDX_Tool.Licenses.Manager.License_Manager (1);
      File    : SPDX_Tool.Files.File_Type (100);
      Result  : License_Match;
   begin
      Manager.Languages.Initialize (Config);
      Manager.Load_License ("regtests/files/templates/variable.txt");
      Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
      declare
         Buf : constant Buffer_Accessor := File.Buffer.Value;
      begin
         Result := Manager.Find_License (Buf.Data, File.Lines, 1, 2);
      end;
      Util.Tests.Assert_Equals (T, "variable", Result.Info.Name,
                                "Invalid license found");
      Assert_Equals (T, Infos.TEMPLATE_LICENSE, Result.Info.Match, "Invalid match kind");
   end Test_Template_Var;

   procedure Test_Template_Var2 (T : in out Test) is
      Data    : File_Info := Get_Path ("files/templates/variable-2.ads");
      Config  : SPDX_Tool.Configs.Config_Type;
      Manager : SPDX_Tool.Licenses.Manager.License_Manager (1);
      File    : SPDX_Tool.Files.File_Type (100);
      Result  : License_Match;
   begin
      Manager.Languages.Initialize (Config);
      Manager.Load_License ("regtests/files/templates/variable-2.txt");
      Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
      declare
         Buf : constant Buffer_Accessor := File.Buffer.Value;
      begin
         Result := Manager.Find_License (Buf.Data, File.Lines, 1, 2);
      end;
      Util.Tests.Assert_Equals (T, "variable-2", Result.Info.Name,
                                "Invalid license found");
      Assert_Equals (T, Infos.TEMPLATE_LICENSE, Result.Info.Match, "Invalid match kind");
   end Test_Template_Var2;

   procedure Test_Template_Optional (T : in out Test) is
      Config  : SPDX_Tool.Configs.Config_Type;
      Manager : SPDX_Tool.Licenses.Manager.License_Manager (1);
   begin
      Manager.Languages.Initialize (Config);
      Manager.Load_License ("regtests/files/templates/optional-1.txt");
      declare
         Data    : File_Info := Get_Path ("files/templates/optional-1.ads");
         File    : SPDX_Tool.Files.File_Type (100);
         Result  : License_Match;
      begin
         Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
         declare
            Buf : constant Buffer_Accessor := File.Buffer.Value;
         begin
            Result := Manager.Find_License (Buf.Data, File.Lines, 1, 2);
         end;
         Util.Tests.Assert_Equals (T, "optional-1", Result.Info.Name,
                                   "Invalid license found");
         Assert_Equals (T, Infos.TEMPLATE_LICENSE, Result.Info.Match, "Invalid match kind");
      end;
      declare
         Data    : File_Info := Get_Path ("files/templates/optional-1.java");
         File    : SPDX_Tool.Files.File_Type (100);
         Result  : License_Match;
      begin
         Manager.File_Mgr (1).Open (File, Data, Manager.Languages);
         declare
            Buf : constant Buffer_Accessor := File.Buffer.Value;
         begin
            Result := Manager.Find_License (Buf.Data, File.Lines, 1, 4);
         end;
         Util.Tests.Assert_Equals (T, "optional-1", Result.Info.Name,
                                   "Invalid license found");
         Assert_Equals (T, Infos.TEMPLATE_LICENSE, Result.Info.Match, "Invalid match kind");
      end;
   end Test_Template_Optional;

   --  ------------------------------
   --  Test Find_License with simple license files
   --  ------------------------------
   procedure Test_Find_License_Fixed (T : in out Test) is
   begin
      Check_License (T, "apache-2.0-1.ads", "standard/Apache-2.0.txt",
                     "Apache-2.0", TEMPLATE_LICENSE, 3, 16);
   end Test_Find_License_Fixed;

   procedure Test_Find_License_Var (T : in out Test) is
   begin
      --  License contains variable part.
      Check_License (T, "lgpl-2.1.c", "standard/LGPL-2.1+.txt",
                     "LGPL-2.1+", TEMPLATE_LICENSE, 1, 16);
      Check_License (T, "bsd-3-clause.c", "standard/BSD-3-Clause.txt",
                     "BSD-3-Clause", TEMPLATE_LICENSE, 1, 24);
   end Test_Find_License_Var;

   procedure Test_Find_License_Optional (T : in out Test) is
   begin
      Check_License (T, "antlr-pd-1.c", "standard/ANTLR-PD.txt",
                     "ANTLR-PD", TEMPLATE_LICENSE, 1, 16);
      Check_License (T, "antlr-pd-2.c", "standard/ANTLR-PD.txt",
                     "ANTLR-PD", TEMPLATE_LICENSE, 3, 16);
   end Test_Find_License_Optional;

   procedure Test_Find_License_SPDX (T : in out Test) is
   begin
      Check_License (T, "gpl-2.0-only-1.sh", "standard/LGPL-2.1+.txt",
                     "GPL-2.0-only", SPDX_LICENSE, 1, 1);
      Check_License (T, "mit-2.c", "standard/LGPL-2.1+.txt",
                     "MIT", SPDX_LICENSE, 1, 1);
      Check_License (T, "gpl-2.0-or-bsd.c", "standard/LGPL-2.1+.txt",
                     "GPL-2.0+ OR BSD-3-Clause", SPDX_LICENSE, 1, 1);
   end Test_Find_License_SPDX;

end SPDX_Tool.Licenses.Manager.Tests;
