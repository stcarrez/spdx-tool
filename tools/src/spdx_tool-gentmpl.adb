-- --------------------------------------------------------------------
--  gendecisiontree -- Generate a decision tree for the static licenses
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Text_IO;
with Ada.Containers.Indefinite_Ordered_Maps;
with Ada.Streams;
with Ada.Directories;
with Ada.Command_Line;
with Util.Strings;
with SPDX_Tool.Counter_Arrays;
with SPDX_Tool.Licenses;
with SPDX_Tool.Token_Counters;
with SPDX_Tool.Licenses.Reader;
procedure SPDX_Tool.Gentmpl is

   use Ada.Streams;
   use type Ada.Containers.Count_Type;

   package AD renames Ada.Directories;
   use type AD.File_Kind;
   procedure Print_Token_Data;
   procedure Print_Token_Array (I : in License_Index);
   procedure Scan (Path : in String);

   package Token_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (Key_Type => Token_Index,
                                                 Element_Type => Buffer_Type);

   Idx      : License_Index := 0;
   Info     : SPDX_Tool.Token_Counters.Vectorizer_Type;
   Tokens   : Token_Maps.Map;

   function Increment (Value : in Natural) return Natural is
   begin
      return Value + 1;
   end Increment;

   function Is_Punctuation (C : in Byte) return Boolean
   is (Is_Space_Or_Punctuation (C) or else C = Character'Pos ('_')
       or else C = Character'Pos ('=') or else C = Character'Pos ('*')
       or else C = Character'Pos ('+') or else C = Character'Pos ('?')
       or else C = Character'Pos ('>') or else C = Character'Pos (']')
       or else C = Character'Pos ('[') or else C = Character'Pos ('/')
       or else C = Character'Pos ('#') or else C = Character'Pos ('$')
       or else C = Character'Pos ('`'));

   procedure Add_Token (Into : in out SPDX_Tool.Token_Counters.Vectorizer_Type;
                        Idx  : in License_Index;
                        Buf  : in Buffer_Type;
                        From : in Buffer_Index;
                        To   : in Buffer_Index) is
      First : Buffer_Index := From;
      Last  : Buffer_Index := To;
   begin
      while First <= Last and then Is_Punctuation (Buf (First)) loop
         First := First + 1;
      end loop;
      while First <= Last and then Is_Punctuation (Buf (Last)) loop
         Last := Last - 1;
      end loop;
      if First <= Last then
         SPDX_Tool.Token_Counters.Add_Token (Into, Idx,
                                             Buf (First .. Last),
                                             Increment'Access);
      end if;
   end Add_Token;

   procedure Split_Tokens (Content : in String) is
      Data  : constant SPDX_Tool.Buffer_Ref := SPDX_Tool.Create_Buffer (Content);
      Buf   : constant Buffer_Accessor := Data.Value;
      Last  : constant Buffer_Index := Buf.Data'Last;
      Pos   : Buffer_Index := 1;
      First : Buffer_Index;
      Len   : Buffer_Size;
   begin
      while Pos <= Last loop
         First := SPDX_Tool.Skip_Spaces (Buf.Data, Pos, Last);
         exit when First > Last;

         Pos := SPDX_Tool.Next_Space (Buf.Data, First, Last);
         if First <= Pos then
            Add_Token (Info, Idx, Buf.Data, First, Pos);
         end if;
         Pos := Pos + 1;
         while Pos <= Last loop
            Len := SPDX_Tool.Punctuation_Length (Buf.Data, Pos, Last);
            exit when Len = 0;
            Pos := Pos + Len;
         end loop;
      end loop;
   end Split_Tokens;

   procedure Scan (Path : in String) is
      Dir_Filter  : constant AD.Filter_Type := (AD.Ordinary_File => True,
                                                AD.Directory     => True,
                                                others           => False);
      Ent    : AD.Directory_Entry_Type;
      Search : AD.Search_Type;
   begin
      AD.Start_Search (Search, Directory => Path,
                       Pattern => "*", Filter => Dir_Filter);
      while AD.More_Entries (Search) loop
         AD.Get_Next_Entry (Search, Ent);
         declare
            Full_Name : constant String := AD.Full_Name (Ent);
            Lic       : SPDX_Tool.Licenses.Reader.License_Type;
         begin
            if AD.Kind (Ent) /= AD.Directory then
               SPDX_Tool.Licenses.Reader.Load (Lic, Full_Name);
               if Length (Lic.License) > 0 then
                  Split_Tokens (To_String (Lic.License));
                  Idx := Idx + 1;
               end if;
            end if;
         end;
      end loop;
   end Scan;

   procedure Print_Token_Array (I : in License_Index) is
      use SPDX_Tool.Counter_Arrays;
      Row : Maps.Cursor := Info.Counters.Cells.Ceiling ((I, 1));
      Col : Natural := 0;
   begin
      Ada.Text_IO.Put ("(");
      while Maps.Has_Element (Row) loop
         declare
            K : constant Index_Type := Maps.Key (Row);
         begin
            exit when K.Row /= I;
            if Col > 80 then
               Ada.Text_IO.Put_Line (",");
               Ada.Text_IO.Put ("      ");
               Col := 0;
            elsif Col > 0 then
               Ada.Text_IO.Put (", ");
            end if;
            Col := Col + 10;
            Ada.Text_IO.Put ("(");
            Ada.Text_IO.Put (Util.Strings.Image (Natural (K.Column)));
            Ada.Text_IO.Put (",");
            Ada.Text_IO.Put (Maps.Element (Row)'Image);
            Ada.Text_IO.Put (")");
         end;
         Maps.Next (Row);
      end loop;
      Ada.Text_IO.Put_Line (");");
   end Print_Token_Array;

   procedure Print_Token_Data is
      Len : Buffer_Size := 0;
      Col : Natural := 0;
   begin
      for Token of Tokens loop
         Len := Len + Token'Length;
      end loop;
      Ada.Text_IO.Put ("   Tokens : constant Buffer_Type (1 ..");
      Ada.Text_IO.Put (Len'Image);
      Ada.Text_IO.Put (") := (");
      for Token of Tokens loop
         if Col > 0 then
            Ada.Text_IO.Put_Line (",");
         else
            Ada.Text_IO.Put_Line ("");
         end if;
         Ada.Text_IO.Put ("      --  ");
         Ada.Text_IO.Put_Line (To_String (To_UString (Token)));
         Col := 10;
         begin
            Ada.Text_IO.Put ("     ");
            for C of Token loop
               if Col > 80 then
                  Ada.Text_IO.Put_Line (",");
                  Ada.Text_IO.Put ("     ");
                  Col := 10;
               elsif Col > 10 then
                  Ada.Text_IO.Put (",");
               else
                  Col := 15;
               end if;
               Col := Col + 5;
               Ada.Text_IO.Put (C'Image);
            end loop;
         end;
      end loop;
      Ada.Text_IO.Put_Line (");");
      Ada.Text_IO.Put ("   Token_Pos : constant Position_Array := (");
      Col := 0;
      Len := 0;
      for Token of Tokens loop
         begin
            Len := Token'Length;
            if Col > 80 then
               Ada.Text_IO.Put_Line (",");
               Ada.Text_IO.Put ("      ");
               Col := 0;
            elsif Col > 0 then
               Ada.Text_IO.Put (",");
            end if;
            Col := Col + 5;
            Ada.Text_IO.Put (Len'Image);
         end;
      end loop;
      Ada.Text_IO.Put_Line (");");
   end Print_Token_Data;

   Arg_Count : constant Natural := Ada.Command_Line.Argument_Count;
begin
   Info.Counters.Default := 0;
   for I in 1 .. Arg_Count loop
      Scan (Ada.Command_Line.Argument (I));
   end loop;
   declare
      Tokens : Token_Counters.Token_Maps.Map := Info.Tokens;
      Token_Id : Token_Index := 1;
   begin
      Info.Tokens.Clear;
      for Iter in Tokens.Iterate loop
         Info.Tokens.Insert (Token_Counters.Token_Maps.Key (Iter), Token_Id);
         Token_Id := Token_Id + 1;
      end loop;
   end;
   Info.Counters.Cells.Clear;
   Idx := 0;
   for I in 1 .. Arg_Count loop
      Scan (Ada.Command_Line.Argument (I));
   end loop;
   for Iter in Info.Tokens.Iterate loop
      declare
         K : constant Buffer_Type := Token_Counters.Token_Maps.Key (Iter);
         E : constant Token_Index := Token_Counters.Token_Maps.Element (Iter);
      begin
         Tokens.Insert (E, K);
      end;
   end loop;

   --  Generate decision tree by identifying the best token that split
   --  the list of licenses in two sets: a left set that contains the token
   --  and a right set which does not contain it.  Sometimes, it is possible
   --  that there is no such token and the leaf node will indicate several
   --  licenses.
   Ada.Text_IO.Put_Line ("--  Generated by gendecisiontree.adb");
   Ada.Text_IO.Put_Line ("--  Static license identification decision tree");
   Ada.Text_IO.Put_Line ("--  Entire decision tree is stored in .rodata section");
   Ada.Text_IO.Put_Line ("with SPDX_Tool.Licenses.Templates;");
   Ada.Text_IO.Put_Line ("private package SPDX_Tool.Licenses.Templates is");
   Print_Token_Data;
   for I in 0 .. Idx loop
      Ada.Text_IO.Put ("   T" & Util.Strings.Image (Natural (I)) & " : aliased constant ");
      Ada.Text_IO.Put_Line ("Token_Array :=");
      Ada.Text_IO.Put ("      ");
      Print_Token_Array (I);
   end loop;
   Ada.Text_IO.Put_Line ("   --  Count=" & Info.Last_Column'Image);
   Ada.Text_IO.Put_Line ("end SPDX_Tool.Licenses.Templates;");
end SPDX_Tool.Gentmpl;
