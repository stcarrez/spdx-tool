-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Files;
with Util.Beans.Objects;
with Util.Beans.Objects.Iterators;
with Util.Serialize.IO.JSON;
with Util.Log.Loggers;

package body SPDX_Tool.Licenses.Reader is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses.Reader");

   package UBO renames Util.Beans.Objects;

   function Find_Header (List : UBO.Object) return UBO.Object;
   function Find_Value (Info : UBO.Object; Name : String) return Boolean;
   function Find_Value (Info : UBO.Object; Name : String) return UString;

   function Find_Header (List : UBO.Object) return UBO.Object is
      Iter : UBO.Iterators.Iterator := UBO.Iterators.First (List);
   begin
      while UBO.Iterators.Has_Element (Iter) loop
         declare
            Item : constant UBO.Object := UBO.Iterators.Element (Iter);
            Hdr  : constant UBO.Object
              := UBO.Get_Value (Item, "spdx:standardLicenseTemplate");
         begin
            if not UBO.Is_Null (Hdr) then
               return Item;
            end if;
         end;
         UBO.Iterators.Next (Iter);
      end loop;
      return UBO.Null_Object;
   end Find_Header;

   function Find_Value (Info : UBO.Object; Name : String) return Boolean is
      N : UBO.Object := UBO.Get_Value (Info, Name);
   begin
      if UBO.Is_Null (N) then
         return False;
      end if;
      N := UBO.Get_Value (N, "@value");
      if UBO.Is_Null (N) then
         return False;
      end if;
      return UBO.To_Boolean (N);
   end Find_Value;

   function Find_Value (Info : UBO.Object; Name : String) return UString is
      N : constant UBO.Object := UBO.Get_Value (Info, Name);
   begin
      if UBO.Is_Null (N) then
         return To_UString ("");
      else
         return UBO.To_Unbounded_String (N);
      end if;
   end Find_Value;

   procedure Load (License : in out License_Type;
                   Path    : in String) is
      Root, Graph, Info : Util.Beans.Objects.Object;
   begin
      Root := Util.Serialize.IO.JSON.Read (Path);
      Graph := Util.Beans.Objects.Get_Value (Root, "@graph");
      Info := Find_Header (Graph);
      License.OSI_Approved := Find_Value (Info, "spdx:isOsiApproved");
      License.FSF_Libre := Find_Value (Info, "spdx:isFsfLibre");
      License.Name := Find_Value (Info, "spdx:licenseId");
      License.Template := Find_Value (Info,
                                      "spdx:standardLicenseHeaderTemplate");
      License.License := Find_Value (Info, "spdx:licenseText");
      if Length (License.Template) = 0 then
         License.Template := Find_Value (Info, "spdx:standardLicenseTemplate");
      end if;
   end Load;

   function Get_Name (License : License_Type) return String is
   begin
      return To_String (License.Name);
   end Get_Name;

   function Get_Template (License : License_Type) return String is
   begin
      return To_String (License.Template);
   end Get_Template;

   procedure Save_License (License : in License_Type;
                           Path    : in String) is
      Content : constant String := To_String (License.Template);
      P : Natural := Content'First;
   begin
      while P < Content'Last and then Content (P) /= ASCII.LF loop
         P := P + 1;
      end loop;
      Log.Debug ("{0}", Content (Content'First .. P - 1));
      Util.Files.Write_File (Path, Content);
   end Save_License;

end SPDX_Tool.Licenses.Reader;
