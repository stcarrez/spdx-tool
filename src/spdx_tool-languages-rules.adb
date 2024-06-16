-- --------------------------------------------------------------------
--  spdx_tool-languages-rules -- Rules declaration for language identification
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Exceptions;
with Util.Log.Loggers;
with Util.Strings;
with SPDX_Tool.Arrays;
package body SPDX_Tool.Languages.Rules is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Languages.Rules");

   type Match_Type is (NO_MATCH, SKIP, FOUND);

   function "<" (Left : in Extension_Rules; Right : in String) return Boolean is
      (Left.Extension.all < Right);
   function "=" (Left : in Extension_Rules; Right : in String) return Boolean is
      (Left.Extension.all = Right);
   function Middle (Left, Right : in Positive) return Positive is
      ((Left + Right) / 2);

   package Rule_Arrays is
      new SPDX_Tool.Arrays (Element_Type => Extension_Rules,
                            Index_Type   => Positive,
                            Array_Type   => Extension_Rules_Array);
   subtype Result_Type is Rule_Arrays.Result_Type;

   function Find is
      new Rule_Arrays.Find (Search_Type => String, Middle => Middle);

   function Check (Rules   : in Rules_List;
                   Rule    : in Rule_Definition;
                   File    : in File_Info;
                   Content : in File_Type) return Match_Type;

   function Check (Rules   : in Rules_List;
                   Rule    : in Rule_Definition;
                   File    : in File_Info;
                   Content : in File_Type) return Match_Type is
      Lines : Line_Range_Type := Rule.Lines;
      Buf  : constant Buffer_Accessor := Content.Buffer.Value;
   begin
      case Rule.Mode is
         when RULE_SUCCESS =>
            return FOUND;

         when RULE_FILENAME_MATCH | RULE_FILENAME_MATCH_AND =>
            if GNAT.Regpat.Match (Rules.Patterns (Rule.Pattern).all, File.Path) then
               return FOUND;
            else
               return SKIP;
            end if;

         when others =>
            null;
      end case;
      if Lines.First_Line = 0 then
         Lines.First_Line := 1;
      end if;
      if Lines.Last_Line = 0 then
         Lines.Last_Line := Content.Count;
      end if;
      for Line_No in Lines.First_Line .. Lines.Last_Line loop
         exit when Line_No > Content.Count;
         declare
            First     : constant Buffer_Index := Content.Lines (Line_No).Line_Start;
            Last      : constant Buffer_Size := Content.Lines (Line_No).Line_End;
            Line      : String (1 .. Natural (Last - First + 1));
            for Line'Address use Buf.Data (First)'Address;
         begin
            case Rule.Mode is
               when RULE_STARTS_WITH | RULE_STARTS_WITH_AND =>
                  if Util.Strings.Starts_With (Line, Rules.Strings (Rule.Pattern).all) then
                     return FOUND;
                  end if;

               when RULE_CONTAINS | RULE_CONTAINS_AND =>
                  if Util.Strings.Index (Line, Rules.Strings (Rule.Pattern).all, Line'First) > 0 then
                     return FOUND;
                  end if;

               when RULE_MATCH | RULE_MATCH_AND =>
                  if GNAT.Regpat.Match (Rules.Patterns (Rule.Pattern).all, Line) then
                     return FOUND;
                  end if;

               when others =>
                  null;

            end case;
         end;
      end loop;
      return (if Rule.Mode in RULE_MATCH_AND | RULE_STARTS_WITH_AND | RULE_CONTAINS_AND
                then SKIP else NO_MATCH);
   end Check;

   --  ------------------------------
   --  Find from the rules array, the rule that matches the file and its content.
   --  Returns the index of the rule or 0 when nothing matched.
   --  ------------------------------
   function Find (Rules   : in Rules_List;
                  File    : in File_Info;
                  Content : in File_Type) return Rule_Index is
      Sep    : Natural := Util.Strings.Rindex (File.Path, '.');
      Result : Result_Type;
      Pos    : Rule_Index;
      Last   : Rule_Index;
   begin
      if Sep = 0 then
         return 0;
      end if;

      if File.Path (Sep .. File.Path'Last) = ".map" then
         Sep := Util.Strings.Rindex (File.Path, '.', Sep - 1);
         if Sep = 0 then
            return 0;
         end if;
      end if;
      Result := Find (Rules.Extensions.all, File.Path (Sep .. File.Path'Last));
      if not Result.Found then
         return 0;
      end if;
      Pos := Rules.Extensions (Result.Position).First;
      Last := Rules.Extensions (Result.Position).Last;
      while Pos <= Last loop
         case Check (Rules, Rules.Rules (Pos), File, Content) is
            when FOUND =>
               return Pos;

            when SKIP =>
               while Pos + 1 <= Last
                  and then Rules.Rules (Pos).Result = Rules.Rules (Pos + 1).Result
               loop
                  Pos := Pos + 1;
               end loop;

            when others =>
               null;
         end case;
         Pos := Pos + 1;
      end loop;
      return 0;
   end Find;

   procedure Initialize (Rules : in Rules_List) is
      function Compile (Pattern : in String;
                        Flags   : in GNAT.Regpat.Regexp_Flags) return Matcher_Access;

      function Compile (Pattern : in String;
                        Flags   : in GNAT.Regpat.Regexp_Flags) return Matcher_Access is
         C : constant GNAT.Regpat.Pattern_Matcher := GNAT.Regpat.Compile (Pattern, Flags);
         P : constant Matcher_Access := new GNAT.Regpat.Pattern_Matcher (Size => C.Size);
      begin
         P.all := C;
         return P;
      end Compile;

   begin
      for I in Rules.Patterns'Range loop
         declare
            use type GNAT.Regpat.Regexp_Flags;

            Pattern : constant Name_Access := Rules.Strings (I);
            Flags   : GNAT.Regpat.Regexp_Flags := GNAT.Regpat.No_Flags;
            Pos     : Positive := Pattern'First;
         begin
            if Util.Strings.Starts_With (Pattern.all, "(?im)") then
               Flags := GNAT.Regpat.Case_Insensitive or GNAT.Regpat.Multiple_Lines;
               Pos := Pos + 5;
            elsif Util.Strings.Starts_With (Pattern.all, "(?i)") then
               Flags := GNAT.Regpat.Case_Insensitive;
               Pos := Pos + 4;
            end if;
            Rules.Patterns (I) := Compile (Pattern (Pos .. Pattern'Last), Flags);

         exception
            when E : GNAT.Regpat.Expression_Error =>
               Log.Debug ("Invalid regex '{0}': {1}", Rules.Strings (I).all,
                          Ada.Exceptions.Exception_Message (E));
         end;
      end loop;
   end Initialize;

end SPDX_Tool.Languages.Rules;
