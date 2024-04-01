-- --------------------------------------------------------------------
--  spdx_tool-languages-shell -- Shell detector language
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Strings.Maps;
with Ada.Strings.Fixed;
with SPDX_Tool.Languages.InterpreterMap;
package body SPDX_Tool.Languages.Shell is

   use type Ada.Strings.Maps.Character_Set;

   Spaces : constant Ada.Strings.Maps.Character_Set
     := Ada.Strings.Maps.To_Set (' ')
     or Ada.Strings.Maps.To_Set (ASCII.HT);

   Spaces_Or_Path : constant Ada.Strings.Maps.Character_Set
     := Ada.Strings.Maps.To_Set (' ')
     or Ada.Strings.Maps.To_Set (ASCII.HT)
     or Ada.Strings.Maps.To_Set ('/');

   procedure Check_Interpreter (Detector    : in Shell_Detector_Type;
                                Interpreter : in String;
                                Result      : in out Detector_Result) is
      pragma Unreferenced (Detector);

      Language : constant access constant String := InterpreterMap.Get_Mapping (Interpreter);
   begin
      Set_Languages (Result, Language);
   end Check_Interpreter;

   overriding
   procedure Detect (Detector : in Shell_Detector_Type;
                     File     : in File_Info;
                     Content  : in File_Type;
                     Result   : in out Detector_Result) is
   begin
      if Content.Last_Offset <= 3 or else Content.Count = 0 then
         return;
      end if;
      declare
         Buf       : constant Buffer_Accessor := Content.Buffer.Value;
         First     : constant Buffer_Index := Content.Lines (1).Line_Start;
         Last      : constant Buffer_Size := Content.Lines (1).Line_End;
         Line      : String (Natural (First) .. Natural (Last));
         for Line'Address use Buf.Data'Address;

         Pos       : Natural;
         Next      : Natural;
      begin
         if not Util.Strings.Starts_With (Line, "#!") then
            return;
         end if;
         Pos := Ada.Strings.Fixed.Index (Line (Line'First + 2 .. Line'Last), Spaces);
         if Pos = 0 then
            Pos := Line'First + 2;
         else
            while Pos < Line'Last and then Line (Pos) in ' ' | ASCII.HT loop
               Pos := Pos + 1;
            end loop;
         end if;
         loop
            Next := Ada.Strings.Fixed.Index (Line (Pos .. Line'Last), Spaces_Or_Path);
            if Next = 0 then
               Next := Line'Last + 1;
               exit;
            end if;
            exit when Line (Next) /= '/';
            Pos := Next + 1;
            if Pos >= Line'Last then
               return;
            end if;
         end loop;
         if not Util.Strings.Starts_With (Line (Pos .. Next - 1), "env") then
            Detector.Check_Interpreter (Line (Pos .. Next - 1), Result);
            return;
         end if;
      end;
   end Detect;

end SPDX_Tool.Languages.Shell;
