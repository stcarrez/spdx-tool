-- --------------------------------------------------------------------
--  spdx_tool-licenses-repository -- licenses repository
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;
with Ada.Finalization;
with Ada.Containers.Hashed_Maps;

with SCI.Numbers;
with SCI.Vectorizers.Transformers;
with SPDX_Tool.Infos;
with SPDX_Tool.Counter_Arrays;
with SPDX_Tool.Token_Counters;
private package SPDX_Tool.Licenses.Repository is

   MAX_LICENSE_SIZE : constant := 64 * 1024;

   function Hash (Value : Token_Index) return Ada.Containers.Hash_Type is
      (Ada.Containers.Hash_Type (Value));

   package Token_License_Maps is
     new Ada.Containers.Hashed_Maps (Key_Type => Token_Index,
                                     Element_Type => License_Index_Map,
                                     Hash => Hash,
                                     Equivalent_Keys => "=");

   subtype Confidence_Type is Infos.Confidence_Type;
   use type Infos.Confidence_Type;
   function To_Float (Value : in Count_Type) return Float is (Float (Value));

   --  ??? Mul and Div seem necessary as "*" and "/" fail to instantiate
   function Mul (Left, Right : Confidence_Type) return Confidence_Type is (Left * Right);
   function Div (Left, Right : Confidence_Type) return Confidence_Type is (Left / Right);
   function From_Integer (Value : in Integer) return Confidence_Type is (Confidence_Type (Value));
   function From_Float (Value : in Float) return Confidence_Type is (Confidence_Type (Value));
   package Confidence_Numbers is new SCI.Numbers.Number (Confidence_Type, "*" => Mul, "/" => Div);
   package Confidence_Conversions is new SCI.Numbers.Conversion (Confidence_Numbers);

   package Freq_Transformers is
      new SCI.Vectorizers.Transformers (Frequency_Type => Float,
                                        Arrays         => SPDX_Tool.Counter_Arrays,
                                        Convert        => To_Float);
   package Frequency_Arrays renames Freq_Transformers.Frequency_Arrays;

   type Frequency_Array_Access is access all Freq_Transformers.Frequency_Array;

   type Float_Array is array (License_Index range <>) of Float;
   type Float_Array_Access is access all Float_Array;

   function Is_Ignored (Token : in Buffer_Type) return Boolean;

   --  Protect concurrent loading of license templates.
   protected type License_Tree is
      function Get_Count return License_Index;

      function Get_License (License : in License_Index) return Token_Access;

      function Get_Name (License : in License_Index) return UString;

      procedure Load_License (License : in License_Index;
                              Token   : out Token_Access);

      procedure Allocate_License (License  : out License_Index);

      procedure Set_License (License  : in License_Index;
                             Template : in License_Template);
   private
      Next_Index : License_Index := 0;
      Licenses   : License_Template_Array (0 .. License_Index'Last);
   end License_Tree;

   type Repository_Type is limited new Ada.Finalization.Limited_Controlled with record
      Repository     : aliased License_Tree;
      Instance       : access Repository_Type := Repository_Type'Unchecked_Access;
      Token_Counters : SPDX_Tool.Token_Counters.Vectorizer_Type;
      Dyn_Index      : Token_License_Maps.Map;

      --  A map of tokens used in license templates.
      Token_Frequency      : Frequency_Arrays.Array_Type;
      License_Squares      : Float_Array_Access;
      License_Frequency    : Frequency_Array_Access;
   end record;

   --  Get a printable representation of a list of licenses.
   function To_String (Repository : in Repository_Type;
                       List       : in License_Index_Array) return String;

   --  Get the license template for the given license index.
   function Get_License (Repository : in Repository_Type;
                         License    : in License_Index) return Token_Access;

   --  Read the license template with the given path and allocate
   --  a license index for that license template.
   procedure Read_License (Repository : in out Repository_Type;
                           Path       : in String;
                           License    : out License_Index) with
     Pre => Ada.Directories.Exists (Path);

   procedure Initialize_Tokens (Repository : in out Repository_Type);

   --  Configure the license token frequencies when we have loaded every license template.
   procedure Configure_Frequencies (Repository : in out Repository_Type);

   --  Given a list of lines with their tokens, compute the token frequencies.
   function Compute_Frequency (Repository : in Repository_Type;
                               Lines      : in SPDX_Tool.Languages.Line_Array;
                               From       : in Line_Number;
                               To         : in Line_Number) return Frequency_Arrays.Array_Type;

   --  Guess a best license based on the token inverse document frequencies (TIDF).
   function Guess_License (Repository : in Repository_Type;
                           Lines      : in SPDX_Tool.Languages.Line_Array;
                           From       : in Line_Number;
                           To         : in Line_Number) return License_Match;

   --  For each line, find the possible licenses and populate the Licenses field
   --  in each line.
   procedure Find_Possible_Licenses (Repository : in Repository_Type;
                                     Lines      : in out SPDX_Tool.Languages.Line_Array;
                                     From       : in Line_Number;
                                     To         : in Line_Number);

   function Find_License_Templates (Lines   : in SPDX_Tool.Languages.Line_Array;
                                    From    : in Line_Number;
                                    To      : in Line_Number) return License_Index_Array;

   function Find_License_Templates (Repository : in Repository_Type;
                                    Line       : in SPDX_Tool.Languages.Line_Type)
                                     return License_Index_Map;

   overriding
   procedure Finalize (Repository : in out Repository_Type);

end SPDX_Tool.Licenses.Repository;
