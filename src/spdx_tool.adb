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

   function Skip_Spaces (Buffer : in Buffer_Type;
                         First  : in Buffer_Index;
                         Last   : in Buffer_Index) return Buffer_Index is
      Pos : Buffer_Index := First;
   begin
      while Pos <= Last and then Is_Space (Buffer (Pos)) loop
         Pos := Pos + 1;
      end loop;
      return Pos;
   end Skip_Spaces;

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
   begin
      while Pos <= Last and then not Is_Space (Buffer (Pos)) loop
         Pos := Pos + 1;
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

   function To_UString (Buffer : in Buffer_Type) return UString is
      Content : String (1 .. Buffer'Length);
      for Content'Address use Buffer'Address;
   begin
      return To_UString (Content);
   end To_UString;

end SPDX_Tool;
