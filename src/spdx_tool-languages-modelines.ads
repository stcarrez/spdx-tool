-- --------------------------------------------------------------------
--  spdx_tool-languages-modelines -- Detect language by looking at Emacs modeline
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

private package SPDX_Tool.Languages.Modelines is

   type Modeline_Detector_Type is new Detector_Type with null record;

   overriding
   procedure Detect (Detector : in Modeline_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result);

   function Emacs_Detect (Detector : in Modeline_Detector_Type;
                          Buffer   : in Buffer_Type;
                          Result   : in out Detector_Result) return Boolean;

   procedure Set_Language (Detector : in Modeline_Detector_Type;
                           Alias    : in String;
                           Result   : in out Detector_Result);

end SPDX_Tool.Languages.Modelines;
