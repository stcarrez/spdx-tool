-- --------------------------------------------------------------------
--  spdx_tool-licenses-repository -- licenses repository
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Directories;

private with Ada.Finalization;
package SPDX_Tool.Licenses.Repository is

   MAX_LICENSE_SIZE : constant := 64 * 1024;

   type Repository_Type is tagged limited private;

   --  Get the license template for the given license index.
   function Get_License (Repository : in Repository_Type;
                         License    : in License_Index) return Token_Access;

   --  Read the license template with the given path and allocate
   --  a license index for that license template.
   procedure Read_License (Repository : in out Repository_Type;
                           Path       : in String;
                           License    : out License_Index) with
     Pre => Ada.Directories.Exists (Path);

private

   --  Protect concurrent loading of license templates.
   protected type License_Tree is
      function Get_License (License : in License_Index) return Token_Access;

      procedure Load_License (License : in License_Index;
                              Token   : out Token_Access);

      procedure Allocate_License (Template : in License_Template;
                                  License  : out License_Index);

   private
      Next_Index : License_Index := 0;
      Licenses   : License_Template_Array (0 .. License_Index'Last);
   end License_Tree;

   type Repository_Type is limited new Ada.Finalization.Limited_Controlled with record
      Repository : aliased License_Tree;
      Instance   : access Repository_Type := Repository_Type'Unchecked_Access;
   end record;

end SPDX_Tool.Licenses.Repository;
