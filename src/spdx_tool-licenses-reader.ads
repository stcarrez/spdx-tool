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
      Is_Exception : Boolean := False;
   end record;

   procedure Load_JSON (License : in out License_Type;
                        Path    : in String);

   procedure Save_License (License : in License_Type;
                           Path    : in String);

   function Get_Name (License : License_Type) return String;
   function Get_Template (License : License_Type) return String;

   type Abstract_Parser_Type is abstract tagged limited record
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
   procedure Parse (Parser  : in out Abstract_Parser_Type'Class;
                    Content : in Buffer_Type);

   --  Called by `Parse` when a token is found.
   procedure Token (Parser  : in out Abstract_Parser_Type;
                    Content : in Buffer_Type;
                    Token   : in Token_Kind) is abstract;

   type Parser_Type is new Abstract_Parser_Type with private;

   overriding
   procedure Token (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    Token   : in SPDX_Tool.Licenses.Token_Kind);

   procedure Parse (Parser  : in out Parser_Type;
                    Content : in Buffer_Type;
                    License : in out License_Template);

   procedure Load_License (Name    : in String;
                           Content : in Buffer_Type;
                           License : in out License_Template);

   procedure Load_License (License : in License_Index;
                           Name    : in UString;
                           Into    : in out License_Template;
                           Tokens  : out Token_Access);

private

   MAX_NESTED_OPTIONAL : constant := 10;

   type Optional_Index is new Natural range 0 .. MAX_NESTED_OPTIONAL;
   type Optional_Token_Array_Access is
      array (Optional_Index range 1 .. MAX_NESTED_OPTIONAL) of Optional_Token_Access;

   type Parser_Type is new Abstract_Parser_Type with record
      Root        : Token_Access;
      Token       : Token_Access;
      Previous    : Token_Access;
      Optionals   : Optional_Token_Array_Access;
      Optional    : Optional_Index := 0;
      Saved       : Token_Access;
      Token_Count : Natural := 0;
      License     : UString;
   end record;

   function Find_Token (Parser : in Parser_Type;
                        Word   : in Buffer_Type) return Token_Access;

   procedure Append_Token (Parser : in out Parser_Type;
                           Token  : in Token_Access);

end SPDX_Tool.Licenses.Reader;
