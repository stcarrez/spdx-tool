-- --------------------------------------------------------------------
--  spdx_tool-configs -- configuration
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Ada.Containers.Indefinite_Ordered_Maps;
with GNAT.Strings;
with Util.Strings;
with TOML;

package SPDX_Tool.Configs is

   package Sections is
      DEFAULT     : constant String := "default";
      RULES       : constant String := "rules";
      LANGUAGES   : constant String := "languages";
      COMMENTS    : constant String := "comments";
      LICENSES    : constant String := "license-files";
   end Sections;

   package Names is
      COLOR           : constant String := "color";
      IGNORE          : constant String := "ignore";
   end Names;

   Config_Path     : aliased GNAT.Strings.String_Access;

   Error : exception;

   type Config_Type is tagged limited private;

   procedure Load_Default (Into : in out Config_Type);

   --  Read the tool configuration file.
   procedure Read (Into : in out Config_Type;
                   Path : in String);

private

   type Config_Type is tagged limited record
      Main : TOML.TOML_Value;
   end record;

end SPDX_Tool.Configs;
