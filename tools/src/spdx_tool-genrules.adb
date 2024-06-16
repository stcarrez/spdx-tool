-- --------------------------------------------------------------------
--  spdx_tool-genrules -- Generate definition of language rules
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Command_Line;
with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Maps;
with Ada.Containers.Indefinite_Ordered_Maps;
with Ada.Directories;
with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Streams.Stream_IO;
with Util.Serialize.IO.JSON;
with Util.Streams.Texts;
with Util.Streams.Files;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Beans.Objects.Vectors;
with Util.Strings.Vectors;
with Util.Strings.Transforms;
with Util.Strings.Tokenizers;
with SPDX_Tool.Infos;
with SPDX_Tool.Languages.Rules;
procedure SPDX_Tool.Genrules is

   package UBO renames Util.Beans.Objects;
   use type Ada.Containers.Count_Type;
   use Util.Strings.Vectors;
   use Ada.Strings.Unbounded;
   use SPDX_Tool.Languages.Rules;
   use SPDX_Tool.Infos;

   package SMaps is
      new Ada.Containers.Indefinite_Ordered_Maps (Key_Type     => String,
                                                  Element_Type => Util.Strings.Vectors.Vector);

   package String_Maps is
      new Ada.Containers.Indefinite_Ordered_Maps (Key_Type     => String,
                                                  Element_Type => Natural);
   package Integer_Maps is
      new Ada.Containers.Ordered_Maps (Key_Type     => Integer,
                                       Element_Type => Natural);
   function Get_Mapping (From : in Integer_Maps.Map; Value : in Integer) return Integer;

   type Rule_Type is record
      Mode      : Rule_Mode;
      Min_Lines : Natural;
      Lines     : Infos.Line_Range_Type;
      Pattern   : Integer;
      Result    : Integer;
   end record;

   package Rule_Vectors is
      new Ada.Containers.Vectors (Element_Type => Rule_Type,
                                  Index_Type   => Positive);

   type Rule_Definition is record
      Rules     : Rule_Vectors.Vector;
      Generator : Integer := -1;
      Language  : Integer := -1;
   end record;

   package Rule_Definition_Vectors is
      new Ada.Containers.Vectors (Element_Type => Rule_Definition,
                                  Index_Type   => Positive);

   package Maps is
      new Ada.Containers.Indefinite_Ordered_Maps (Key_Type     => String,
                                                  Element_Type => Rule_Definition_Vectors.Vector,
                                                  "=" => Rule_Definition_Vectors."=");

   --  General methods.
   procedure Usage;
   procedure Error (Message : in String);

   --  Parsing methods.
   procedure Parse_JSON (Filename : in String);
   function To_String (List : in UBO.Object) return String;
   function Get_String_Index (From : in out String_Maps.Map; Item : in String) return Integer;
   function Get_Pattern_Index (From : in out String_Maps.Map; Item : in String) return Integer;
   function Get_Int_Value (From : in UBO.Object;
                           Name : in String;
                           Default : Integer) return Integer;
   procedure Add_Rule (Ext : in String;
                       Def : in Rule_Definition);
   procedure Register_Rule (Ext_List : in UBO.Object;
                            Rule     : in UBO.Object);
   procedure Register_Rules (Ext_List : in UBO.Object;
                             Rules    : in UBO.Object);
   procedure Register_Disambiguations (List : in UBO.Object);
   procedure Register_Patterns (List : in UBO.Object);

   --  Generation methods.
   function Should_Break (Column  : in Natural;
                          Content : in String) return Boolean;
   procedure Write_String (Content : in String);
   procedure Write_Strings (Index     : in out Natural;
                            Map       : in String_Maps.Map;
                            Converter : in out Integer_Maps.Map);
   procedure Write_Rules (Index    : in out Natural;
                          Need_Sep : in out Boolean;
                          List     : in Rule_Definition_Vectors.Vector;
                          Pat_Cvt  : in Integer_Maps.Map;
                          Str_Cvt  : in Integer_Maps.Map);
   function To_Package_Name (Filename : in String) return String;

   Exts           : Maps.Map;
   Named_Patterns : SMaps.Map;
   Strings        : String_Maps.Map;
   Patterns       : String_Maps.Map;
   Output   : aliased Util.Streams.Files.File_Stream;
   Writer   : aliased Util.Streams.Texts.Print_Stream;
   Empty_List : Util.Strings.Vectors.Vector;

   function Get_Int_Value (From : in UBO.Object;
                           Name : in String;
                           Default : Integer) return Integer is
      Value : constant UBO.Object := UBO.Get_Value (From, Name);
   begin
      if UBO.Is_Null (Value) then
         return Default;
      else
         return UBO.To_Integer (Value);
      end if;
   end Get_Int_Value;

   procedure Error (Message : in String) is
   begin
      Ada.Text_IO.Put_Line ("error: " & Message);
   end Error;

   function Get_String_Index (From : in out String_Maps.Map; Item : in String) return Integer is
      Pos : constant String_Maps.Cursor := From.Find (Item);
   begin
      if Item = "null" then
         return -1;
      end if;
      if String_Maps.Has_Element (Pos) then
         return String_Maps.Element (Pos);
      else
         declare
            Value : constant Natural := Natural (From.Length + 1);
         begin
            From.Insert (Item, Value);
            return Value;
         end;
      end if;
   end Get_String_Index;

   function Get_Named_Pattern (Name : in String) return Util.Strings.Vectors.Vector is
      Pos : constant SMaps.Cursor := Named_Patterns.Find (Name);
   begin
      if SMaps.Has_Element (Pos) then
         return SMaps.Element (Pos);
      else
         return Empty_List;
      end if;
   end Get_Named_Pattern;

   function Get_Pattern_Index (From : in out String_Maps.Map; Item : in String) return Integer is
      Item1 : constant String := Util.Strings.Replace (Item, "?i:", "", First => False);
      Item2 : constant String := Util.Strings.Replace (Item1, "?:", "", First => False);
      Item3 : constant String := Util.Strings.Replace (Item2, "(?i)", "", First => False);
      Item4 : constant String := Util.Strings.Replace (Item3, "?>", "", First => False);
      Item5 : constant String := Util.Strings.Replace (Item4, "?<!", "", First => False);
      Item6 : constant String := Util.Strings.Replace (Item5, "?!", "", First => False);
      Item7 : constant String := Util.Strings.Replace (Item6, "?=", "", First => False);
      Item8 : constant String := Util.Strings.Replace (Item7, "?-", "", First => False);
   begin
      return Get_String_Index (From, Item8);
   end Get_Pattern_Index;

   function To_String (List : in UBO.Object) return String is
      Result : UString;
      Iter   : UBO.Iterators.Iterator := UBO.Iterators.First (List);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
         begin
            if Length (Result) > 0 then
               Append (Result, ",");
            end if;
            Append (Result, UBO.To_String (Item));
         end;
         UBO.Iterators.Next (Iter);
      end loop;
      return To_String (Result);
   end To_String;

   procedure Add_Rule (Ext : in String;
                       Def : in Rule_Definition) is
      procedure Process (Token : in String; Done : out Boolean);

      procedure Process (Token : in String; Done : out Boolean) is
         pragma Unreferenced (Done);

         Pos : constant Maps.Cursor := Exts.Find (Token);
      begin
         if Maps.Has_Element (Pos) then
            Exts.Reference (Pos).Append (Def);
         else
            declare
               List : Rule_Definition_Vectors.Vector;
            begin
               List.Append (Def);
               Exts.Insert (Token, List);
            end;
         end if;
      end Process;
   begin
      Util.Strings.Tokenizers.Iterate_Tokens (Ext, ",", Process'Access);
   end Add_Rule;

   procedure Register_Rule (Ext_List : in UBO.Object;
                            Rule     : in UBO.Object) is
      procedure Process_Rule (Position : in Positive;
                              Item     : in UBO.Object);

      Lang : constant UBO.Object := UBO.Get_Value (Rule, "language");
      Gen  : constant UBO.Object := UBO.Get_Value (Rule, "generator");
      Min  : constant Integer := Get_Int_Value (Rule, "min-lines", 0);
      File : constant UBO.Object := UBO.Get_Value (Rule, "filename");
      Def  : Rule_Definition;
      Is_And : Boolean := False;

      procedure Process_Rule (Position : in Positive;
                              Item     : in UBO.Object) is
         pragma Unreferenced (Position);
         procedure Add_Rule (Pos : in Positive; Pat : in UBO.Object);

         Line     : constant UBO.Object := UBO.Get_Value (Item, "line");
         Contains : constant UBO.Object := UBO.Get_Value (Item, "contains");
         Pattern  : constant UBO.Object := UBO.Get_Value (Item, "pattern");
         Named_Pattern : constant UBO.Object := UBO.Get_Value (Item, "named_pattern");
         R : Rule_Type;

         procedure Add_Rule (Pos : in Positive; Pat : in UBO.Object) is
            pragma Unreferenced (Pos);
         begin
            R.Pattern := Get_Pattern_Index (Patterns, UBO.To_String (Pat));
            Def.Rules.Append (R);
         end Add_Rule;
      begin
         if not UBO.Is_Null (Line) then
            begin
               R.Lines := SPDX_Tool.Infos.Get_Range (UBO.To_String (Line));
            exception
               when E : Constraint_Error =>
                  Error ("invalid 'line' attribute '" & UBO.To_String (Line)
                         & "': " & Ada.Exceptions.Exception_Message (E));
            end;
         end if;
         R.Min_Lines := Min;
         R.Result := (if Def.Language > 0 then Def.Language else Def.Generator);
         if not UBO.Is_Null (Pattern) then
            R.Mode := (if Is_And then RULE_MATCH_AND else RULE_MATCH);
            if not UBO.Is_Array (Pattern) then
               R.Pattern := Get_Pattern_Index (Patterns, UBO.To_String (Pattern));
               Def.Rules.Append (R);
            else
               UBO.Vectors.Iterate (Pattern, Add_Rule'Access);
            end if;
         elsif not UBO.Is_Null (Contains) then
            R.Mode := (if Is_And then RULE_CONTAINS_AND else RULE_CONTAINS);
            R.Pattern := Get_String_Index (Strings, UBO.To_String (Contains));
            Def.Rules.Append (R);
         elsif not UBO.Is_Null (Named_Pattern) then
            R.Mode := (if Is_And then RULE_MATCH_AND else RULE_MATCH);
            declare
               List : Util.Strings.Vectors.Vector := Get_Named_Pattern (UBO.To_String (Named_Pattern));
            begin
               for Pat of List loop
                  R.Pattern := Get_Pattern_Index (Patterns, Pat);
                  Def.Rules.Append (R);
               end loop;
            end;
         else
            R.Mode := RULE_SUCCESS;
            Def.Rules.Append (R);
         end if;
      end Process_Rule;

      List  : UBO.Object;
      Empty : Boolean := True;
   begin
      if not UBO.Is_Null (Lang) then
         Def.Language := Get_String_Index (Strings, UBO.To_String (Lang));
      elsif not UBO.Is_Null (Gen) then
         Def.Generator := Get_String_Index (Strings, UBO.To_String (Gen));
      else
         Error ("Missing 'language' or 'generator' for rule of extension: "
                & To_String (Ext_List));
      end if;

      if not UBO.Is_Null (File) then
         declare
            R : Rule_Type;
         begin
            R.Min_Lines := Min;
            R.Mode := RULE_FILENAME_MATCH;
            R.Pattern := Get_Pattern_Index (Patterns, UBO.To_String (File));
            R.Result := (if Def.Language > 0 then Def.Language else Def.Generator);
            Def.Rules.Append (R);
         end;
      end if;

      List := UBO.Get_Value (Rule, "and");
      if not UBO.Is_Null (List) then
         Is_And := True;
         UBO.Vectors.Iterate (List, Process_Rule'Access);
         Empty := False;
      end if;

      List := UBO.Get_Value (Rule, "or");
      if not UBO.Is_Null (List) then
         Is_And := False;
         UBO.Vectors.Iterate (List, Process_Rule'Access);
         Empty := False;
      end if;

      if Empty then
         Process_Rule (1, Rule);
      end if;

      if UBO.Is_Array (Ext_List) then
         Add_Rule (To_String (Ext_List), Def);
      else
         declare
            Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Ext_List);
         begin
            while UBO.Iterators.Has_Element (Iter) loop
               declare
                  Ext : constant UBO.Object := UBO.Iterators.Element (Iter);
               begin
                  Add_Rule (To_String (Ext), Def);
               end;
               UBO.Iterators.Next (Iter);
            end loop;
         end;
      end if;
   end Register_Rule;

   procedure Register_Rules (Ext_List : in UBO.Object;
                             Rules    : in UBO.Object) is
   begin
      if not UBO.Is_Array (Rules) then
         Register_Rule (Ext_List, Rules);
      else
         declare
            Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Rules);
         begin
            while UBO.Iterators.Has_Element (Iter) loop
               declare
                  Rule : constant UBO.Object := UBO.Iterators.Element (Iter);
               begin
                  Register_Rule (Ext_List, Rule);
               end;
               UBO.Iterators.Next (Iter);
            end loop;
         end;
      end if;
   end Register_Rules;

   procedure Register_Disambiguations (List : in UBO.Object) is
   begin
      if not UBO.Is_Array (List) then
         declare
            Ext_List : constant UBO.Object := UBO.Get_Value (List, "extensions");
            Rules    : constant UBO.Object := UBO.Get_Value (List, "rules");
         begin
            Register_Rule (Ext_List, Rules);
         end;
      else
         declare
            Iter : UBO.Iterators.Iterator := UBO.Iterators.First (List);
         begin
            while UBO.Iterators.Has_Element (Iter) loop
               declare
                  Item     : constant UBO.Object := UBO.Iterators.Element (Iter);
                  Ext_List : constant UBO.Object := UBO.Get_Value (Item, "extensions");
                  Rules    : constant UBO.Object := UBO.Get_Value (Item, "rules");
               begin
                  if not UBO.Is_Null (Ext_List) and then not UBO.Is_Null (Rules) then
                     Register_Rules (Ext_List, Rules);
                  end if;
               end;
               UBO.Iterators.Next (Iter);
            end loop;
         end;
      end if;
   end Register_Disambiguations;

   procedure Register_Patterns (List : in UBO.Object) is
      procedure Register_Pattern (Name : in String;
                                  List : in UBO.Object);

      procedure Register_Pattern (Name : in String;
                                  List : in UBO.Object) is
         Pattern_List : Util.Strings.Vectors.Vector;
      begin
         if not UBO.Is_Array (List) then
            Pattern_List.Append (UBO.To_String (List));
         else
            declare
               Iter : UBO.Iterators.Iterator := UBO.Iterators.First (List);
            begin
               while UBO.Iterators.Has_Element (Iter) loop
                  declare
                     Item : constant UBO.Object := UBO.Iterators.Element (Iter);
                  begin
                     Pattern_List.Append (UBO.To_String (Item));
                  end;
                  UBO.Iterators.Next (Iter);
               end loop;
            end;
         end if;
         Named_Patterns.Include (Name, Pattern_List);
      end Register_Pattern;

      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (List);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
            Name : constant String := UBO.Iterators.Key (Iter);
         begin
            Register_Pattern (Name, Item);
         end;
         UBO.Iterators.Next (Iter);
      end loop;
   end Register_Patterns;

   procedure Parse_JSON (Filename : in String) is
      Root : constant UBO.Object := Util.Serialize.IO.JSON.Read (Filename);
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Root);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item  : constant UBO.Object := UBO.Iterators.Element (Iter);
         begin
            if UBO.Iterators.Has_Key (Iter) then
               if UBO.Iterators.Key (Iter) = "disambiguations" then
                  Register_Disambiguations (Item);
               elsif UBO.Iterators.Key (Iter) = "patterns" then
                  Register_Patterns (Item);
               elsif UBO.Iterators.Key (Iter) = "generators" then
                  Register_Disambiguations (Item);
               end if;
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
   end Parse_JSON;

   procedure Usage is
   begin
      Ada.Text_IO.Put_Line ("Usage: spdx_tool-genrules generated-path definition.json...");
      Ada.Command_Line.Set_Exit_Status (2);
   end Usage;

   function Should_Break (Column  : in Natural;
                          Content : in String) return Boolean is
      Count : Natural := 0;
   begin
      if Column >= 70 then
         for C of Content loop
            if C in ' ' | '!' | '#' .. '~' then
               return Count + Column > 80;
            end if;
            if C < ' ' then
               return True;
            end if;
            Count := Count + 1;
            if Count > 15 then
               return True;
            end if;
         end loop;
      end if;
      return False;
   end Should_Break;

   procedure Write_String (Content : in String) is
      Need_Sep : Boolean := False;
      Column   : Natural := 0;
      C        : Character;
      Pos      : Natural := Content'First;
   begin
      Column := 40;
      Writer.Write ("""");
      while Pos <= Content'Last loop
         C := Content (Pos);
         if Should_Break (Column, Content (Pos .. Content'Last)) then
            if not Need_Sep then
               Writer.Write ("""");
            end if;
            Writer.Write (ASCII.LF);
            Writer.Write ("      ");
            Column := 6;
            Need_Sep := True;
         end if;
         case C is
            when ASCII.CR =>
               if not Need_Sep then
                  Writer.Write ("""");
                  Need_Sep := True;
                  Column := Column + 1;
               end if;
               Writer.Write (" & ASCII.CR");
               Column := Column + 11;

            when ASCII.LF =>
               if not Need_Sep then
                  Writer.Write ("""");
                  Need_Sep := True;
                  Column := Column + 1;
               end if;
               Writer.Write (" & ASCII.LF");
               Column := Column + 11;

            when ASCII.HT =>
               if not Need_Sep then
                  Writer.Write ("""");
                  Need_Sep := True;
                  Column := Column + 1;
               end if;
               Writer.Write (" & ASCII.HT");
               Column := Column + 11;

            when '"' =>
               if Need_Sep then
                  Writer.Write (" & """);
                  Need_Sep := False;
                  Column := Column + 5;
               end if;
               Writer.Write ("""""");
               Column := Column + 1;

            when ' ' | '!' | '#' .. '~' =>
               if Need_Sep then
                  Writer.Write (" & """);
                  Need_Sep := False;
                  Column := Column + 5;
               end if;
               Writer.Write (C);

            when Character'Val (192) .. Character'Val (255) =>
               if Need_Sep then
                  Writer.Write (" & """);
                  Need_Sep := False;
                  Column := Column + 5;
               end if;
               Writer.Write (C);
               while Pos + 1 <= Content'Last loop
                  C := Content (Pos + 1);
                  exit when Character'Pos (C) < 128;
                  exit when Character'Pos (C) >= 192;
                  Pos := Pos + 1;
                  Writer.Write (C);
               end loop;

            when others =>
               if not Need_Sep then
                  Writer.Write ("""");
                  Need_Sep := True;
                  Column := Column + 1;
               end if;
               Writer.Write (" & Character'Val (");
               Writer.Write (Util.Strings.Image (Integer (Character'Pos (C))));
               Writer.Write (")");
               Column := Column + 22;

         end case;
         Column := Column + 1;
         Pos := Pos + 1;
      end loop;
      if not Need_Sep then
         Writer.Write ("""");
      end if;
   end Write_String;

   procedure Write_Strings (Index     : in out Natural;
                            Map       : in String_Maps.Map;
                            Converter : in out Integer_Maps.Map) is
   begin
      for Iter in Map.Iterate loop
         declare
            Item  : constant String := String_Maps.Key (Iter);
            Value : constant Natural := String_Maps.Element (Iter);
         begin
            Index := Index + 1;
            Writer.Write ("   S" & Util.Strings.Image (Index));
            Writer.Write (" : aliased constant String := ");
            Write_String (Item);
            Writer.Write (";" & ASCII.LF);
            Converter.Insert (Value, Index);
         end;
      end loop;
   end Write_Strings;

   function Get_Mapping (From : in Integer_Maps.Map; Value : in Integer) return Integer is
      Pos : constant Integer_Maps.Cursor := From.Find (Value);
   begin
      if Integer_Maps.Has_Element (Pos) then
         return Integer_Maps.Element (Pos);
      else
         return 1;
      end if;
   end Get_Mapping;

   procedure Write_Rules (Index    : in out Natural;
                          Need_Sep : in out Boolean;
                          List     : in Rule_Definition_Vectors.Vector;
                          Pat_Cvt  : in Integer_Maps.Map;
                          Str_Cvt  : in Integer_Maps.Map) is
      Rule_Pos : Natural;
      Value    : Natural;
   begin
      for Def of List loop
         Rule_Pos := 0;
         for Rule of Def.Rules loop
            Index := Index + 1;
            Rule_Pos := Rule_Pos + 1;
            if Need_Sep then
               Writer.Write ("," & ASCII.LF);
            end if;
            Writer.Write ("      " & Util.Strings.Image (Index));
            Writer.Write (" => (");
            if Rule_Pos = Natural (Def.Rules.Length) then
               if Rule.Mode = RULE_MATCH then
                  Writer.Write ("RULE_MATCH, ");
                  Value := Get_Mapping (Pat_Cvt, Rule.Pattern);
               elsif Rule.Mode = RULE_CONTAINS then
                  Writer.Write ("RULE_CONTAINS, ");
                  Value := Get_Mapping (Str_Cvt, Rule.Pattern);
               else
                  Writer.Write ("RULE_SUCCESS, ");
                  Value := 0;
               end if;
            else
               if Rule.Mode = RULE_MATCH then
                  Writer.Write ("RULE_MATCH_AND, ");
                  Value := Get_Mapping (Pat_Cvt, Rule.Pattern);
               elsif Rule.Mode = RULE_CONTAINS then
                  Writer.Write ("RULE_CONTAINS_AND, ");
                  Value := Get_Mapping (Str_Cvt, Rule.Pattern);
               else
                  Writer.Write ("RULE_SUCCESS, ");
                  Value := 0;
               end if;
            end if;
            Writer.Write (Util.Strings.Image (Rule.Min_Lines));
            Writer.Write (", (");
            Writer.Write (Util.Strings.Image (Natural (Rule.Lines.First_Line)));
            Writer.Write (", ");
            Writer.Write (Util.Strings.Image (Natural (Rule.Lines.Last_Line)));
            Writer.Write ("), ");
            Writer.Write (Util.Strings.Image (Value));
            Writer.Write (", ");
            if Rule.Result > 0 then
               Writer.Write (Util.Strings.Image (Get_Mapping (Str_Cvt, Rule.Result)));
            else
               Writer.Write ("0");
            end if;
            Writer.Write (")");
            Need_Sep := True;
         end loop;
      end loop;
   end Write_Rules;

   function To_Package_Name (Filename : in String) return String is
      Name : constant String := Ada.Directories.Base_Name (Filename);
      Sep  : constant Natural := Util.Strings.Rindex (Name, '-');
   begin
      if Sep > 0 then
         return Util.Strings.Transforms.Capitalize (Name (Sep + 1 .. Name'Last));
      else
         return Util.Strings.Transforms.Capitalize (Name);
      end if;
   end To_Package_Name;

begin
   if Ada.Command_Line.Argument_Count < 2 then
      Usage;
      return;
   end if;

   declare
      Filename : constant String := Ada.Command_Line.Argument (1);
      Name     : constant String := To_Package_Name (Filename);
   begin
      if Filename'Length = 0 then
         Usage;
         return;
      end if;
      for I in 2 .. Ada.Command_Line.Argument_Count loop
         Parse_JSON (Ada.Command_Line.Argument (I));
      end loop;
      Output.Create (Mode => Ada.Streams.Stream_IO.Out_File,
                     Name => Filename);
      Writer.Initialize (Output'Unchecked_Access);

      Writer.Write ("--  Generated by spdx_tool-genrules.adb" & ASCII.LF);
      Writer.Write ("--  SPDX-License-Identifier: Apache-2.0" & ASCII.LF);
      Writer.Write ("package SPDX_Tool.Languages.Rules.");
      Writer.Write (Name);
      Writer.Write (" is" & ASCII.LF & ASCII.LF);
      Writer.Write ("   Definition  : constant Rules_List;" & ASCII.LF & ASCII.LF);
      Writer.Write ("private" & ASCII.LF & ASCII.LF);
      declare
         Index    : Natural := 0;
         Need_Sep : Boolean := False;
         Ext_Idx  : Natural := 0;
         Pat_Cvt  : Integer_Maps.Map;
         Str_Cvt  : Integer_Maps.Map;
         Pat_Cnt  : Natural;
      begin
         Write_Strings (Index, Patterns, Pat_Cvt);
         Pat_Cnt := Index;
         Write_Strings (Index, Strings, Str_Cvt);
         Writer.Write (ASCII.LF);
         Writer.Write ("   Strings : aliased constant String_Array_Access := ("
                       & ASCII.LF & "      ");
         for I in 1 .. Index loop
            Writer.Write ("S" & Util.Strings.Image (I) & "'Access");
            if I < Index then
               Writer.Write (",");
               if I mod 4 = 0 then
                  Writer.Write (ASCII.LF);
                  Writer.Write ("      ");
               else
                  Writer.Write (" ");
               end if;
            end if;
         end loop;
         Writer.Write (");" & ASCII.LF & ASCII.LF);
         Index := 0;
         for Iter in Exts.Iterate loop
            declare
               Key : constant String := Maps.Key (Iter);
            begin
               Ext_Idx := Ext_Idx + 1;
               Writer.Write ("   Ext_" & Util.Strings.Image (Ext_Idx));
               Writer.Write (" : aliased constant String := ");
               Write_String (Key);
               Writer.Write (";" & ASCII.LF);
            end;
         end loop;
         Writer.Write (ASCII.LF);
         Writer.Write ("   Rules : aliased constant Rule_Array := (" & ASCII.LF);
         for Iter in Exts.Iterate loop
            declare
               Def : constant Maps.Reference_Type := Exts.Reference (Iter);
            begin
               Write_Rules (Index, Need_Sep, Def, Pat_Cvt, Str_Cvt);
            end;
         end loop;
         Writer.Write (");" & ASCII.LF & ASCII.LF);
         Writer.Write ("   Extensions : aliased constant Extension_Rules_Array := (" & ASCII.LF);
         Ext_Idx  := 0;
         Index := 0;
         Need_Sep := False;
         for Iter in Exts.Iterate loop
            declare
               Def : constant Maps.Reference_Type := Exts.Reference (Iter);
            begin
               if Need_Sep then
                  Writer.Write ("," & ASCII.LF);
               end if;
               Ext_Idx := Ext_Idx + 1;
               Writer.Write ("      (Ext_" & Util.Strings.Image (Ext_Idx));
               Writer.Write ("'Access, " & Util.Strings.Image (Index + 1));
               for R of Def loop
                  Index := Index + Natural (R.Rules.Length);
               end loop;
               Writer.Write (", " & Util.Strings.Image (Index));
               Writer.Write (")");
               Need_Sep := True;
            end;
         end loop;
         Writer.Write (");" & ASCII.LF & ASCII.LF);

         Writer.Write ("   Patterns : aliased Matcher_Array_Access :=" & ASCII.LF);
         Writer.Write ("      (");
         for I in 1 .. Pat_Cnt loop
            Writer.Write ("null");
            if I /= Pat_Cnt then
               Writer.Write (",");
               if (I mod 8) = 0 then
                  Writer.Write (ASCII.LF);
               else
                  Writer.Write (" ");
               end if;
            end if;
         end loop;
         Writer.Write (");" & ASCII.LF & ASCII.LF);
         Writer.Write ("   Definition : constant Rules_List :=" & ASCII.LF);
         Writer.Write ("      (Strings    => Strings'Access," & ASCII.LF);
         Writer.Write ("       Extensions => Extensions'Access," & ASCII.LF);
         Writer.Write ("       Rules      => Rules'Access," & ASCII.LF);
         Writer.Write ("       Patterns   => Patterns'Access);" & ASCII.LF & ASCII.LF);
      end;
      Writer.Write ("end SPDX_Tool.Languages.Rules.");
      Writer.Write (Name);
      Writer.Write (";" & ASCII.LF);
   end;
end SPDX_Tool.Genrules;
