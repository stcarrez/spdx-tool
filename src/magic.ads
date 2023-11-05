-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with System;
with Interfaces.C.Strings;
package Magic is

   type Flags is new Interfaces.C.unsigned;

   MAGIC_NONE     : constant Flags := 16#0000000#;
   MAGIC_DEBUG    : constant Flags := 16#0000001#;
   MAGIC_SYMLINK  : constant Flags := 16#0000002#;
   MAGIC_COMPRESS : constant Flags := 16#0000004#;
   MAGIC_DEVICES : constant Flags := 16#0000008#;
   MAGIC_MIME_TYPE : constant Flags := 16#0000010#;
   MAGIC_CONTINUE : constant Flags := 16#0000020#;
   MAGIC_CHECK : constant Flags := 16#0000040#;
   MAGIC_PRESERVE_ATIME : constant Flags := 16#0000080#;
   MAGIC_RAW : constant Flags := 16#0000100#;
   MAGIC_ERROR : constant Flags := 16#0000200#;
   MAGIC_MIME_ENCODING : constant Flags := 16#0000400#;
   MAGIC_MIME : constant Flags := MAGIC_MIME_TYPE or MAGIC_MIME_ENCODING;

   MAGIC_APPLE : constant Flags := 16#0000800#;
   MAGIC_EXTENSION : constant Flags := 16#1000000#;

   MAGIC_COMPRESS_TRANSP : constant Flags := 16#2000000#;
   MAGIC_NODESC : constant Flags := MAGIC_EXTENSION or MAGIC_MIME or MAGIC_APPLE;

   MAGIC_NO_CHECK_COMPRESS : constant Flags := 16#0001000#;  --  /usr/include/magic.h:52
   MAGIC_NO_CHECK_TAR : constant Flags := 16#0002000#;  --  /usr/include/magic.h:53
   MAGIC_NO_CHECK_SOFT : constant Flags := 16#0004000#;  --  /usr/include/magic.h:54
   MAGIC_NO_CHECK_APPTYPE : constant Flags := 16#0008000#;  --  /usr/include/magic.h:55
   MAGIC_NO_CHECK_ELF : constant Flags := 16#0010000#;  --  /usr/include/magic.h:56
   MAGIC_NO_CHECK_TEXT : constant Flags := 16#0020000#;  --  /usr/include/magic.h:57
   MAGIC_NO_CHECK_CDF : constant Flags := 16#0040000#;  --  /usr/include/magic.h:58
   MAGIC_NO_CHECK_CSV : constant Flags := 16#0080000#;  --  /usr/include/magic.h:59
   MAGIC_NO_CHECK_TOKENS : constant Flags := 16#0100000#;  --  /usr/include/magic.h:60
   MAGIC_NO_CHECK_ENCODING : constant Flags := 16#0200000#;  --  /usr/include/magic.h:61
   MAGIC_NO_CHECK_JSON : constant Flags := 16#0400000#;  --  /usr/include/magic.h:62
   MAGIC_NO_CHECK_BUILTIN : constant := MAGIC_NO_CHECK_COMPRESS or MAGIC_NO_CHECK_TAR
                                     or MAGIC_NO_CHECK_APPTYPE or MAGIC_NO_CHECK_ELF
                                     or MAGIC_NO_CHECK_TEXT or MAGIC_NO_CHECK_CSV
                                     or MAGIC_NO_CHECK_CDF or MAGIC_NO_CHECK_TOKENS
                                     or MAGIC_NO_CHECK_ENCODING or MAGIC_NO_CHECK_JSON;

   MAGIC_VERSION : constant := 541;  --  /usr/include/magic.h:116

   MAGIC_PARAM_INDIR_MAX : constant := 0;  --  /usr/include/magic.h:145
   MAGIC_PARAM_NAME_MAX : constant := 1;  --  /usr/include/magic.h:146
   MAGIC_PARAM_ELF_PHNUM_MAX : constant := 2;  --  /usr/include/magic.h:147
   MAGIC_PARAM_ELF_SHNUM_MAX : constant := 3;  --  /usr/include/magic.h:148
   MAGIC_PARAM_ELF_NOTES_MAX : constant := 4;  --  /usr/include/magic.h:149
   MAGIC_PARAM_REGEX_MAX : constant := 5;  --  /usr/include/magic.h:150
   MAGIC_PARAM_BYTES_MAX : constant := 6;  --  /usr/include/magic.h:151
   MAGIC_PARAM_ENCODING_MAX : constant := 7;  --  /usr/include/magic.h:152

   subtype chars_ptr is Interfaces.C.Strings.chars_ptr;

   type Magic_set is null record;   -- incomplete struct

   type Magic_t is access all Magic_set;  -- /usr/include/magic.h:123

   function Open (Config : in Flags) return Magic_t
     with Import => True, Convention => C, Link_Name => "magic_open";

   procedure Close (Cookie : in Magic_t)
     with Import => True, Convention => C, Link_Name => "magic_close";

   function Load (Cookie : in Magic_t;
                  Path   : in chars_ptr) return Integer
     with Import => True, Convention => C, Link_Name => "magic_load";

   function Errno (Cookie : in Magic_t) return Integer
     with Import => True, Convention => C, Link_Name => "magic_errno";

   function Error (Cookie : in Magic_t) return chars_ptr
     with Import => True, Convention => C, Link_Name => "magic_error";

   function File (Cookie : in Magic_t;
                  Path   : in chars_ptr) return chars_ptr
     with Import => True, Convention => C, Link_Name => "magic_file";

   function Buffer (Cookie : in Magic_t;
                    Buffer : in System.Address;
                    Size   : in Interfaces.C.size_t) return chars_ptr
     with Import => True, Convention => C, Link_Name => "magic_buffer";

   function Get_Flags (Cookie : in Magic_t) return Flags
     with Import => True, Convention => C, Link_Name => "magic_getflags";

   function Set_Flags (Cookie : in Magic_t;
                       Config : in Flags) return Integer
     with Import => True, Convention => C, Link_Name => "magic_setflags";

   function Version (Cookie : in Magic_t) return Integer
     with Import => True, Convention => C, Link_Name => "magic_version";

   pragma Linker_Options ("-lmagic");

end Magic;
