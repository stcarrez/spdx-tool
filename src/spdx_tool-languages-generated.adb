-- --------------------------------------------------------------------
--  spdx_tool-languages-generated -- Detect generated languages
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with SPDX_Tool.Languages.Rules;
with SPDX_Tool.Languages.Rules.Generated;
package body SPDX_Tool.Languages.Generated is

   use Rules;

   overriding
   procedure Detect (Detector : in Generated_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result) is
      Definition : Rules.Rules_List renames Rules.Generated.Definition;
      Pos : constant Rules.Rule_Index := Rules.Find (Definition, File, Content);
   begin
      if Pos > 0 and then Definition.Rules (Pos).Result > 0 then
         Set_Generated (Result, Definition.Strings (Definition.Rules (Pos).Result).all);
      end if;
   end Detect;

end SPDX_Tool.Languages.Generated;
