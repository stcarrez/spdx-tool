with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Containers.Indefinite_Ordered_Maps;
with Util.Serialize.IO.JSON;
with Util.Streams.Buffered;
with Util.Streams.Texts;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Strings.Vectors;
with Util.Strings.Transforms;
procedure SPDX_Tool.Genmap is

   package UBO renames Util.Beans.Objects;
   use type Ada.Containers.Count_Type;
   use Util.Strings.Transforms;
   use Util.Strings.Vectors;
   use Ada.Strings.Unbounded;

   package Maps is
      new Ada.Containers.Indefinite_Ordered_Maps (Key_Type     => String,
                                                  Element_Type => Util.Strings.Vectors.Vector);

   procedure Usage;
   procedure Register (Name  : in String;
                       Value : in String);
   procedure Register (Name  : in String;
                       Value : in UBO.Object);
   procedure Extract (Label : in String;
                      Root  : in UBO.Object);
   function Get_Label (Option : in String) return String;
   function To_String (List : in Vector) return String;

   Exts : Maps.Map;
   Use_Lowercase : Boolean := False;
   Comment_Map   : Boolean := False;
   Alias_Map     : Boolean := False;

   function Get_Key (Name : in String) return String is
      (if Use_Lowercase then Util.Strings.Transforms.To_Lower_Case (Name) else Name);

   procedure Register (Name  : in String;
                       Value : in String) is
      Key  : constant String := Get_Key ((if Comment_Map then Name else Value));
      Val  : constant String := (if Comment_Map then Value else Name);
      Pos  : constant Maps.Cursor := Exts.Find (Key);
      List : Vector;
   begin
      if not Maps.Has_Element (Pos) then
         List.Append (Val);
         Exts.Insert (Key, List);
      else
         List := Maps.Element (Pos);
         for Item of List loop
            if Item = Val then
               return;
            end if;
         end loop;
         List.Append (Val);
         Exts.Include (Key, List);
      end if;
   end Register;

   procedure Register (Name  : in String;
                       Value : in UBO.Object) is
   begin
      if not UBO.Is_Array (Value) then
         Register (Name, UBO.To_String (Value));
      else
         declare
            Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Value);
         begin
            while UBO.Iterators.Has_Element (Iter) loop
               declare
                  Item : constant UBO.Object := UBO.Iterators.Element (Iter);
               begin
                  Register (Name, UBO.To_String (Item));
               end;
               UBO.Iterators.Next (Iter);
            end loop;
         end;
      end if;
   end Register;

   procedure Extract (Label : in String;
                      Root  : in UBO.Object) is
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Root);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item  : constant UBO.Object := UBO.Iterators.Element (Iter);
            Value : constant UBO.Object := UBO.Get_Value (Item, Label);
         begin
            if UBO.Iterators.Has_Key (Iter) then
               if not UBO.Is_Null (Value) then
                  Register (UBO.Iterators.Key (Iter), Value);
               elsif Comment_Map then
                  Register (UBO.Iterators.Key (Iter), UBO.To_Object (String '("")));
               end if;
               if Alias_Map then
                  declare
                     Lang  : constant String := UBO.Iterators.Key (Iter);
                     Alias : constant String := To_Lower_Case (Lang);
                  begin
                     if Lang /= Alias then
                        Register (Lang, Alias);
                     end if;
                  end;
               end if;
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
   end Extract;

   procedure Usage is
   begin
      Ada.Text_IO.Put_Line ("Usage: spdx_tool-genmap {--extensions|--interpreters|"
                            & "--filenames|--mimes|--aliases|--comments} path");
      Ada.Command_Line.Set_Exit_Status (2);
   end Usage;

   function Get_Label (Option : in String) return String is
   begin
      if Option = "--extensions" then
         return "extensions";
      elsif Option = "--interpreters" then
         return "interpreters";
      elsif Option = "--filenames" then
         return "filenames";
      elsif Option = "--mimes" then
         return "codemirror_mime_type";
      elsif Option = "--aliases" then
         return "aliases";
      elsif Option = "--comments" then
         return "comment_style";
      else
         return "";
      end if;
   end Get_Label;

   function Get_Priority (Name : in String) return Natural is
   begin
      if Name in "Perl" | "Python" | "C" | "C++" then
         return 10;
      end if;
      if Name in "INI" | "XML" | "YAML" | "JSON" then
         return 5;
      end if;
      if Name in "M4" | "R" | "VBA" | "D" | "Assembly" | "Elixir" | "Lua" | "OCaml" then
         return 3;
      end if;
      return 0;
   end Get_Priority;

   function Compare (Left, Right : in String) return Boolean is
      A : constant Natural := Get_Priority (Left);
      B : constant Natural := Get_Priority (Right);
   begin
      return A > B or else (A = B and then Left > Right);
   end Compare;

   package Sort is new Util.Strings.Vectors.Generic_Sorting (Compare);

   function To_String (List : in Vector) return String is
   begin
      if List.Is_Empty then
         return "";
      elsif List.Length = 1 then
         return List.First_Element;
      else
         declare
            Result : UString;
            L      : Vector := List;
         begin
            Sort.Sort (L);
            for Item of L loop
               if Item'Length > 0 then
                  if Length (Result) > 0 then
                     Append (Result, ",");
                  end if;
                  Append (Result, Item);
               end if;
            end loop;
            return To_String (Result);
         end;
      end if;
   end To_String;

   Root   : UBO.Object;
begin
   if Ada.Command_Line.Argument_Count < 2 then
      Usage;
      return;
   end if;

   declare
      Label : constant String := Get_Label (Ada.Command_Line.Argument (1));
   begin
      if Label'Length = 0 then
         Usage;
         return;
      end if;
      if Label = "aliases" then
         Use_Lowercase := True;
         Alias_Map := True;
      elsif Label = "comment_style" then
         Comment_Map := True;
      end if;
      for I in 2 .. Ada.Command_Line.Argument_Count loop
         Root := Util.Serialize.IO.JSON.Read (Ada.Command_Line.Argument (I));
         Extract (Label, Root);
      end loop;
      declare
         Offset : constant Natural := (if Label = "extensions" then 1 else 0);
         Buffer : aliased Util.Streams.Buffered.Output_Buffer_Stream;
         Print  : aliased Util.Streams.Texts.Print_Stream;
         Output : Util.Serialize.IO.JSON.Output_Stream;
      begin
         Buffer.Initialize (Size => 100_000);
         Print.Initialize (Buffer'Unchecked_Access);
         Output.Initialize (Print'Unchecked_Access);
         Output.Start_Document;
         Output.Start_Entity ("");
         for Iter in Exts.Iterate loop
            declare
               Ext   : constant String := Maps.Key (Iter);
               Items : constant Vector := Maps.Element (Iter);
            begin
               Output.Write_Entity (Ext (Ext'First + Offset .. Ext'Last),
                                    To_String (Items));
            end;
         end loop;
         Output.End_Entity ("");
         Output.End_Document;
         Output.Flush;
         Ada.Text_IO.Put_Line (Util.Streams.Texts.To_String (Buffer));
      end;
   end;
end SPDX_Tool.Genmap;
