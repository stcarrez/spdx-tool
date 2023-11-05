-- --------------------------------------------------------------------
--  sci-occurrences -- helper to identify occurrences of a given item
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

package body SCI.Occurrences is

   --  ------------------------------
   --  Add the item in the set.  If the item already exists, add the value
   --  to the current count.
   --  ------------------------------
   procedure Add (Set   : in out Sets.Set;
                  Item  : in String;
                  Value : in Element_Type) is
      C   : Occurrence := (Len   => Item'Length,
                           Item  => Item,
                           Count => Value);
      Pos : constant Sets.Cursor := Set.Find (C);
   begin
      if Sets.Has_Element (Pos) then
         C.Count := C.Count + Sets.Element (Pos).Count;
         Set.Replace_Element (Pos, C);
      else
         Set.Insert (C);
      end if;
   end Add;

   --  ------------------------------
   --  Get the list of occurrence items sorted on the occurence value.
   --  ------------------------------
   procedure List (Set  : in Sets.Set;
                   Into : in out Vectors.Vector) is

      function "<" (Left, Right : Occurrence) return Boolean is
      begin
         if Left.Count < Right.Count then
            return False;
         elsif Right.Count < Left.Count then
            return True;
         else
            return Left.Item < Right.Item;
         end if;
      end "<";

      package Sort is
         new Vectors.Generic_Sorting ("<" => "<");
   begin
      for Item of Set loop
         Into.Append (Item);
      end loop;
      Sort.Sort (Into);
   end List;

   --  ------------------------------
   --  Return the longest item in the list.
   --  ------------------------------
   function Longest (From : in Vectors.Vector) return Natural is
      Result : Natural := 0;
   begin
      for Item of From loop
         if Result < Item.Len then
            Result := Item.Len;
         end if;
      end loop;
      return Result;
   end Longest;

   --  ------------------------------
   --  Compute the sum of every element count.
   --  ------------------------------
   function Sum (From    : in Vectors.Vector;
                 Initial : in Element_Type) return Element_Type is
      Result : Element_Type := Initial;
   begin
      for Item of From loop
         Result := Result + Item.Count;
      end loop;
      return Result;
   end Sum;

end SCI.Occurrences;
