-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;

with Util.Log.Loggers;
with Util.Files;
with Util.Strings.Vectors;
with Util.Strings.Split;
with SPDX_Tool.Extensions;
package body SPDX_Tool.Languages is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Languages");

   use type Infos.License_Kind;
   use all type Language_Mappers.Match_Result;

   overriding
   procedure Find_Comment (Analyzer : in Line_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is
   begin
      if Comment.Mode = BLOCK_COMMENT then
         return;
      end if;
      declare
         Len : constant Buffer_Size := Analyzer.Len;
         Pos : Buffer_Index := From;
      begin
         while Pos + Len <= Last loop
            if Buffer (Pos .. Pos + Len - 1) = Analyzer.Comment_Start then
               Comment := (Analyzer   => null,
                    Start      => Pos + Len,
                    Last       => Pos,
                    Head       => Pos,
                    Text_Start => Pos + Len,
                    Text_Last  => Skip_Backward_Spaces (Buffer, Pos, Last),
                    Trailer => 0,
                    Length  => 0,
                    Mode    => LINE_COMMENT,
                    Boxed   => False);
               return;
            end if;
            Pos := Pos + 1;
         end loop;
         Comment.Mode := NO_COMMENT;
      end;
   end Find_Comment;

   overriding
   procedure Find_Comment (Analyzer : in Block_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is
      Len : constant Buffer_Size := Analyzer.Len_Start;
      Pos : Buffer_Index := From;
   begin
      if Comment.Mode in START_COMMENT | BLOCK_COMMENT then
         declare
            Len : constant Buffer_Size := Analyzer.Len_End;
         begin
            Comment.Start := Pos;
            Comment.Head := Pos;
            if Pos <= Last - 1 then
               --  Ignore a ' * ' or ' + ' presentation in code blocks.
               Comment.Text_Start := Skip_Presentation (Buffer, Pos, Last - 1);
            else
               --  Empty line
               Comment.Text_Start := Pos;
            end if;
            Comment.Text_Last := Last - 1;
            while Pos + Len <= Last loop
               if Buffer (Pos .. Pos + Len - 1) = Analyzer.Comment_End then
                  Comment.Mode := END_COMMENT;
                  Comment.Trailer := Len;
                  Comment.Text_Last := Pos - 1;
                  return;
               end if;
               Pos := Pos + 1;
            end loop;
            Comment.Mode := BLOCK_COMMENT;
            return;
         end;
      end if;
      while Pos + Len <= Last loop
         if Buffer (Pos .. Pos + Len - 1) = Analyzer.Comment_Start then
            declare
               Len_End : constant Buffer_Size := Analyzer.Len_End;
            begin
               Comment.Mode := START_COMMENT;
               Comment.Start := Pos;
               Comment.Text_Start := Pos + Len;
               Comment.Head := Pos;
               Comment.Trailer := 0;
               Comment.Text_Last := Skip_Backward_Spaces (Buffer, Pos + Len, Last);
               Pos := Pos + Len;
               while Pos + Len_End <= Last loop
                  if Buffer (Pos .. Pos + Len_End - 1) = Analyzer.Comment_End then
                     Comment.Mode := LINE_BLOCK_COMMENT;
                     Comment.Trailer := Len_End;
                     Comment.Text_Last := Pos - Len_End + 1;
                     exit;
                  end if;
                  Pos := Pos + 1;
               end loop;
               Comment.Last := Last;
               return;
            end;
         end if;
         Pos := Pos + 1;
      end loop;
      Comment.Mode := NO_COMMENT;
   end Find_Comment;

   overriding
   procedure Find_Comment (Analyzer : in Combined_Analyzer_Type;
                           Buffer   : in Buffer_Type;
                           From     : in Buffer_Index;
                           Last     : in Buffer_Index;
                           Comment  : in out Comment_Info) is
   begin
      if comment.Analyzer /= null and then Comment.Mode in START_COMMENT | BLOCK_COMMENT then
         Comment.Analyzer.Find_Comment (Buffer, From, Last, Comment);
      else
         Comment.Analyzer := null;
         for Current of Analyzer.Analyzers loop
            if Current /= null then
               Current.Find_Comment (Buffer, From, Last, Comment);
               if Comment.Mode /= NO_COMMENT then
                  if Comment.Analyzer = null then
                     Comment.Analyzer := Current;
                  end if;
                  return;
               end if;
            end if;
         end loop;
      end if;
   end Find_Comment;

   function Get_Language_From_Extension (Path : in String) return String is
      Ext  : constant String := Ada.Directories.Extension (Path);
      Kind : access constant String := Extensions.Get_Mapping (Ext);
   begin
      if Kind /= null then
         return Kind.all;
      end if;
      if Kind = null and then Util.Strings.Ends_With (Ext, "~") then
         Kind := Extensions.Get_Mapping (Ext (Ext'First .. Ext'Last - 1));
      end if;
      if Kind /= null then
         return Kind.all;
      end if;
      return "";
   end Get_Language_From_Extension;

   function Guess_Language (Manager : in Language_Manager;
                            File    : in SPDX_Tool.Infos.File_Info;
                            Buffer  : in Buffer_Type) return String is
      Match : constant Language_Mappers.Filter_Result := Manager.File_Mapper.Match (File.Path);
   begin
      if Match.Match = Language_Mappers.Found then
         return Language_Mappers.Get_Value (Match);
      end if;
      declare
         Language : constant String := Get_Language_From_Extension (File.Path);
      begin
         if Language'Length > 0 then
            return Language;
         end if;
      end;
      declare
         Mime : constant String := To_String (File.Mime);
      begin
         if Util.Strings.Starts_With (Mime, "text/") then
            if Util.Strings.Starts_With (Mime, "text/x-shellscript") then
               return "Shell";
            elsif Util.Strings.Starts_With (Mime, "text/x-m4") then
               return "M4";
            elsif Util.Strings.Starts_With (Mime, "text/x-makefile") then
               return  "Makefile";
            elsif Util.Strings.Starts_With (Mime, "text/xml") then
               return  "XML";
            else
               return "Text file";
            end if;
         elsif Util.Strings.Starts_With (Mime, "image/") then
            return "Image";
         elsif Util.Strings.Starts_With (Mime, "video/") then
            return "Video";
         elsif Util.Strings.Starts_With (Mime, "application/pdf") then
            return  "PDF";
         elsif Util.Strings.Starts_With (Mime, "application/zip") then
            return  "ZIP";
         elsif Util.Strings.Starts_With (Mime, "application/x-tar") then
            return  "TAR";
         end if;
      end;

      return "";
   end Guess_Language;

   --  ------------------------------
   --  Identify the language used by the given file.
   --  ------------------------------
   procedure Find_Language (Manager  : in Language_Manager;
                            File     : in out SPDX_Tool.Infos.File_Info;
                            Buffer   : in Buffer_Type;
                            Analyzer : out Analyzer_Access) is
      Language : constant String := Manager.Guess_Language (File, Buffer);
   begin
      File.Language := To_UString (Language);
      if Language'Length = 0 then
         Analyzer := null;
         Log.Info ("{0}: no language found", File.Path);
         return;
      end if;
      declare
         Pos : constant Language_Maps.Cursor := Manager.Languages.Find (Language);
      begin
         if Language_Maps.Has_Element (Pos) then
            Analyzer := Language_Maps.Element (Pos).Analyzer;
            Log.Info ("{0}: language {1} with analyzer", File.Path, Language);
         else
            Analyzer := null;
            Log.Info ("{0}: language {1} without analyzer", File.Path, Language);
         end if;
      end;
   end Find_Language;

   procedure Find_Comments (Analyzer : in Analyzer_Type'Class;
                            Buffer   : in Buffer_Type;
                            Lines    : in out Line_Array;
                            Count    : out Infos.Line_Count) is
      Len      : constant Buffer_Size := Buffer'Length;
      Pos      : Buffer_Index := Buffer'First;
      First    : Buffer_Index;
      Line_No  : Infos.Line_Count := 0;
      Style    : Comment_Info := (Mode => NO_COMMENT, others => <>);
   begin
      while Pos <= Len loop
         First := Pos;
         Pos := Find_Eol (Buffer (Pos .. Len), Pos);
         Line_No := Line_No + 1;
         Lines (Line_No).Line_Start := First;
         Lines (Line_No).Line_End := Pos - 1;
         Analyzer.Find_Comment (Buffer, First, Pos, Style);
         if Style.Text_Last < Style.Text_Start then
            Style.Text_Last := Style.Text_Start - 1;
         end if;
         Style.Length := Printable_Length (Buffer, First, Pos);
         Lines (Line_No).Style := Style;
         if Style.Mode /= NO_COMMENT then
            Lines (Line_No).Comment := Style.Mode;
            Lines (Line_No).Style.Last := Pos - 1;
            Extract_Line_Tokens (Buffer, Lines (Line_No));
         else
            Lines (Line_No).Comment := NO_COMMENT;
         end if;
         exit when Line_No = Lines'Last or else Pos > Len;
         if Buffer (Pos) = CR
            and then Pos + 1 <= Len
            and then Buffer (Pos + 1) = LF
         then
            Pos := Pos + 2;
         else
            Pos := Pos + 1;
         end if;
      end loop;
      Count := Line_No;
   end Find_Comments;

   --  ------------------------------
   --  Compute maximum length of lines between From..To as byte count.
   --  ------------------------------
   function Max_Length (Lines : in Line_Array;
                        From  : in Infos.Line_Number;
                        To    : in Infos.Line_Number) return Buffer_Size is
      Max : Buffer_Size := 0;
   begin
      for I in From .. To loop
         declare
            Len : constant Buffer_Size
              := Lines (I).Line_End - Lines (I).Line_Start + 1;
         begin
            if Len > Max then
               Max := Len;
            end if;
         end;
      end loop;
      return Max;
   end Max_Length;

   --  ------------------------------
   --  Check if Lines (From..To) are of the same length.
   --  ------------------------------
   function Is_Same_Length (Lines : in Line_Array;
                            From  : in Infos.Line_Number;
                            To    : in Infos.Line_Number) return Boolean is
      Line_Length : constant Natural := Lines (From).Style.Length;
   begin
      return Line_Length > 0
        and then (for all I in From + 1 .. To =>
                    Lines (I).Style.Length = Line_Length);
   end Is_Same_Length;

   --  ------------------------------
   --  Check if we have the same byte for every line starting from the
   --  end of the line with the given offset.
   --  ------------------------------
   function Is_Same_Byte (Lines  : in Line_Array;
                          Buffer : in Buffer_Type;
                          From   : in Infos.Line_Number;
                          To     : in Infos.Line_Number;
                          Offset : in Buffer_Size) return Boolean is
      C : constant Byte := Buffer (Lines (From).Line_End - Offset);
   begin
      return (for all I in From + 1 .. To =>
                Buffer (Lines (I).Line_End - Offset) = C);
   end Is_Same_Byte;

   --  ------------------------------
   --  Find the common length at end of each line between From and To.
   --  ------------------------------
   function Common_End_Length (Lines  : in Line_Array;
                               Buffer : in Buffer_Type;
                               From   : in Infos.Line_Number;
                               To     : in Infos.Line_Number) return Buffer_Size is
      Line_Length : constant Buffer_Size :=
        Lines (From).Line_End - Lines (From).Line_Start;
      Len : Buffer_Size := 0;
   begin
      while Len < Line_Length loop
         if not Is_Same_Byte (Lines, Buffer, From, To, Len) then
            exit;
         end if;
         Len := Len + 1;
      end loop;
      return Len;
   end Common_End_Length;

   --  ------------------------------
   --  Find the common length of spaces at beginning of each line
   --  between From and To.  We don't need to have identical length
   --  for each line.
   --  ------------------------------
   function Common_Start_Length (Lines  : in Line_Array;
                                 Buffer : in Buffer_Type;
                                 From   : in Infos.Line_Number;
                                 To     : in Infos.Line_Number) return Buffer_Size is
      Line_Length : constant Buffer_Size := Max_Length (Lines, From, To);
      Len         : Buffer_Size := 0;
   begin
      while Len < Line_Length loop
         for I in From .. To loop
            declare
               Pos : constant Buffer_Index
                 := Lines (I).Style.Text_Start + Len;
            begin
               --  Ignore lines which are not a comment or too short.
               if Lines (I).Comment /= NO_COMMENT
                 and then Pos <= Lines (I).Line_End
                 and then not Is_Space (Buffer (Pos))
               then
                  return Len;
               end if;
            end;
         end loop;
         Len := Len + 1;
      end loop;
      return Len;
   end Common_Start_Length;

   --  ------------------------------
   --  Check if the comment line is only a presentation line: it is either
   --  empty or contains the same presentation character.
   --  ------------------------------
   function Is_Presentation_Line (Lines  : in Line_Array;
                                  Buffer : in Buffer_Type;
                                  Line   : in Infos.Line_Number) return Boolean is
      Info : Comment_Info renames Lines (Line).Style;
   begin
      return (for all I in Info.Text_Start .. Info.Text_Last
                => Is_Space_Or_Punctuation (Buffer (I)));
   end Is_Presentation_Line;

   --  ------------------------------
   --  Identify boundaries of a license with a boxed presentation.
   --  Having identified such boxed presentation, update the lines Text_Last
   --  position to indicate the last position of the text for each line
   --  to ignore the boxed presentation.
   --  ------------------------------
   procedure Boxed_License (Lines  : in out Line_Array;
                            Buffer : in Buffer_Type;
                            Boxed  : out Boolean) is
      Limit  : constant Infos.Line_Count := (Lines'Length / 2);
      Common : Buffer_Size;
      Common_Start : Buffer_Size;
   begin
      for I in Lines'First .. Limit loop
         if Lines (I).Comment /= NO_COMMENT then
            for J in reverse I + 3 .. Lines'Last loop
               if Lines (J).Comment /= NO_COMMENT
                 and then Is_Same_Length (Lines, I, J)
               then
                  Boxed := True;
                  Common := Common_End_Length (Lines, Buffer, I, J);
                  Common_Start := Common_Start_Length (Lines, Buffer, I, J);
                  for K in I .. J loop
                     Lines (K).Style.Boxed := True;
                     Lines (K).Style.Text_Last := Lines (K).Style.Last - Common;
                     Lines (K).Style.Text_Start := Lines (K).Style.Text_Start + Common_Start;
                  end loop;
                  return;
               end if;
            end loop;
         end if;
      end loop;
   end Boxed_License;

   --  ------------------------------
   --  Extract from the given line in the comment the list of tokens used.
   --  Such list can be used by the license decision tree to find a matching license.
   --  ------------------------------
   procedure Extract_Line_Tokens (Buffer : in Buffer_Type;
                                  Line   : in out Line_Type) is
      Last  : constant Buffer_Index := Line.Style.Text_Last;
      Pos   : Buffer_Index := Line.Style.Text_Start;
      First : Buffer_Index;
   begin
      while Pos <= Last loop
         First := Skip_Spaces (Buffer, Pos, Last);
         exit when First > Last;
         Pos := Next_Space (Buffer, First, Last);
         if First <= Pos then
            Line.Tokens.Include (Buffer (First .. Pos));
         end if;
         Pos := Pos + 1;
      end loop;
   end Extract_Line_Tokens;

   --  ------------------------------
   --  Extract from the header the license text that was found.
   --  When no license text was clearly identified, extract the text
   --  found in the header comment.
   --  ------------------------------
   function Extract_License (Lines   : in Line_Array;
                             Buffer  : in Buffer_Type;
                             License : in Infos.License_Info)
                             return Infos.License_Text_Access is
      First_Line      : Infos.Line_Count;
      Last_Line       : Infos.Line_Count;
      Size, Len, Skip : Buffer_Size;
   begin
      if License.Match /= Infos.NONE then
         First_Line := License.First_Line;
         Last_Line := License.Last_Line;
      else
         First_Line := Lines'First;
         Last_Line := Lines'Last;
         while First_Line > Last_Line
           and then Lines (First_Line).Comment = NO_COMMENT
         loop
            First_Line := First_Line + 1;
         end loop;
         Last_Line := First_Line + 1;
         while Last_Line <= Lines'Last
           and then Lines (Last_Line).Comment /= NO_COMMENT
         loop
            Last_Line := Last_Line + 1;
         end loop;
         Last_Line := Last_Line - 1;
         if Is_Presentation_Line (Lines, Buffer, First_Line) then
            First_Line := First_Line + 1;
         end if;
         if Is_Presentation_Line (Lines, Buffer, Last_Line) then
            Last_Line := Last_Line - 1;
         end if;
      end if;
      if First_Line > Last_Line then
         return null;
      end if;
      Skip := Common_Start_Length (Lines, Buffer, First_Line, Last_Line);
      Size := Buffer_Size (Last_Line - First_Line + 1);
      for I in First_Line .. Last_Line loop
         Len := Lines (I).Style.Text_Last
           - Lines (I).Style.Text_Start + 1;
         if Len > Skip then
            Len := Len - Skip;
         end if;
         Size := Size + Len;
      end loop;
      declare
         Text  : constant Infos.License_Text_Access := new Infos.License_Text (Len => Size);
         Pos   : Buffer_Index := 1;
         Start : Buffer_Index;
         Last  : Buffer_Index;
      begin
         for I in First_Line .. Last_Line loop
            Start := Lines (I).Style.Text_Start;
            Last := Lines (I).Style.Text_Last;
            Len := Last - Start + 1;
            if Len > Skip then
               Start := Start + Skip;
               Len := Len - Skip;
            end if;
            Text.Content (Pos .. Pos + Len - 1) := Buffer (Start .. Last);
            Pos := Pos + Len;
            Text.Content (Pos) := LF;
            Pos := Pos + 1;
         end loop;
         return Text;
      end;
   end Extract_License;

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
            Manager.File_Mapper.Insert (Pattern   => Pattern,
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
   begin
      Add_Builtin ("Ada", "--");
      Add_Builtin ("C-line", "//");
      Add_Builtin ("Shell", "#");
      Add_Builtin ("Latex", "%%");
      Add_Builtin ("C-block", "/*", "*/");
      Add_Builtin ("XML", "<!--", "-->");
      Add_Builtin ("OCaml", "(*", "*)");
      Add_Builtin ("Erlang", "%%");
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
   end Initialize;

end SPDX_Tool.Languages;
