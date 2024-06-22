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
            Set_Language (Result, "mime", "Shell", Detector.Confidence);
         elsif Util.Strings.Starts_With (Mime, "text/x-m4") then
            Set_Language (Result, "mime", "M4", Detector.Confidence);
         elsif Util.Strings.Starts_With (Mime, "text/x-makefile") then
            Set_Language (Result, "mime", "Makefile", Detector.Confidence);
         elsif Util.Strings.Starts_With (Mime, "text/xml") then
            Set_Language (Result, "mime", "XML", Detector.Confidence);
         else
            Set_Language (Result, "mime", "Text file", Detector.Confidence);
         end if;
      elsif Util.Strings.Starts_With (Mime, "image/") then
         Set_Language (Result, "mime", "Image", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "video/") then
         Set_Language (Result, "mime", "Video", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/pdf") then
         Set_Language (Result, "mime", "PDF", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/zip") then
         Set_Language (Result, "mime", "ZIP", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/gzip") then
         Set_Language (Result, "mime", "GZIP", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/x-tar") then
         Set_Language (Result, "mime", "TAR", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/x-executable") then
         Set_Language (Result, "mime", "Executable", Detector.Confidence);
      elsif Util.Strings.Starts_With (Mime, "application/octet-stream") then
         Set_Language (Result, "mime", "Binary", Detector.Confidence);
      end if;
   end Detect;

end SPDX_Tool.Languages.Mimes;
