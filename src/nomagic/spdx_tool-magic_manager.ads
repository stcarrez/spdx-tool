-- --------------------------------------------------------------------
--  spdx_tool-nomagic -- File identification with libmagic
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Streams;
package SPDX_Tool.Magic_Manager is

   type Magic_Manager is tagged record A : Natural := 0; end record;

   procedure Initialize (Manager : in out Magic_Manager;
                         Path    : in String);

   --  Check whether the manager and the libmagic library is initialized.
   function Is_Initialized (Manager : in Magic_Manager) return Boolean
      is (True);

   --  Identify the content of the buffer by using the libmagic library.
   function Identify (Manager : in Magic_Manager;
                      Data    : in Ada.Streams.Stream_Element_Array)
                      return String is ("");

end SPDX_Tool.Magic_Manager;
