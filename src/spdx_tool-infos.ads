-- --------------------------------------------------------------------
--  spdx_tool-infos -- result information collected while analyzing files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Containers.Indefinite_Ordered_Maps;
with Util.Strings;

package SPDX_Tool.Infos is

   MAX_LINES : constant := 100;

   type Line_Count is new Natural range 0 .. MAX_LINES;

   subtype Line_Number is Line_Count range 1 .. Line_Count'Last;

   function Image (Line : in Line_Count)
                   return String is (Util.Strings.Image (Natural (Line)));

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

   --  Information about the license that was identified in the file.
   type License_Info is record
      First_Line : Line_Count := 0;
      Last_Line  : Line_Count := 0;
      Name       : UString;
      Match      : License_Kind := NONE;
      Confidence : Confidence_Type := 1.0;
   end record;

   --  Holds the license text found in the header of the file
   type License_Text (Len : Buffer_Size) is record
      Content : Buffer_Type (1 .. Len);
   end record;
   type License_Text_Access is access all License_Text;

   --  Information collected for a file.  An instance is created for each
   --  file that is scanned and put in a File_Maps.  The file is analyzed
   --  by a separate thread which populates the `License` and `Mime` info.
   type File_Info (Len : Natural) is record
      License  : License_Info;
      Mime     : UString;
      Language : UString;
      Path     : String (1 .. Len);
      Filtered : Boolean := False;
      Text     : License_Text_Access;
   end record;
   type File_Info_Access is access all File_Info;

   package File_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (String, File_Info_Access);

   subtype File_Map is File_Maps.Map;
   subtype File_Cursor is File_Maps.Cursor;

end SPDX_Tool.Infos;
