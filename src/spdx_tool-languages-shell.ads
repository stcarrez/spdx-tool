-- --------------------------------------------------------------------
--  spdx_tool-languages-shell -- Shell detector language
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

private package SPDX_Tool.Languages.Shell is

   type Shell_Detector_Type is new Detector_Type with null record;

   overriding
   procedure Detect (Detector : in Shell_Detector_Type;
                     File     : in File_Info;
                     Buffer   : in Buffer_Type;
                     Result   : in out Detector_Result);

end SPDX_Tool.Languages.Shell;
