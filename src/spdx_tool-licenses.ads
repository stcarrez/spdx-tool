-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Containers.Indefinite_Ordered_Maps;

with GNAT.Strings;
with GNAT.Regpat;

with Util.Algorithms.Arrays;

with SPDX_Tool.Files;
with SPDX_Tool.Infos;
with SPDX_Tool.Buffer_Sets;
with SPDX_Tool.Languages;
with SPDX_Tool.Counter_Arrays;
private with Util.Measures;
package SPDX_Tool.Licenses is

   SPDX_License_Tag : constant String := "SPDX-License-Identifier:";
   Unknown_License  : constant String := "Unknown";
   No_License       : constant String := "None";
   Empty_File       : constant String := "Empty file";

   License_Dir      : aliased GNAT.Strings.String_Access;
   Export_Dir       : aliased GNAT.Strings.String_Access;
   Ignore_Licenses  : aliased GNAT.Strings.String_Access;
   Only_Licenses    : aliased GNAT.Strings.String_Access;
   Ignore_Languages : aliased GNAT.Strings.String_Access;
   Only_Languages   : aliased GNAT.Strings.String_Access;
   Update_Pattern   : aliased GNAT.Strings.String_Access;
   Opt_No_Builtin   : aliased Boolean := False;
   Opt_Perf_Report  : aliased Boolean := False;

   subtype Line_Count is SPDX_Tool.Infos.Line_Count;
   subtype Line_Number is SPDX_Tool.Infos.Line_Number;
   subtype Line_Array is SPDX_Tool.Languages.Line_Array;
   use type SPDX_Tool.Infos.Line_Number;
   function Image (Line : Line_Count) return String renames SPDX_Tool.Infos.Image;

   type Line_Pos is record
      Line : Line_Number := 1;
      Pos  : Buffer_Index;
   end record;

   type Token_Type (Len : Buffer_Size) is tagged limited private;
   type Token_Access is access all Token_Type'Class;

   type License_Match is record
      Info  : Infos.License_Info;
      Last  : Token_Access;
      Depth : Natural := 0;
   end record;

   type License_Template is record
      Root   : Token_Access;
      Name   : UString;
      --  Tokens : SPDX_Tool.Buffer_Sets.Set;
   end record;

   type Name_Array is array (License_Index range <>) of Name_Access;

   subtype Token_Count_Type is SPDX_Tool.Counter_Arrays.Cell_Type;
   subtype Token_Array is SPDX_Tool.Counter_Arrays.Cell_Array_Type;
   type Token_Array_Access is access constant Token_Array;
   type Position is new Natural range 0 .. 255;
   for Position'Size use 8;
   type Position_Array is array (Token_Index range <>) of Position;
   type License_Array is array (License_Index range <>) of Token_Array_Access;

   type Index_Type is record
      Token : Token_Index;
      List  : License_Index_Array_Access;
   end record;
   type Token_Index_Array is array (Token_Index range <>) of Index_Type;

   function "<" (Left, Right : Index_Type) return Boolean
      is (Left.Token < Right.Token);
   overriding
   function "=" (Left, Right : Index_Type) return Boolean
      is (Left.Token = Right.Token);
   function Middle (Low, High : Token_Index) return Token_Index
      is ((High + Low) / 2);

   package Algorithms is
      new Util.Algorithms.Arrays (Element_Type => Index_Type,
                                  Index_Type => Token_Index,
                                  Array_Type => Token_Index_Array,
                                  Middle => Middle);

   function Is_Loaded (License : in License_Template)
                       return Boolean is (License.Root /= null);

   --  Collect in the Tokens set, the list of tokens used by the license text.
   procedure Collect_License_Tokens (License : in Token_Access;
                                     Tokens  : in out Buffer_Sets.Set);

   type License_Template_Array is array (License_Index range <>) of License_Template;

   package Count_Maps is new Ada.Containers.Indefinite_Ordered_Maps
     (Key_Type     => String,
      Element_Type => Natural);

   type Content_Access is access constant Buffer_Type;

   type License_Info is record
      First_Line : Natural := 0;
      Last_Line  : Natural := 0;
      Name       : UString;
   end record;

   procedure Performance_Report;

   type Token_Kind is (TOK_WORD,
                       TOK_COPYRIGHT,
                       TOK_OPTIONAL,
                       TOK_VAR,
                       TOK_LICENSE,
                       TOK_END_OPTIONAL,
                       TOK_END);

   --  Get a printable representation of a list of licenses.
   function To_String (List : in License_Index_Array) return String;

private

   function Get_License_Name (License : in License_Index) return String;

   function Skip_Spaces (Content : in Buffer_Type;
                         Lines   : in Line_Array;
                         From    : in Line_Pos;
                         To      : in Line_Pos) return Line_Pos;

   --  The license templates are read within a tree of tokens.  To find a
   --  license match, the license text in the source file header is split in
   --  tokens and we start from the license manager root token.  We move to
   --  the next token if there is a match.  We look for alternate tokens when
   --  there is no match.  Some special tokens exists to check optional matches
   --  or to match regular expressions.  The license token tree look like:
   --
   --  Tokens -> "Copyright" [Next] -> "(c)" -> ".*" -> ...
   --                | [Alternate]
   --            "Licensed"  -> "under" -> "the" -> "Apache" -> ...
   --                                                  |
   --                                               "Open" -> ...
   --
   --  While matching tokens we try to take into account the SPDX license
   --  match recommendations:
   --  - spaces are ignored,
   --  - punctuation must match,
   --  - Copyright, (c) and "©" are considered identical,

   type Token_Type (Len : Buffer_Size) is tagged limited record
      Next      : Token_Access;
      Previous  : Token_Access;
      Alternate : Token_Access;
      Content   : Buffer_Type (1 .. Len);
   end record;

   procedure Match (Token   : in Token_Access;
                    Content : in Buffer_Type;
                    Lines   : in Line_Array;
                    From    : in Line_Pos;
                    Last    : in Line_Pos;
                    Result  : out Line_Pos;
                    Next    : out Token_Access);

   procedure Matches (Token   : in Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access);

   function Kind (Token : in Token_Type)
                  return Token_Kind is (TOK_WORD);

   function Depth (Token : in Token_Type'Class) return Natural;

   type Any_Token_Type (Len : Buffer_Size)
   is new Token_Type (Len) with record
      Max_Length : Buffer_Size;
   end record;

   overriding
   function Kind (Token : in Any_Token_Type)
                  return Token_Kind is (TOK_VAR);

   overriding
   procedure Matches (Token   : in Any_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access);

   type Regpat_Token_Type (Len  : Buffer_Size;
                           Plen : GNAT.Regpat.Program_Size)
   is new Token_Type (Len) with record
      Pattern   : GNAT.Regpat.Pattern_Matcher (Plen);
   end record;

   overriding
   function Kind (Token : in Regpat_Token_Type)
                  return Token_Kind is (TOK_VAR);

   overriding
   procedure Matches (Token   : in Regpat_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access);

   type Optional_Token_Type is new Token_Type (Len => 0) with record
      Optional : Token_Access;
   end record;
   type Optional_Token_Access is access all Optional_Token_Type;

   overriding
   function Kind (Token : in Optional_Token_Type)
                  return Token_Kind is (TOK_OPTIONAL);

   overriding
   procedure Matches (Token   : in Optional_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access);

   type Final_Token_Type (Len : Buffer_Size)
   is new Token_Type (Len) with record
      License   : UString;
   end record;

   overriding
   function Kind (Token : in Final_Token_Type)
                  return Token_Kind is (TOK_LICENSE);

   --  Find in the header comment an SPDX license tag.
   function Look_SPDX_License (Content : in Buffer_Type;
                                Lines   : in SPDX_Tool.Languages.Line_Array;
                                From    : in Line_Number;
                                To      : in Line_Number)
                               return License_Match
      with Pre => From <= To;

   function Look_License (License : in License_Index;
                          File    : in SPDX_Tool.Files.File_Type;
                          From    : in Line_Number;
                          To      : in Line_Number)
                          return License_Match;

   function Look_License_Tree (Root    : in Token_Access;
                               Content : in Buffer_Type;
                               Lines   : in SPDX_Tool.Languages.Line_Array;
                               From    : in Line_Number;
                               To      : in Line_Number)
                           return License_Match;

   Perf : aliased Util.Measures.Measure_Set;

   procedure Report (Stamp : in out Util.Measures.Stamp;
                     Title : in String;
                     Count : in Positive := 1);

end SPDX_Tool.Licenses;
