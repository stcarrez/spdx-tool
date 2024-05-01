-- --------------------------------------------------------------------
--  spdx_tool-languages-mimes -- Detect language from mime type
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Strings;
package body SPDX_Tool.Languages.Mimes is

   overriding
   procedure Detect (Detector : in Mime_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result) is
      pragma Unreferenced (Content);
      Mime : constant String := To_String (File.Mime);
   begin
      if Util.Strings.Starts_With (Mime, "text/") then
         if Util.Strings.Starts_With (Mime, "text/x-shellscript") then
            Set_Language (Result, "Shell", Detector.Confidence);
         elsif Util.Strings.Starts_With (Mime, "text/x-m4") then
            Set_Language (Result, "M4", Detector.Confidence);
         elsif Util.Strings.Starts_With (Mime, "text/x-makefile") then
            Set_Language (Result, "Makefile", Detector.Confidence);
         elsif Util.Strings.Starts_With (Mime, "text/xml") then
            Set_Language (Result, "XML", Detector.Confidence);
         else
            Set_Language (Result, "Text file", Detector.Confidence);
         end if;
      elsif Util.Strings.Starts_With (Mime, "image/") then
         Set_Language (Result, "Image", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "video/") then
         Set_Language (Result, "Video", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/pdf") then
         Set_Language (Result, "PDF", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/zip") then
         Set_Language (Result, "ZIP", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/x-tar") then
         Set_Language (Result, "TAR", Detector.Confidence);
      end if;
   end Detect;

end SPDX_Tool.Languages.Mimes;
