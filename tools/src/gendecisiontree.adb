-- --------------------------------------------------------------------
--  gendecisiontree -- Generate a decision tree for the static licenses
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Text_IO;
with Ada.Containers.Ordered_Sets;
with Ada.Streams;
with Util.Strings;
with SCI.Occurrences.Arrays;
with SPDX_Tool.Licenses;
with SPDX_Tool.Licenses.Files;
with SPDX_Tool.Buffer_Sets;
procedure Gendecisiontree is

   use SPDX_Tool;
   use Ada.Streams;
   use type SPDX_Tool.Buffer_Type;
   use type Ada.Containers.Count_Type;
   use type Ada.Text_IO.Count;
   subtype License_Index is SPDX_Tool.Licenses.License_Index;
   use type SPDX_Tool.Licenses.License_Index;

   package Index_Sets is
     new Ada.Containers.Ordered_Sets (Element_Type => License_Index);
   subtype Set is Index_Sets.Set;

   procedure Decision_Tree (List  : Set);

   procedure Print_Node (Token     : in Buffer_Type;
                         Left_Idx  : in Natural;
                         Right_Idx : in Natural;
                         List      : in Set);

   package Token_Occurrences is
     new SCI.Occurrences.Arrays (Element_Type    => SPDX_Tool.Byte,
                                 Index_Type      => Stream_Element_Offset,
                                 Array_Type      => SPDX_Tool.Buffer_Type,
                                 Occurrence_Type => Set);

   License_Count : constant License_Index := SPDX_Tool.Licenses.Files.Names_Count;
   Licenses      : SPDX_Tool.Licenses.License_Template_Array (0 .. License_Count - 1);
   Node_Idx      : Natural := 0;

   procedure Print_Node (Token     : in Buffer_Type;
                         Left_Idx  : in Natural;
                         Right_Idx : in Natural;
                         List      : in Set) is
      I : Positive := 1;
      Need_Sep : Boolean := False;
   begin
      Node_Idx := Node_Idx + 1;
      Ada.Text_IO.Put ("   N");
      Ada.Text_IO.Put (Util.Strings.Image (Node_Idx));
      Ada.Text_IO.Put (" : aliased constant Decision_Node := Decision_Node '(Length => ");
      Ada.Text_IO.Put (Util.Strings.Image (Natural (Token'Length)));
      Ada.Text_IO.Put (", Size => ");
      Ada.Text_IO.Put (Util.Strings.Image (Natural (List.Length)));
      Ada.Text_IO.Put_Line (",");
      Ada.Text_IO.Put ("      Left => ");
      if Left_Idx > 0 then
         Ada.Text_IO.Put ("N" & Util.Strings.Image (Left_Idx));
         Ada.Text_IO.Put ("'Access");
      else
         Ada.Text_IO.Put ("null");
      end if;
      Ada.Text_IO.Put (", Right => ");
      if Right_Idx > 0 then
         Ada.Text_IO.Put ("N" & Util.Strings.Image (Right_Idx));
         Ada.Text_IO.Put ("'Access");
      else
         Ada.Text_IO.Put ("null");
      end if;
      Ada.Text_IO.Put_Line (",");
      if Token'Length > 0 then
         Ada.Text_IO.Put ("      Token => (");
         for Pos in Token'Range loop
            if Ada.Text_IO.Col > 70 then
               Ada.Text_IO.Put_Line (",");
               Ada.Text_IO.Put ("                ");
            elsif Need_Sep then
               Ada.Text_IO.Put (", ");
            end if;
            Ada.Text_IO.Put (Util.Strings.Image (Natural (Pos)));
            Ada.Text_IO.Put (" => ");
            Ada.Text_IO.Put (Util.Strings.Image (Natural (Token (Pos))));
            Need_Sep := True;
         end loop;
         Ada.Text_IO.Put_Line ("),");
      end if;
      if List.Length > 0 then
         Ada.Text_IO.Put ("      Licenses => (");
         for License of List loop
            if Ada.Text_IO.Col > 70 then
               Ada.Text_IO.Put_Line (",");
               Ada.Text_IO.Put ("                   ");
            elsif I > 1 then
               Ada.Text_IO.Put (", ");
            end if;
            Ada.Text_IO.Put (Util.Strings.Image (I));
            Ada.Text_IO.Put (" => ");
            Ada.Text_IO.Put (Util.Strings.Image (Natural (License)));
            I := I + 1;
         end loop;
         Ada.Text_IO.Put (")");
      end if;
      if List.Length = 0 or else Token'Length = 0 then
         Ada.Text_IO.Put (", others => <>");
      end if;
      Ada.Text_IO.Put_Line (");");
   end Print_Node;

   procedure Decision_Tree (List  : Set) is

      function "<" (Left, Right : Set)
                    return Boolean is (Left.Length < Right.Length);
      procedure Add is
        new Token_Occurrences.Add ("+" => Index_Sets."or");
      procedure List_Occurrences is
         new Token_Occurrences.List ("<");

      Empty : Buffer_Type (1 .. 0);
      O : Token_Occurrences.Set;
      S : Token_Occurrences.Vector;
      Common : SPDX_Tool.Buffer_Sets.Set;
      Common_Setup : Boolean := True;
   begin
      if List.Length = 1 then
         Print_Node (Empty, 0, 0, List);
         return;
      end if;

      --  Remove tokens which are common to every licenses.
      for L of List loop
         if Common_Setup then
            Common := Licenses (L).Tokens;
            Common_Setup := False;
         else
            Common.Intersection (Licenses (L).Tokens);
         end if;
      end loop;

      --  Gather token occurrences with their associate license index.
      for L of List loop
         declare
            V : Set;
         begin
            V.Include (L);
            for Item of Licenses (L).Tokens loop
               if not Common.Contains (Item) then
                  Add (O, Item, V);
               end if;
            end loop;
         end;
      end loop;

      --  No token to differentiate the licenses, emit a leaf node for the list.
      if O.Length = 0 then
         Print_Node (Empty, 0, 0, List);
         return;
      end if;

      --  Sort occurrences
      List_Occurrences (O, S);
      declare
         Middle : constant Ada.Containers.Count_Type := (List.Length / 2);
         Right  : Set := List;
         Pos    : Natural := 0;
         Left_Idx  : Natural := 0;
         Right_Idx : Natural := 0;
      begin
         for I in 1 .. Natural (S.Length) loop
            if S.Reference (I).Occurrence.Length <= Middle then
               Pos := I;
               exit;
            end if;
         end loop;
         if Pos = 0 then
            Pos := 1;
         end if;
         Decision_Tree (S.Reference (Pos).Occurrence);
         Left_Idx := Node_Idx;
         Right.Difference (S.Reference (Pos).Occurrence);
         if Right.Length > 0 then
            Decision_Tree (Right);
            Right_Idx := Node_Idx;
         end if;
         Print_Node (S.Reference (Pos).Element, Left_Idx, Right_Idx, List);
      end;
   end Decision_Tree;

   List     : Set;
begin
   --  Load the licenses from the static content and identify its tokens.
   for License in Licenses'Range loop
      SPDX_Tool.Licenses.Load_License (License, Licenses (License));
      if SPDX_Tool.Licenses.Is_Loaded (Licenses (License)) then
         SPDX_Tool.Licenses.Collect_License_Tokens (Licenses (License));
         List.Insert (License);
      end if;
   end loop;

   --  Generate decision tree by identifying the best token that split
   --  the list of licenses in two sets: a left set that contains the token
   --  and a right set which does not contain it.  Sometimes, it is possible
   --  that there is no such token and the leaf node will indicate several
   --  licenses.
   Ada.Text_IO.Put_Line ("--  Generated by gendecisiontree.adb");
   Ada.Text_IO.Put_Line ("--  Static license identification decision tree");
   Ada.Text_IO.Put_Line ("--  Entire decision tree is stored in .rodata section");
   Ada.Text_IO.Put_Line ("with SPDX_Tool.Licenses.Files;");
   Ada.Text_IO.Put_Line ("private package SPDX_Tool.Licenses.Decisions is");
   Ada.Text_IO.Put_Line ("   Licenses : License_Template_Array "
                         & "(0 .. SPDX_Tool.Licenses.Files.Names_Count - 1);");
   Decision_Tree (List);
   Ada.Text_IO.Put ("   Root : constant Decision_Node_Access := N");
   Ada.Text_IO.Put (Util.Strings.Image (Node_Idx));
   Ada.Text_IO.Put_Line ("'Access;");
   Ada.Text_IO.Put_Line ("end SPDX_Tool.Licenses.Decisions;");
end Gendecisiontree;
