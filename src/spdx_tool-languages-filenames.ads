-- --------------------------------------------------------------------
--  spdx_tool-languages-filenames -- Detect language from file name or extension
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

private package SPDX_Tool.Languages.Filenames is

   type Filename_Detector_Type is limited new Detector_Type with record
      File_Mapper   : Language_Mappers.Filter_Type;
   end record;

   overriding
   procedure Detect (Detector : in Filename_Detector_Type;
                     File     : in File_Info;
                     Content  : in File_Type;
                     Result   : in out Detector_Result);

end SPDX_Tool.Languages.Filenames;
