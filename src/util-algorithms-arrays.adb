-- --------------------------------------------------------------------
--  util-algorithms-arrays -- Path filters
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

package body Util.Algorithms.Arrays is

   function Max (Left, Right : Index_Type) return Index_Type
      is (if Left > Right then Left else Right);

   --  Left := (1, 3, 5, 7)
   --  Right := (1, 2, 3, 8) => (1, 3)
   overriding
   function "&" (Left, Right : Array_Type) return Array_Type is
      M : Array_Type (Left'First .. Max (Left'Last, Right'Last));
      Target : Index_Type := M'First;
      Pos    : Index_Type := Right'First;
   begin
      for Val of Left loop
         if Right (Pos) = Val then
            M (Target) := Val;
            Pos := Index_Type'Succ (Pos);
            Target := Index_Type'Succ (Target);
         else
            while Pos <= Right'Last and then Right (Pos) < Val loop
               Pos := Index_Type'Succ (Pos);
            end loop;
         end if;
      end loop;
      return M (M'First .. Target);
   end "&";

   --  Left := (1, 3, 5, 7)
   --  Right := (1, 2, 3, 8)
   --  ==> Left := (1, 3)
   --      Count := 2
   procedure Intersect (Into : in out Array_Type; From : in Array_Type; Count : out Natural) is
      Target : Index_Type := Into'First;
      Pos    : Index_Type := Into'First;
   begin
      Count := 0;
      for Val of From loop
         while Into (Pos) < Val loop
            if Pos = Into'Last then
               return;
            end if;
            Pos := Index_Type'Succ (Pos);
            if Pos > Into'Last then
               return;
            end if;
         end loop;
         if Into (Pos) = Val then
            Pos := Index_Type'Succ (Pos);
            Into (Target) := Val;
            Target := Index_Type'Succ (Target);
            Count := Count + 1;
            exit when Target > Into'Last or else Pos > Into'Last;
         end if;
      end loop;
   end Intersect;

   function Find (From : Array_Type; Item : Element_Type) return Result_Type is
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
         else
            High := Index_Type'Pred (Pos);
         end if;
      end loop;
      return (False, Pos);
   end Find;

end Util.Algorithms.Arrays;