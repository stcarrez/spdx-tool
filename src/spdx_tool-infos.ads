-- --------------------------------------------------------------------
--  spdx_tool-infos -- result information collected while analyzing files
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Containers.Indefinite_Ordered_Maps;

package SPDX_Tool.Infos is

   --  Identifies the license implementation found:
   --  - SPDX_LICENSE indicates we found a license tag (strongest identification),
   --  - the TEMPLATE_LICENSE means we found a match in some license template,
   --  - the UNKNOWN_LICENSE means we found some header comment but didn't match
   --    any license.
   --  - NONE indicates there was no comment holding any license.
   type License_Kind is (SPDX_LICENSE,
                         TEMPLATE_LICENSE,
                         UNKNOWN_LICENSE,
                         NONE);

   --  Information about the license that was identified in the file.
   type License_Info is record
      First_Line : Natural := 0;
      Last_Line  : Natural := 0;
      Name       : UString;
      Match      : License_Kind := NONE;
   end record;

   --  Information collected for a file.  An instance is created for each
   --  file that is scanned and put in a File_Maps.  The file is analyzed
   --  by a separate thread which populates the `License` and `Mime` info.
   type File_Info (Len : Natural) is record
      License  : License_Info;
      Mime     : UString;
      Language : UString;
      Path     : String (1 .. Len);
   end record;
   type File_Info_Access is access all File_Info;

   package File_Maps is
     new Ada.Containers.Indefinite_Ordered_Maps (String, File_Info_Access);

   subtype File_Map is File_Maps.Map;
   subtype File_Cursor is File_Maps.Cursor;

end SPDX_Tool.Infos;
