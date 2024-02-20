-- --------------------------------------------------------------------
--  spdx_tool-licenses-reader -- Read license description from JSON files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

package SPDX_Tool.Licenses.Reader is

   type License_Type is tagged limited record
      Name         : UString;
      Template     : UString;
      License      : UString;
      OSI_Approved : Boolean := False;
      FSF_Libre    : Boolean := False;
   end record;

   procedure Load (License : in out License_Type;
                   Path    : in String);

   procedure Save_License (License : in License_Type;
                           Path    : in String);

   function Get_Name (License : License_Type) return String;
   function Get_Template (License : License_Type) return String;

end SPDX_Tool.Licenses.Reader;
