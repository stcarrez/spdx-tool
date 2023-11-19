-- --------------------------------------------------------------------
--  spdx_tool-magic -- File identification with libmagic
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Finalization;

with Magic; use Magic;
package SPDX_Tool.Magic is

   package AF renames Ada.Finalization;

   type Magic_Manager is limited new AF.Limited_Controlled with private;

   --  Initialize the magic manager and prepare the libmagic library.
   procedure Initialize (Manager : in out Magic_Manager;
                         Path    : in String);

   --  Identify the content of the buffer by using the libmagic library.
   function Identify (Manager : in Magic_Manager;
                      Data    : in Buffer_Type) return String;

private

   type Magic_Manager is limited new AF.Limited_Controlled with record
      Magic_Cookie : Magic_t;
   end record;

   overriding
   procedure Finalize (Manager : in out Magic_Manager);

end SPDX_Tool.Magic;
