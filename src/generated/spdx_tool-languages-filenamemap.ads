--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Filename mapping generated from filenames.json
package SPDX_Tool.Languages.FilenameMap is

   --  Returns the mapping that corresponds to the name or null.
   function Get_Mapping (Name : String) return
      access constant String;

end SPDX_Tool.Languages.FilenameMap;