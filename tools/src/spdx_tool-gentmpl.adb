-- --------------------------------------------------------------------
--  spdx_tool-gentmpl -- Generate a license template index
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Containers.Indefinite_Ordered_Maps;
with Ada.Streams.Stream_IO;
with Ada.Command_Line;
with Ada.Text_IO;
with Util.Strings;
with Util.Streams.Files;
with Util.Streams.Texts;
with SPDX_Tool.Counter_Arrays;
with SPDX_Tool.Licenses;
with SPDX_Tool.Token_Counters;
with SPDX_Tool.Licenses.Files;
with SPDX_Tool.Licenses.Reader;
procedure SPDX_Tool.Gentmpl is

   use Ada.Streams;
   use type Ada.Containers.Count_Type;
   use all type SPDX_Tool.Licenses.Token_Kind;

   procedure Print_Token_Data;
   procedure Print_Token_Array (I : in License_Index);
   procedure Add_Token (Into : in out SPDX_Tool.Token_Counters.Vectorizer_Type;
                        Idx  : in License_Index;
                        Buf  : in Buffer_Type;
                        From : in Buffer_Index;
                        To   : in Buffer_Index);
   function Increment (Value : in Count_Type) return Count_Type;
   procedure Build_Index_For_License (I : in License_Index);
   procedure Print_Index;
   function Is_Ignored (Token : in Buffer_Type) return Boolean;
   procedure Load_License (Name : in String);

   package Token_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (Key_Type => Token_Index,
                                                 Element_Type => Buffer_Type);

   --  Build a index map that gives the list of license indexes that use a given token.
   package Index_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (Key_Type => Token_Index,
                                                 Element_Type => License_Index_Array);

   package Index_To_Variable_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (Key_Type => License_Index_Array,
                                                 Element_Type => Natural);

   Idx      : License_Index := 0;
   Info     : SPDX_Tool.Token_Counters.Vectorizer_Type;
   Tokens   : Token_Maps.Map;
   Indexes  : Index_Maps.Map;
   Output   : aliased Util.Streams.Files.File_Stream;
   Writer   : aliased Util.Streams.Texts.Print_Stream;

   type Parser_Type is new SPDX_Tool.Licenses.Reader.Parser_Type with null record;

   overriding
   procedure Token (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    Token   : in SPDX_Tool.Licenses.Token_Kind);

   function Increment (Value : in Count_Type) return Count_Type is
   begin
      return Value + 1;
   end Increment;

   function Is_Ignored (Token : in Buffer_Type) return Boolean is
      Word : String (Natural (Token'First) .. Natural (Token'Last));
      for Word'Address use Token'Address;
   begin
      if Word'Length = 1 then
         return True;
      end if;
      if Word in "of" | "is" | "to" | "in" | "do" | "be" then
         return True;
      end if;
      if Word in "all" | "any" | "and" | "the" then
         return True;
      end if;
      if Word in "2008" | "2009" | "2011" then
         return True;
      end if;
      return False;
   end Is_Ignored;

   procedure Add_Token (Into : in out SPDX_Tool.Token_Counters.Vectorizer_Type;
                        Idx  : in License_Index;
                        Buf  : in Buffer_Type;
                        From : in Buffer_Index;
                        To   : in Buffer_Index) is
      Len   : constant Buffer_Size := Punctuation_Length (Buf, From, To);
      First : constant Buffer_Index := (if Len > 0 then From + Len else From);
   begin
      if First <= To and then not Is_Ignored (Buf (First .. To)) then
         SPDX_Tool.Token_Counters.Add_Token (Into, Idx,
                                             Buf (First .. To),
                                             Increment'Access);
      end if;
   end Add_Token;

   overriding
   procedure Token (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    Token   : in SPDX_Tool.Licenses.Token_Kind) is
   begin
      if Token = TOK_VAR then
         declare
            Last  : constant Buffer_Index := Parser.Orig_End;
            Pos   : Buffer_Index := Parser.Orig_Pos;
            Len   : Buffer_Size;
            First : Buffer_Index;
         begin
            while Pos < Last loop
               loop
                  if Pos > Last then
                     return;
                  end if;
                  Len := SPDX_Tool.Punctuation_Length (Content, Pos, Last);
                  if Len = 0 then
                     Len := Space_Length (Content, Pos, Last);
                     exit when Len = 0;
                  end if;
                  Pos := Pos + Len;
               end loop;
               First := Pos;
               Pos := SPDX_Tool.Next_Space (Content, First, Last);
               if First <= Pos then
                  Add_Token (Info, Idx, Content, First, Pos);
               end if;
               Pos := Pos + 1;
            end loop;
         end;
      elsif Token = TOK_WORD and then Parser.Token_Pos < Parser.Current_Pos - 1 then
         Add_Token (Info, Idx, Content, Parser.Token_Pos, Parser.Current_Pos - 1);
      end if;
   end Token;

   procedure Load_License (Name : in String) is
      Buf    : constant access constant Buffer_Type := Licenses.Files.Get_Content (Name);
      Parser : Parser_Type;
   begin
      Parser.Parse (Buf.all);
   end Load_License;

   procedure Build_Index_For_License (I : in License_Index) is
      use SPDX_Tool.Counter_Arrays;
      Row : Maps.Cursor := Info.Counters.Cells.Ceiling ((I, 1));
   begin
      while Maps.Has_Element (Row) loop
         declare
            K : constant Index_Type := Maps.Key (Row);
         begin
            exit when K.Row /= I;
            declare
               Index : constant Index_Maps.Cursor := Indexes.Find (K.Column);
            begin
               if not Index_Maps.Has_Element (Index) then
                  Indexes.Insert (K.Column, (1 => I));
               else
                  Indexes.Include (K.Column, Index_Maps.Element (Index) & I);
               end if;
            end;
         end;
         Maps.Next (Row);
      end loop;
   end Build_Index_For_License;

   procedure Print_Token_Array (I : in License_Index) is
      use SPDX_Tool.Counter_Arrays;
      Row : Maps.Cursor := Info.Counters.Cells.Ceiling ((I, 1));
      Col : Natural := 0;
   begin
      Writer.Write ("(");
      while Maps.Has_Element (Row) loop
         declare
            K : constant Index_Type := Maps.Key (Row);
         begin
            exit when K.Row /= I;
            if Col > 80 then
               Writer.Write ("," & ASCII.LF);
               Writer.Write ("      ");
               Col := 0;
            elsif Col > 0 then
               Writer.Write (", ");
            end if;
            Col := Col + 10;
            if K.Column > 1000 then
               Col := Col + 2;
            end if;
            Writer.Write ("(");
            Writer.Write (Util.Strings.Image (Natural (K.Column)));
            Writer.Write (",");
            Writer.Write (Maps.Element (Row)'Image);
            Writer.Write (")");
         end;
         Maps.Next (Row);
      end loop;
      Writer.Write (");" & ASCII.LF);
   end Print_Token_Array;

   procedure Print_Token_Data is
      Len : Buffer_Size := 0;
      Col : Natural := 0;
   begin
      for Token of Tokens loop
         Len := Len + Token'Length;
      end loop;
      Writer.Write ("   Tokens : constant Buffer_Type (1 ..");
      Writer.Write (Len'Image);
      Writer.Write (") := (");
      for Token of Tokens loop
         if Col > 0 then
            Writer.Write ("," & ASCII.LF);
         else
            Writer.Write ("" & ASCII.LF);
         end if;
         Writer.Write ("      --  ");
         Writer.Write (To_String (To_UString (Token)) & ASCII.LF);
         Col := 10;
         begin
            Writer.Write ("     ");
            for C of Token loop
               if Col > 80 then
                  Writer.Write ("," & ASCII.LF);
                  Writer.Write ("     ");
                  Col := 10;
               elsif Col > 10 then
                  Writer.Write (",");
               else
                  Col := 15;
               end if;
               Col := Col + 5;
               Writer.Write (C'Image);
            end loop;
         end;
      end loop;
      Writer.Write (");" & ASCII.LF & ASCII.LF);
      Writer.Write ("   Token_Pos : constant Position_Array := (");
      Col := 0;
      Len := 0;
      for Token of Tokens loop
         begin
            Len := Token'Length;
            if Col > 80 then
               Writer.Write ("," & ASCII.LF);
               Writer.Write ("      ");
               Col := 0;
            elsif Col > 0 then
               Writer.Write (", ");
            end if;
            Col := Col + 5;
            Writer.Write (Util.Strings.Image (Integer (Len)));
         end;
      end loop;
      Writer.Write (");" & ASCII.LF & ASCII.LF);
   end Print_Token_Data;

   procedure Print_Index is
      I    : Natural := 0;
      Vars : Index_To_Variable_Maps.Map;
      Max_Length : Natural := 0;
   begin
      for Iter in Indexes.Iterate loop
         declare
            E : constant License_Index_Array := Index_Maps.Element (Iter);
         begin
            if not Vars.Contains (E) then
               Vars.Insert (E, I);
               Writer.Write ("   L" & Util.Strings.Image (I)
                             & " : aliased constant License_Index_Array := (");
               if E'Length = 1 then
                  Writer.Write ("1 => ");
               end if;
               if E'Length > Max_Length then
                  Max_Length := E'Length;
               end if;
               for J in E'Range loop
                  if J > 1 then
                     if (J mod 8) = 7 then
                        Writer.Write ("," & ASCII.LF & "      ");
                     else
                        Writer.Write (", ");
                     end if;
                  end if;
                  Writer.Write (Util.Strings.Image (Natural (E (J))));
               end loop;
               Writer.Write (");" & ASCII.LF);
               I := I + 1;
            end if;
         end;
      end loop;

      Writer.Write ("   Max_License_Index_Size : constant Positive := ");
      Writer.Write (Util.Strings.Image (Max_Length));
      Writer.Write (";" & ASCII.LF);

      I := 0;
      Writer.Write ("   Index : constant Token_Index_Array := (");
      for Iter in Indexes.Iterate loop
         declare
            K : constant Token_Index := Index_Maps.Key (Iter);
            E : constant License_Index_Array := Index_Maps.Element (Iter);
            V : constant Index_To_Variable_Maps.Cursor := Vars.Find (E);
         begin
            if I > 0 then
               if (I mod 4) = 3 then
                  Writer.Write ("," & ASCII.LF & "      ");
               else
                  Writer.Write (", ");
               end if;
            end if;
            Writer.Write ("(" & Util.Strings.Image (Natural (K)));
            Writer.Write (", L" & Util.Strings.Image (Index_To_Variable_Maps.Element (V))
                          & "'Access)");
            I := I + 1;
         end;
      end loop;
      Writer.Write (");" & ASCII.LF & ASCII.LF);
   end Print_Index;

   Arg_Count : constant Natural := Ada.Command_Line.Argument_Count;
begin
   if Arg_Count /= 1 then
      Ada.Text_IO.Put_Line ("Usage: spdx_tool-gentmpl target.ads");
      return;
   end if;
   Output.Create
     (Mode => Ada.Streams.Stream_IO.Out_File,
      Name => Ada.Command_Line.Argument (1));
   Writer.Initialize (Output'Unchecked_Access);
   Info.Counters.Default := 0;
   for Name of SPDX_Tool.Licenses.Files.Names loop
      Load_License (Name.all);
      Idx := Idx + 1;
   end loop;

   --  After first scan, we know the full list of tokens but they have been
   --  assigned a number which depends on the read-order somehow.  Get the
   --  sorted list of token, and insert them in the token array so that
   --  we control the token id so that they are also sorted on the token id.
   declare
      Tokens   : constant Token_Counters.Token_Maps.Map := Info.Tokens;
      Token_Id : Token_Index := 1;
   begin
      Info.Tokens.Clear;
      for Iter in Tokens.Iterate loop
         Info.Tokens.Insert (Token_Counters.Token_Maps.Key (Iter), Token_Id);
         Token_Id := Token_Id + 1;
      end loop;
   end;

   --  Scan again to now use the new token ids.
   Info.Counters.Cells.Clear;
   Idx := 0;
   for Name of SPDX_Tool.Licenses.Files.Names loop
      Load_License (Name.all);
      Idx := Idx + 1;
   end loop;

   --  Now we can dump the token buffer as a byte array buffer where
   --  each token appears sorted.
   for Iter in Info.Tokens.Iterate loop
      declare
         K : constant Buffer_Type := Token_Counters.Token_Maps.Key (Iter);
         E : constant Token_Index := Token_Counters.Token_Maps.Element (Iter);
      begin
         Tokens.Insert (E, K);
      end;
   end loop;

   --  Build the index map by looking at the token counters and build
   --  the index.
   for I in 0 .. Idx - 1 loop
      Build_Index_For_License (I);
   end loop;

   Writer.Write ("--  Generated by spdx_tool-gentmpl.adb" & ASCII.LF);
   Writer.Write ("--  SPDX-License-Identifier: Apache-2.0" & ASCII.LF);
   Writer.Write ("--  Static license list, inverted index and license tokens" & ASCII.LF);
   Writer.Write ("--  Inverted index is sorted on the indexed token" & ASCII.LF);
   Writer.Write ("--  Tokens in the buffer are sorted" & ASCII.LF);
   Writer.Write ("--  All this content is stored in .rodata section" & ASCII.LF);
   Writer.Write ("package SPDX_Tool.Licenses.Templates is" & ASCII.LF);
   Writer.Write ("   List      : constant License_Array;" & ASCII.LF);
   Writer.Write ("   Index     : constant Token_Index_Array;" & ASCII.LF);
   Writer.Write ("   Tokens    : constant Buffer_Type;" & ASCII.LF);
   Writer.Write ("   Token_Pos : constant Position_Array;" & ASCII.LF);
   Writer.Write ("   Max_License_Index_Size : constant Positive;" & ASCII.LF);
   Writer.Write ("private" & ASCII.LF & ASCII.LF);
   Print_Token_Data;
   for I in 0 .. Idx - 1 loop
      Writer.Write ("   T" & Util.Strings.Image (Natural (I)) & " : aliased constant ");
      Writer.Write ("Token_Array :=" & ASCII.LF);
      Writer.Write ("      ");
      Print_Token_Array (I);
   end loop;
   Writer.Write ("" & ASCII.LF);
   Writer.Write ("   List : constant License_Array := (");
   for I in 0 .. Idx - 1 loop
      if I > 0 then
         if (I mod 6) = 5 then
            Writer.Write ("," & ASCII.LF & "      ");
         else
            Writer.Write (", ");
         end if;
      end if;
      Writer.Write ("T" & Util.Strings.Image (Natural (I)) & "'Access");
   end loop;
   Writer.Write (");" & ASCII.LF);
   Print_Index;
   Writer.Write ("   --  Count=" & Info.Last_Column'Image & ASCII.LF);
   Writer.Write ("end SPDX_Tool.Licenses.Templates;" & ASCII.LF);
end SPDX_Tool.Gentmpl;
