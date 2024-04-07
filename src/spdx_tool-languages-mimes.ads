-- --------------------------------------------------------------------
--  spdx_tool-languages-mimes -- Detect language from mime type
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

private package SPDX_Tool.Languages.Mimes is

   type Mime_Detector_Type is new Detector_Type with record
      Confidence : Confidence_Type := 0.5;
   end record;

   overriding
   procedure Detect (Detector : in Mime_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result);

end SPDX_Tool.Languages.Mimes;
