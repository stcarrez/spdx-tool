-- --------------------------------------------------------------------
--  spdx_tool-configs -- tool configuration
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with GNAT.Strings;
with TOML;
with Util.Strings.Vectors;

package SPDX_Tool.Configs is

   package Sections is
      DEFAULT     : constant String := "default";
      RULES       : constant String := "rules";
      LANGUAGES   : constant String := "languages";
      COMMENTS    : constant String := "comments";
      LICENSES    : constant String := "license-files";
   end Sections;

   package Names is
      COLOR               : constant String := "color";
      IGNORE              : constant String := "ignore";
      NO_BUILTIN_LICENSES : constant String := "no-builtin-licenses";

      START               : constant String := "start";
      BLOCK_START         : constant String := "block-start";
      BLOCK_END           : constant String := "block-end";
      COMMENT             : constant String := "comment";
      ALTERNATIVE         : constant String := "alternative";
   end Names;

   Config_Path     : aliased GNAT.Strings.String_Access;

   Error : exception;

   type Config_Type is tagged limited private;

   --  Load the default configuration embedded in the tool.
   procedure Load_Default (Into : in out Config_Type);

   --  Read the tool configuration file.
   procedure Read (Into : in out Config_Type;
                   Path : in String);

   procedure Configure (From    : in Config_Type;
                        Name    : in String;
                        Process : not null access procedure (Value : in String));

   type Comment_Configuration is record
      Language    : UString;
      Start       : UString;
      Block_Start : UString;
      Block_End   : UString;
      Alternative : UString;
   end record;

   procedure Configure (From    : in Config_Type;
                        Process : not null access
                         procedure (Config : in Comment_Configuration));

   type Language_Configuration is record
      Language   : UString;
      Extensions : Util.Strings.Vectors.Vector;
      Comment    : UString;
   end record;

   procedure Configure (From    : in Config_Type;
                        Process : not null access
                         procedure (Config : in Language_Configuration));

private

   type Config_Type is tagged limited record
      Main    : TOML.TOML_Value;
      Default : TOML.TOML_Value;
   end record;

end SPDX_Tool.Configs;
