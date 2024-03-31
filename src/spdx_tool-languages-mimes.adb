-- --------------------------------------------------------------------
--  spdx_tool-languages-mimes -- Detect language from mime type
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
package body SPDX_Tool.Languages.Mimes is

   overriding
   procedure Detect (Detector : in Mime_Detector_Type;
                     File     : in File_Info;
                     Content  : in File_Type;
                     Result   : in out Detector_Result) is
      Mime : constant String := To_String (File.Mime);
   begin
      if Util.Strings.Starts_With (Mime, "text/") then
         if Util.Strings.Starts_With (Mime, "text/x-shellscript") then
            Set_Language (Result, "Shell");
         elsif Util.Strings.Starts_With (Mime, "text/x-m4") then
            Set_Language (Result, "M4");
         elsif Util.Strings.Starts_With (Mime, "text/x-makefile") then
            Set_Language (Result, "Makefile");
         elsif Util.Strings.Starts_With (Mime, "text/xml") then
            Set_Language (Result, "XML");
         else
            Set_Language (Result, "Text file");
         end if;
      elsif Util.Strings.Starts_With (Mime, "image/") then
         Set_Language (Result, "Image");
      elsif Util.Strings.Starts_With (Mime, "video/") then
         Set_Language (Result, "Video");
      elsif Util.Strings.Starts_With (Mime, "application/pdf") then
         Set_Language (Result, "PDF");
      elsif Util.Strings.Starts_With (Mime, "application/zip") then
         Set_Language (Result, "ZIP");
      elsif Util.Strings.Starts_With (Mime, "application/x-tar") then
         Set_Language (Result, "TAR");
      end if;
   end Detect;

end SPDX_Tool.Languages.Mimes;
