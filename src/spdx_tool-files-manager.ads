-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with SPDX_Tool.Infos;
with SPDX_Tool.Magic_Manager;
with SPDX_Tool.Languages.Manager;
package SPDX_Tool.Files.Manager is

   type File_Manager is tagged limited private;
   type File_Manager_Access is access all File_Manager;

   --  Initialize the file manager and prepare the libmagic library.
   procedure Initialize (Manager : in out File_Manager;
                         Path    : in String);

   --  Open the file and read the first data block (4K) to identify the
   --  language and comment headers.
   procedure Open (Manager   : in File_Manager;
                   Data      : in out File_Type;
                   File      : in out SPDX_Tool.Infos.File_Info;
                   Languages : in SPDX_Tool.Languages.Manager.Language_Manager);

   --  Save the file to replace the header license template by the corresponding
   --  SPDX license header.
   procedure Save (Manager : in File_Manager;
                   File    : in out File_Type;
                   Path    : in String;
                   First   : in Line_Number;
                   Last    : in Line_Number;
                   Before  : in Line_Range_Type;
                   After   : in Line_Range_Type;
                   License : in String);

private

   type File_Manager is tagged limited record
      Magic_Manager : SPDX_Tool.Magic_Manager.Magic_Manager;
      Buffer        : Buffer_Ref;
   end record;

   --  Identify the file mime type.
   procedure Find_Mime_Type (Manager : in File_Manager;
                             File    : in out SPDX_Tool.Infos.File_Info;
                             Buffer  : in Buffer_Type);

end SPDX_Tool.Files.Manager;
