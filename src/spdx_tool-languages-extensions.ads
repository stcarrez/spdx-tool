-- --------------------------------------------------------------------
--  spdx_tool-languages-extensions -- Detect language from file extensions
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

private package SPDX_Tool.Languages.Extensions is

   type Extension_Detector_Type is new Detector_Type with null record;

   overriding
   procedure Detect (Detector : in Extension_Detector_Type;
                     File     : in File_Info;
                     Buffer   : in Buffer_Type;
                     Result   : in out Detector_Result);

end SPDX_Tool.Languages.Extensions;
