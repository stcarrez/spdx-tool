-- --------------------------------------------------------------------
--  spdx_tool-languages-filenames -- Detect language from file name or extension
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Strings.Tokenizers;
package body SPDX_Tool.Languages.Filenames is

   overriding
   procedure Detect (Detector : in Filename_Detector_Type;
                     File     : in File_Info;
                     Content  : in File_Type;
                     Result   : in out Detector_Result) is
      use type Language_Mappers.Match_Result;
      procedure Collect (Item : in String; Done : out Boolean);

      procedure Collect (Item : in String; Done : out Boolean) is
      begin
         if Item'Length > 0 then
            Set_Language (Result, Item, 0);
         end if;
         Done := False;
      end Collect;

      Match : constant Language_Mappers.Filter_Result := Detector.File_Mapper.Match (File.Path);
   begin
      if Match.Match = Language_Mappers.Found then
         declare
            Language : constant String := Language_Mappers.Get_Value (Match);
         begin
            if Util.Strings.Index (Language, ',') > 0 then
               Util.Strings.Tokenizers.Iterate_Tokens (Language, ",", Collect'Access);
            else
               Set_Language (Result, Language);
            end if;
         end;
      end if;
   end Detect;

end SPDX_Tool.Languages.Filenames;
