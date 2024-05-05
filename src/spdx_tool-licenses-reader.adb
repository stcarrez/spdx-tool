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

package body SPDX_Tool.Licenses.Reader is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses.Reader");

   package UBO renames Util.Beans.Objects;

   function Find_Header (List : UBO.Object) return UBO.Object;
   function Find_Value (Info : UBO.Object; Name : String) return Boolean;
   function Find_Value (Info : UBO.Object; Name : String) return UString;

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
      License.License := Find_Value (Info, "spdx:licenseText");
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

   --  ------------------------------
   --  Parse the license text template that was extracted from the JSONLD file.
   --  The Parser instance is updated to indicate position of tokens found
   --  and the `Token` method is called for each token found as parsing progresses.
   --  ------------------------------
   procedure Parse (Parser  : in out Parser_Type'Class;
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
            Parser.Match_End := Find_String_End (Content, Match, Last);
            Pos := Parser.Match_End + 1;
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
            elsif Pos = First then
               exit when Space_Length (Content, Pos, Last) /= 0;
               Len := Punctuation_Length (Content, Pos, Last);
               if Len > 0 then
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

end SPDX_Tool.Licenses.Reader;
