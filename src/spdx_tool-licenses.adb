-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Unchecked_Deallocation;
with Ada.Streams.Stream_IO;

with Util.Strings;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Serialize.IO.JSON;
with Util.Log.Loggers;
with Util.Streams.Files;

with SPDX_Tool.Files;
with SPDX_Tool.Licenses.Files;
package body SPDX_Tool.Licenses is

   use type SPDX_Tool.Files.Comment_Style;
   use type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   package UBO renames Util.Beans.Objects;

   File_Mgr : SPDX_Tool.Files.File_Manager_Access := null with Thread_Local_Storage;

   function Find_Header (List : UBO.Object) return UBO.Object is
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (List);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
            Hdr  : constant UBO.Object
              := UBO.Get_Value (Item, "spdx:standardLicenseTemplate");
         begin
            if not UBO.Is_Null (Hdr) then
               return Item;
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
      return UBO.Null_Object;
   end Find_Header;

   function Find_Value (Info : UBO.Object; Name : String) return Boolean is
      N : UBO.Object := UBO.Get_Value (Info, Name);
   begin
      if UBO.Is_Null (N) then
         return False;
      end if;
      N := UBO.Get_Value (N, "@value");
      if UBO.Is_Null (N) then
         return False;
      end if;
      return UBO.To_Boolean (N);
   end Find_Value;

   function Find_Value (Info : UBO.Object; Name : String) return UString is
      N : constant UBO.Object := UBO.Get_Value (Info, Name);
   begin
      if UBO.Is_Null (N) then
         return To_UString ("");
      else
         return UBO.To_Unbounded_String (N);
      end if;
   end Find_Value;

   procedure Load (License : in out License_Type;
                   Path    : in String) is
      Root, Graph, Info : Util.Beans.Objects.Object;
   begin
      Root := Util.Serialize.IO.JSON.Read (Path);
      Graph := Util.Beans.Objects.Get_Value (Root, "@graph");
      Info := Find_Header (Graph);
      License.OSI_Approved := Find_Value (Info, "spdx:isOsiApproved");
      License.FSF_Libre := Find_Value (Info, "spdx:isFsfLibre");
      License.Name := Find_Value (Info, "spdx:licenseId");
      License.Template := Find_Value (Info,
                                      "spdx:standardLicenseHeaderTemplate");
   end Load;

   function Get_Name (License : License_Type) return String is
   begin
      return To_String (License.Name);
   end Get_Name;

   function Get_Template (License : License_Type) return String is
   begin
      return To_String (License.Template);
   end Get_Template;

   --  Configure the license manager.
   procedure Configure (Manager : in out License_Manager;
                        Job     : in Job_Type;
                        Tasks   : in Task_Count) is
   begin
      if Opt_Mimes then
         for I in Manager.File_Mgr'Range loop
            Manager.File_Mgr (I).Initialize ("/usr/share/misc/magic");
         end loop;
      end if;
      Manager.Job := Job;
      Manager.Manager := Manager'Unchecked_Access;
      Manager.Executor.Start;

      for Name of Files.Names loop
         Manager.Load_License (Name.all, Files.Get_Content (Name.all).all);
      end loop;
   end Configure;

   --  ------------------------------
   --  Load the license templates defined in the directory for the license
   --  identification and analysis.
   --  ------------------------------
   procedure Load_Licenses (Manager : in out License_Manager;
                            Path    : in String) is
      Filter : Util.Files.Walk.Filter_Type;
   begin
      Log.Info ("Loading licenses from {0}", Path);

      Filter.Include ("*.txt");
      Filter.Exclude ("*");
      Manager.Job := LOAD_LICENSES;
      Manager.Scan (Path, Filter);
      Manager.Job := READ_LICENSES;
   end Load_Licenses;

   --  ------------------------------
   --  Load the license template from the given path.
   --  ------------------------------
   procedure Load_License (Manager : in out License_Manager;
                           Path    : in String) is
      File   : Util.Streams.Files.File_Stream;
      Buffer : Buffer_Type (1 .. 4096);
      Last   : Ada.Streams.Stream_Element_Offset;
      Name   : constant String := Ada.Directories.Base_Name (Path);
   begin
      Log.Info ("Load license template {0}", Path);
      File.Open (Mode => Ada.Streams.Stream_IO.In_File, Name => Path);
      File.Read (Into => Buffer, Last => Last);
      Manager.Load_License (Name, Buffer (1 .. Last));
   end Load_License;

   procedure Load_License (Manager : in out License_Manager;
                           Name    : in String;
                           Content : in Buffer_Type) is

      Pos   : Buffer_Index := Content'First;
      First : Buffer_Index;
      Tok   : Token_Kind;
      Token, Previous : Token_Access;

      procedure Next_Token (Token : out Token_Kind) is
         Match : Buffer_Index;
      begin
         if Content (Pos) = Character'Pos ('<') then
            Match := Next_With (Content, Pos, "<<beginOptional>>");
            if Match > Pos then
               Pos := Match;
               Token := TOK_OPTIONAL;
               return;
            end if;
            Match := Next_With (Content, Pos, "<<endOptional>>");
            if Match > Pos then
               Pos := Match;
               Token := TOK_OPTIONAL;
               return;
            end if;
            Match := Next_With (Content, Pos, "<<var");
            if Match > Pos then
               Pos := Match;
               Token := TOK_VAR;
               return;
            end if;
         end if;
         Pos := Next_Space (Content, Pos, Content'Last);
         Token := TOK_WORD;
      end Next_Token;

      function Find_Token (Word : in Buffer_Type) return Token_Access is
         Item : Token_Access;
      begin
         if Previous = null then
            Item := Manager.Tokens;
         else
            Item := Previous.Next;
         end if;
         while Item /= null loop
            if Item.Content = Word then
               return Item;
            end if;
            Item := Item.Alternate;
         end loop;
         return null;
      end Find_Token;

      procedure Append_Token (Token : in Token_Access) is
      begin
         if Previous = null then
            if Manager.Tokens = null then
               Manager.Tokens := Token;
            else
               Token.Alternate := Manager.Tokens.Alternate;
               Manager.Tokens.Alternate := Token;
            end if;
         elsif Previous.Next = null then
            Previous.Next := Token;
         else
            declare
               Prev : Token_Access := Previous.Next;
            begin
               --  Insert the new token at end of the Alternate list if this
               --  is a variable token (otherwise, we insert to head of list).
               if Token.Kind in TOK_VAR | TOK_OPTIONAL then
                  while Prev.Alternate /= null loop
                     Prev := Prev.Alternate;
                  end loop;
               end if;
               Token.Alternate := Prev.Alternate;
               Prev.Alternate := Token;
            end;
         end if;
      end Append_Token;

      function Create_Regpat (Content : in Buffer_Type) return Token_Access is
         Regpat : String (1 .. Content'Length);
         for Regpat'Address use Content'Address;
         Pat : constant GNAT.Regpat.Pattern_Matcher := GNAT.Regpat.Compile (Regpat);
      begin
         return new Regpat_Token_Type '(Len => Content'Length,
                                        Plen => Pat.Size,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Pattern => Pat);
      end Create_Regpat;

      --  Parse and extract information from <<var tags>>.
      --  We only keep the regular expression defined by the match="" attribute.
      procedure Parse_Var is
         Match : Buffer_Index;
         Found : Boolean := False;
      begin
         Pos := Pos + 5;
         while Pos <= Content'Last loop
            Match := Next_With (Content, Pos, ";match=""");
            if Match > Pos and then not Found then
               Found := True;
               First := Match;
               Pos := Match;
               while Pos <= Content'Last loop
                  exit when Content (Pos) = Character'Pos ('"');
                  Pos := Pos + 1;
               end loop;
               Token := Find_Token (Content (First .. Pos - 1));
               if Token = null then
                  Token := Create_Regpat (Content => Content (First .. Pos - 1));
                  Append_Token (Token);
               end if;
               Previous := Token;
            else
               Match := Next_With (Content, Pos, ">>");
               if Match > Pos then
                  Pos := Match;
                  return;
               end if;
            end if;
            Pos := Pos + 1;
         end loop;
      end Parse_Var;

      procedure Parse_Optional is
      begin
         null;
      end Parse_Optional;

      procedure Parse_Copyright is
      begin
         null;
      end Parse_Copyright;

      procedure Parse_Token is
      begin
         if Next_With (Content, First, "PURPOSE.") > First then
            Log.Info ("Found PURPOSE");
         end if;
         Token := Find_Token (Content (First .. Pos - 1));
         if Token = null then
            Token := new Token_Type '(Len => Pos - First,
                                      Next => null,
                                      Alternate => null,
                                      Content => Content (First .. Pos - 1));
            Append_Token (Token);
         end if;
         Previous := Token;
      end Parse_Token;

      License_Tag : UString;

      procedure Finish is
         Token : Token_Access;
      begin
         Token := new Final_Token_Type '(Len => 0,
                                         License => License_Tag,
                                         others => <>);
         Append_Token (Token);
      end Finish;

      Match : Buffer_Index;
   begin
      Match := Next_With (Content, Pos, SPDX_License_Tag);
      if Match > Pos then
         Match := Skip_Spaces (Content, Match, Content'Last);
         Pos := Find_Eol (Content, Match);
         License_Tag := To_UString (Content (Match .. Pos - 1));
      else
         License_Tag := To_UString (Name);
      end if;

      --  <<beginOptional>>
      --  <<endOptional>>
      --  <<var...>>
      while Pos <= Content'Last loop

         --  Ignore white spaces betwen tokens.
         while Is_Space (Content (Pos)) loop
            Pos := Pos + 1;
            if Pos > Content'Last then
               Finish;
               return;
            end if;
         end loop;

         First := Pos;
         Next_Token (Tok);
         case Tok is
            when TOK_WORD =>
               Parse_Token;

            when TOK_OPTIONAL =>
               Parse_Optional;

            when TOK_VAR =>
               Parse_Var;

            when TOK_COPYRIGHT =>
               Parse_Copyright;

            when TOK_LICENSE =>
               exit;

         end case;
         exit when Pos = Content'Last;
      end loop;
      Finish;
   end Load_License;

   --  ------------------------------
   --  Get the path of a file that can be read to get a list of files to ignore
   --  in the given directory (ie, .gitignore).
   --  ------------------------------
   overriding
   function Get_Ignore_Path (Walker : License_Manager;
                             Path   : String) return String is
   begin
      return Util.Files.Compose (Path, ".gitignore");
   end Get_Ignore_Path;

   --  Called when a file is found during the directory tree walk.
   overriding
   procedure Scan_File (Manager : in out License_Manager;
                        Path   : String) is
      use SPDX_Tool.Infos;
      Job   : License_Job_Type;
      Count : Natural;
   begin
      Log.Info ("Scan file {0}", Path);

      case Manager.Job is
         when SCAN_LICENSES =>
            declare
               L : License_Type;
            begin
               Load (L, Path);
               if Length (L.Template) > 0 then
                  declare
                     T : constant String := To_String (L.Template);
                     N : constant String := To_String (L.Name);
                     P : Natural := T'First;
                  begin
                     while P < T'Last and then T (P) /= ASCII.LF loop
                        P := P + 1;
                     end loop;
                     Log.Info ("{0}", T (T'First .. P - 1));
                     if N'Length > 0 then
                        Util.Files.Write_File (N & ".txt", T);
                     end if;
                  end;
               elsif Length (L.Name) > 0 then
                  Log.Error ("{0}: {1} => {2}", Path, To_String (L.Name),
                             To_String (L.Template));
               else
                  Log.Error ("{0}", Path);
               end if;
            end;

         when LOAD_LICENSES =>
            Manager.Load_License (Path);

         when others =>
            Job.File := new File_Info '(Len => Path'Length,
                                        Path => Path,
                                        others => <>);
            Job.Manager := Manager.Manager;
            Manager.Files.Insert (Path, Job.File);
            Manager.Executor.Execute (Job);
            Count := Manager.Executor.Get_Count;
            if Count > Manager.Max_Fill then
               Manager.Max_Fill := Count;
            end if;
      end case;
   end Scan_File;

   function Get_Stats (Manager : in License_Manager) return Count_Maps.Map is
   begin
      return Manager.Stats.Get_Stats;
   end Get_Stats;

   procedure Wait (Manager : in out License_Manager) is
   begin
      Manager.Executor.Stop;
      Manager.Executor.Wait;
   end Wait;

   function Find_Token (Token : in Token_Access;
                        Word  : in Buffer_Type) return Token_Access is
      Current : Token_Access := Token;
      Tok : constant String := To_String (To_UString (Word));
   begin
      while Current /= null loop
         if Current.Matches (Word) then
            Log.Debug ("Found match {0} - {1}",
                    To_String (To_UString (Current.Content)), Tok);
            return Current;
         end if;
         Log.Debug ("No match {0} - {1}",
                    To_String (To_UString (Current.Content)), Tok);
         Current := Current.Alternate;
      end loop;
      return null;
   end Find_Token;

   function Matches (Token : in Token_Type;
                     Word  : in Buffer_Type) return Boolean is
   begin
      if Token.Content = Word then
         return True;
      end if;
      return False;
   end Matches;

   overriding
   function Matches (Token : in Regpat_Token_Type;
                     Word  : in Buffer_Type) return Boolean is
      Item : String (1 .. Word'Length);
      for Item'Address use Word'Address;
   begin
      return GNAT.Regpat.Match (Token.Pattern, Item);
   end Matches;

   function Extract_SPDX (Lines   : in SPDX_Tool.Files.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Positive;
                          From    : in Buffer_Index) return Infos.License_Info is
      Is_Boxed : Boolean;
      Spaces, Length : Natural;
      Pos  : Buffer_Index := From;
      Last : Buffer_Index := Lines (Line).Style.Last;
      Result  : Infos.License_Info;
   begin
      if Lines (Line).Comment = SPDX_Tool.Files.LINE_BLOCK_COMMENT then
         Last := Last - Lines (Line).Style.Trailer;
      end if;
      if Lines'First = Lines'Last then
         Is_Boxed := False;
      else
         SPDX_Tool.Files.Boxed_License (Lines, Content, Lines'First, Lines'Last,
                                        Spaces, Is_Boxed, Length);
      end if;
      Pos := Skip_Spaces (Content, From, Last);
      if Is_Boxed then
         while Last > Pos and then not Is_Space (Content (Last)) loop
            Last := Last - 1;
         end loop;
      end if;
      while Last > Pos and then Is_Space (Content (Last)) loop
         Last := Last - 1;
      end loop;

      --  Drop a possible parenthesis arround the SPDX license ex: '(...)'
      if Content (Pos) = OPEN_PAREN and then Content (Last) = CLOSE_PAREN then
         Pos := Pos + 1;
         Last := Last - 1;
      end if;
      Result.First_Line := Line;
      Result.Last_Line := Line;
      Result.Name := To_UString (Content (Pos .. Last));
      Result.Match := Infos.SPDX_LICENSE;
      return Result;
   end Extract_SPDX;

   function Find_License (Manager : in License_Manager;
                          Content : in Buffer_Type;
                          Lines   : in SPDX_Tool.Files.Line_Array)
                          return Infos.License_Info is

      Line    : Positive := Lines'First;
      Current : Token_Access := null;
      Result  : Infos.License_Info;
      Pos, Last, First : Buffer_Index;
      Next_Token : Token_Access;
   begin
      Result.First_Line := Line;
      while Line <= Lines'Last loop
         if Lines (Line).Style.Style /= SPDX_Tool.Files.NO_COMMENT then
            Pos := Lines (Line).Style.Start;
            Last := Lines (Line).Style.Last;
            if Current = null and then Pos <= Last then
               Pos := Skip_Spaces (Content, Pos, Last);
               if Pos <= Last then
                  First := Next_With (Content, Pos, SPDX_License_Tag);
                  if First > Pos then
                     return Extract_SPDX (Lines, Content, Line, First);
                  end if;
               end if;
            end if;
            while Pos <= Last loop
               Pos := Skip_Spaces (Content, Pos, Last);
               exit when Pos > Last;
               First := Pos;
               Pos := Next_Space (Content, Pos, Last);
               if Current = null then
                  Next_Token := Find_Token (Manager.Tokens,
                                            Content (First .. Pos - 1));
               else
                  Next_Token := Find_Token (Current.Next,
                                            Content (First .. Pos - 1));
                  if Next_Token = null
                     and then Current.Kind = TOK_VAR
                     and then Current.Matches (Content (First .. Pos - 1))
                  then
                     Next_Token := Current;
                  end if;
               end if;
               if Next_Token = null then
                  if Current /= null then
                     Log.Debug ("Missmatch found");
                  end if;
                  return Result;
               end if;
               Current := Next_Token;
               if Current.Next /= null
                 and then Current.Next.Kind = TOK_LICENSE
               then
                  Current := Current.Next;
                  Result.Name := Final_Token_Type (Current.all).License;
                  Result.Last_Line := Line;
                  Result.Match := Infos.TEMPLATE_LICENSE;
                  return Result;
               end if;
            end loop;
         end if;
         Line := Line + 1;
      end loop;
      Result.Last_Line := Line;
      Result.Match := Infos.UNKNOWN_LICENSE;
      return Result;
   end Find_License;

   function Find_License (Manager : in License_Manager;
                          File    : in SPDX_Tool.Files.File_Type)
                          return Infos.License_Info is
      Buf     : constant Buffer_Accessor := File.Buffer.Value;
      Result  : Infos.License_Info := (others => <>);
      Line    : Positive := 1;
   begin
      if File.Cmt_Style = SPDX_Tool.Files.NO_COMMENT then
         Result.Match := Infos.NONE;
         return Result;
      end if;
      while Line <= File.Count loop
         if File.Lines (Line).Comment /= SPDX_Tool.Files.NO_COMMENT then
            Result := Find_License (Manager, Buf.Data,
                                    File.Lines (Line .. File.Count));
            exit when Result.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE;
         end if;
         Line := Line + 1;
      end loop;
      return Result;
   end Find_License;

   --  Analyze the file to find license information in the header comment.
   procedure Analyze (Manager  : in out License_Manager;
                      Path     : in String) is
   begin
      Manager.Scan_File (Path);
   end Analyze;

   procedure Analyze (Manager  : in out License_Manager;
                      File_Mgr : in out SPDX_Tool.Files.File_Manager;
                      File     : in out SPDX_Tool.Infos.File_Info) is
      Data   : SPDX_Tool.Files.File_Type (100);
   begin
      File_Mgr.Open (Data, File.Path);
      File.License := Manager.Find_License (Data);
      File.Mime := Data.Ident.Mime;
      if File.License.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then

         Log.Info ("{0}: {1}", File.Path, To_String (File.License.Name));
         Manager.Stats.Increment (To_String (File.License.Name));
         if Manager.Job = UPDATE_LICENSES then
            File_Mgr.Save
              (File    => Data,
               Path    => File.Path,
               First   => File.License.First_Line,
               Last    => File.License.Last_Line,
               License => To_String (File.License.Name));
         end if;
      else
         declare
            use SPDX_Tool.Files;

            Cmt_Count : Natural := 0;
         begin
            for I in Data.Lines'Range loop
               if Data.Lines (I).Comment /= NO_COMMENT then
                  Cmt_Count := Cmt_Count + 1;
               end if;
            end loop;
            if Cmt_Count = 0 then
               Log.Info ("{0} is {1}: {2} lines no comment", File.Path,
                         To_String (Data.Ident.Mime),
                         Util.Strings.Image (Data.Count));
               Manager.Stats.Increment (To_String (Data.Ident.Mime));
            else
               Log.Info ("{0} is {1}: {2} lines {3} cmt", File.Path,
                         To_String (Data.Ident.Mime),
                         Util.Strings.Image (Data.Count),
                         Util.Strings.Image (Cmt_Count));
               Manager.Stats.Increment ("unknown " & To_String (Data.Ident.Mime));
               Manager.Stats.Add_Header (Data);
            end if;
         end;
      end if;
   end Analyze;

   procedure Report (Manager : in out License_Manager) is
   begin
      Process (Manager.Files);
   end Report;

   overriding
   procedure Finalize (Manager : in out License_Manager) is
      use type Executors.Executor_Manager_Access;
      procedure Free is
        new Ada.Unchecked_Deallocation (Object => Executor_Manager'Class,
                                        Name   => Executor_Manager_Access);
   begin
      Log.Info ("License manager stopping, max fill {0}",
                Util.Strings.Image (Manager.Max_Fill));
   end Finalize;

   function Get_File_Manager (Manager : in out License_Manager)
                              return SPDX_Tool.Files.File_Manager_Access is
      Value : Integer;
   begin
      Util.Concurrent.Counters.Increment (Manager.Mgr_Idx, Value);
      return Manager.File_Mgr (Value + 1)'Unchecked_Access;
   end Get_File_Manager;

   procedure Execute (Job : in out License_Job_Type) is
      use type SPDX_Tool.Files.File_Manager_Access;
   begin
      if File_Mgr = null then
         File_Mgr := Job.Manager.Get_File_Manager;
      end if;
      Job.Manager.Analyze (File_Mgr.all, Job.File.all);
   end Execute;

   procedure Error (Job : in out License_Job_Type;
                    Ex  : in Ada.Exceptions.Exception_Occurrence) is
   begin
      Log.Error ("Job {0} failed", Job.File.Path);
      Log.Error ("Exception", Ex);
   end Error;

   function Hash (Buf : in Buffer_Type) return Ada.Containers.Hash_Type is
      H : Ada.Containers.Hash_Type := Buf'Length;
   begin
      return H;
   end Hash;

   procedure Print_Header (Manager : in out License_Manager) is
   begin
      Manager.Stats.Print_Header;
   end Print_Header;

   protected body  License_Stats is

      procedure Increment (Name : in String) is
         Pos : constant Count_Maps.Cursor := Map.Find (Name);
      begin
         if Count_Maps.Has_Element (Pos) then
            declare
               Count : constant Positive := Count_Maps.Element (Pos) + 1;
            begin
               Map.Replace_Element (Position => Pos, New_Item => Count);
            end;
         else
            Map.Insert (Name, 1);
         end if;
      end Increment;

      procedure Add_Line (Line : in Buffer_Type; Line_Number : Positive) is

         procedure Process (Item : in out Line_Maps.Map) is
            New_Line : Line_Stat (Len => Line'Length) := (Len => Line'Length, Count => 1, Content => Line);
            Pos  : Line_Maps.Cursor := Item.Find (Line);
         begin
            if Line_Maps.Has_Element (Pos) then
               Item.Replace_Element (Pos, Line_Maps.Element (Pos) + 1);
            else
               Item.Insert (Line, 1);
            end if;
         end Process;

         S : Line_Maps.Map;
      begin
         while Natural (Lines.Length) < Line_Number loop
            Lines.Append (S);
         end loop;
         Lines.Update_Element (Line_Number, Process'Access);
      end Add_Line;

      procedure Add_Header (File : in SPDX_Tool.Files.File_Type) is
         Buf     : constant Buffer_Accessor := File.Buffer.Value;
         Start, Last : Buffer_Index;
         Pos : Line_Sets.Cursor;
      begin
         for Line in 1 .. File.Count loop
            if File.Lines (Line).Comment /= SPDX_Tool.Files.NO_COMMENT then
               Start := File.Lines (Line).Style.Start;
               Last  := File.Lines (Line).Style.Last;
               Add_Line (Buf.Data (Start .. Last), Line);
               if Max_Line < Line then
                  Max_Line := Line;
               end if;
            end if;
         end loop;
         Unknown_Count := Unknown_Count + 1;
      end Add_Header;

      function Get_Stats return Count_Maps.Map is
      begin
         return Map;
      end Get_Stats;

      procedure Print_Header is
         type Line_Array is array (1 .. Max_Line) of Line_Sets.Set;

         L : Line_Array := (others => <>);
      begin
         for I in L'Range loop
            declare
               Stat : Line_Sets.Set;
            begin
               for Iter in Lines.Element (I).Iterate loop
                  declare
                     Content : Buffer_Type := Line_Maps.Key (Iter);
                     Count : Positive := Line_Maps.Element (Iter);
                  begin
                     Stat.Include ((Len => Content'Length,
                                    Count => Count,
                                    Content => Content));
                  end;
               end loop;
               L (I) := Stat;
            end;
         end loop;
         for I in L'Range loop
            if not L (I).Is_Empty then
               declare
                  First : Line_Stat := L (I).First_Element;
                  Last  : Line_Stat := L (I).Last_Element;
                  S : String (1 .. Natural (First.Len));
                  for S'Address use First.Content'Address;
               begin
                  Log.Info ("{0}|{1}|{2}", First.Count'Image, Last.Count'Image, S);
               end;
            end if;
         end loop;
      end Print_Header;

   end License_Stats;

end SPDX_Tool.Licenses;
