-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Files;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Serialize.IO.JSON;
with Util.Log.Loggers;
with Util.Strings;

with SPDX_Tool.Licenses.Files;
package body SPDX_Tool.Licenses.Reader is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses.Reader");

   package UBO renames Util.Beans.Objects;

   function Find_Header (List : UBO.Object) return UBO.Object;
   function Find_Value (Info : UBO.Object; Name : String) return Boolean;
   function Find_Value (Info : UBO.Object; Name : String) return UString;
   function Get_License_Id (Value : in UBO.Object) return UString;

   function Find_Header (List : UBO.Object) return UBO.Object is
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (List);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
            Hdr  : UBO.Object
              := UBO.Get_Value (Item, "spdx:standardLicenseTemplate");
         begin
            if not UBO.Is_Null (Hdr) then
               return Item;
            end if;
            Hdr := UBO.Get_Value (Item, "spdx:standardLicenseHeaderTemplate");
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

   function Get_License_Id (Value : in UBO.Object) return UString is
      Prefix : constant String := "http://spdx.org/licenses/";
      Id     : constant String := UBO.To_String (Value);
   begin
      if Util.Strings.Starts_With (Id, Prefix) then
         return To_UString (Id (Id'First + Prefix'Length .. Id'Last));
      else
         return To_UString (Id);
      end if;
   end Get_License_Id;

   procedure Load_JSON (License : in out License_Type;
                        Path    : in String) is
      Root, Graph, Info, License_Id : Util.Beans.Objects.Object;
   begin
      Root := Util.Serialize.IO.JSON.Read (Path);
      Graph := Util.Beans.Objects.Get_Value (Root, "@graph");
      if UBO.Is_Null (Graph) then
         Info := Root;
      else
         Info := Find_Header (Graph);
      end if;
      License_Id := UBO.Get_Value (Info, "@id");
      License.Is_Exception := UBO.Is_Null (License_Id);
      if UBO.Is_Null (License_Id) then
         License.Name := Find_Value (Info, "spdx:licenseExceptionId");
         License.Template := Find_Value (Info, "spdx:licenseExceptionTemplate");
         License.License := Find_Value (Info, "spdx:licenseExceptionText");
      else
         License.Name := Get_License_Id (License_Id);
         License.Template := Find_Value (Info,
                                         "spdx:standardLicenseHeaderTemplate");
         License.License := Find_Value (Info, "spdx:licenseText");
         if Length (License.Template) = 0 then
            declare
               Template : constant UString := Find_Value (Info, "spdx:standardLicenseTemplate");
            begin
               if Length (Template) > 0 and then Length (Template) < 4096 then
                  License.Template := Template;
               end if;
            end;
         end if;
      end if;
      License.OSI_Approved := Find_Value (Info, "spdx:isOsiApproved");
      License.FSF_Libre := Find_Value (Info, "spdx:isFsfLibre");
   end Load_JSON;

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

   --  ------------------------------
   --  Parse the license text template that was extracted from the JSONLD file.
   --  The Parser instance is updated to indicate position of tokens found
   --  and the `Token` method is called for each token found as parsing progresses.
   --  ------------------------------
   procedure Parse (Parser  : in out Abstract_Parser_Type'Class;
                    Content : in Buffer_Type) is
      procedure Parse_Var;

      TAG_BEGIN_OPTIONAL : constant String := "<<beginOptional>>";
      TAG_END_OPTIONAL   : constant String := "<<endOptional>>";
      TAG_VAR            : constant String := "<<var";

      Last     : constant Buffer_Index := Content'Last;
      Pos      : Buffer_Index := Content'First;

      --  ------------------------------
      --  Parse and extract information from <<var tags>>.
      --  We only keep the regular expression defined by the match="" attribute.
      --  ------------------------------
      procedure Parse_Var is
         Match : Buffer_Index;
      begin
         Match := Next_With (Content, Pos, ";name=""");
         if Match > Pos then
            Parser.Name_Pos := Match;
            Parser.Name_End := Find_String_End (Content, Match, Last);
            Pos := Parser.Name_End + 1;
            if Pos > Last then
               return;
            end if;
         end if;
         Match := Next_With (Content, Pos, ";original=""");
         if Match > Pos then
            Parser.Orig_Pos := Match;
            Parser.Orig_End := Find_String_End (Content, Match, Last);
            Pos := Parser.Orig_End + 1;
            if Pos > Last then
               return;
            end if;
         end if;
         Match := Next_With (Content, Pos, ";match=""");
         if Match > Pos then
            Parser.Match_Pos := Match;
            Pos := Find_String_End (Content, Match, Last);
            if Content (Pos) = Character'Pos ('"') then
               Parser.Match_End := Pos - 1;
               Pos := Pos + 1;
            else
               Parser.Match_End := Pos;
            end if;
            if Pos > Last then
               return;
            end if;
         end if;
         while Pos < Last loop
            Match := Next_With (Content, Pos, ">>");
            if Match > Pos then
               Pos := Match;
               return;
            end if;
            Pos := Pos + 1;
         end loop;
      end Parse_Var;

      First    : Buffer_Index;
      Match    : Buffer_Index;
      Token    : Token_Kind;
      Len      : Buffer_Size;
   begin
      --  <<beginOptional>>
      --  <<endOptional>>
      --  <<var;name="...";original="...";match=".+">>
      while Pos <= Last loop
         --  Ignore white spaces between tokens.
         loop
            Len := Space_Length (Content, Pos, Last);
            exit when Len = 0;
            Pos := Pos + Len;
            if Pos > Last then
               Parser.Token (Content, TOK_END);
               return;
            end if;
         end loop;

         Token := TOK_WORD;
         Parser.Token_Pos := Pos;
         First := Pos;
         while Pos <= Last loop
            if Content (Pos) = Character'Pos ('<') then
               Match := Next_With (Content, Pos, TAG_BEGIN_OPTIONAL);
               if Match > Pos then
                  exit when Pos /= First;
                  Pos := Match;
                  Token := TOK_OPTIONAL;
                  exit;
               end if;
               Match := Next_With (Content, Pos, TAG_END_OPTIONAL);
               if Match > Pos then
                  exit when Pos /= First;
                  Pos := Match;
                  Token := TOK_END_OPTIONAL;
                  exit;
               end if;
               Match := Next_With (Content, Pos, TAG_VAR);
               if Match > Pos then
                  exit when Pos /= First;
                  Pos := Match;
                  Token := TOK_VAR;
                  Parse_Var;
                  exit;
               end if;
               Pos := Pos + 1;
               exit;
            elsif Pos = First then
               exit when Space_Length (Content, Pos, Last) /= 0;
               Len := Punctuation_Length (Content, Pos, Last);
               if Len > 0 then
                  if Is_Quote (Content (Pos)) then
                     Token := TOK_QUOTE;
                     --  If we have a `` we only emit a single TOK_QUOTE because
                     --  the Quote_Token_Type matcher will handle special mapping
                     --  to match ``AS IS'' as well as "AS IS".
                     if Pos + 1 <= Last and then Is_Quote (Content (Pos + 1)) then
                        Len := Len + 1;
                     end if;
                  end if;
                  Pos := Pos + Len;
                  exit;
               end if;
            else
               exit when Punctuation_Length (Content, Pos, Last) /= 0;
               exit when Space_Length (Content, Pos, Last) /= 0;
            end if;
            Pos := Pos + 1;
         end loop;
         if Pos > Last then
            Parser.Current_Pos := Last;
         else
            Parser.Current_Pos := Pos;
         end if;
         Parser.Token (Content, Token);
      end loop;
      Parser.Token (Content, TOK_END);
   end Parse;

   function Find_Token (Parser : in Parser_Type;
                        Word   : in Buffer_Type) return Token_Access is
      Item : Token_Access;
   begin
      if Parser.Previous = null then
         Item := Parser.Root;
      else
         Item := Parser.Previous.Next;
      end if;
      while Item /= null loop
         if Item.Content = Word then
            return Item;
         end if;
         Item := Item.Alternate;
      end loop;
      return null;
   end Find_Token;

   procedure Load_License (Name    : in String;
                           Content : in Buffer_Type;
                           License : in out License_Template) is
      Pos   : Buffer_Index := Content'First;
      Match : Buffer_Index;
      Parser : Parser_Type;
   begin
      Match := Next_With (Content, Pos, SPDX_License_Tag);
      if Match > Pos then
         Match := Skip_Spaces (Content, Match, Content'Last);
         Pos := Find_Eol (Content, Match);
         License.Name := To_UString (Content (Match .. Pos - 1));
      else
         License.Name := To_UString (Name);
      end if;
      Parser.Root := License.Root;
      Parser.License := License.Name;
      Parser.Parse (Content (Pos .. Content'Last));
      License.Root := Parser.Root;
      Log.Debug ("License {0} => {1} tokens", To_String (License.Name),
                Natural'Image (Parser.Token_Count));

   exception
      when E : others =>
         Log.Error ("exception", E);
   end Load_License;

   procedure Load_License (License : in License_Index;
                           Name    : in UString;
                           Into    : in out License_Template;
                           Tokens  : out Token_Access) is
      Path    : constant Name_Access := Files.Names (License);
      Content : constant access constant Buffer_Type
        := Files.Get_Content (Path.all);
      Pos    : Buffer_Index := Content'First;
      Match  : Buffer_Index;
      Parser : Parser_Type;
   begin
      Log.Debug ("Loading license template {0}", Path.all);
      Match := Next_With (Content.all, Pos, SPDX_License_Tag);
      if Match > Pos then
         Match := Skip_Spaces (Content.all, Match, Content'Last);
         Pos := Find_Eol (Content.all, Match);
         Into.Name := To_UString (Content (Match .. Pos - 1));
      else
         Into.Name := Name;
      end if;
      Tokens := null;
      Parser.Root := null;
      Parser.License := Into.Name;
      Parser.Parse (Content (Pos .. Content'Last));
      Tokens := Parser.Root;
   end Load_License;

   procedure Append_Token (Parser : in out Parser_Type;
                           Token  : in Token_Access) is
      Is_Optional : constant Boolean := Token.all in Optional_Token_Type'Class;
      Is_Linked   : Boolean := False;
   begin
      Parser.Token_Count := Parser.Token_Count + 1;
      if Parser.Optional > 0 and then Parser.Optionals (Parser.Optional).Optional = null then
         Parser.Optionals (Parser.Optional).Optional := Token;
         Token.Previous := Parser.Optionals (Parser.Optional).all'Access;
         Parser.Previous := Token;
         Is_Linked := True;
      end if;
      if Is_Optional then
         Parser.Optional := Parser.Optional + 1;
         Parser.Optionals (Parser.Optional) := Optional_Token_Type (Token.all)'Access;
      end if;
      if Parser.Optional > 1 then
         return;
      end if;
      if Token.Previous = null then
         Token.Previous := Parser.Previous;
      end if;
      if Parser.Previous = null then
         if Parser.Root = null then
            Parser.Root := Token;
         else
            Token.Alternate := Parser.Root.Alternate;
            Parser.Root.Alternate := Token;
         end if;
      elsif Parser.Previous.Next /= null then
         declare
            Prev : Token_Access := Parser.Previous.Next;
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
      elsif not Is_Linked then
         Parser.Previous.Next := Token;
      end if;
   end Append_Token;

   overriding
   procedure Token (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    Token   : in SPDX_Tool.Licenses.Token_Kind) is
      function Create_Regpat (Content : in Buffer_Type) return Token_Access;
      function Multi_Token_Count (Regpat : in String) return Natural;

      --  Returns true if the regular expression applies on several tokens.
      function Multi_Token_Count (Regpat : in String) return Natural is
         Cnt : Natural := 1;
         Pos : Positive := Regpat'First;
      begin
         if Regpat = "[^.]+\." then
            return 20;
         end if;
         while Pos <= Regpat'Last loop
            --  Example: "SOFTWARE IS|MATERIALS ARE"
            if Regpat (Pos) in ' ' | ':' | ',' | '.' | ';' | '!' | '"' | '<' | '>'
              | '@' | '/' | '&' | '=' | '#'
            then
               Cnt := Cnt + 1;

               --  Example: "this\s+software\s+and..."
               --  Example: "assume\.?"
               --  Example: \(0BSD\)
            elsif Regpat (Pos) = '\' and then Pos + 1 <= Regpat'Last
              and then Regpat (Pos + 1) in '.' | 's' | '(' | ')' | '[' | ']' | '#'
            then
               Cnt := Cnt + 1;
               Pos := Pos + 1;
            end if;
            Pos := Pos + 1;
         end loop;
         return Cnt;
      end Multi_Token_Count;

      function Create_Regpat (Content : in Buffer_Type) return Token_Access is
         Regpat : String (1 .. Content'Length);
         for Regpat'Address use Content'Address;
      begin
         if Regpat = ".+" then
            Log.Debug ("Pattern: '{0}'", Regpat);
            return new Any_Token_Type '(Len => Content'Length,
                                        Previous => null,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Max_Length => 1000);
         end if;
         if Regpat = ".*" or else Regpat = ".{0,5000}" then
            Log.Debug ("Pattern: '{0}'", Regpat);
            return new Any_Token_Type '(Len => Content'Length,
                                        Previous => null,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Max_Length => 1000);
         end if;
         if Regpat = ".{0,20}" then
            Log.Debug ("Pattern: '{0}'", Regpat);
            return new Any_Token_Type '(Len => Content'Length,
                                        Previous => null,
                                        Next => null,
                                        Alternate => null,
                                        Content => Content,
                                        Max_Length => 20);
         end if;
         declare
            Pat : constant GNAT.Regpat.Pattern_Matcher := GNAT.Regpat.Compile (Regpat);
            Cnt : constant Natural := Multi_Token_Count (Regpat);
         begin
            Log.Debug ("Pattern: '{0}' {1} tokens", Regpat, Util.Strings.Image (Cnt));
            if Cnt > 1 then
               return new Regpat_Multi_Token_Type '(Len => Content'Length,
                                                    Plen => Pat.Size,
                                                    Max_Token => Cnt,
                                                    Previous => null,
                                                    Next => null,
                                                    Alternate => null,
                                                    Content => Content,
                                                    Pattern => Pat);
            end if;
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
            Log.Error ("cannot compile regex: '{0}'", Regpat);
            return new Token_Type '(Len => Content'Length,
                                    Previous => null,
                                    Next => null,
                                    Alternate => null,
                                    Content => Content);
      end Create_Regpat;

      T : Token_Access;
   begin
      case Token is
         when TOK_WORD =>
            T := Parser.Find_Token (Content (Parser.Token_Pos .. Parser.Current_Pos - 1));
            if T = null then
               T := new Token_Type '(Len => Parser.Current_Pos - Parser.Token_Pos,
                                     Previous => null,
                                     Next => null,
                                     Alternate => null,
                                     Content => Content (Parser.Token_Pos
                                        .. Parser.Current_Pos - 1));
               Parser.Append_Token (T);
            end if;
            Parser.Previous := T;

         when TOK_QUOTE =>
            T := Parser.Find_Token (Content (Parser.Token_Pos .. Parser.Current_Pos - 1));
            if T = null then
               T := new Quote_Token_Type '(Len => Parser.Current_Pos - Parser.Token_Pos,
                                           Previous => null,
                                           Next => null,
                                           Alternate => null,
                                           Content => Content (Parser.Token_Pos
                                             .. Parser.Current_Pos - 1));
               Parser.Append_Token (T);
            end if;
            Parser.Previous := T;

         when TOK_VAR =>
            T := Parser.Find_Token (Content (Parser.Match_Pos .. Parser.Match_End));
            if T = null then
               T := Create_Regpat (Content => Content (Parser.Match_Pos .. Parser.Match_End));
               Parser.Append_Token (T);
            end if;
            Parser.Previous := T;

         when TOK_OPTIONAL =>
            if Parser.Optional = MAX_NESTED_OPTIONAL then
               Log.Error ("too many nested <<beginOptional>>");
               return;
            end if;
            T := new Optional_Token_Type '(Len => 0,
                                            Previous => null,
                                            Next => null,
                                            Alternate => null,
                                            others => <>);
            Parser.Append_Token (T);
            Parser.Previous := T;

         when TOK_END_OPTIONAL =>
            if Parser.Optional = 0 then
               Log.Error ("not with a <<beginOptional>> element");
               return;
            end if;
            T := Parser.Optionals (Parser.Optional).all'Access;
            Parser.Previous := T;
            Parser.Optional := Parser.Optional - 1;

         when TOK_LICENSE | TOK_END | TOK_COPYRIGHT =>
            T := new Final_Token_Type '(Len => 0,
                                        License => Parser.License,
                                        others => <>);
            Parser.Append_Token (T);

      end case;
   end Token;

   procedure Parse (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    License : in out License_Template) is
   begin
      Parser.Root := null;
      Parser.License := License.Name;
      Parser.Parse (Content);
      License.Root := Parser.Root;
   end Parse;

end SPDX_Tool.Licenses.Reader;
