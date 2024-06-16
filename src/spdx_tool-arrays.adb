-- --------------------------------------------------------------------
--  util-algorithms-arrays -- Path filters
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

package body SPDX_Tool.Arrays is

   function Find (From : Array_Type; Item : Search_Type) return Result_Type is
      Low  : Index_Type := From'First;
      High : Index_Type := From'Last;
      Pos  : Index_Type := Low;
   begin
      while Low <= High loop
         Pos := Middle (Low, High);
         if From (Pos) = Item then
            return (True, Pos);
         end if;
         if From (Pos) < Item then
            Low := Index_Type'Succ (Pos);
         elsif Pos > From'First then
            High := Index_Type'Pred (Pos);
         else
            exit;
         end if;
      end loop;
      return (False, Pos);
   end Find;

end SPDX_Tool.Arrays;