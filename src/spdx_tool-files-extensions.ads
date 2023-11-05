--  Advanced Resource Embedder 1.3.0
--  SPDX-License-Identifier: Apache-2.0
--  Extensions mapping generated from extensions.json
package SPDX_Tool.Files.Extensions is

   type Content_Access is access constant String;

   --  Returns the mapping that corresponds to the name or null.
   function Get_Mapping (Name : String) return
      access constant String;

end SPDX_Tool.Files.Extensions;
