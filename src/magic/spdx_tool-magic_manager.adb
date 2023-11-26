-- --------------------------------------------------------------------
--  spdx_tool-magic -- File identification with libmagic
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Log.Loggers;
with Magic;
package body SPDX_Tool.Magic_Manager is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Magic");

   --  ------------------------------
   --  Initialize the magic manager and prepare the libmagic library.
   --  ------------------------------
   procedure Initialize (Manager : in out Magic_Manager;
                         Path    : in String) is
   begin
      Manager.Initialize (Magic.MAGIC_MIME, Path);

   exception
      when Magic.Manager.Error =>
         Log.Error ("cannot load magic file {0}: {1}",
                    Path, Manager.Last_Error);

   end Initialize;

end SPDX_Tool.Magic_Manager;
