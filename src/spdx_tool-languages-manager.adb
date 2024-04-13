-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Log.Loggers;
with Util.Strings.Vectors;
with Util.Strings.Split;
with SPDX_Tool.Languages.CommentsMap;
package body SPDX_Tool.Languages.Manager is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Languages");

   --  ------------------------------
   --  Identify the language used by the given file.
   --  ------------------------------
   procedure Find_Language (Manager  : in Language_Manager;
                            File     : in out SPDX_Tool.Infos.File_Info;
                            Content  : in out File_Type;
                            Analyzer : out Analyzer_Access) is
      Result : Detector_Result;
   begin
      Manager.Filename_Detect.Detect (File, Content, Result);
      Manager.Extension_Detect.Detect (File, Content, Result);
      Manager.Mime_Detect.Detect (File, Content, Result);
      Manager.Shell_Detect.Detect (File, Content, Result);
      Manager.Modeline_Detect.Detect (File, Content, Result);
      declare
         Language : constant String := Get_Language (Result);
         Comment  : constant access constant String := CommentsMap.Get_Mapping (Language);
         Pos      : Language_Maps.Cursor;
      begin
         if Language'Length = 0 then
            Analyzer := null;
            Log.Info ("{0}: no language found", File.Path);
            return;
         end if;
         if Comment /= null then
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
                         Config  : in SPDX_Tool.Configs.Config_Type) is
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
                  Log.Error ("Language {0}: invalid comment style {1}",
                             Name, Lang);
               else
                  declare
                     Ref_Lang : constant Language_Maps.Reference_Type
                        := Manager.Languages.Reference (Pos);
                  begin
                     if Ref_Lang.Analyzer = null then
                        if Recurse > MAX_RECURSE then
                           Log.Error ("Too many recursive depend {0}", Name);
                        elsif Length (Ref_Lang.Config.Alternative) = 0 then
                           Log.Error ("Invalid language {0}", Lang);
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
      Add_Builtin ("dash-style", "--");
      Add_Builtin ("C-line", "//");
      Add_Builtin ("Shell", "#");
      Add_Builtin ("Latex", "%");
      Add_Builtin ("Forth", "\");
      Add_Builtin ("C-block", "/*", "*/");
      Add_Builtin ("XML", "<!--", "-->");
      Add_Builtin ("OCaml", "(*", "*)");
      Add_Builtin ("Erlang", "%%");
      Add_Builtin ("Lisp", ";");
      Add_Builtin ("JSP-style", "<%--", "--%>");
      Add_Builtin ("Smarty-style", "{*", "*}");
      Add_Builtin ("Haskell-style", "{-", "-}");
      Add_Builtin ("Smalltalk-style", """", """");
      Add_Builtin ("PowerShell-block", "<#", "#>");
      Add_Builtin ("CoffeeScript-block", "###", "###");
      Add_Builtin ("PowerShell-style", "", "", "PowerShell-block,Shell");
      Add_Builtin ("CoffeeScript-style", "", "", "Shell,CoffeeScript-block");
      Add_Builtin ("C-style", "", "", "C-line,C-block");
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

end SPDX_Tool.Languages.Manager;
