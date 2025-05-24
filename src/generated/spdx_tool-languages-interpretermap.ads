--  Advanced Resource Embedder 1.5.1
--  SPDX-License-Identifier: Apache-2.0
--  Interpreter mapping generated from interpreters.json
package SPDX_Tool.Languages.InterpreterMap is

   --  Returns the mapping that corresponds to the name or null.
   function Get_Mapping (Name : String) return
      access constant String;

end SPDX_Tool.Languages.InterpreterMap;
