-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Log.Loggers;
with Util.Properties;
package body SPDX_Tool is

   procedure Configure_Logs (Debug : Boolean; Verbose : Boolean) is
      Log_Config  : Util.Properties.Manager;
   begin
      Log_Config.Set ("log4j.rootCategory", "DEBUG,errorConsole");
      Log_Config.Set ("log4j.appender.errorConsole", "Console");
      Log_Config.Set ("log4j.appender.errorConsole.level", "ERROR");
      Log_Config.Set ("log4j.appender.errorConsole.layout", "message");
      Log_Config.Set ("log4j.appender.errorConsole.stderr", "true");
      Log_Config.Set ("log4j.appender.errorConsole.prefix", "spdx-tool: ");
      Log_Config.Set ("log4j.logger.Util", "DEBUG");
      Log_Config.Set ("log4j.logger.Util.Events", "ERROR");
      Log_Config.Set ("log4j.logger.SPDX_Tool", "INFO");
      if Verbose or Debug then
         Log_Config.Set ("log4j.logger.Util", "DEBUG");
         Log_Config.Set ("log4j.logger.Are", "INFO");
         Log_Config.Set ("log4j.rootCategory", "INFO,errorConsole,verbose");
         Log_Config.Set ("log4j.appender.verbose", "Console");
         Log_Config.Set ("log4j.appender.verbose.level", "INFO");
         Log_Config.Set ("log4j.appender.verbose.layout", "level-message");
      end if;
      if Debug then
         Log_Config.Set ("log4j.logger.Util.Processes", "INFO");
         Log_Config.Set ("log4j.logger.SPDX_Tool", "DEBUG");
         Log_Config.Set ("log4j.rootCategory", "DEBUG,errorConsole,debug");
         Log_Config.Set ("log4j.appender.debug", "Console");
         Log_Config.Set ("log4j.appender.debug.level", "DEBUG");
         Log_Config.Set ("log4j.appender.debug.layout", "full");
      end if;

      Util.Log.Loggers.Initialize (Log_Config);
   end Configure_Logs;

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

            --  2 byte sequence: 0xA0
         when 16#C2# =>
            return (if First + 1 <= Last
                    and then Buffer (First + 1) = 16#A0# then 2 else 0);

            --  3 byte sequenes: 0x2000..0x200A
         when 16#E2# =>
            return (if First + 2 <= Last and then Buffer (First + 1) = 16#80#
                    and then Buffer (First + 2) >= 16#82#
                    and then Buffer (First + 2) <= 16#8A# then 3 else 0);

            --  3 byte sequences: 0x3000
         when 16#E3# =>
            return (if First + 2 <= Last and then Buffer (First + 1) = 16#80#
                    and then Buffer (First + 2) = 16#80# then 3 else 0);

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

            --  2 byte sequence: 0xA0
         when 16#C2# =>
            return (if First + 1 <= Last
                    and then Buffer (First + 1) = 16#A0# then 2 else 0);

            --  3 byte sequenes: 0x2000..0x206F
         when 16#E2# =>
            return 3;

            --  3 byte sequences: 0x3000..0x303F
         when 16#E3# =>
            return 3;

            --  3 byte sequences: 0xFF00..0xFFEF
         when 16#EF# =>
            return 3;

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
      if Pos < Last and then not Is_Space (Buffer (Pos))
        and then not Is_Utf8_Special_3 (Buffer (Pos))
      then
         Pos := Pos + 1;
      end if;
      while Pos < Last loop
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
      return Pos;
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

   --  Find the end of line.
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

   function To_UString (Buffer : in Buffer_Type) return UString is
      Content : String (1 .. Buffer'Length);
      for Content'Address use Buffer'Address;
   begin
      return To_UString (Content);
   end To_UString;

end SPDX_Tool;
