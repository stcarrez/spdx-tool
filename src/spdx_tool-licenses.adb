-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Text_IO;

with Util.Strings;
with Util.Log.Loggers;

with SCI.Numbers;
with SCI.Similarities.Indefinite_Ordered_Sets;

with SPDX_Tool.Licenses.Files;
with SPDX_Tool.Licenses.Decisions;
package body SPDX_Tool.Licenses is

   use all type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;
   subtype Confidence_Type is SPDX_Tool.Infos.Confidence_Type;
   use type SPDX_Tool.Infos.Confidence_Type;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   --  ??? Mul and Div seem necessary as "*" and "/" fail to instantiate
   function Mul (Left, Right : Confidence_Type) return Confidence_Type is (Left * Right);
   function Div (Left, Right : Confidence_Type) return Confidence_Type is (Left / Right);
   function From_Float (Value : Float) return Confidence_Type is (Confidence_Type (Value));
   function From_Integer (Value : Integer) return Confidence_Type is (Confidence_Type (Value));

   package Confidence_Number is
     new SCI.Numbers.Number (Confidence_Type, "*" => Mul, "/" => Div);
   package Confidence_Conversion is
     new SCI.Numbers.Conversion (Confidence_Number);
   package Token_Similarities is
      new SCI.Similarities.Indefinite_Ordered_Sets (SPDX_Tool.Buffer_Sets, Confidence_Conversion);

   function Extract_SPDX (Lines   : in SPDX_Tool.Languages.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Infos.Line_Number;
                          From    : in Buffer_Index) return Infos.License_Info;
   function Get_License_Name (License : in License_Index) return String;

   function Get_License_Name (License : in License_Index) return String is
      Name    : constant Name_Access := Files.Names (License);
      Pos     : constant Natural := Util.Strings.Index (Name.all, '/');
   begin
      if Pos > 0 then
         return Name (Pos + 1 .. Name'Last);
      else
         return Name.all;
      end if;
   end Get_License_Name;

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
         Stamp : Util.Measures.Stamp;
      begin
         Token := Decisions.Licenses (License).Root;
         if Token = null then
            Load_License (License, Decisions.Licenses (License), Token);
            if Token /= null then
               Collect_License_Tokens (Token, Decisions.Licenses (License).Tokens);
               Decisions.Licenses (License).Root := Token;
            end if;
         end if;
         Report (Stamp, "Load template license");
      end Load_License;

   end License_Tree;

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

      Last     : constant Buffer_Index := Content'Last;
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
               exit when Space_Length (Content, Check, Last) /= 0;
            else
               exit when Punctuation_Length (Content, Check, Last) /= 0;
               exit when Space_Length (Content, Check, Last) /= 0;
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
         Log.Debug ("Pattern: '{0}'", Regpat);
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
         Len      : Buffer_Size;
      begin
         Optional := new Optional_Token_Type '(Len => 0,
                                               Previous => null,
                                               Next => null,
                                               Alternate => null,
                                               others => <>);
         Token := Optional.all'Access;
         while Pos <= Content'Last loop

            --  Ignore white spaces between tokens.
            loop
               Len := Space_Length (Content, Pos, Last);
               exit when Len = 0;
               Pos := Pos + Len;
               if Pos > Last then
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
            Pos := Next_Space (Content, Pos, Last);
            if Pos - First > END_OPTIONAL'Length then
               for I in First + 1 .. Pos loop
                  Match := Next_With (Content, I, END_OPTIONAL);
                  if Match > I then
                     Pos := I;
                     exit;
                  end if;
               end loop;
            end if;
            Token := new Token_Type '(Len => Pos - First + 1,
                                      Previous => Token,
                                      Next => null,
                                      Alternate => null,
                                      Content => Content (First .. Pos));
            if Optional.Optional = null then
               Optional.Optional := Token;
            else
               Token.Previous.Next := Token;
            end if;
            Pos := Pos + 1;

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

      Len  : Buffer_Size;
   begin
      --  <<beginOptional>>
      --  <<endOptional>>
      --  <<var...>>
      while Pos <= Last loop

         --  Ignore white spaces between tokens.
         loop
            Len := Space_Length (Content, Pos, Last);
            exit when Len = 0;
            Pos := Pos + Len;
            if Pos > Last then
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

   procedure Collect_License_Tokens (License : in Token_Access;
                                     Tokens  : in out Buffer_Sets.Set) is
      Token : Token_Access := License;
   begin
      while Token /= null loop
         if Token.Kind = TOK_WORD then
            Tokens.Include (Token.Content);
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
      Log.Debug ("License {0} => {1} tokens", To_String (License.Name),
                Natural'Image (Token_Count - Count));

   exception
      when E : others =>
         Log.Error ("Exception ", E);
   end Load_License;

   procedure Load_License (License : in License_Index;
                           Into    : in out License_Template;
                           Tokens  : out Token_Access) is
      Name    : constant Name_Access := Files.Names (License);
      Content : constant access constant Buffer_Type
        := Files.Get_Content (Name.all);
   begin
      Into.Name := To_UString (Get_License_Name (License));
      Tokens := null;
      Parse_License (Content.all, Content'First, Tokens, null, Into.Name);
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
            Last : constant Buffer_Index := Lines (Result.Line).Style.Text_Last;
         begin
            if Result.Pos < Last then
               Result.Pos := Skip_Spaces (Content, Result.Pos, Last);
               exit when Result.Pos < Last;
            end if;
            exit when Result.Line = To.Line;
            Result.Line := Result.Line + 1;
            Result.Pos := Lines (Result.Line).Style.Text_Start;
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
            exit when Lines (First.Line).Comment = NO_COMMENT;
            End_Line := Lines (First.Line).Style.Text_Last;
            exit when First.Pos > End_Line;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Match (Check, Content, Lines, First, (To.Line, Pos.Pos), Result, Next);
            if Next /= null and then Result /= First then
               return;
            end if;
            Pos.Pos := Pos.Pos + 1;
            if Pos.Pos >= End_Line then
               exit when First.Line = To.Line;
               Pos.Line := First.Line + 1;
               exit when Lines (Pos.Line).Comment = NO_COMMENT;
               Pos.Pos := Lines (Pos.Line).Style.Text_Start - 1;
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
            exit when Lines (First.Line).Comment = NO_COMMENT;
            End_Line := Lines (First.Line).Style.Text_Last;
            exit when First.Pos > End_Line;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Match (Check, Content, Lines, First, (To.Line, Pos.Pos), Result, Next);
            if Next /= null and then Result /= First then
               return;
            end if;
            Pos.Pos := Pos.Pos + 1;
            if Pos.Pos >= End_Line then
               exit when First.Line = To.Line;
               Pos.Line := First.Line + 1;
               Pos.Pos := Lines (Pos.Line).Style.Text_Start;
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
              or else Lines (Pos.Line).Comment = NO_COMMENT
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
            End_Line := Lines (First.Line).Style.Text_Last;
            exit when First.Pos > End_Line;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Check.Matches (Content, Lines, First, (To.Line, Pos.Pos), Result, Next);
            if Next = null and then Result = First then
               Result := From;
               return;
            end if;
            Pos.Pos := Pos.Pos + 1;
            Check := Check.Next;
         end loop;
         Next := Token.Next;
         Result := (Line => Pos.Line, Pos => Pos.Pos + 1);
      end;
   end Matches;

   function Extract_SPDX (Lines   : in SPDX_Tool.Languages.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Infos.Line_Number;
                          From    : in Buffer_Index) return Infos.License_Info is
      Pos    : Buffer_Index := From;
      Last   : Buffer_Index := Lines (Line).Style.Text_Last;
      Result : Infos.License_Info;
   begin
      Pos := Skip_Spaces (Content, From, Last);
      if Lines (Line).Style.Boxed then
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
                          Lines   : in Line_Array;
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
         if Lines (Pos.Line).Style.Mode /= NO_COMMENT then
            if Pos.Pos < Lines (Pos.Line).Style.Text_Start then
               Pos.Pos := Lines (Pos.Line).Style.Text_Start;
            end if;
            Last.Pos := Lines (Pos.Line).Style.Text_Last;
            while Pos.Pos <= Last.Pos and then First.Line = Pos.Line loop
               Pos.Pos := Skip_Spaces (Content, Pos.Pos, Last.Pos);
               exit when Pos.Pos > Last.Pos;
               First.Pos := Pos.Pos;
               Pos.Pos := Next_Space (Content, Pos.Pos, Last.Pos);
               if Current = null then
                  Match (Root, Content, Lines, First,
                         (To, Pos.Pos), Pos, Next_Token);
               else
                  Match (Current, Content, Lines, First,
                         (To, Pos.Pos), Pos, Next_Token);
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
               --  Pos.Pos := Pos.Pos + 1;
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
                               Lines   : in Line_Array;
                               From    : in Line_Number;
                               To      : in Line_Number)
                               return License_Match is
      Result : License_Match;
      Pos    : Buffer_Index;
      Last   : Buffer_Index;
      First  : Buffer_Index;
   begin
      Result.Info.First_Line := From;
      Result.Info.Last_Line := To;
      for Line in From .. To loop
         Pos := Lines (Line).Style.Text_Start;
         Last := Lines (Line).Style.Text_Last;
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
                          File    : in SPDX_Tool.Files.File_Type;
                          From    : in Line_Number;
                          To      : in Line_Number)
                          return License_Match is
      Token : Token_Access;
      Stamp : Util.Measures.Stamp;
   begin
      Token := License_Tree.Get_License (License);
      if Token = null then
         License_Tree.Load_License (License, Token);
      end if;
      declare
         Buf     : constant Buffer_Accessor := File.Buffer.Value;
         Result  : License_Match := (Last => null, Depth => 0, others => <>);
         Match   : License_Match;
         Line    : Infos.Line_Number := From;
      begin
         while Line <= To loop
            if File.Lines (Line).Comment /= NO_COMMENT then
               Match := Find_License (Token, Buf.Data,
                                      File.Lines, Line, To);
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
            exit when Line = To;
            Line := Line + 1;
         end loop;
         Report (Stamp, "Find license (no match)");
         return Result;
      end;
   end Find_License;

   MIN_CONFIDENCE : constant := 700 * Confidence_Type'Small;

   function Guess_License (Nodes   : in Decision_Array_Access;
                           Tokens  : in SPDX_Tool.Buffer_Sets.Set) return License_Match is
      Map   : License_Index_Map (0 .. Licenses.Files.Names_Count) := (others => False);
      Guess : License_Index := 0;
      Confidence : Confidence_Type := 0.0;
      C : Confidence_Type;
      Result  : License_Match := (Last => null, Depth => 0, others => <>);
      Stamp   : Util.Measures.Stamp;
   begin
      for Node of reverse Nodes loop
         for License of Node.Licenses loop
            if not Map (License) then
               declare
                  Token : Token_Access;
               begin
                  Token := License_Tree.Get_License (License);
                  if Token = null then
                     License_Tree.Load_License (License, Token);
                  end if;
               end;
               C := Token_Similarities.Tversky (Decisions.Licenses (License).Tokens,
                                                Tokens,
                                                0.75, 0.25);
               if C >= Confidence then
                  Log.Debug ("Confidence with {0}: {1} *",
                         SPDX_Tool.Licenses.Files.Names (License).all,
                         C'Image);
                  Guess := License;
                  Confidence := C;
               else
                  Log.Debug ("Confidence with {0}: {1}",
                            SPDX_Tool.Licenses.Files.Names (License).all,
                            C'Image);
               end if;
               Map (License) := True;
            end if;
         end loop;
      end loop;
      if Confidence >= MIN_CONFIDENCE then
         Result.Info.Match := Infos.GUESSED_LICENSE;
         Result.Info.Confidence := Confidence;
         Result.Info.Name := To_UString (Get_License_Name (Guess));
         SPDX_Tool.Licenses.Report (Stamp, "Guess license");
      end if;
      return Result;
   end Guess_License;

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
            if File.Lines (Line).Comment /= NO_COMMENT then
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

   Perf : Util.Measures.Measure_Set;

   procedure Performance_Report is
   begin
      Util.Measures.Write (Perf, "spdx-tool", Ada.Text_IO.Standard_Output);
   end Performance_Report;

   procedure Report (Stamp : in out Util.Measures.Stamp;
                     Title : in String;
                     Count : in Positive := 1) is
   begin
      Util.Measures.Report (Perf, Stamp, Title, Count);
   end Report;

end SPDX_Tool.Licenses;
