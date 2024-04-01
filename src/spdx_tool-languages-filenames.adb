-- --------------------------------------------------------------------
--  spdx_tool-languages-filenames -- Detect language from file name or extension
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;
with SPDX_Tool.Languages.FilenameMap;
package body SPDX_Tool.Languages.Filenames is

   overriding
   procedure Detect (Detector : in Filename_Detector_Type;
                     File     : in File_Info;
                     Content  : in File_Type;
                     Result   : in out Detector_Result) is
      use type Language_Mappers.Match_Result;

      Filename : constant String := Ada.Directories.Simple_Name (File.Path);
      Match    : constant Language_Mappers.Filter_Result := Detector.File_Mapper.Match (File.Path);
      Kind     : constant access constant String := FilenameMap.Get_Mapping (Filename);
   begin
      if Match.Match = Language_Mappers.Found then
         declare
            Language : constant String := Language_Mappers.Get_Value (Match);
         begin
            Set_Languages (Result, Language);
         end;
      end if;
      Set_Languages (Result, Kind);
   end Detect;

end SPDX_Tool.Languages.Filenames;
