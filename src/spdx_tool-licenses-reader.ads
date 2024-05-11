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

   type Parser_Type is abstract tagged limited record
      Current_Pos : Buffer_Index := 1;
      Token_Pos   : Buffer_Index := 1;
      Name_Pos    : Buffer_Index := 1;
      Name_End    : Buffer_Index := 1;
      Orig_Pos    : Buffer_Index := 1;
      Orig_End    : Buffer_Index := 1;
      Match_Pos   : Buffer_Index := 1;
      Match_End   : Buffer_Index := 1;
   end record;

   --  Parse the license text template that was extracted from the JSONLD file.
   --  The Parser instance is updated to indicate position of tokens found
   --  and the `Token` method is called for each token found as parsing progresses.
   procedure Parse (Parser  : in out Parser_Type'Class;
                    Content : in Buffer_Type);

   --  Called by `Parse` when a token is found.
   procedure Token (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    Token   : in Token_Kind) is abstract;

end SPDX_Tool.Licenses.Reader;
