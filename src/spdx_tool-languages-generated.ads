-- --------------------------------------------------------------------
--  spdx_tool-languages-generated -- Detect generated languages
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

private package SPDX_Tool.Languages.Generated is

   type Generated_Detector_Type is limited new Detector_Type with record
      File_Mapper   : Language_Mappers.Filter_Type;
   end record;

   overriding
   procedure Detect (Detector : in Generated_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result);

end SPDX_Tool.Languages.Generated;
