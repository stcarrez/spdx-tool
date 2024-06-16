-- --------------------------------------------------------------------
--  util-algorithms-arrays -- Path filters
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

generic
   type Element_Type is private;
   type Index_Type is (<>);
   type Array_Type is array (Index_Type range <>) of Element_Type;
package SPDX_Tool.Arrays is

   type Result_Type is record
      Found    : Boolean;
      Position : Index_Type;
   end record;

   generic
      type Search_Type (<>) is private;
      with function "<" (Left : Element_Type; Right : Search_Type) return Boolean is <>;
      with function "=" (Left : Element_Type; Right : Search_Type) return Boolean is <>;
      with function Middle (Low, High : Index_Type) return Index_Type;
   function Find (From : in Array_Type;
                  Item : in Search_Type) return Result_Type;

end SPDX_Tool.Arrays;