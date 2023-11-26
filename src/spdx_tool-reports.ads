-- --------------------------------------------------------------------
--  spdx_tool-reports -- print various reports about files and licenses
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with SPDX_Tool.Infos;
with PT.Drivers;
package SPDX_Tool.Reports is

   type Style_Configuration is record
      Title   : PT.Style_Type;
      Label   : PT.Style_Type;
      Default : PT.Style_Type;
      Marker1 : PT.Style_Type;
      Marker2 : PT.Style_Type;
      With_Progress : Boolean := True;
   end record;

   --  Print the license used and their associated number of files.
   procedure Print_Licenses (Printer : in out PT.Printer_Type'Class;
                             Styles  : in Style_Configuration;
                             Files   : in SPDX_Tool.Infos.File_Map);

   --  Print the files grouped by license.
   procedure Print_Files (Printer : in out PT.Printer_Type'Class;
                          Styles  : in Style_Configuration;
                          Files   : in SPDX_Tool.Infos.File_Map);

end SPDX_Tool.Reports;
