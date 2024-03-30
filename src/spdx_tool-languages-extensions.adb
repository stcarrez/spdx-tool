-- --------------------------------------------------------------------
--  spdx_tool-languages-extensions -- Detect language from file extensions
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;
with SPDX_Tool.Extensions;
with Util.Strings.Tokenizers;
package body SPDX_Tool.Languages.Extensions is

   function Get_Language_From_Extension (Path : in String) return access constant String;

   function Get_Language_From_Extension (Path : in String) return access constant String is
      Ext  : constant String := Ada.Directories.Extension (Path);
      Kind : access constant String := SPDX_Tool.Extensions.Get_Mapping (Ext);
   begin
      if Kind /= null then
         return Kind;
      end if;
      if Kind = null and then Util.Strings.Ends_With (Ext, "~") then
         Kind := SPDX_Tool.Extensions.Get_Mapping (Ext (Ext'First .. Ext'Last - 1));
      end if;
      if Kind /= null then
         return Kind;
      end if;
      return null;
   end Get_Language_From_Extension;

   overriding
   procedure Detect (Detector : in Extension_Detector_Type;
                     File     : in File_Info;
                     Buffer   : in Buffer_Type;
                     Result   : in out Detector_Result) is
      procedure Collect (Item : in String; Done : out Boolean);

      procedure Collect (Item : in String; Done : out Boolean) is
      begin
         if Item'Length > 0 then
            Set_Language (Result, Item, 0);
         end if;
         Done := False;
      end Collect;

      Language : constant access constant String := Get_Language_From_Extension (File.Path);
   begin
      if Language /= null then
         if Util.Strings.Index (Language.all, ',') > 0 then
            Util.Strings.Tokenizers.Iterate_Tokens (Language.all, ",", Collect'Access);
         else
            Set_Language (Result, Language.all);
         end if;
      end if;
   end Detect;

end SPDX_Tool.Languages.Extensions;
