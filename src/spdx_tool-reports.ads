-- --------------------------------------------------------------------
--  spdx_tool-reports -- print various reports about files and licenses
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with GNAT.Strings;
with SPDX_Tool.Infos;
with PT.Drivers;
with SPDX_Tool.Licenses;
package SPDX_Tool.Reports is

   Json_Path      : aliased GNAT.Strings.String_Access;
   Xml_Path       : aliased GNAT.Strings.String_Access;

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

   --  Print the mime types used and their associated number of files.
   procedure Print_Mimes (Printer : in out PT.Printer_Type'Class;
                          Styles  : in Style_Configuration;
                          Files   : in SPDX_Tool.Infos.File_Map);

   --  Print the languages used and their associated number of files.
   procedure Print_Languages (Printer : in out PT.Printer_Type'Class;
                              Styles  : in Style_Configuration;
                              Files   : in SPDX_Tool.Infos.File_Map);

   type Identify_Mode is (PRINT_LICENSE, PRINT_LANGUAGE);

   --  Print the license or language name with the file name as prefix.
   procedure Print_Identify (Printer : in out PT.Printer_Type'Class;
                             Styles  : in Style_Configuration;
                             Files   : in SPDX_Tool.Infos.File_Map;
                             Mode    : in Identify_Mode);

   --  Print the license texts content found in header files.
   procedure Print_Texts (Printer   : in out PT.Printer_Type'Class;
                          Styles    : in Style_Configuration;
                          Files     : in SPDX_Tool.Infos.File_Map;
                          Show_Line : in Boolean);

   procedure Print_License_Text (Printer   : in out PT.Printer_Type'Class;
                                 Styles    : in Style_Configuration;
                                 Text      : in Infos.License_Text;
                                 Show_Line : in Boolean);

   --  Print the tokens defined by the token array (used for debugging).
   procedure Print_Tokens (Printer : in out PT.Printer_Type'Class;
                           Styles  : in Style_Configuration;
                           Tokens  : in SPDX_Tool.Licenses.Token_Array);

   --  Write a JSON report with the license and files that were identified.
   procedure Write_Json (Path  : in String;
                         Files : in SPDX_Tool.Infos.File_Map);
   procedure Write_Xml (Path  : in String;
                        Files : in SPDX_Tool.Infos.File_Map);

end SPDX_Tool.Reports;
