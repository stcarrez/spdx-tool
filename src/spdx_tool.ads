-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Streams;
with Ada.Strings.Unbounded;
with Util.Blobs;
package SPDX_Tool is

   use Ada.Streams;

   subtype Byte is Stream_Element;
   subtype Buffer_Size is Stream_Element_Offset range 0 .. Stream_Element_Offset'Last;
   subtype Buffer_Index is Stream_Element_Offset range 1 .. Stream_Element_Offset'Last;
   subtype Buffer_Type is Stream_Element_Array;

   subtype Buffer_Ref is Util.Blobs.Blob_Ref;
   subtype Buffer_Accessor is Util.Blobs.Blob_Accessor;
   function Create_Buffer (Content : in String) return Buffer_Ref
                           renames Util.Blobs.Create_Blob;
   function Create_Buffer (Size : in Natural) return Buffer_Ref
                           renames Util.Blobs.Create_Blob;
   Null_Buffer : constant Buffer_Ref := Util.Blobs.Null_Blob;

   type Range_Index is record
      First, Last : Buffer_Index := 0;
   end record;
   type Range_Array is array (Positive range <>) of Range_Index;

   type Comment_Type is (COMMENT_C, COMMENT_CPP, COMMENT_ADA);

   subtype UString is Ada.Strings.Unbounded.Unbounded_String;

   function To_UString (S : String) return UString
                        renames Ada.Strings.Unbounded.To_Unbounded_String;
   function To_String (S : UString) return String
                       renames Ada.Strings.Unbounded.To_String;
   function Length (S : UString) return Natural
                    renames Ada.Strings.Unbounded.Length;

   function "-" (M : in String) return String is (M);

   subtype Task_Count is Positive range 1 .. 32;

private

   procedure Configure_Logs (Debug : Boolean; Verbose : Boolean);

   Opt_Debug    : aliased Boolean := False;
   Opt_Verbose  : aliased Boolean := False;
   Opt_Version  : aliased Boolean := False;
   Opt_Check    : aliased Boolean := False;
   Opt_Update   : aliased Boolean := False;
   Opt_Files    : aliased Boolean := False;
   Opt_No_Color : aliased Boolean := False;
   Opt_Tasks    : aliased Integer := 1;

   LF    : constant Byte := 16#0A#;
   CR    : constant Byte := 16#0D#;
   SPACE : constant Byte := 16#20#;
   TAB   : constant Byte := 16#09#;

   function Is_Space (C : Byte)
                      return Boolean is (C in SPACE | TAB | CR | LF);

   function Is_Eol (C : Byte)
                      return Boolean is (C in CR | LF);

   --  Find index of the first non white space after first and up to last.
   function Skip_Spaces (Buffer : in Buffer_Type;
                         First  : in Buffer_Index;
                         Last   : in Buffer_Index) return Buffer_Index
     with Pre => First <= Last and then First >= Buffer'First
     and then Last <= Buffer'Last;

   function Next_Space (Buffer : in Buffer_Type;
                        First  : in Buffer_Index;
                        Last   : in Buffer_Index) return Buffer_Index
     with Pre => First <= Last and then First >= Buffer'First
     and then Last <= Buffer'Last;

   --  Move to the next position after the text if the buffer matches.
   function Next_With (Buffer : in Buffer_Type;
                       From   : in Buffer_Index;
                       Text   : in String) return Buffer_Index
     with Pre => From >= Buffer'First and then From <= Buffer'Last
     and then Text'Length > 0;

   --  Find the end of line.
   function Find_Eol (Buffer : in Buffer_Type;
                      From   : in Buffer_Index) return Buffer_Index
     with Pre => From >= Buffer'First and then From <= Buffer'Last;

   function To_UString (Buffer : in Buffer_Type) return UString;

end SPDX_Tool;
