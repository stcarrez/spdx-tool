-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Streams;
with Ada.Strings.Unbounded;
with Util.Blobs;
with Intl;
with Interfaces;
package SPDX_Tool is

   use Ada.Streams;

   subtype Byte is Stream_Element;
   subtype Buffer_Size is Stream_Element_Offset range 0 .. Stream_Element_Offset'Last;
   subtype Buffer_Index is Stream_Element_Offset range 1 .. Stream_Element_Offset'Last;
   subtype Buffer_Type is Stream_Element_Array;

   subtype Buffer_Ref is Util.Blobs.Blob_Ref;
   subtype Buffer_Accessor is Util.Blobs.Blob_Accessor;
   function Create_Buffer (Content : in String) return Buffer_Ref renames Util.Blobs.Create_Blob;
   function Create_Buffer (Size : in Natural) return Buffer_Ref renames Util.Blobs.Create_Blob;
   Null_Buffer : constant Buffer_Ref := Util.Blobs.Null_Blob;

   type Content_Access is access constant String;

   type Comment_Type is (COMMENT_C, COMMENT_CPP, COMMENT_ADA);

   subtype UString is Ada.Strings.Unbounded.Unbounded_String;

   function To_UString (S : String) return UString
      renames Ada.Strings.Unbounded.To_Unbounded_String;
   function To_String (S : UString) return String
      renames Ada.Strings.Unbounded.To_String;
   function Length (S : UString) return Natural
      renames Ada.Strings.Unbounded.Length;

   function To_Buffer (S : String) return Buffer_Type;
   function To_Buffer (S : UString) return Buffer_Type;

   function "-" (M : in String) return String renames Intl."-";

   subtype Task_Count is Positive range 1 .. 32;

   type Name_Access is access constant String;

   MAX_LICENSE_COUNT : constant := 768;

   type License_Index is new Natural range 0 .. MAX_LICENSE_COUNT - 1;
   type Count_Type is new Natural range 0 .. 65_535;
   for Count_Type'Size use 16;

   function Increment (Value : in Count_Type) return Count_Type is (Value + 1);

   type Token_Index is new Positive range 1 .. 65_535;
   for Token_Index'Size use 16;

   type License_Index_Array is array (Positive range <>) of License_Index;
   type License_Index_Array_Access is access constant License_Index_Array;

   type License_Bitmap is new Interfaces.Unsigned_32;
   type License_Bitmap_Index is new Natural range 0 .. MAX_LICENSE_COUNT / 32;
   type License_Index_Map is array (License_Bitmap_Index) of License_Bitmap;

   EMPTY_MAP : constant License_Index_Map := (others => 0);

   procedure Set_License (Into    : in out License_Index_Map;
                          License : in License_Index);
   procedure Set_Licenses (Into : in out License_Index_Map;
                           List : in License_Index_Array);
   procedure And_Licenses (Into : in out License_Index_Map;
                           List : in License_Index_Array);
   procedure And_Licenses (Into : in out License_Index_Map;
                           Map  : in License_Index_Map);
   function Is_Set (From    : in License_Index_Map;
                    License : in License_Index) return Boolean;
   function Is_Empty (Map : in License_Index_Map) return Boolean
      is (for some V of Map => V /= 0);
   function Get_Count (Map : in License_Index_Map) return Natural;
   function To_License_Index_Array (Map : in License_Index_Map) return License_Index_Array;

private

   procedure Configure_Logs (Debug : Boolean; Verbose : Boolean; Verbose2 : Boolean);

   Opt_Debug     : aliased Boolean := False;
   Opt_Verbose   : aliased Boolean := False;
   Opt_Verbose2  : aliased Boolean := False;
   Opt_Version   : aliased Boolean := False;
   Opt_Check     : aliased Boolean := False;
   Opt_Update    : aliased Boolean := False;
   Opt_Files     : aliased Boolean := False;
   Opt_Mimes     : aliased Boolean := False;
   Opt_Languages : aliased Boolean := False;
   Opt_No_Color  : aliased Boolean := False;
   Opt_Print     : aliased Boolean := False;
   Opt_Identify  : aliased Boolean := False;
   Opt_Help      : aliased Boolean := False;
   Opt_Print_Lineno : aliased Boolean := False;
   Opt_Tasks     : aliased Integer := 1;

   LF          : constant Byte := 16#0A#;
   CR          : constant Byte := 16#0D#;
   SPACE       : constant Byte := 16#20#;
   TAB         : constant Byte := 16#09#;
   OPEN_PAREN  : constant Byte := Character'Pos ('(');
   CLOSE_PAREN : constant Byte := Character'Pos (')');

   --  UTF-8 special 3-byte codes that represent space or punctuation:
   --  * General punctuation: 0x2000-0x206F            0xE2 0x80..0x81 0x80..0xBF
   --  * Currency symbols: 0x20A0-0x20CF
   --  * CJK Symbols and Punctuation: 0x3000-0x303F    0xE3 0x80 0x80..0xBF
   --  * Halfwidth and Fullwidth Forms: 0xFF00-0xFFEF  0xEF 0xBC 0x9A
   function Is_Utf8_Special_3 (C : Byte) return Boolean is (C in 16#E2# | 16#E3# | 16#EF#);

   --  UTF-8 special 2-byte code
   function Is_Utf8_Special_2 (C : Byte) return Boolean is (C in 16#C2#);

   function Is_Space (C : Byte) return Boolean is (C in SPACE | TAB | CR | LF);

   function Is_Space_Or_Punctuation (C : Byte) return Boolean is
      (C in
       SPACE | TAB | CR | LF | Character'Pos (':') | Character'Pos (',')
       | Character'Pos ('.') | Character'Pos (';') | Character'Pos ('!')
       | Character'Pos ('(') | Character'Pos (')') | Character'Pos ('-')
       | Character'Pos ('"') | Character'Pos ('''));

   function Is_Eol (C : Byte) return Boolean is (C in CR | LF);

   function Is_Comment_Presentation (C : Byte) return Boolean is
      (C in Character'Pos ('*') | Character'Pos ('-') | Character'Pos ('+'));

   --  Check if there is a space in the buffer starting at `First` position
   --  and return its length.  Returns 0 when there is no space.
   function Space_Length
      (Buffer : in Buffer_Type; First : in Buffer_Index; Last : in Buffer_Index)
       return Buffer_Size with
      Pre => First <= Last and then First >= Buffer'First and then Last <= Buffer'Last;

   --  Check if there is a punctuation code in the buffer starting at `First` position
   --  and return its length.  Returns 0 when there is no punctuation code.
   function Punctuation_Length
      (Buffer : in Buffer_Type; First : in Buffer_Index; Last : in Buffer_Index)
       return Buffer_Size with
      Pre => First <= Last and then First >= Buffer'First and then Last <= Buffer'Last;

   --  Find index of the first non white space after first and up to last.
   function Skip_Spaces
      (Buffer : in Buffer_Type; First : in Buffer_Index; Last : in Buffer_Index)
       return Buffer_Index with
      Pre => First <= Last and then First >= Buffer'First and then Last <= Buffer'Last;

   --  Find backward index of the first non white space before last.
   function Skip_Backward_Spaces
      (Buffer : in Buffer_Type; First : in Buffer_Index; Last : in Buffer_Index)
       return Buffer_Index with
      Pre => First <= Last and then First >= Buffer'First and then Last <= Buffer'Last;

   --  Skip an optional presentation marker at beginning of a line.
   --  Presentation markers include '*', '-' and may be repeated several times.
   --  Then, spaces are skipped.  Example of presentation:
   --    *
   --    **
   --    *-*
   --    **
   --    --
   function Skip_Presentation
      (Buffer : in Buffer_Type; First : in Buffer_Index; Last : in Buffer_Index)
       return Buffer_Index with
      Pre => First <= Last and then First >= Buffer'First and then Last <= Buffer'Last;

   function Next_Space
      (Buffer : in Buffer_Type; First : in Buffer_Index; Last : in Buffer_Index)
       return Buffer_Index with
      Pre => First <= Last and then
       First >= Buffer'First and then Last <= Buffer'Last;

   --  Move to the next position after the text if the buffer matches.
   function Next_With
      (Buffer : in Buffer_Type; From : in Buffer_Index; Text : in String)
       return Buffer_Index with
      Pre => From >= Buffer'First and then From <= Buffer'Last and then Text'Length > 0;

   --  Find index position of one character in text in the buffer and starting
   --  at the given position.  Returns 0 if not found.
   function Index_Any_Of
      (Buffer : in Buffer_Type; From : in Buffer_Index; Last : in Buffer_Index; Text : in String)
      return Buffer_Size with
      Pre => From >= Buffer'First and then From <= Buffer'Last and then Text'Length > 0;

   --  Find the end of line.
   function Find_Eol
      (Buffer : in Buffer_Type; From : in Buffer_Index) return Buffer_Index with
      Pre => From >= Buffer'First and then From <= Buffer'Last;

   --  Find the next '"' after the `From` position.
   function Find_String_End (Content : in Buffer_Type;
                             From    : in Buffer_Index;
                             Last    : in Buffer_Index) return Buffer_Index with
      Pre => From >= Content'First and then From <= Content'Last;

   --  Guess the printable length of the content assuming UTF-8 sequence.
   function Printable_Length
      (Buffer : in Buffer_Type; From : in Buffer_Index; Last : in Buffer_Index)
       return Natural with
      Pre => From >= Buffer'First and then Last <= Buffer'Last;

   function To_String (Buffer : in Buffer_Type) return String;
   function To_UString (Buffer : in Buffer_Type) return UString;

end SPDX_Tool;
