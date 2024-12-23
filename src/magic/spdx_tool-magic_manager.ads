-- --------------------------------------------------------------------
--  spdx_tool-magic -- File identification with libmagic
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Magic.Manager;
package SPDX_Tool.Magic_Manager is

   HAS_MAGIC_SUPPORT : constant Boolean := True;

   subtype Magic_Manager is Magic.Manager.Magic_Manager;

   --  Initialize the magic manager and prepare the libmagic library.
   procedure Initialize (Manager : in out Magic_Manager;
                         Path    : in String);

end SPDX_Tool.Magic_Manager;
