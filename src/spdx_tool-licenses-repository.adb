-- --------------------------------------------------------------------
--  spdx_tool-licenses-repository -- licenses repository
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;
with Util.Log.Loggers;
with Util.Streams.Files;
with SPDX_Tool.Licenses.Reader;
with SPDX_Tool.Licenses.Files;
package body SPDX_Tool.Licenses.Repository is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses.Repository");

   --  ------------------------------
   --  Get the license template for the given license index.
   --  ------------------------------
   function Get_License (Repository : in Repository_Type;
                         License    : in License_Index) return Token_Access is
      Token : Token_Access;
   begin
      Token := Repository.Instance.Repository.Get_License (License);
      if Token = null then
         Repository.Instance.Repository.Load_License (License, Token);
      end if;
      return Token;
   end Get_License;

   --  ------------------------------
   --  Read the license template with the given path and allocate
   --  a license index for that license template.
   --  ------------------------------
   procedure Read_License (Repository : in out Repository_Type;
                           Path       : in String;
                           License    : out License_Index) is
      use type Ada.Directories.File_Size;

      Ext  : constant String := Ada.Directories.Extension (Path);
      Size : constant Ada.Directories.File_Size := Ada.Directories.Size (Path);
      Info : Reader.License_Type;
      Template : License_Template;
   begin
      if Size = 0 or else Size > MAX_LICENSE_SIZE then
         Log.Error ("license file {0} is too big", Path);
         return;
      end if;
      if Ext = "jsonld" then
         Reader.Load_JSON (Info, Path);
         declare
            Name    : constant String := To_String (Info.Name);
            Content : String := To_String (Info.Template);
            Buffer  : Buffer_Type (1 .. Content'Length);
            for Buffer'Address use Content'Address;
         begin
            Reader.Load_License (Name, Buffer, Template);
         end;
      else
         declare
            File   : Util.Streams.Files.File_Stream;
            Buffer : Buffer_Type (1 .. Buffer_Size (Size));
            Last   : Ada.Streams.Stream_Element_Offset;
            Name   : constant String := Ada.Directories.Base_Name (Path);
         begin
            File.Open (Mode => Ada.Streams.Stream_IO.In_File, Name => Path);
            File.Read (Into => Buffer, Last => Last);
            Reader.Load_License (Name, Buffer (1 .. Last), Template);
         end;
      end if;
      Repository.Repository.Allocate_License (Template, License);
   end Read_License;

   protected body License_Tree is

      function Get_License (License : in License_Index) return Token_Access is
      begin
         return Licenses (License).Root;
      end Get_License;

      procedure Load_License (License : in License_Index;
                              Token    : out Token_Access) is
         Stamp : Util.Measures.Stamp;
      begin
         Token := Licenses (License).Root;
         if Token = null then
            Reader.Load_License (License, Licenses (License), Token);
            if Token /= null then
               Licenses (License).Root := Token;
            else
               Log.Debug ("No license loaded for {0}",
                          SPDX_Tool.Licenses.Files.Names (License).all);
            end if;
         end if;
         Report (Stamp, "Load template license");
      end Load_License;

      procedure Allocate_License (Template : in License_Template;
                                  License  : out License_Index) is
      begin
         if Next_Index = 0 then
            Next_Index := SPDX_Tool.Licenses.Files.Names'Last + 1;
         end if;
         License := Next_Index;
         Licenses (License) := Template;
         Next_Index := Next_Index + 1;
      end Allocate_License;

   end License_Tree;

end SPDX_Tool.Licenses.Repository;
