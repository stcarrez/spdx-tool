with Ada.Text_IO;
with Ada.Command_Line;
with Util.Serialize.IO.JSON;
with Util.Streams.Buffered;
with Util.Streams.Texts;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Strings.Maps;
procedure SPDX_Tool.Genmap is

   package UBO renames Util.Beans.Objects;

   procedure Usage;
   procedure Register (Name  : in String;
                       Value : in String);
   procedure Register (Name  : in String;
                       Value : in UBO.Object);
   procedure Extract (Label : in String;
                      Root  : in UBO.Object);
   function Get_Label (Option : in String) return String;

   Exts : Util.Strings.Maps.Map;

   procedure Register (Name : in String;
                       Value : in String) is
      Pos : constant Util.Strings.Maps.Cursor := Exts.Find (Value);
   begin
      if Util.Strings.Maps.Has_Element (Pos) then
         Exts.Include (Value, Name & ", " & Util.Strings.Maps.Element (Pos));
      else
         Exts.Insert (Value, Name);
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
            if UBO.Iterators.Has_Key (Iter) and then not UBO.Is_Null (Value) then
               Register (UBO.Iterators.Key (Iter), Value);
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
   end Extract;

   procedure Usage is
   begin
      Ada.Text_IO.Put_Line ("Usage: spdx_tool-genmap {--extensions|--interpreters|"
                            & "--filenames|--mimes|--alias} path");
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
      else
         return "";
      end if;
   end Get_Label;

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
               Ext : constant String := Util.Strings.Maps.Key (Iter);
            begin
               Output.Write_Entity (Ext (Ext'First + Offset .. Ext'Last),
                                    Util.Strings.Maps.Element (Iter));
            end;
         end loop;
         Output.End_Entity ("");
         Output.End_Document;
         Output.Flush;
         Ada.Text_IO.Put_Line (Util.Streams.Texts.To_String (Buffer));
      end;
   end;
end SPDX_Tool.Genmap;
