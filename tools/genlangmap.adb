with Ada.Text_IO;
with Ada.Command_Line;
with Util.Serialize.IO.JSON;
with Util.Streams.Buffered;
with Util.Streams.Texts;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Strings.Maps;
procedure Genlangmap is

   package UBO renames Util.Beans.Objects;

   procedure Register (Name       : in String;
                       Extensions : in UBO.Object);
   procedure Extract (Root : in UBO.Object);

   Exts : Util.Strings.Maps.Map;

   procedure Register (Name       : in String;
                       Extensions : in UBO.Object) is
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Extensions);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
            Ext  : constant String := UBO.To_String (Item);
            Pos  : constant Util.Strings.Maps.Cursor := Exts.Find (Ext);
         begin
            if Util.Strings.Maps.Has_Element (Pos) then
               Exts.Include (Ext, Name & ", " & Util.Strings.Maps.Element (Pos));
            else
               Exts.Insert (Ext, Name);
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
   end Register;

   procedure Extract (Root : in UBO.Object) is
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (Root);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
            Name : UBO.Object;
            Extensions : UBO.Object;
         begin
            if UBO.To_Bean (Item) /= null then
               Name := UBO.Get_Value (Item, "name");
               Extensions := UBO.Get_Value (Item, "extensions");
               Register (UBO.To_String (Name), Extensions);
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
   end Extract;

   Root   : UBO.Object;
begin
   if Ada.Command_Line.Argument_Count = 0 then
      Ada.Text_IO.Put_Line ("Usage: genlangmap path");
      return;
   end if;

   for I in 1 .. Ada.Command_Line.Argument_Count loop
      Root := Util.Serialize.IO.JSON.Read (Ada.Command_Line.Argument (I));
      Extract (Root);
   end loop;

   declare
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
            Output.Write_Entity (Ext (Ext'First + 1 .. Ext'Last),
                                 Util.Strings.Maps.Element (Iter));
         end;
      end loop;
      Output.End_Entity ("");
      Output.End_Document;
      Output.Flush;
      Ada.Text_IO.Put_Line (Util.Streams.Texts.To_String (Buffer));
   end;
end Genlangmap;
