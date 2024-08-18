-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Unchecked_Deallocation;
with Util.Log.Loggers;
with Util.Strings.Vectors;
with Util.Strings.Split;
with SPDX_Tool.Languages.CommentsMap;
with SPDX_Tool.Languages.Rules.Generated;
with SPDX_Tool.Languages.Rules.Disambiguations;
package body SPDX_Tool.Languages.Manager is

   use type Ada.Containers.Count_Type;
   use type Infos.File_Kind;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Languages");

   --  ------------------------------
   --  Look at the detected languages and disambiguate if several are identified.
   --  ------------------------------
   procedure Disambiguate (Manager : in Language_Manager;
                           File    : in SPDX_Tool.Infos.File_Info;
                           Content : in File_Type;
                           Result  : in out Detector_Result) is
      Definition : Rules.Rules_List renames Rules.Disambiguations.Definition;
   begin
      if Result.Languages.Length <= 1 then
         return;
      end if;
      declare
         use type Rules.Rule_Index, Rules.Pattern_Length;
         Pos : constant Rules.Rule_Index := Rules.Find (Definition, File, Content);
      begin
         if Pos > 0 and then Definition.Rules (Pos).Result > 0 then
            Set_Language (Result, "disambiguate",
                          Definition.Strings (Definition.Rules (Pos).Result).all, 0.5);
         end if;
      end;
   end Disambiguate;

   --  ------------------------------
   --  Identify the language used by the given file.
   --  ------------------------------
   procedure Find_Language (Manager  : in Language_Manager;
                            Tokens   : in SPDX_Tool.Token_Counters.Token_Maps.Map;
                            File     : in out SPDX_Tool.Infos.File_Info;
                            Content  : in out File_Type;
                            Analyzer : out Analyzer_Access) is
      Buf    : constant Buffer_Accessor := Content.Buffer.Value;
      Len    : constant Buffer_Size := Content.Last_Offset;
      Result : Detector_Result;
   begin
      Manager.Filename_Detect.Detect (File, Content, Result);
      Manager.Extension_Detect.Detect (File, Content, Result);
      Manager.Mime_Detect.Detect (File, Content, Result);
      Manager.Shell_Detect.Detect (File, Content, Result);
      Manager.Modeline_Detect.Detect (File, Content, Result);
      Manager.Generated_Detect.Detect (File, Content, Result);
      Manager.Disambiguate (File, Content, Result);
      declare
         Language : constant String := Get_Language (Result);
         Comment  : constant access constant String := CommentsMap.Get_Mapping (Language);
         Pos      : Language_Maps.Cursor;
      begin
         File.Generated := Result.Generated;
         File.Kind := Result.Kind;
         if Language'Length = 0 then
            Analyzer := null;
            if Length (Result.Generated) = 0 then
               Log.Info ("{0}: no language found", File.Path);
            elsif not Opt_Keep_Generated then
               Log.Info ("{0}: generated file by {1} (ignored)",
                      File.Path, To_String (Result.Generated));
               Content.Cmt_Style := NO_COMMENT;
               File.Filtered := True;
            else
               Log.Info ("{0}: generated file by {1}",
                      File.Path, To_String (Result.Generated));
               Content.Cmt_Style := NO_COMMENT;
            end if;
            return;
         end if;
         if File.Kind /= Infos.FILE_PROGRAMMING then
            Log.Info ("{0}: {1} (skipped)", File.Path, Language);
            Content.Cmt_Style := NO_COMMENT;
            File.Filtered := True;
            return;
         end if;
         if Comment /= null and then Comment.all /= "" then
            Pos := Manager.Languages.Find (Comment.all);
         else
            Pos := Manager.Languages.Find (Language);
         end if;
         File.Language := To_UString (Language);
         if Language_Maps.Has_Element (Pos) then
            Analyzer := Language_Maps.Element (Pos).Analyzer;
            Log.Info ("{0}: language {1} with analyzer", File.Path, Language);
         elsif Manager.Default /= null then
            Analyzer := Manager.Default.all'Access;
            Log.Info ("{0}: language {1} with default analyzer", File.Path, Language);
         else
            Analyzer := null;
            Log.Info ("{0}: language {1} without analyzer", File.Path, Language);
         end if;
         if not Opt_Keep_Generated and then Length (Result.Generated) > 0 then
            Log.Info ("{0}: generated file by {1} (ignored)",
                      File.Path, To_String (Result.Generated));
            Content.Cmt_Style := NO_COMMENT;
            File.Filtered := True;
            return;
         end if;
         if Analyzer /= null and then Manager.Level = IDENTIFY_COMMENTS then
            Analyzer.all.Find_Comments (Tokens, Buf.Data (Buf.Data'First .. Len),
                                        Content.Lines, Content.Count);
            for Line of Content.Lines (1 .. Content.Count) loop
               if Line.Style.Mode /= NO_COMMENT
                  and then Line.Style.Category not in Files.INTERPRETER | Files.MODELINE
               then
                  Content.Cmt_Style := Line.Style.Mode;
                  Content.Cmt_Count := Content.Cmt_Count + 1;
               end if;
            end loop;
         else
            Content.Cmt_Style := NO_COMMENT;
         end if;
      end;
   end Find_Language;

   function Create_Analyzer (Manager : in Language_Manager;
                             Conf    : in Comment_Configuration) return Analyzer_Access is
   begin
      if Length (Conf.Alternative) = 0 then
         if Length (Conf.Block_Start) = 0 then
            declare
               Start : constant Buffer_Type := To_Buffer (Conf.Start);
            begin
               return new Line_Analyzer_Type '(Len           => Start'Length,
                                               Comment_Start => Start);
            end;
         else
            declare
               Block_Start : constant Buffer_Type := To_Buffer (Conf.Block_Start);
               Block_End   : constant Buffer_Type := To_Buffer (Conf.Block_End);
            begin
               return new Block_Analyzer_Type '(Len_Start     => Block_Start'Length,
                                                Len_End       => Block_End'Length,
                                                Comment_Start => Block_Start,
                                                Comment_End   => Block_End);
            end;
         end if;
      end if;
      return null;
   end Create_Analyzer;

   function Find_Analyzer (Manager : in Language_Manager;
                           Name    : in String) return Analyzer_Access is
      Pos : constant Language_Maps.Cursor := Manager.Languages.Find (Name);
   begin
      if Language_Maps.Has_Element (Pos) then
         return Language_Maps.Element (Pos).Analyzer;
      else
         return null;
      end if;
   end Find_Analyzer;

   --  ------------------------------
   --  Initialize the language manager with the given configuration.
   --  ------------------------------
   procedure Initialize (Manager : in out Language_Manager;
                         Config  : in SPDX_Tool.Configs.Config_Type;
                         Level   : in Level_Type := IDENTIFY_COMMENTS) is
      procedure Set_Comments (Conf : in Comment_Configuration);
      procedure Set_Language (Conf : in Language_Configuration);
      procedure Add_Builtin (Language     : in String;
                             Start_Cmt    : in String;
                             End_Cmt      : in String := "";
                             Alternatives : in String := "");
      procedure Setup_Language (Name    : in String;
                                Lang    : in Language_Maps.Reference_Type;
                                Recurse : in Positive);

      procedure Set_Comments (Conf : in Comment_Configuration) is
         Lang : constant String := To_String (Conf.Language);
         Pos  : constant Language_Maps.Cursor := Manager.Languages.Find (Lang);
      begin
         if not Language_Maps.Has_Element (Pos) then
            Manager.Languages.Include (Lang, (null, Conf));
         end if;
      end Set_Comments;

      procedure Set_Language (Conf : in Language_Configuration) is
         Language : constant String := To_String (Conf.Language);
         Comment  : constant String := To_String (Conf.Comment);
      begin
         for Pattern of Conf.Extensions loop
            Manager.Filename_Detect.File_Mapper.Insert (Pattern   => Pattern,
                                                        Recursive => True,
                                                        Value     => Language);
         end loop;
         if Comment'Length > 0 then
            Add_Builtin (Language, "", "", Comment);
         end if;
      end Set_Language;

      procedure Add_Builtin (Language     : in String;
                             Start_Cmt    : in String;
                             End_Cmt      : in String := "";
                             Alternatives : in String := "") is
         Conf : Comment_Configuration;
      begin
         Conf.Language := To_UString (Language);
         if End_Cmt'Length = 0 then
            Conf.Start := To_UString (Start_Cmt);
         else
            Conf.Block_Start := To_UString (Start_Cmt);
            Conf.Block_End := To_UString (End_Cmt);
         end if;
         Conf.Alternative := To_UString (Alternatives);
         Set_Comments (Conf);
      end Add_Builtin;

      MAX_RECURSE : constant := 10;

      procedure Setup_Language (Name    : in String;
                                Lang    : in Language_Maps.Reference_Type;
                                Recurse : in Positive) is
         Names : constant Util.Strings.Vectors.Vector
            := Util.Strings.Split (To_String (Lang.Config.Alternative), ",");
         Result : Combined_Analyzer_Access;
      begin
         Result := new Combined_Analyzer_Type '(Count => Positive (Names.Length),
                                                others => <>);
         for I in 1 .. Result.Count loop
            declare
               Lang : constant String := Names.Element (I);
               Pos  : constant Language_Maps.Cursor := Manager.Languages.Find (Lang);
            begin
               if not Language_Maps.Has_Element (Pos) then
                  Log.Error ("language {0}: invalid comment style {1}",
                             Name, Lang);
               else
                  declare
                     Ref_Lang : constant Language_Maps.Reference_Type
                        := Manager.Languages.Reference (Pos);
                  begin
                     if Ref_Lang.Analyzer = null then
                        if Recurse > MAX_RECURSE then
                           Log.Error ("too many recursive depend {0}", Name);
                        elsif Length (Ref_Lang.Config.Alternative) = 0 then
                           Log.Error ("invalid language {0}", Lang);
                        else
                           Setup_Language (Lang, Ref_Lang, Recurse + 1);
                        end if;
                     end if;
                     Result.Analyzers (I) := Ref_Lang.Analyzer;
                  end;
               end if;
            end;
         end loop;
         Lang.Analyzer := Result.all'Access;
      end Setup_Language;

      Basic_Analyzer_Count : Natural := 0;
   begin
      Manager.Level := Level;
      SPDX_Tool.Languages.Rules.Initialize (Rules.Generated.Definition);
      SPDX_Tool.Languages.Rules.Initialize (Rules.Disambiguations.Definition);
      Add_Builtin ("dash-style", "--");
      Add_Builtin ("C-line", "//");
      Add_Builtin ("Shell", "#");
      Add_Builtin ("Latex-style", "%");
      Add_Builtin ("Forth", "\");
      Add_Builtin ("C-block", "/*", "*/");
      Add_Builtin ("XML", "<!--", "-->");
      Add_Builtin ("OCaml-style", "(*", "*)");
      Add_Builtin ("Erlang-style", "%%");
      Add_Builtin ("Semicolon", ";");
      Add_Builtin ("JSP-style", "<%--", "--%>");
      Add_Builtin ("Smarty-style", "{*", "*}");
      Add_Builtin ("Haskell-style", "{-", "-}");
      Add_Builtin ("Smalltalk-style", """", """");
      Add_Builtin ("PowerShell-block", "<#", "#>");
      Add_Builtin ("CoffeeScript-block", "###", "###");
      Add_Builtin ("PowerShell-style", "", "", "PowerShell-block,Shell");
      Add_Builtin ("CoffeeScript-style", "", "", "Shell,CoffeeScript-block");
      Add_Builtin ("C-style", "", "", "C-line,C-block");
      Add_Builtin ("M4-dnl", "dnl");
      Add_Builtin ("M4-style", "", "", "M4-dnl,Shell");
      Configs.Configure (Config,
                         Set_Comments'Access);
      Configs.Configure (Config,
                         Set_Language'Access);

      --  Build the basic line or block comment language analyzers.
      for Iter in Manager.Languages.Iterate loop
         declare
            Lang : constant Language_Maps.Reference_Type := Manager.Languages.Reference (Iter);
         begin
            if Length (Lang.Config.Alternative) = 0 then
               Lang.Analyzer := Manager.Create_Analyzer (Lang.Config);
               Basic_Analyzer_Count := Basic_Analyzer_Count + 1;
            end if;
         end;
      end loop;

      --  Build language analyzer that depend on other analyzers.
      for Iter in Manager.Languages.Iterate loop
         declare
            Lang : constant Language_Maps.Reference_Type := Manager.Languages.Reference (Iter);
         begin
            if Length (Lang.Config.Alternative) > 0 then
               Setup_Language (Language_Maps.Key (Iter), Lang, 1);
            end if;
         end;
      end loop;

      Manager.Default := new Combined_Analyzer_Type '(Count => Basic_Analyzer_Count, others => <>);
      Basic_Analyzer_Count := 0;
      for Iter in Manager.Languages.Iterate loop
         declare
            Lang : constant Language_Maps.Reference_Type := Manager.Languages.Reference (Iter);
         begin
            if Length (Lang.Config.Alternative) = 0
               and then Lang.Analyzer /= null
               and then Basic_Analyzer_Count <= Manager.Default.Count
            then
               Basic_Analyzer_Count := Basic_Analyzer_Count + 1;
               Manager.Default.Analyzers (Basic_Analyzer_Count) := Lang.Analyzer;
            end if;
         end;
      end loop;
   end Initialize;

   overriding
   procedure Finalize (Manager : in out Language_Manager) is
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Analyzer_Type'Class,
                                         Name   => Analyzer_Access);
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Combined_Analyzer_Type,
                                         Name   => Combined_Analyzer_Access);
   begin
      for I in Manager.Default.Analyzers'Range loop
         Free (Manager.Default.Analyzers (I));
      end loop;
      Free (Manager.Default);
   end Finalize;

end SPDX_Tool.Languages.Manager;
