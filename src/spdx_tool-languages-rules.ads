-- --------------------------------------------------------------------
--  spdx_tool-languages-rules -- Rules declaration for language identification
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with GNAT.Regpat;
with SPDX_Tool.Infos;
package SPDX_Tool.Languages.Rules is

   subtype Line_Range_Type is SPDX_Tool.Infos.Line_Range_Type;

   type Pattern_Length is new Natural;
   subtype Pattern_Index is Pattern_Length range 1 .. Pattern_Length'Last;
   type Rule_Index is new Natural;
   type Rule_Result_Index is new Natural;
   type Rule_Mode is (RULE_FILENAME_MATCH, RULE_FILENAME_MATCH_AND,
                      RULE_STARTS_WITH, RULE_STARTS_WITH_AND,
                      RULE_CONTAINS, RULE_CONTAINS_AND,
                      RULE_MATCH, RULE_MATCH_AND);

   type Rule_Definition is record
      Mode      : Rule_Mode;
      Min_Lines : Natural;
      Lines     : Line_Range_Type;
      Pattern   : Pattern_Index;
      Result    : Pattern_Length;
   end record;
   type Rule_Array is array (Rule_Index range <>) of Rule_Definition;
   type Rule_Array_Access is access constant Rule_Array;

   type Matcher_Access is access all GNAT.Regpat.Pattern_Matcher;
   type Matcher_Array_Access is array (Pattern_Index range <>) of Matcher_Access;
   type Matchers_Array_Access is access all Matcher_Array_Access;
   type String_Array_Access is array (Pattern_Index range <>) of Name_Access;
   type Strings_Array_Access is access constant String_Array_Access;

   type Extension_Rules is record
      Extension : Name_Access;
      First     : Rule_Index;
      Last      : Rule_Index;
   end record;
   type Extension_Rules_Array is array (Positive range <>) of Extension_Rules;
   type Extension_Rules_Array_Access is access constant Extension_Rules_Array;

   type Rules_List is record
      Strings    : Strings_Array_Access;
      Extensions : Extension_Rules_Array_Access;
      Rules      : Rule_Array_Access;
      Patterns   : Matchers_Array_Access;
   end record;

   --  Find from the rules array, the rule that matches the file and its content.
   --  Returns the index of the rule or 0 when nothing matched.
   function Find (Rules   : in Rules_List;
                  File    : in File_Info;
                  Content : in File_Type) return Rule_Index;

   procedure Initialize (Rules : in Rules_List);

end SPDX_Tool.Languages.Rules;
