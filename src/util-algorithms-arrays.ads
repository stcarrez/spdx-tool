-- --------------------------------------------------------------------
--  util-algorithms-arrays -- Path filters
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

generic
   type Element_Type is private;
   type Index_Type is (<>);
   type Array_Type is array (Index_Type range <>) of Element_Type;
   with function "<" (Left, Right : Element_Type) return Boolean is <>;
   with function "=" (Left, Right : Element_Type) return Boolean is <>;
   with function Middle (Low, High : Index_Type) return Index_Type;
package Util.Algorithms.Arrays is

   function "&" (Left, Right : Array_Type) return Array_Type;

   procedure Intersect (Into  : in out Array_Type;
                        From  : in Array_Type;
                        Count : out Natural);

   type Result_Type is record
      Found    : Boolean;
      Position : Index_Type;
   end record;

   function Find (From : in Array_Type;
                  Item : in Element_Type) return Result_Type;

end Util.Algorithms.Arrays;