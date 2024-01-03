-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Files;
with Util.Strings;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Serialize.IO.JSON;
with Util.Log.Loggers;

with SPDX_Tool.Licenses.Files;
with SPDX_Tool.Licenses.Decisions;
package body SPDX_Tool.Licenses is

   use type SPDX_Tool.Files.Comment_Style;
   use type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   package UBO renames Util.Beans.Objects;

   function Extract_SPDX (Lines   : in SPDX_Tool.Files.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Infos.Line_Number;
                          From    : in Buffer_Index) return Infos.License_Info;
   function Find_Header (List : UBO.Object) return UBO.Object;
   function Find_Value (Info : UBO.Object; Name : String) return Boolean;
   function Find_Value (Info : UBO.Object; Name : String) return UString;

   --  Protect concurrent loading of license templates.
   protected License_Tree is
      function Get_License (License : in License_Index) return Token_Access;

      procedure Load_License (License : in License_Index;
                              Token   : out Token_Access);
   end License_Tree;

   protected body License_Tree is
      function Get_License (License : in License_Index) return Token_Access is
      begin
         return Decisions.Licenses (License).Root;
      end Get_License;

      procedure Load_License (License : in License_Index;
                             Token    : out Token_Access) is
      begin
         if Decisions.Licenses (License).Root = null then
            Load_License (License, Decisions.Licenses (License));
         end if;
         Token := Decisions.Licenses (License).Root;
      end Load_License;

   end License_Tree;

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
      if Length (License.Template) = 0 then
         License.Template := Find_Value (Info, "spdx:standardLicenseTemplate");
      end if;
   end Load;

   function Get_Name (License : License_Type) return String is
   begin
      return To_String (License.Name);
   end Get_Name;

   function Get_Template (License : License_Type) return String is
   begin
      return To_String (License.Template);
   end Get_Template;

   procedure Save_License (License : in License_Type;
                           Path    : in String) is
      Content : constant String := To_String (License.Template);
      P : Natural := Content'First;
   begin
      while P < Content'Last and then Content (P) /= ASCII.LF loop
         P := P + 1;
      end loop;
      Log.Debug ("{0}", Content (Content'First .. P - 1));
      Util.Files.Write_File (Path, Content);
   end Save_License;

   Token_Count : Natural := 0;

   procedure Parse_License (Content : in Buffer_Type;
                            From    : in Buffer_Index;
                            Root    : in out Token_Access;
                            Current : in Token_Access;
                            License : in UString) is
      procedure Next_Token (Token : out Token_Kind);
      function Find_Token (Word : in Buffer_Type) return Token_Access;
      procedure Append_Token (Token : in Token_Access);
      function Create_Regpat (Content : in Buffer_Type) return Token_Access;
      procedure Parse_Var;
      procedure Parse_Optional;
      procedure Parse_Copyright;
      procedure Parse_Token;
      procedure Finish;

      BEGIN_OPTIONAL : constant String := "<<beginOptional>>";
      END_OPTIONAL   : constant String := "<<endOptional>>";

      Pos      : Buffer_Index := From;
      First    : Buffer_Index;
      Tok      : Token_Kind;
      Token    : Token_Access;
      Previous : Token_Access := Current;

      procedure Next_Token (Token : out Token_Kind) is
         Match : Buffer_Index;
         Check : Buffer_Index := Pos;
      begin
         while Check <= Content'Last loop
            if Content (Check) = Character'Pos ('<') then
               Match := Next_With (Content, Check, BEGIN_OPTIONAL);
               if Match > Check then
                  exit when Check /= Pos;
                  Pos := Match;
                  Token := TOK_OPTIONAL;
                  return;
               end if;
               Match := Next_With (Content, Check, END_OPTIONAL);
               if Match > Check then
                  exit when Check /= Pos;
                  Pos := Match;
                  Token := TOK_OPTIONAL;
                  return;
               end if;
               Match := Next_With (Content, Check, "<<var");
               if Match > Check then
                  exit when Check /= Pos;
                  Pos := Match;
                  Token := TOK_VAR;
                  return;
               end if;
            elsif Check = Pos then
               exit when Is_Space (Content (Check));
            else
               exit when Is_Space_Or_Punctuation (Content (Check));
            end if;
            Check := Check + 1;
         end loop;
         Pos := Check;
         Token := TOK_WORD;
      end Next_Token;

      function Find_Token (Word : in Buffer_Type) return Token_Access is
         Item : Token_Access;
      begin
         if Previous = null then
            Item := Root;
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
         Token_Count := Token_Count + 1;
         Token.Previous := Previous;
         if Previous = null then
            if Root = null then
               Root := Token;
            else
               Token.Alternate := Root.Alternate;
               Root.Alternate := Token;
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
      begin
         if Regpat = ".+" then
            return new Any_Token_Type '(Len => Content'Length,
                                        Previous => null,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Max_Length => 1000);
         end if;
         if Regpat = ".*" or else Regpat = ".{0,5000}" then
            return new Any_Token_Type '(Len => Content'Length,
                                        Previous => null,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Max_Length => 1000);
         end if;
         if Regpat = ".{0,20}" then
            return new Any_Token_Type '(Len => Content'Length,
                                        Previous => null,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Max_Length => 20);
         end if;
         Log.Info ("Pattern: '{0}'", Regpat);
         declare
            Pat : constant GNAT.Regpat.Pattern_Matcher := GNAT.Regpat.Compile (Regpat);
         begin
            return new Regpat_Token_Type '(Len => Content'Length,
                                           Plen => Pat.Size,
                                           Previous => null,
                                           Next => null,
                                           Alternate => null,
                                           Content => Content,
                                           Pattern => Pat);
         end;

      exception
         when others =>
            Log.Error ("Cannot compile regex: '{0}'", Regpat);
            return new Token_Type '(Len => Content'Length,
                                    Previous => null,
                                    Next => null,
                                    Alternate => null,
                                    Content => Content);
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
                  if Content (Pos) = Character'Pos ('\') then
                     Pos := Pos + 1;
                     exit when Pos > Content'Last;
                  else
                     exit when Content (Pos) = Character'Pos ('"');
                  end if;
                  Pos := Pos + 1;
               end loop;
               Token := Find_Token (Content (First .. Pos - 1));
               if Token /= null then
                  Log.Info ("Reuse pattern {0}",
                           To_String (To_UString (Content (First .. Pos - 1))));
               end if;
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

      --  Parse the optional in the form:
      --  <<beginOptional>
      --  ...
      --  <<endOptional>>
      procedure Parse_Optional is
         Match    : Buffer_Index;
         --  Current  : constant Token_Access := Previous;
         Optional : Optional_Token_Access;
      begin
         Optional := new Optional_Token_Type '(Len => 0,
                                               Previous => null,
                                               Next => null,
                                               Alternate => null,
                                               others => <>);
         Token := Optional.all'Access;
         while Pos <= Content'Last loop

            --  Ignore white spaces betwen tokens.
            while Is_Space (Content (Pos)) loop
               Pos := Pos + 1;
               if Pos > Content'Last then
                  Token := Optional.all'Access;
                  Append_Token (Token);
                  Previous := Token;
                  --  Build a subtree without the token that describe
                  --  the optional section.
                  --  if Has_Tokens then
                  --   Parse_License (Content, Pos, Root, Current, License);
                  --  end if;
                  return;
               end if;
            end loop;

            Match := Next_With (Content, Pos, END_OPTIONAL);
            if Match > Pos then
               Pos := Match;
               Token := Optional.all'Access;
               Append_Token (Token);
               Previous := Token;
               return;
            end if;

            First := Pos;
            Pos := Next_Space (Content, Pos, Content'Last);
            if Pos - First > END_OPTIONAL'Length then
               for I in First + 1 .. Pos loop
                  Match := Next_With (Content, I, END_OPTIONAL);
                  if Match > I then
                     Pos := I;
                     exit;
                  end if;
               end loop;
            end if;
            Token := new Token_Type '(Len => Pos - First,
                                      Previous => Token,
                                      Next => null,
                                      Alternate => null,
                                      Content => Content (First .. Pos - 1));
            if Optional.Optional = null then
               Optional.Optional := Token;
            else
               Token.Previous.Next := Token;
            end if;

            --  Append_Token (Token);
            --  Previous := Token;
            --  Has_Tokens := True;
         end loop;
         Token := Optional.all'Access;
         Append_Token (Token);
         Previous := Token;
         --  Build a subtree without the token that describe
         --  the optional section.
         --  if Has_Tokens then
         --   Parse_License (Content, Pos, Root, Current, License);
         --  end if;
      end Parse_Optional;

      procedure Parse_Copyright is
      begin
         null;
      end Parse_Copyright;

      procedure Parse_Token is
      begin
         --  if Next_With (Content, First, "PURPOSE.") > First then
         --     Log.Info ("Found PURPOSE");
         --  end if;
         Token := Find_Token (Content (First .. Pos - 1));
         if Token = null then
            Token := new Token_Type '(Len => Pos - First,
                                      Previous => null,
                                      Next => null,
                                      Alternate => null,
                                      Content => Content (First .. Pos - 1));
            Append_Token (Token);
         end if;
         Previous := Token;
      end Parse_Token;

      procedure Finish is
         Token : Token_Access;
      begin
         Token := new Final_Token_Type '(Len => 0,
                                         License => License,
                                         others => <>);
         Append_Token (Token);
      end Finish;

   begin
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
   end Parse_License;

   procedure Collect_License_Tokens (License : in out License_Template) is
      Token : Token_Access := License.Root;
   begin
      while Token /= null loop
         if Token.Kind = TOK_WORD then
            License.Tokens.Include (Token.Content);
         end if;
         Token := Token.Next;
      end loop;
   end Collect_License_Tokens;

   procedure Load_License (Name    : in String;
                           Content : in Buffer_Type;
                           License : in out License_Template) is
      Pos   : Buffer_Index := Content'First;
      Match : Buffer_Index;
      Count : constant Natural := Token_Count;
   begin
      Match := Next_With (Content, Pos, SPDX_License_Tag);
      if Match > Pos then
         Match := Skip_Spaces (Content, Match, Content'Last);
         Pos := Find_Eol (Content, Match);
         License.Name := To_UString (Content (Match .. Pos - 1));
      else
         License.Name := To_UString (Name);
      end if;
      Parse_License (Content, Pos, License.Root, null, License.Name);
      Log.Info ("License {0} => {1} tokens", To_String (License.Name),
                Natural'Image (Token_Count - Count));

   exception
      when E : others =>
         Log.Error ("Exception ", E);
   end Load_License;

   procedure Load_License (License : in License_Index;
                           Into    : in out License_Template) is
      Name    : constant Name_Access := Files.Names (License);
      Content : constant access constant Buffer_Type
        := Files.Get_Content (Name.all);
      Pos     : constant Natural := Util.Strings.Index (Name.all, '/');
   begin
      if Pos > 0 then
         Into.Name := To_UString (Name (Pos + 1 .. Name'Last));
      else
         Into.Name := To_UString (Name.all);
      end if;
      Parse_License (Content.all, Content'First, Into.Root, null, Into.Name);
   end Load_License;

   function Depth (Token : in Token_Type'Class) return Natural is
      Result : Natural := 0;
      Parent : Token_Access := Token.Previous;
   begin
      while Parent /= null loop
         Parent := Parent.Previous;
         Result := Result + 1;
      end loop;
      return Result;
   end Depth;

   procedure Matches (Token   : in Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
   begin
      if Token.Content = Content (From.Pos .. To.Pos) then
         Result := (Line => From.Line, Pos => To.Pos + 1);
         Next := Token.Next;
      else
         Result := From;
         Next := null;
      end if;
   end Matches;

   function Skip_Spaces (Content : in Buffer_Type;
                         Lines   : in Line_Array;
                         From    : in Line_Pos;
                         To      : in Line_Pos) return Line_Pos is
      Result : Line_Pos := From;
   begin
      while Result.Line <= To.Line loop
         declare
            Last : constant Buffer_Index := Lines (Result.Line).Line_End;
         begin
            if Result.Pos < Last then
               Result.Pos := Skip_Spaces (Content, Result.Pos, Last);
               exit when Result.Pos < Last;
            end if;
            Result.Line := Result.Line + 1;
            exit when Result.Line > Lines'Last;
            Result.Pos := Lines (Result.Line).Line_Start;
         end;
      end loop;
      return Result;
   end Skip_Spaces;

   overriding
   procedure Matches (Token   : in Any_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
      Last  : constant Buffer_Index := Content'Last;
      Check : constant Token_Access := Token.Next;
      Pos   : Line_Pos := (Line => From.Line, Pos => To.Pos);
   begin
      if Check = null then
         Result := From;
         Next := null;
         return;
      end if;
      while Pos.Pos < Last loop
         declare
            End_Pos : constant Line_Pos := Pos;
            First   : constant Line_Pos
              := Skip_Spaces (Content, Lines, (Pos.Line, Pos.Pos + 1), To);
            End_Line : Buffer_Index;
         begin
            exit when First.Line > Lines'Last;
            exit when End_Pos.Pos - From.Pos > Token.Max_Length;
            exit when Lines (First.Line).Comment = SPDX_Tool.Files.NO_COMMENT;
            End_Line := Lines (First.Line).Style.Last;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Match (Check, Content, Lines, First, (To.Line, Pos.Pos - 1), Result, Next);
            if Next /= null and then Result /= First then
               return;
            end if;
            if Pos.Pos >= End_Line then
               Pos.Line := First.Line + 1;
               exit when Pos.Line > Lines'Last;
               exit when Lines (Pos.Line).Comment = SPDX_Tool.Files.NO_COMMENT;
               Pos.Pos := Lines (Pos.Line).Style.Start - 1;
            else
               Pos.Line := First.Line;
            end if;
         end;
      end loop;
      Result := From;
      Next := null;
   end Matches;

   overriding
   procedure Matches (Token   : in Regpat_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
      Last  : constant Buffer_Index := Content'Last;
      --  Start : constant Positive := Positive (From);
      --  End_Pos : Positive;
      --  First : Buffer_Index := From;
      Pos   : Line_Pos := (Line => From.Line, Pos => To.Pos);
      Check : constant Token_Access := Token.Next;
   begin
      if Check = null then
         Result := From;
         Next := null;
         return;
      end if;
      Match (Check, Content, Lines, From, To, Result, Next);
      if Next /= null and then Result /= From
        and then GNAT.Regpat.Match (Token.Pattern, "")
      then
         return;
      end if;
      while Pos.Pos < Last loop
         declare
            --  End_Pos : constant Line_Pos := Pos;
            First   : constant Line_Pos
              := Skip_Spaces (Content, Lines, (Pos.Line, Pos.Pos + 1), To);
            End_Line : Buffer_Index;
         begin
            exit when First.Line > Lines'Last;
            exit when Lines (First.Line).Comment = SPDX_Tool.Files.NO_COMMENT;
            End_Line := Lines (First.Line).Style.Last;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Match (Check, Content, Lines, First, (To.Line, Pos.Pos - 1), Result, Next);
            if Next /= null and then Result /= First then
               return;
            end if;
            if Pos.Pos >= End_Line then
               Pos.Line := First.Line + 1;
               exit when Pos.Line > Lines'Last;
               Pos.Pos := Lines (Pos.Line).Style.Start;
            else
               Pos.Line := First.Line;
            end if;
         end;
      end loop;
      --  while Pos.Pos < Last loop
      --   End_Pos := Positive (Pos);
      --   First := Skip_Spaces (Content, Pos + 1, Last);
      --   exit when First > Last;
      --   Pos := Next_Space (Content, First, Last);
      --   Check.Matches (Content, First, Pos - 1, Result, Next);
      --   if Next /= null and then Result /= First then
      --      declare
      --         Item : String (1 .. Content'Length);
      --         for Item'Address use Content'Address;
      --      begin
      --         Log.Debug ("Check '{0}'", Item (Start .. End_Pos));
      --          if GNAT.Regpat.Match (Token.Pattern, Item (Start .. End_Pos)) then
      --            return;
      --         end if;
      --      end;
      --   end if;
      --  end loop;
      Result := From;
      Next := null;
   end Matches;

   overriding
   procedure Matches (Token   : in Optional_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
   begin
      if Token.Optional = null then
         Result := From;
         Next := null;
         return;
      end if;
      Token.Optional.Matches (Content, Lines, From, To, Result, Next);
      if Next = null then
         Token.Next.Matches (Content, Lines, From, To, Result, Next);
         return;
      end if;

      --  Other optional tokens must match.
      declare
         Last  : constant Buffer_Index := Content'Last;
         First : Line_Pos := From;
         Pos   : Line_Pos := (Line => From.Line, Pos => To.Pos);
         Check : Token_Access := Token.Optional.Next;
         End_Line : Buffer_Index;
      begin
         while Check /= null loop
            if Pos.Pos + 1 > Last
              or else Lines (Pos.Line).Comment /= SPDX_Tool.Files.NO_COMMENT
            then
               Result := From;
               Next := null;
               return;
            end if;
            First := Skip_Spaces (Content, Lines,
                                  (Line => Pos.Line, Pos => Pos.Pos + 1),
                                  (Line => To.Line, Pos => To.Pos));
            if First.Line > Lines'Last then
               Result := From;
               Next := null;
               return;
            end if;
            End_Line := Lines (First.Line).Style.Last;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Check.Matches (Content, Lines, First, (To.Line, Pos.Pos - 1), Result, Next);
            if Next = null and then Result = First then
               Result := From;
               return;
            end if;
            Check := Check.Next;
         end loop;
         Next := Token.Next;
         Result := (Line => Pos.Line, Pos => Pos.Pos + 1);
      end;
   end Matches;

   function Extract_SPDX (Lines   : in SPDX_Tool.Files.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Infos.Line_Number;
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

   procedure Match (Token   : in Token_Access;
                    Content : in Buffer_Type;
                    Lines   : in Line_Array;
                    From    : in Line_Pos;
                    Last    : in Line_Pos;
                    Result  : out Line_Pos;
                    Next    : out Token_Access) is
      Current : Token_Access := Token;
   begin
      while Current /= null loop
         Current.Matches (Content, Lines, From, Last, Result, Next);
         if Next /= null then
            return;
         end if;
         Current := Current.Alternate;
      end loop;
      Next := null;
      Result := From;
   end Match;

   function Find_License (Root    : in Token_Access;
                          Content : in Buffer_Type;
                          Lines   : in SPDX_Tool.Files.Line_Array;
                          From    : in Line_Number;
                          To      : in Line_Number)
                          return License_Match is
      Current : Token_Access := null;
      Result  : License_Match;
      Pos, First : Line_Pos;
      Next_Token : Token_Access;
      Last : Line_Pos;
   begin
      Result.Info.First_Line := From;
      Pos.Line := From;
      Pos.Pos := Content'First;
      Last.Line := To;
      while Pos.Line <= To loop
         First.Line := Pos.Line;
         if Lines (Pos.Line).Style.Style /= SPDX_Tool.Files.NO_COMMENT then
            if Pos.Pos < Lines (Pos.Line).Style.Start then
               Pos.Pos := Lines (Pos.Line).Style.Start;
            end if;
            Last.Pos := Lines (Pos.Line).Style.Last;
            while Pos.Pos <= Last.Pos and then First.Line = Pos.Line loop
               Pos.Pos := Skip_Spaces (Content, Pos.Pos, Last.Pos);
               exit when Pos.Pos > Last.Pos;
               First.Pos := Pos.Pos;
               Pos.Pos := Next_Space (Content, Pos.Pos, Last.Pos);
               if Current = null then
                  Match (Root, Content, Lines, First,
                         (To, Pos.Pos - 1), Pos, Next_Token);
               else
                  Match (Current, Content, Lines, First,
                         (To, Pos.Pos - 1), Pos, Next_Token);
               end if;
               if Next_Token = null then
                  if Current /= null then
                     Log.Debug ("Missmatch found");
                  end if;
                  Result.Last := Current;
                  return Result;
               end if;
               Current := Next_Token;
               if Current.Next /= null
                 and then Current.Next.Kind = TOK_LICENSE
               then
                  Current := Current.Next;
                  Result.Info.Name := Final_Token_Type (Current.all).License;
                  Result.Info.Last_Line := Pos.Line;
                  Result.Info.Match := Infos.TEMPLATE_LICENSE;
                  Result.Last := Current;
                  return Result;
               end if;
            end loop;
         end if;
         if First.Line = Pos.Line then
            exit when Pos.Line = To;
            Pos.Line := Pos.Line + 1;
         end if;
      end loop;
      Result.Info.Last_Line := Pos.Line;
      Result.Info.Match := Infos.UNKNOWN_LICENSE;
      Result.Last := null;
      return Result;
   end Find_License;

   --  ------------------------------
   --  Find in the header comment an SPDX license tag.
   --  ------------------------------
   function Find_SPDX_License (Content : in Buffer_Type;
                               Lines   : in SPDX_Tool.Files.Line_Array)
                               return License_Match is
      Result : License_Match;
      Pos    : Buffer_Index;
      Last   : Buffer_Index;
      First  : Buffer_Index;
   begin
      Result.Info.First_Line := Lines'First;
      Result.Info.Last_Line := Lines'Last;
      for Line in Lines'Range loop
         if Lines (Line).Style.Style /= SPDX_Tool.Files.NO_COMMENT then
            Pos := Lines (Line).Style.Start;
            Last := Lines (Line).Style.Last;
            if Pos <= Last then
               First := Skip_Spaces (Content, Pos, Last);
               if First <= Last then
                  Pos := Next_With (Content, First, SPDX_License_Tag);
                  if Pos > First then
                     Result.Info := Extract_SPDX (Lines, Content, Line, Pos);
                     Result.Last := null;
                     return Result;
                  end if;
               end if;
            end if;
         end if;
      end loop;
      Result.Info.Match := Infos.UNKNOWN_LICENSE;
      Result.Last := null;
      return Result;
   end Find_SPDX_License;

   --  ------------------------------
   --  Find a license from the license decision tree.
   --  ------------------------------
   function Find_Builtin_License (Tokens : in SPDX_Tool.Buffer_Sets.Set)
                          return Decision_Array_Access is
      Node   : Decision_Node_Access := SPDX_Tool.Licenses.Decisions.Root;
      Result : Decision_Array_Access (1 .. 20);
      Depth  : Natural := 0;
   begin
      while Node /= null loop
         Depth := Depth + 1;
         Result (Depth) := Node;
         exit when Node.Length = 0;
         if Tokens.Contains (Node.Token) then
            Node := Node.Left;
         else
            Node := Node.Right;
         end if;
      end loop;
      return Result (1 .. Depth);
   end Find_Builtin_License;

   function Find_License (License : in License_Index;
                          File    : in SPDX_Tool.Files.File_Type)
                          return License_Match is
      Token : Token_Access;
   begin
      Token := License_Tree.Get_License (License);
      if Token = null then
         License_Tree.Load_License (License, Token);
      end if;
      declare
         Buf     : constant Buffer_Accessor := File.Buffer.Value;
         Result  : License_Match := (Last => null, Depth => 0, others => <>);
         Match   : License_Match;
         Line    : Infos.Line_Number := 1;
      begin
         while Line <= File.Count loop
            if File.Lines (Line).Comment /= SPDX_Tool.Files.NO_COMMENT then
               Match := Find_License (Token, Buf.Data,
                                      File.Lines, Line, File.Count);
               if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
                  return Match;
               end if;
               if Match.Last /= null then
                  Match.Depth := Match.Last.Depth;
                  if Result.Last = null or else Match.Depth > Result.Depth then
                     Result.Last := Match.Last;
                     Result.Depth := Match.Depth;
                  end if;
               end if;
            end if;
            exit when Line = File.Count;
            Line := Line + 1;
         end loop;
         return Result;
      end;
   end Find_License;

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

      procedure Add_Line (Line : in Buffer_Type; Line_Number : Infos.Line_Number) is
         procedure Process (Item : in out Line_Maps.Map);

         procedure Process (Item : in out Line_Maps.Map) is
            Pos  : constant Line_Maps.Cursor := Item.Find (Line);
         begin
            if Line_Maps.Has_Element (Pos) then
               Item.Replace_Element (Pos, Line_Maps.Element (Pos) + 1);
            else
               Item.Insert (Line, 1);
            end if;
         end Process;

         S : Line_Maps.Map;
      begin
         while Infos.Line_Count (Lines.Length) < Line_Number loop
            Lines.Append (S);
         end loop;
         Lines.Update_Element (Line_Number, Process'Access);
      end Add_Line;

      procedure Add_Header (File : in SPDX_Tool.Files.File_Type) is
         Buf     : constant Buffer_Accessor := File.Buffer.Value;
         Start, Last : Buffer_Index;
      begin
         for Line in 1 .. File.Count loop
            if File.Lines (Line).Comment /= SPDX_Tool.Files.NO_COMMENT then
               Start := File.Lines (Line).Style.Text_Start;
               Last  := File.Lines (Line).Style.Text_Last;
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
                     Content : constant Buffer_Type := Line_Maps.Key (Iter);
                     Count   : constant Positive := Line_Maps.Element (Iter);
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
                  First : constant Line_Stat := L (I).First_Element;
                  Last  : constant Line_Stat := L (I).Last_Element;
                  S     : String (1 .. Natural (First.Len));
                  for S'Address use First.Content'Address;
               begin
                  Log.Info ("{0}|{1}|{2}", First.Count'Image, Last.Count'Image, S);
               end;
            end if;
         end loop;
      end Print_Header;

   end License_Stats;

end SPDX_Tool.Licenses;
