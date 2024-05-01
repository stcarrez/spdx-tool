-- --------------------------------------------------------------------
--  spdx_tool-languages-extensions -- Detect language from file extensions
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;
with Util.Strings;
with SPDX_Tool.Languages.ExtensionMap;
package body SPDX_Tool.Languages.Extensions is

   function Get_Language_From_Extension (Path : in String) return access constant String;

   function Get_Language_From_Extension (Path : in String) return access constant String is
      Ext  : constant String := Ada.Directories.Extension (Path);
      Kind : access constant String := ExtensionMap.Get_Mapping (Ext);
   begin
      if Kind /= null then
         return Kind;
      end if;
      if Kind = null and then Util.Strings.Ends_With (Ext, "~") then
         Kind := ExtensionMap.Get_Mapping (Ext (Ext'First .. Ext'Last - 1));
      end if;
      if Kind /= null then
         return Kind;
      end if;
      return null;
   end Get_Language_From_Extension;

   overriding
   procedure Detect (Detector : in Extension_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result) is
      pragma Unreferenced (Content);

      Language : constant access constant String := Get_Language_From_Extension (File.Path);
   begin
      Set_Languages (Result, Language, 1.0);
   end Detect;

end SPDX_Tool.Languages.Extensions;
