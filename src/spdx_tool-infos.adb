-- --------------------------------------------------------------------
--  spdx_tool-infos -- result information collected while analyzing files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Strings.Fixed;

package body SPDX_Tool.Infos is

   --  ------------------------------
   --  Convert the string into a range of two integers.
   --  The string format is either <num> or <first>..<last>.
   --  A Constraint_Error exception is raised with a message if it is invalid.
   --  ------------------------------
   function Get_Range (Pattern : in String) return Line_Range_Type is
      Pos    : constant Natural := Ada.Strings.Fixed.Index (Pattern, "..");
      Result : Line_Range_Type;
   begin
      if Pos > Pattern'First then
         Result.First_Line := Line_Count'Value (Pattern (Pattern'First .. Pos - 1));
         Result.Last_Line := Line_Count'Value (Pattern (Pos + 2 .. Pattern'Last));
      elsif Pos = Pattern'First then
         Result.Last_Line := Line_Count'Value (Pattern (Pos + 2 .. Pattern'Last));
      else
         Result.First_Line := Line_Count'Value (Pattern);
         Result.Last_Line := Result.First_Line;
      end if;
      return Result;

   exception
      when Constraint_Error =>
         raise Constraint_Error with -("Invalid range of line: ") & "'" & Pattern & "'";
   end Get_Range;

end SPDX_Tool.Infos;