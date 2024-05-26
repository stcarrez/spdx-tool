-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Finalization;
with Util.Log.Loggers;
with Util.Log.Formatters.Factories;
with Util.Properties;
with Util.Strings.Builders;
package body SPDX_Tool is

   use Interfaces;
   use Util.Log.Formatters;
   function Get_Count (V : in Interfaces.Unsigned_8) return Natural;

   type NLS_Formatter (Length : Positive) is
      new Util.Log.Formatters.Formatter (Length) with null record;

   --  Format the message with the list of arguments.
   overriding
   procedure Format (Format    : in NLS_Formatter;
                     Into      : in out Util.Strings.Builders.Builder;
                     Level     : in Util.Log.Level_Type;
                     Logger    : in String;
                     Message   : in String;
                     Arguments : in String_Array_Access);

   function Create_Formatter (Name    : in String;
                              Config  : in Util.Properties.Manager) return Formatter_Access;

   --  Format the message with the list of arguments.
   overriding
   procedure Format (Format    : in NLS_Formatter;
                     Into      : in out Util.Strings.Builders.Builder;
                     Level     : in Util.Log.Level_Type;
                     Logger    : in String;
                     Message   : in String;
                     Arguments : in String_Array_Access) is
   begin
      if Level >= Util.Log.INFO_LEVEL then
         Formatter (Format).Format (Into, Level, Logger, -(Message), Arguments);
      else
         Formatter (Format).Format (Into, Level, Logger, Message, Arguments);
      end if;
   end Format;

   --  ------------------------------
   --  Create a formatter instance with a factory with the given name.
   --  ------------------------------
   function Create_Formatter (Name    : in String;
                              Config  : in Util.Properties.Manager) return Formatter_Access is
      pragma Unreferenced (Config);

      Result : constant Formatter_Access
        := new NLS_Formatter '(Ada.Finalization.Limited_Controlled with Length => Name'Length,
                               Name => Name,
                               others => <>);
   begin
      return Result.all'Access;
   end Create_Formatter;

   package Formatter_Factory is
      new Util.Log.Formatters.Factories (Name   => "NLS",
                                         Create => Create_Formatter'Access)
                                          with Unreferenced;

   procedure Set_License (Into    : in out License_Index_Map;
                          License : in License_Index) is
      Pos : constant License_Bitmap_Index := License_Bitmap_Index (License / 32);
      Bit : constant Natural := Natural (License mod 32);
   begin
      Into (Pos) := Into (Pos) or License_Bitmap (Shift_Left (Unsigned_32 (1), Bit));
   end Set_License;

   procedure Set_Licenses (Into : in out License_Index_Map;
                           List : in License_Index_Array) is
   begin
      for License of List loop
         Set_License (Into, License);
      end loop;
   end Set_Licenses;

   procedure And_Licenses (Into : in out License_Index_Map;
                           List : in License_Index_Array) is
      New_List : License_Index_Map := EMPTY_MAP;
   begin
      Set_Licenses (New_List, List);
      for I in Into'Range loop
         Into (I) := Into (I) and New_List (I);
      end loop;
   end And_Licenses;

   procedure And_Licenses (Into : in out License_Index_Map;
                           Map  : in License_Index_Map) is
   begin
      for I in Into'Range loop
         Into (I) := Into (I) and Map (I);
      end loop;
   end And_Licenses;

   function Get_Count (V : in Interfaces.Unsigned_8) return Natural is
      Count : Natural := 0;
      Mask  : Unsigned_8 := 1;
      Val   : Unsigned_8 := V;
   begin
      while Val /= 0 loop
         if (Val and Mask) /= 0 then
            Count := Count + 1;
            Val := Val xor Mask;
         end if;
         Mask := Shift_Left (Mask, 1);
      end loop;
      return Count;
   end Get_Count;

   function Is_Set (From    : in License_Index_Map;
                    License : in License_Index) return Boolean is
      Pos : constant License_Bitmap_Index := License_Bitmap_Index (License / 32);
      Bit : constant Natural := Natural (License mod 32);
   begin
      return (From (Pos) and License_Bitmap (Shift_Left (Unsigned_32 (1), Bit))) /= 0;
   end Is_Set;

   function Get_Count (Map : in License_Index_Map) return Natural is
      Result : Natural := 0;
   begin
      for V of Map loop
         if V /= 0 then
            Result := Result + Get_Count (Unsigned_8 (V and 16#ff#));
            Result := Result + Get_Count (Unsigned_8 (Shift_Right (V, 8) and 16#ff#));
            Result := Result + Get_Count (Unsigned_8 (Shift_Right (V, 16) and 16#ff#));
            Result := Result + Get_Count (Unsigned_8 (Shift_Right (V, 24) and 16#ff#));
         end if;
      end loop;
      return Result;
   end Get_Count;

   function To_License_Index_Array (Map : in License_Index_Map) return License_Index_Array is
      Count  : constant Natural := Get_Count (Map);
      Result : License_Index_Array (1 .. Count);
      Pos    : Positive := 1;
      V      : License_Bitmap;
   begin
      for I in Map'Range loop
         V := Map (I);
         if V /= 0 then
            declare
               Bit_Pos : Natural := 0;
               Mask    : License_Bitmap := 1;
            begin
               loop
                  if (V and Mask) /= 0 then
                     Result (Pos) := License_Index (Natural (I) * 32 + Bit_Pos);
                     Pos := Pos + 1;
                     V := V xor Mask;
                     exit when V = 0;
                  end if;
                  Mask := License_Bitmap (Shift_Left (Unsigned_32 (Mask), 1));
                  Bit_Pos := Bit_Pos + 1;
               end loop;
            end;
         end if;
      end loop;
      return Result;
   end To_License_Index_Array;

   procedure Configure_Logs (Debug : Boolean; Verbose : Boolean) is
      Log_Config  : Util.Properties.Manager;
   begin
      Log_Config.Set ("spdx_tool.rootCategory", "DEBUG,errorConsole");
      Log_Config.Set ("spdx_tool.appender.errorConsole", "Console");
      Log_Config.Set ("spdx_tool.appender.errorConsole.level", "ERROR");
      Log_Config.Set ("spdx_tool.appender.errorConsole.layout", "message");
      Log_Config.Set ("spdx_tool.appender.errorConsole.stderr", "true");
      Log_Config.Set ("spdx_tool.appender.errorConsole.prefix", "spdx-tool: ");
      Log_Config.Set ("spdx_tool.logger.Util", "DEBUG");
      Log_Config.Set ("spdx_tool.logger.Util.Events", "ERROR");
      Log_Config.Set ("spdx_tool.logger.SPDX_Tool", "INFO:NLS");
      if Verbose or Debug then
         Log_Config.Set ("spdx_tool.logger.Util", "DEBUG");
         Log_Config.Set ("spdx_tool.rootCategory", "INFO,errorConsole,verbose");
         Log_Config.Set ("spdx_tool.appender.verbose", "Console");
         Log_Config.Set ("spdx_tool.appender.verbose.level", "INFO");
         Log_Config.Set ("spdx_tool.appender.verbose.layout", "level-message");
      end if;
      if Debug then
         Log_Config.Set ("spdx_tool.logger.Util.Processes", "INFO");
         Log_Config.Set ("spdx_tool.logger.SPDX_Tool", "DEBUG");
         Log_Config.Set ("spdx_tool.rootCategory", "DEBUG,errorConsole,debug");
         Log_Config.Set ("spdx_tool.appender.debug", "Console");
         Log_Config.Set ("spdx_tool.appender.debug.level", "DEBUG");
         Log_Config.Set ("spdx_tool.appender.debug.layout", "full");
      end if;

      Util.Log.Loggers.Initialize (Log_Config, "spdx_tool.");
   end Configure_Logs;

   function To_Buffer (S : String) return Buffer_Type is
      Data   : Buffer_Type (Buffer_Index (S'First) .. Buffer_Index (S'Last));
      for Data'Address use S'Address;
   begin
      return Data;
   end To_Buffer;

   function To_Buffer (S : UString) return Buffer_Type is
      Result : String := To_String (S);
      Data   : Buffer_Type (Buffer_Index (Result'First) .. Buffer_Index (Result'Last));
      for Data'Address use Result'Address;
   begin
      return Data;
   end To_Buffer;

   --  ------------------------------
   --  Check if there is a space in the buffer starting at `First` position
   --  and return its length.  Returns 0 when there is no space.
   --  ------------------------------
   function Space_Length (Buffer : in Buffer_Type;
                          First  : in Buffer_Index;
                          Last   : in Buffer_Index) return Buffer_Size is
   begin
      if First > Last then
         return 0;
      end if;
      case Buffer (First) is
         when SPACE | TAB | LF | CR =>
            return 1;

            --  2 byte sequence: 0xA0 (assume space if we reached end of buffer).
         when 16#C2# =>
            return (if First = Last then 1
                    else (if Buffer (First + 1) = 16#A0# then 2 else 0));

            --  3 byte sequenes: 0x2000..0x200A (assume space if we reached end of buffer).
         when 16#E2# =>
            return (if First = Last then 1
                    else (if Buffer (First + 1) /= 16#80# then 0
                          else (if First + 1 = Last then 2
                                else (if Buffer (First + 2) >= 16#82#
                                      and then Buffer (First + 2) <= 16#8A# then 3 else 0))));

            --  3 byte sequences: 0x3000 (assume space if we reached end of buffer).
         when 16#E3# =>
            return (if First = Last then 1
                    else (if Buffer (First + 1) /= 16#80# then 0
                          else (if First + 1 = Last then 2
                                else (if Buffer (First + 2) = 16#80# then 3 else 0))));

         when others =>
            return 0;
      end case;
   end Space_Length;

   --  ------------------------------
   --  Check if there is a punctuation code in the buffer starting at `First` position
   --  and return its length.  Returns 0 when there is no punctuation code.
   --  ------------------------------
   function Punctuation_Length (Buffer : in Buffer_Type;
                                First  : in Buffer_Index;
                                Last   : in Buffer_Index) return Buffer_Size is
   begin
      if First > Last then
         return 0;
      end if;
      case Buffer (First) is
         when Character'Pos (':') | Character'Pos (',') | Character'Pos ('.')
            | Character'Pos (';') | Character'Pos ('!') | Character'Pos ('?')
            | Character'Pos ('(') | Character'Pos (')') | Character'Pos ('[')
            | Character'Pos (']') | Character'Pos ('`') | Character'Pos (''')
            | Character'Pos ('"') | Character'Pos ('-') | Character'Pos ('+')
            | Character'Pos ('*') | Character'Pos ('=') | Character'Pos ('<')
            | Character'Pos ('>') | Character'Pos ('#') | Character'Pos ('$')
            | Character'Pos ('%') | Character'Pos ('^') | Character'Pos ('&')
            | Character'Pos ('@') | Character'Pos ('/') | Character'Pos ('\') =>
            return 1;

            --  2 byte sequence: 0xA0 (assume punctuation if we reach end of buffer)
         when 16#C2# =>
            return (if First = Last then 1
                    else (if Buffer (First + 1) = 16#A0# then 2 else 0));

            --  3 byte sequenes: 0x2000..0x206F
         when 16#E2# =>
            return (if First + 2 <= Last then 3 else Last - First + 1);

            --  3 byte sequences: 0x3000..0x303F
         when 16#E3# =>
            return (if First + 2 <= Last then 3 else Last - First + 1);

            --  3 byte sequences: 0xFF00..0xFFEF
         when 16#EF# =>
            return (if First + 2 <= Last then 3 else Last - First + 1);

         when others =>
            return 0;
      end case;
   end Punctuation_Length;

   function Skip_Spaces (Buffer : in Buffer_Type;
                         First  : in Buffer_Index;
                         Last   : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := First;
      Len : Buffer_Size;
   begin
      while Pos <= Last loop
         Len := Space_Length (Buffer, Pos, Last);
         exit when Len = 0;
         Pos := Pos + Len;
      end loop;
      return Pos;
   end Skip_Spaces;

   function Skip_Backward_Spaces (Buffer : in Buffer_Type;
                                  First  : in Buffer_Index;
                                  Last   : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := Last;
   begin
      while Pos >= First and then Is_Space (Buffer (Pos)) loop
         Pos := Pos - 1;
      end loop;
      return Pos;
   end Skip_Backward_Spaces;

   function Skip_Presentation (Buffer : in Buffer_Type;
                               First  : in Buffer_Index;
                               Last   : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := First;
   begin
      if Is_Space (Buffer (Pos)) then
         Pos := Skip_Spaces (Buffer, Pos, Last);
      end if;
      while Pos <= Last and then Is_Comment_Presentation (Buffer (Pos)) loop
         Pos := Pos + 1;
      end loop;
      if Pos <= Last then
         Pos := Skip_Spaces (Buffer, Pos, Last);
      end if;
      return Pos;
   end Skip_Presentation;

   function Next_Space (Buffer : in Buffer_Type;
                        First  : in Buffer_Index;
                        Last   : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := First;
      Len : Buffer_Size;
   begin
      Len := Space_Length (Buffer, Pos, Last);
      if Len = 0 then
         Len := Punctuation_Length (Buffer, Pos, Last);
         if Len > 0 then
            Pos := Pos + Len;
         elsif Pos = Last then
            return Pos;
         else
            Pos := Pos + 1;
         end if;
      end if;
      while Pos <= Last loop
         Len := Space_Length (Buffer, Pos, Last);
         if Len > 0 then
            return Pos - 1;
         end if;
         Len := Punctuation_Length (Buffer, Pos, Last);
         if Len > 0 then
            return Pos - 1;
         else
            Pos := Pos + 1;
         end if;
      end loop;
      return Pos - 1;
   end Next_Space;

   --  ------------------------------
   --  Move to the next position after the text if the buffer matches.
   --  ------------------------------
   function Next_With (Buffer : in Buffer_Type;
                       From   : in Buffer_Index;
                       Text   : in String) return Buffer_Index is
      Last   : constant Buffer_Index := From + Text'Length - 1;
      Expect : Buffer_Type (1 .. Text'Length);
      for Expect'Address use Text'Address;
   begin
      if Last > Buffer'Last or else Buffer (From .. Last) /= Expect then
         return From;
      else
         return Last + 1;
      end if;
   end Next_With;

   --  Find index position of one character in text in the buffer and starting
   --  at the given position.  Returns 0 if not found.
   function Index_Any_Of (Buffer : in Buffer_Type;
                          From   : in Buffer_Index;
                          Last   : in Buffer_Index;
                          Text   : in String) return Buffer_Size is
      Pos : Buffer_Index := From;
   begin
      while Pos <= Last loop
         declare
            C : constant Character := Character'Val (Buffer (Pos));
         begin
            if (for some T of Text => C = T) then
               return Pos;
            end if;
            Pos := Pos + 1;
         end;
      end loop;
      return 0;
   end Index_Any_Of;

   --  ------------------------------
   --  Find the end of line.
   --  ------------------------------
   function Find_Eol (Buffer : in Buffer_Type;
                      From : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := From;
   begin
      while Pos < Buffer'Last and then not Is_Eol (Buffer (Pos)) loop
         Pos := Pos + 1;
      end loop;
      return Pos;
   end Find_Eol;

   --  ------------------------------
   --  Find the next '"' after the `From` position.
   --  ------------------------------
   function Find_String_End (Content : in Buffer_Type;
                             From    : in Buffer_Index;
                             Last    : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := From;
   begin
      while Pos < Last and then Content (Pos) /= Character'Pos ('"') loop
         Pos := Pos + 1;
      end loop;
      return Pos;
   end Find_String_End;

   --  ------------------------------
   --  Guess the printable length of the content assuming UTF-8 sequence.
   --  ------------------------------
   function Printable_Length (Buffer : in Buffer_Type;
                              From   : in Buffer_Index;
                              Last   : in Buffer_Index) return Natural is
      Count : Natural := 0;
      Pos   : Buffer_Index := From;
      Val   : Byte;
   begin
      while Pos <= Last loop
         Val := Buffer (Pos);
         Pos := Pos + 1;
         if Val >= 16#C0# or else Val < 16#80# then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Printable_Length;

   function To_String (Buffer : in Buffer_Type) return String is
      Content : String (1 .. Buffer'Length);
      for Content'Address use Buffer'Address;
   begin
      return Content;
   end To_String;

   function To_UString (Buffer : in Buffer_Type) return UString is
      Content : String (1 .. Buffer'Length);
      for Content'Address use Buffer'Address;
   begin
      return To_UString (Content);
   end To_UString;

end SPDX_Tool;
