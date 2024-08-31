-- --------------------------------------------------------------------
--  spdx_tool-infos -- result information collected while analyzing files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Containers.Indefinite_Ordered_Maps;
with Util.Strings;

package SPDX_Tool.Infos is

   MAX_LINES : constant := 100;
   MAX_LICENSES_PER_FILE : constant := 4;

   type Line_Count is new Natural range 0 .. MAX_LINES;

   type Line_Range_Type is record
      First_Line : Line_Count := 0;
      Last_Line  : Line_Count := 0;
   end record;

   --  Convert the string into a range of two integers.
   --  The string format is either <num> or <first>..<last>.
   --  A Constraint_Error exception is raised with a message if it is invalid.
   function Get_Range (Pattern : in String) return Line_Range_Type;

   subtype Line_Number is Line_Count range 1 .. Line_Count'Last;

   function Image (Line : in Line_Count)
                   return String is (Util.Strings.Image (Natural (Line)));

   function Image (Lines : in Line_Range_Type)
     return String is (Image (Lines.First_Line) & ".." & Image (Lines.Last_Line));

   --  Identifies the license implementation found:
   --  - LICENSE_FILE means the file corresponds to a license file,
   --  - SPDX_LICENSE indicates we found a license tag (strongest identification),
   --  - the TEMPLATE_LICENSE means we found a match in some license template,
   --  - the GUESSED_LICENSE means no exact match was found but some similarities exists,
   --  - the UNKNOWN_LICENSE means we found some header comment but didn't match
   --    any license.
   --  - NONE indicates there was no comment holding any license.
   type License_Kind is (LICENSE_FILE,
                         SPDX_LICENSE,
                         TEMPLATE_LICENSE,
                         GUESSED_LICENSE,
                         UNKNOWN_LICENSE,
                         NONE);

   --  The confidence of guessing the license.
   type Confidence_Type is delta 0.001 range 0.0 .. 1.0;

   --  Print the confidence as a percentage (0.0 .. 100.0%).
   function Percent_Image (Confidence : in Confidence_Type) return String;

   --  Information about the license that was identified in the file.
   type License_Info;
   type License_Info_Access is access License_Info;
   type License_Info is record
      Lines      : Line_Range_Type;
      Name       : UString;
      Match      : License_Kind := NONE;
      Confidence : Confidence_Type := 1.0;
      Next       : License_Info_Access;
   end record;

   function Lines_Image (Info : in License_Info) return String
      is (Image (Info.Lines)); --  Image (Info.First_Line) & ".." & Image (Info.Last_Line));

   type License_Count is new Natural range 0 .. MAX_LINES;
   type License_Array_Info is array (License_Count range <>) of License_Info;

   --  Holds the license text found in the header of the file
   type License_Text (Len : Buffer_Size) is record
      Content : Buffer_Type (1 .. Len);
   end record;
   type License_Text_Access is access all License_Text;

   type File_Kind is (FILE_PROGRAMMING, FILE_DOC, FILE_IMAGE, FILE_BINARY);

   --  Information collected for a file.  An instance is created for each
   --  file that is scanned and put in a File_Maps.  The file is analyzed
   --  by a separate thread which populates the `Language`, `Mime` and
   --  `License` info.
   type File_Info (Len : Natural) is record
      License   : License_Info;
      Mime      : UString;
      Language  : UString;
      Generated : UString;
      Path      : String (1 .. Len);
      Filtered  : Boolean := False;
      Text      : License_Text_Access;
      Kind      : File_Kind := FILE_PROGRAMMING;
   end record;
   type File_Info_Access is access all File_Info;

   package File_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (String, File_Info_Access);

   subtype File_Map is File_Maps.Map;
   subtype File_Cursor is File_Maps.Cursor;

end SPDX_Tool.Infos;
