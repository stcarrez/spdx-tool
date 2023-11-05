-- --------------------------------------------------------------------
--  sci-occurrences -- helper to identify occurrences of a given item
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Containers.Indefinite_Ordered_Sets;
with Ada.Containers.Indefinite_Vectors;
generic
   type Element_Type is private;
   with function "+" (Left, Right : Element_Type) return Element_Type is <>;
package SCI.Occurrences is

   type Occurrence (Len : Natural) is record
      Count : Element_Type;
      Item  : String (1 .. Len);
   end record;

   --  Compare the two occurrence only on their name.
   function "<" (Left, Right : Occurrence)
                 return Boolean is (Left.Item < Right.Item);
   function Same (Left, Right : Occurrence)
                  return Boolean is (Left.Item = Right.Item);

   package Vectors is
     new Ada.Containers.Indefinite_Vectors (Positive, Occurrence);
   subtype Vector is Vectors.Vector;

   package Sets is
     new Ada.Containers.Indefinite_Ordered_Sets (Occurrence, "<", Same);
   subtype Set is Sets.Set;

   --  Add the item in the set.  If the item already exists, add the value
   --  to the current count.
   procedure Add (Set   : in out Sets.Set;
                  Item  : in String;
                  Value : in Element_Type);

   --  Get the list of occurrence items sorted on the occurence value.
   generic
      with function "<" (Left, Right : Element_Type) return Boolean is <>;
   procedure List (Set  : in Sets.Set;
                   Into : in out Vectors.Vector);

   --  Return the longest item in the list.
   function Longest (From : in Vectors.Vector) return Natural;

   --  Compute the sum of every element count.
   function Sum (From    : in Vectors.Vector;
                 Initial : in Element_Type) return Element_Type;

end SCI.Occurrences;
