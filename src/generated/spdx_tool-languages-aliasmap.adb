--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Alias mapping generated from aliases.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.AliasMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 9) of Natural :=
     (1, 2, 3, 4, 5, 6, 9, 10, 11, 14);

   T1 : constant array (0 .. 9) of Unsigned_16 :=
     (204, 447, 96, 631, 81, 107, 360, 328, 450, 432);

   T2 : constant array (0 .. 9) of Unsigned_16 :=
     (344, 488, 543, 411, 150, 229, 572, 701, 71, 217);

   G : constant array (0 .. 732) of Unsigned_16 :=
     (0, 168, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 224, 0, 0, 0, 0, 183, 0, 0, 0,
      241, 250, 0, 0, 149, 103, 262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 308,
      0, 0, 135, 0, 0, 26, 0, 364, 248, 0, 0, 0, 0, 0, 0, 301, 0, 33, 0, 74,
      215, 215, 202, 0, 0, 0, 0, 333, 0, 225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50,
      137, 316, 0, 73, 277, 0, 358, 281, 0, 24, 74, 0, 0, 49, 0, 0, 236,
      261, 0, 0, 0, 0, 283, 0, 62, 0, 0, 0, 335, 322, 299, 18, 0, 164, 0, 0,
      0, 0, 0, 308, 0, 40, 0, 0, 151, 0, 0, 0, 0, 0, 0, 249, 137, 0, 0, 0,
      11, 0, 8, 0, 0, 0, 279, 209, 85, 0, 0, 0, 0, 311, 301, 0, 0, 156, 0,
      329, 0, 0, 0, 334, 231, 0, 20, 0, 84, 0, 0, 20, 279, 142, 206, 265, 0,
      166, 0, 64, 0, 104, 7, 328, 91, 318, 0, 0, 0, 0, 272, 339, 0, 291,
      280, 12, 80, 0, 0, 336, 0, 128, 0, 263, 177, 0, 305, 182, 332, 0, 107,
      16, 0, 0, 184, 0, 0, 61, 105, 347, 340, 305, 0, 304, 0, 130, 0, 0,
      174, 182, 306, 0, 0, 178, 79, 0, 28, 20, 0, 139, 54, 79, 0, 0, 0, 93,
      0, 103, 0, 0, 167, 0, 45, 299, 341, 17, 259, 223, 20, 0, 0, 0, 67, 0,
      0, 0, 0, 131, 0, 0, 0, 78, 0, 0, 0, 0, 0, 250, 136, 77, 0, 0, 0, 0,
      246, 351, 0, 0, 62, 16, 0, 216, 271, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
      150, 0, 0, 319, 179, 82, 179, 0, 0, 115, 285, 0, 0, 0, 318, 64, 0, 40,
      0, 0, 85, 0, 0, 0, 0, 0, 192, 162, 49, 242, 0, 0, 0, 0, 0, 0, 0, 159,
      148, 0, 202, 340, 223, 0, 26, 201, 0, 92, 255, 0, 0, 0, 0, 0, 0, 0, 0,
      22, 181, 0, 0, 0, 0, 0, 5, 21, 0, 0, 363, 0, 0, 0, 0, 0, 0, 0, 227, 0,
      144, 0, 0, 0, 267, 20, 32, 217, 0, 95, 92, 0, 0, 205, 0, 175, 160,
      143, 59, 71, 0, 11, 2, 0, 0, 0, 0, 0, 58, 91, 142, 36, 0, 15, 0, 228,
      0, 332, 0, 243, 0, 352, 331, 122, 151, 0, 50, 325, 308, 0, 0, 0, 36,
      16, 294, 0, 0, 275, 0, 0, 57, 193, 0, 0, 160, 8, 273, 86, 271, 158,
      16, 291, 0, 10, 0, 0, 275, 175, 246, 0, 305, 0, 55, 328, 184, 272, 0,
      0, 69, 0, 0, 0, 355, 0, 233, 66, 0, 4, 346, 359, 110, 0, 305, 0, 132,
      3, 73, 48, 52, 0, 0, 0, 0, 0, 348, 21, 0, 0, 1, 291, 208, 172, 0, 0,
      129, 0, 154, 0, 0, 0, 119, 0, 0, 34, 253, 275, 29, 199, 0, 0, 0, 0,
      85, 0, 75, 135, 0, 0, 0, 0, 0, 153, 0, 0, 282, 181, 0, 87, 145, 0, 0,
      23, 0, 254, 73, 0, 333, 202, 0, 223, 171, 156, 0, 27, 164, 0, 0, 246,
      323, 0, 112, 30, 39, 0, 0, 0, 335, 0, 0, 68, 68, 0, 0, 268, 0, 0, 307,
      295, 0, 320, 97, 0, 211, 51, 0, 96, 272, 31, 0, 166, 6, 106, 0, 338,
      335, 234, 237, 243, 266, 163, 142, 0, 128, 177, 273, 0, 0, 0, 302,
      126, 227, 195, 37, 343, 325, 0, 0, 0, 110, 0, 0, 276, 0, 129, 0, 355,
      0, 0, 78, 194, 0, 240, 0, 56, 116, 271, 0, 8, 274, 139, 362, 28, 188,
      0, 0, 88, 316, 25, 132, 0, 0, 175, 0, 0, 19, 201, 116, 124, 251, 110,
      304, 331, 0, 0, 25, 44, 0, 0, 0, 0, 53, 270, 0, 0, 0, 19, 359, 332, 0,
      0, 0, 0, 154, 0, 5, 237, 0, 14, 13, 83, 282, 0, 185, 0, 0, 204, 242,
      0, 0, 7, 25, 258, 186, 0, 81, 252, 0, 0, 0, 0, 94, 54, 337, 0, 214,
      156, 262, 0, 104, 117, 74, 308, 165, 0, 23, 0, 0, 98, 76, 0, 330, 0,
      266, 0, 179, 264);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 733;
         F2 := (F2 + Natural (T2 (K)) * J) mod 733;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 366;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "specfile";
   M_0             : aliased constant String := "RPM Spec";
   K_1             : aliased constant String := "vb6";
   M_1             : aliased constant String := "Visual Basic 6.0";
   K_2             : aliased constant String := "actionscript3";
   M_2             : aliased constant String := "ActionScript";
   K_3             : aliased constant String := "protobuf";
   M_3             : aliased constant String := "Protocol Buffer";
   K_4             : aliased constant String := "adobe multiple font metrics";
   M_4             : aliased constant String := "Adobe Font Metrics";
   K_5             : aliased constant String := "apkbuild";
   M_5             : aliased constant String := "Alpine Abuild";
   K_6             : aliased constant String := "fb";
   M_6             : aliased constant String := "FreeBasic";
   K_7             : aliased constant String := "UltiSnip";
   M_7             : aliased constant String := "Vim Snippet";
   K_8             : aliased constant String := "pcbnew";
   M_8             : aliased constant String := "KiCad Layout";
   K_9             : aliased constant String := "esdl";
   M_9             : aliased constant String := "EdgeQL";
   K_10            : aliased constant String := "chpl";
   M_10            : aliased constant String := "Chapel";
   K_11            : aliased constant String := "soy";
   M_11            : aliased constant String := "Closure Templates";
   K_12            : aliased constant String := "go work sum";
   M_12            : aliased constant String := "Go Checksums";
   K_13            : aliased constant String := "rs-274x";
   M_13            : aliased constant String := "Gerber Image";
   K_14            : aliased constant String := "ql";
   M_14            : aliased constant String := "CodeQL";
   K_15            : aliased constant String := "go.work.sum";
   M_15            : aliased constant String := "Go Checksums";
   K_16            : aliased constant String := "fsharp";
   M_16            : aliased constant String := "F#";
   K_17            : aliased constant String := "xdr";
   M_17            : aliased constant String := "RPC";
   K_18            : aliased constant String := "inputrc";
   M_18            : aliased constant String := "Readline Config";
   K_19            : aliased constant String := "amusewiki";
   M_19            : aliased constant String := "Muse";
   K_20            : aliased constant String := "tm-properties";
   M_20            : aliased constant String := "TextMate Properties";
   K_21            : aliased constant String := "max/msp";
   M_21            : aliased constant String := "Max";
   K_22            : aliased constant String := "elisp";
   M_22            : aliased constant String := "Emacs Lisp";
   K_23            : aliased constant String := "csound-sco";
   M_23            : aliased constant String := "Csound Score";
   K_24            : aliased constant String := "ad block filters";
   M_24            : aliased constant String := "Adblock Filter List";
   K_25            : aliased constant String := "rpcgen";
   M_25            : aliased constant String := "RPC";
   K_26            : aliased constant String := "mdoc";
   M_26            : aliased constant String := "Roff";
   K_27            : aliased constant String := "html+ruby";
   M_27            : aliased constant String := "HTML+ERB";
   K_28            : aliased constant String := "wsdl";
   M_28            : aliased constant String := "XML";
   K_29            : aliased constant String := "clipper";
   M_29            : aliased constant String := "xBase";
   K_30            : aliased constant String := "objc";
   M_30            : aliased constant String := "Objective-C";
   K_31            : aliased constant String := "ascii stl";
   M_31            : aliased constant String := "STL";
   K_32            : aliased constant String := "visual basic 6";
   M_32            : aliased constant String := "Visual Basic 6.0";
   K_33            : aliased constant String := "jruby";
   M_33            : aliased constant String := "Ruby";
   K_34            : aliased constant String := "objectivec";
   M_34            : aliased constant String := "Objective-C";
   K_35            : aliased constant String := "inform7";
   M_35            : aliased constant String := "Inform 7";
   K_36            : aliased constant String := "objj";
   M_36            : aliased constant String := "Objective-J";
   K_37            : aliased constant String := "asm";
   M_37            : aliased constant String := "Assembly";
   K_38            : aliased constant String := "asp";
   M_38            : aliased constant String := "Classic ASP";
   K_39            : aliased constant String := "pikchr";
   M_39            : aliased constant String := "Pic";
   K_40            : aliased constant String := "ahk";
   M_40            : aliased constant String := "AutoHotkey";
   K_41            : aliased constant String := "Justfile";
   M_41            : aliased constant String := "Just";
   K_42            : aliased constant String := "objectivej";
   M_42            : aliased constant String := "Objective-J";
   K_43            : aliased constant String := "Git Blame Ignore Revs";
   M_43            : aliased constant String := "Git Revision List";
   K_44            : aliased constant String := "oncrpc";
   M_44            : aliased constant String := "RPC";
   K_45            : aliased constant String := "aspx";
   M_45            : aliased constant String := "ASP.NET";
   K_46            : aliased constant String := "heex";
   M_46            : aliased constant String := "HTML+EEX";
   K_47            : aliased constant String := "rusthon";
   M_47            : aliased constant String := "Python";
   K_48            : aliased constant String := "nasm";
   M_48            : aliased constant String := "Assembly";
   K_49            : aliased constant String := "coldfusion html";
   M_49            : aliased constant String := "ColdFusion";
   K_50            : aliased constant String := "wolfram";
   M_50            : aliased constant String := "Mathematica";
   K_51            : aliased constant String := "django";
   M_51            : aliased constant String := "Jinja";
   K_52            : aliased constant String := "golang";
   M_52            : aliased constant String := "Go";
   K_53            : aliased constant String := "HashiCorp Configuration Language";
   M_53            : aliased constant String := "HCL";
   K_54            : aliased constant String := "posh";
   M_54            : aliased constant String := "PowerShell";
   K_55            : aliased constant String := "redirects";
   M_55            : aliased constant String := "Redirect Rules";
   K_56            : aliased constant String := "zsh";
   M_56            : aliased constant String := "Shell";
   K_57            : aliased constant String := "salt";
   M_57            : aliased constant String := "SaltStack";
   K_58            : aliased constant String := "nush";
   M_58            : aliased constant String := "Nu";
   K_59            : aliased constant String := "ksy";
   M_59            : aliased constant String := "Kaitai Struct";
   K_60            : aliased constant String := "make";
   M_60            : aliased constant String := "Makefile";
   K_61            : aliased constant String := "typ";
   M_61            : aliased constant String := "Typst";
   K_62            : aliased constant String := "go.mod";
   M_62            : aliased constant String := "Go Module";
   K_63            : aliased constant String := "wasm";
   M_63            : aliased constant String := "WebAssembly";
   K_64            : aliased constant String := "litcoffee";
   M_64            : aliased constant String := "Literate CoffeeScript";
   K_65            : aliased constant String := "ecr";
   M_65            : aliased constant String := "HTML+ECR";
   K_66            : aliased constant String := "odin-lang";
   M_66            : aliased constant String := "Odin";
   K_67            : aliased constant String := "obj-c";
   M_67            : aliased constant String := "Objective-C";
   K_68            : aliased constant String := "vbnet";
   M_68            : aliased constant String := "Visual Basic .NET";
   K_69            : aliased constant String := "pycon";
   M_69            : aliased constant String := "Python console";
   K_70            : aliased constant String := "openedge";
   M_70            : aliased constant String := "OpenEdge ABL";
   K_71            : aliased constant String := "email";
   M_71            : aliased constant String := "E-mail";
   K_72            : aliased constant String := "renpy";
   M_72            : aliased constant String := "Ren'Py";
   K_73            : aliased constant String := "wast";
   M_73            : aliased constant String := "WebAssembly";
   K_74            : aliased constant String := "man page";
   M_74            : aliased constant String := "Roff";
   K_75            : aliased constant String := "htmldjango";
   M_75            : aliased constant String := "Jinja";
   K_76            : aliased constant String := "obj-j";
   M_76            : aliased constant String := "Objective-J";
   K_77            : aliased constant String := "cds";
   M_77            : aliased constant String := "CAP CDS";
   K_78            : aliased constant String := "regexp";
   M_78            : aliased constant String := "Regular Expression";
   K_79            : aliased constant String := "mediawiki";
   M_79            : aliased constant String := "Wikitext";
   K_80            : aliased constant String := "ecmarkdown";
   M_80            : aliased constant String := "Ecmarkup";
   K_81            : aliased constant String := "geojson";
   M_81            : aliased constant String := "JSON";
   K_82            : aliased constant String := "vb.net";
   M_82            : aliased constant String := "Visual Basic .NET";
   K_83            : aliased constant String := "cake";
   M_83            : aliased constant String := "C#";
   K_84            : aliased constant String := "protobuf text format";
   M_84            : aliased constant String := "Protocol Buffer Text Format";
   K_85            : aliased constant String := "au3";
   M_85            : aliased constant String := "AutoIt";
   K_86            : aliased constant String := "vb 6";
   M_86            : aliased constant String := "Visual Basic 6.0";
   K_87            : aliased constant String := "go.work";
   M_87            : aliased constant String := "Go Workspace";
   K_88            : aliased constant String := "kakscript";
   M_88            : aliased constant String := "KakouneScript";
   K_89            : aliased constant String := "cwl";
   M_89            : aliased constant String := "Common Workflow Language";
   K_90            : aliased constant String := "checksum";
   M_90            : aliased constant String := "Checksums";
   K_91            : aliased constant String := "FIGfont";
   M_91            : aliased constant String := "FIGlet Font";
   K_92            : aliased constant String := "b3d";
   M_92            : aliased constant String := "BlitzBasic";
   K_93            : aliased constant String := "IPython Notebook";
   M_93            : aliased constant String := "Jupyter Notebook";
   K_94            : aliased constant String := "text proto";
   M_94            : aliased constant String := "Protocol Buffer Text Format";
   K_95            : aliased constant String := "gemtext";
   M_95            : aliased constant String := "Gemini";
   K_96            : aliased constant String := "cakescript";
   M_96            : aliased constant String := "C#";
   K_97            : aliased constant String := "Ur";
   M_97            : aliased constant String := "UrWeb";
   K_98            : aliased constant String := "groff";
   M_98            : aliased constant String := "Roff";
   K_99            : aliased constant String := "Workflow Description Language";
   M_99            : aliased constant String := "WDL";
   K_100           : aliased constant String := "c++-objdump";
   M_100           : aliased constant String := "Cpp-ObjDump";
   K_101           : aliased constant String := "shellcheckrc";
   M_101           : aliased constant String := "ShellCheck Config";
   K_102           : aliased constant String := "perl-6";
   M_102           : aliased constant String := "Raku";
   K_103           : aliased constant String := "bro";
   M_103           : aliased constant String := "Zeek";
   K_104           : aliased constant String := "saltstate";
   M_104           : aliased constant String := "SaltStack";
   K_105           : aliased constant String := "vb .net";
   M_105           : aliased constant String := "Visual Basic .NET";
   K_106           : aliased constant String := "delphi";
   M_106           : aliased constant String := "Pascal";
   K_107           : aliased constant String := "Carto";
   M_107           : aliased constant String := "CartoCSS";
   K_108           : aliased constant String := "sh";
   M_108           : aliased constant String := "Shell";
   K_109           : aliased constant String := "ackrc";
   M_109           : aliased constant String := "Option List";
   K_110           : aliased constant String := "man";
   M_110           : aliased constant String := "Roff";
   K_111           : aliased constant String := "m68k";
   M_111           : aliased constant String := "Motorola 68K Assembly";
   K_112           : aliased constant String := "abl";
   M_112           : aliased constant String := "OpenEdge ABL";
   K_113           : aliased constant String := "sfv";
   M_113           : aliased constant String := "Simple File Verification";
   K_114           : aliased constant String := "visual basic";
   M_114           : aliased constant String := "Visual Basic .NET";
   K_115           : aliased constant String := "go sum";
   M_115           : aliased constant String := "Go Checksums";
   K_116           : aliased constant String := "perl6";
   M_116           : aliased constant String := "Raku";
   K_117           : aliased constant String := "inc";
   M_117           : aliased constant String := "PHP";
   K_118           : aliased constant String := "objc++";
   M_118           : aliased constant String := "Objective-C++";
   K_119           : aliased constant String := "shell-script";
   M_119           : aliased constant String := "Shell";
   K_120           : aliased constant String := "jsp";
   M_120           : aliased constant String := "Java Server Pages";
   K_121           : aliased constant String := "openrc";
   M_121           : aliased constant String := "OpenRC runscript";
   K_122           : aliased constant String := "raw";
   M_122           : aliased constant String := "Raw token data";
   K_123           : aliased constant String := "objectpascal";
   M_123           : aliased constant String := "Pascal";
   K_124           : aliased constant String := "vlang";
   M_124           : aliased constant String := "V";
   K_125           : aliased constant String := "stla";
   M_125           : aliased constant String := "STL";
   K_126           : aliased constant String := "m2";
   M_126           : aliased constant String := "Macaulay2";
   K_127           : aliased constant String := "csound-orc";
   M_127           : aliased constant String := "Csound";
   K_128           : aliased constant String := "bzl";
   M_128           : aliased constant String := "Starlark";
   K_129           : aliased constant String := "dcl";
   M_129           : aliased constant String := "DIGITAL Command Language";
   K_130           : aliased constant String := "d2lang";
   M_130           : aliased constant String := "D2";
   K_131           : aliased constant String := "csound-csd";
   M_131           : aliased constant String := "Csound Document";
   K_132           : aliased constant String := "abuild";
   M_132           : aliased constant String := "Alpine Abuild";
   K_133           : aliased constant String := "adobe composite font metrics";
   M_133           : aliased constant String := "Adobe Font Metrics";
   K_134           : aliased constant String := "html+jinja";
   M_134           : aliased constant String := "Jinja";
   K_135           : aliased constant String := "xten";
   M_135           : aliased constant String := "X10";
   K_136           : aliased constant String := "udiff";
   M_136           : aliased constant String := "Diff";
   K_137           : aliased constant String := "Cabal";
   M_137           : aliased constant String := "Cabal Config";
   K_138           : aliased constant String := "CoNLL";
   M_138           : aliased constant String := "CoNLL-U";
   K_139           : aliased constant String := "emacs";
   M_139           : aliased constant String := "Emacs Lisp";
   K_140           : aliased constant String := "Ur/Web";
   M_140           : aliased constant String := "UrWeb";
   K_141           : aliased constant String := "batch";
   M_141           : aliased constant String := "Batchfile";
   K_142           : aliased constant String := "dpatch";
   M_142           : aliased constant String := "Darcs Patch";
   K_143           : aliased constant String := "latex";
   M_143           : aliased constant String := "TeX";
   K_144           : aliased constant String := "vdf";
   M_144           : aliased constant String := "Valve Data Format";
   K_145           : aliased constant String := "markojs";
   M_145           : aliased constant String := "Marko";
   K_146           : aliased constant String := "wit";
   M_146           : aliased constant String := "WebAssembly Interface Type";
   K_147           : aliased constant String := "cucumber";
   M_147           : aliased constant String := "Gherkin";
   K_148           : aliased constant String := "nixos";
   M_148           : aliased constant String := "Nix";
   K_149           : aliased constant String := "less-css";
   M_149           : aliased constant String := "Less";
   K_150           : aliased constant String := "coffee-script";
   M_150           : aliased constant String := "CoffeeScript";
   K_151           : aliased constant String := "readline";
   M_151           : aliased constant String := "Readline Config";
   K_152           : aliased constant String := "man-page";
   M_152           : aliased constant String := "Roff";
   K_153           : aliased constant String := "cfc";
   M_153           : aliased constant String := "ColdFusion CFC";
   K_154           : aliased constant String := "velocity";
   M_154           : aliased constant String := "Velocity Template Language";
   K_155           : aliased constant String := "bash session";
   M_155           : aliased constant String := "ShellSession";
   K_156           : aliased constant String := "dosini";
   M_156           : aliased constant String := "INI";
   K_157           : aliased constant String := "cperl";
   M_157           : aliased constant String := "Perl";
   K_158           : aliased constant String := "sqlrpgle";
   M_158           : aliased constant String := "RPGLE";
   K_159           : aliased constant String := "bash";
   M_159           : aliased constant String := "Shell";
   K_160           : aliased constant String := "eex";
   M_160           : aliased constant String := "HTML+EEX";
   K_161           : aliased constant String := "cfm";
   M_161           : aliased constant String := "ColdFusion";
   K_162           : aliased constant String := "python3";
   M_162           : aliased constant String := "Python";
   K_163           : aliased constant String := "nroff";
   M_163           : aliased constant String := "Roff";
   K_164           : aliased constant String := "snippet";
   M_164           : aliased constant String := "YASnippet";
   K_165           : aliased constant String := "md";
   M_165           : aliased constant String := "Markdown";
   K_166           : aliased constant String := "xml+kid";
   M_166           : aliased constant String := "Genshi";
   K_167           : aliased constant String := "AutoIt3";
   M_167           : aliased constant String := "AutoIt";
   K_168           : aliased constant String := "gnu asm";
   M_168           : aliased constant String := "Unix Assembly";
   K_169           : aliased constant String := "mf";
   M_169           : aliased constant String := "Makefile";
   K_170           : aliased constant String := "irc logs";
   M_170           : aliased constant String := "IRC log";
   K_171           : aliased constant String := "sarif";
   M_171           : aliased constant String := "JSON";
   K_172           : aliased constant String := "bazel";
   M_172           : aliased constant String := "Starlark";
   K_173           : aliased constant String := "be";
   M_173           : aliased constant String := "Berry";
   K_174           : aliased constant String := "wiki";
   M_174           : aliased constant String := "Wikitext";
   K_175           : aliased constant String := "bat";
   M_175           : aliased constant String := "Batchfile";
   K_176           : aliased constant String := "bh";
   M_176           : aliased constant String := "Bluespec BH";
   K_177           : aliased constant String := "ragel-rb";
   M_177           : aliased constant String := "Ragel";
   K_178           : aliased constant String := "eml";
   M_178           : aliased constant String := "E-mail";
   K_179           : aliased constant String := "blitzplus";
   M_179           : aliased constant String := "BlitzBasic";
   K_180           : aliased constant String := "ags";
   M_180           : aliased constant String := "AGS Script";
   K_181           : aliased constant String := "igorpro";
   M_181           : aliased constant String := "IGOR Pro";
   K_182           : aliased constant String := "gas";
   M_182           : aliased constant String := "Unix Assembly";
   K_183           : aliased constant String := "objectivec++";
   M_183           : aliased constant String := "Objective-C++";
   K_184           : aliased constant String := "troff";
   M_184           : aliased constant String := "Roff";
   K_185           : aliased constant String := "postscr";
   M_185           : aliased constant String := "PostScript";
   K_186           : aliased constant String := "mbox";
   M_186           : aliased constant String := "E-mail";
   K_187           : aliased constant String := "ad block";
   M_187           : aliased constant String := "Adblock Filter List";
   K_188           : aliased constant String := "NeoSnippet";
   M_188           : aliased constant String := "Vim Snippet";
   K_189           : aliased constant String := "cfml";
   M_189           : aliased constant String := "ColdFusion";
   K_190           : aliased constant String := "nushell-script";
   M_190           : aliased constant String := "Nushell";
   K_191           : aliased constant String := "xsd";
   M_191           : aliased constant String := "XML";
   K_192           : aliased constant String := "yml";
   M_192           : aliased constant String := "YAML";
   K_193           : aliased constant String := "dosbatch";
   M_193           : aliased constant String := "Batchfile";
   K_194           : aliased constant String := "help";
   M_194           : aliased constant String := "Vim Help File";
   K_195           : aliased constant String := "SnipMate";
   M_195           : aliased constant String := "Vim Snippet";
   K_196           : aliased constant String := "xsl";
   M_196           : aliased constant String := "XSLT";
   K_197           : aliased constant String := "adb";
   M_197           : aliased constant String := "Adblock Filter List";
   K_198           : aliased constant String := "pwsh";
   M_198           : aliased constant String := "PowerShell";
   K_199           : aliased constant String := "SELinux Kernel Policy Language";
   M_199           : aliased constant String := "SELinux Policy";
   K_200           : aliased constant String := "razor";
   M_200           : aliased constant String := "HTML+Razor";
   K_201           : aliased constant String := "povray";
   M_201           : aliased constant String := "POV-Ray SDL";
   K_202           : aliased constant String := "octave";
   M_202           : aliased constant String := "MATLAB";
   K_203           : aliased constant String := "plain text";
   M_203           : aliased constant String := "Text";
   K_204           : aliased constant String := "CoNLL-X";
   M_204           : aliased constant String := "CoNLL-U";
   K_205           : aliased constant String := "Protocol Buffers";
   M_205           : aliased constant String := "Protocol Buffer";
   K_206           : aliased constant String := "regex";
   M_206           : aliased constant String := "Regular Expression";
   K_207           : aliased constant String := "vtl";
   M_207           : aliased constant String := "Velocity Template Language";
   K_208           : aliased constant String := "console";
   M_208           : aliased constant String := "ShellSession";
   K_209           : aliased constant String := "apache";
   M_209           : aliased constant String := "ApacheConf";
   K_210           : aliased constant String := "vim";
   M_210           : aliased constant String := "Vim Script";
   K_211           : aliased constant String := "vtt";
   M_211           : aliased constant String := "WebVTT";
   K_212           : aliased constant String := "js";
   M_212           : aliased constant String := "JavaScript";
   K_213           : aliased constant String := "pot";
   M_213           : aliased constant String := "Gettext Catalog";
   K_214           : aliased constant String := "rake";
   M_214           : aliased constant String := "Ruby";
   K_215           : aliased constant String := "nvim";
   M_215           : aliased constant String := "Vim Script";
   K_216           : aliased constant String := "unix asm";
   M_216           : aliased constant String := "Unix Assembly";
   K_217           : aliased constant String := "autoconf";
   M_217           : aliased constant String := "M4Sugar";
   K_218           : aliased constant String := "foxpro";
   M_218           : aliased constant String := "xBase";
   K_219           : aliased constant String := "htmlbars";
   M_219           : aliased constant String := "Handlebars";
   K_220           : aliased constant String := "progress";
   M_220           : aliased constant String := "OpenEdge ABL";
   K_221           : aliased constant String := "dtrace-script";
   M_221           : aliased constant String := "DTrace";
   K_222           : aliased constant String := "pandoc";
   M_222           : aliased constant String := "Markdown";
   K_223           : aliased constant String := "rb";
   M_223           : aliased constant String := "Ruby";
   K_224           : aliased constant String := "xpm";
   M_224           : aliased constant String := "X PixMap";
   K_225           : aliased constant String := "erb";
   M_225           : aliased constant String := "HTML+ERB";
   K_226           : aliased constant String := "bmax";
   M_226           : aliased constant String := "BlitzMax";
   K_227           : aliased constant String := "ats2";
   M_227           : aliased constant String := "ATS";
   K_228           : aliased constant String := "hylang";
   M_228           : aliased constant String := "Hy";
   K_229           : aliased constant String := "c2hs";
   M_229           : aliased constant String := "C2hs Haskell";
   K_230           : aliased constant String := "gf";
   M_230           : aliased constant String := "Grammatical Framework";
   K_231           : aliased constant String := "go mod";
   M_231           : aliased constant String := "Go Module";
   K_232           : aliased constant String := "csharp";
   M_232           : aliased constant String := "C#";
   K_233           : aliased constant String := "actionscript 3";
   M_233           : aliased constant String := "ActionScript";
   K_234           : aliased constant String := "UltiSnips";
   M_234           : aliased constant String := "Vim Snippet";
   K_235           : aliased constant String := "snakefile";
   M_235           : aliased constant String := "Snakemake";
   K_236           : aliased constant String := "Earthfile";
   M_236           : aliased constant String := "Earthly";
   K_237           : aliased constant String := "coccinelle";
   M_237           : aliased constant String := "SmPL";
   K_238           : aliased constant String := "nu-script";
   M_238           : aliased constant String := "Nushell";
   K_239           : aliased constant String := "qsharp";
   M_239           : aliased constant String := "Q#";
   K_240           : aliased constant String := "rs";
   M_240           : aliased constant String := "Rust";
   K_241           : aliased constant String := "splus";
   M_241           : aliased constant String := "R";
   K_242           : aliased constant String := "kak";
   M_242           : aliased constant String := "KakouneScript";
   K_243           : aliased constant String := "pov-ray";
   M_243           : aliased constant String := "POV-Ray SDL";
   K_244           : aliased constant String := "ne-on";
   M_244           : aliased constant String := "NEON";
   K_245           : aliased constant String := "gitconfig";
   M_245           : aliased constant String := "Git Config";
   K_246           : aliased constant String := "opts";
   M_246           : aliased constant String := "Option List";
   K_247           : aliased constant String := "npmrc";
   M_247           : aliased constant String := "NPM Config";
   K_248           : aliased constant String := "arexx";
   M_248           : aliased constant String := "REXX";
   K_249           : aliased constant String := "leex";
   M_249           : aliased constant String := "HTML+EEX";
   K_250           : aliased constant String := "hashes";
   M_250           : aliased constant String := "Checksums";
   K_251           : aliased constant String := "rhtml";
   M_251           : aliased constant String := "HTML+ERB";
   K_252           : aliased constant String := "byond";
   M_252           : aliased constant String := "DM";
   K_253           : aliased constant String := "curlrc";
   M_253           : aliased constant String := "cURL Config";
   K_254           : aliased constant String := "oasv2";
   M_254           : aliased constant String := "OpenAPI Specification v2";
   K_255           : aliased constant String := "AutoItScript";
   M_255           : aliased constant String := "AutoIt";
   K_256           : aliased constant String := "oasv3";
   M_256           : aliased constant String := "OpenAPI Specification v3";
   K_257           : aliased constant String := "sml";
   M_257           : aliased constant String := "Standard ML";
   K_258           : aliased constant String := "sourcemod";
   M_258           : aliased constant String := "SourcePawn";
   K_259           : aliased constant String := "proto";
   M_259           : aliased constant String := "Protocol Buffer";
   K_260           : aliased constant String := "advpl";
   M_260           : aliased constant String := "xBase";
   K_261           : aliased constant String := "jsonc";
   M_261           : aliased constant String := "JSON with Comments";
   K_262           : aliased constant String := "bsdmake";
   M_262           : aliased constant String := "Makefile";
   K_263           : aliased constant String := "ftl";
   M_263           : aliased constant String := "FreeMarker";
   K_264           : aliased constant String := "mumps";
   M_264           : aliased constant String := "M";
   K_265           : aliased constant String := "rss";
   M_265           : aliased constant String := "XML";
   K_266           : aliased constant String := "rst";
   M_266           : aliased constant String := "reStructuredText";
   K_267           : aliased constant String := "xbm";
   M_267           : aliased constant String := "X BitMap";
   K_268           : aliased constant String := "xhtml";
   M_268           : aliased constant String := "HTML";
   K_269           : aliased constant String := "xml+genshi";
   M_269           : aliased constant String := "Genshi";
   K_270           : aliased constant String := "hash";
   M_270           : aliased constant String := "Checksums";
   K_271           : aliased constant String := "lassoscript";
   M_271           : aliased constant String := "Lasso";
   K_272           : aliased constant String := "jsonl";
   M_272           : aliased constant String := "JSON";
   K_273           : aliased constant String := "visual basic classic";
   M_273           : aliased constant String := "Visual Basic 6.0";
   K_274           : aliased constant String := "lisp";
   M_274           : aliased constant String := "Common Lisp";
   K_275           : aliased constant String := "bplus";
   M_275           : aliased constant String := "BlitzBasic";
   K_276           : aliased constant String := "gitattributes";
   M_276           : aliased constant String := "Git Attributes";
   K_277           : aliased constant String := "eeschema schematic";
   M_277           : aliased constant String := "KiCad Schematic";
   K_278           : aliased constant String := "Containerfile";
   M_278           : aliased constant String := "Dockerfile";
   K_279           : aliased constant String := "classic visual basic";
   M_279           : aliased constant String := "Visual Basic 6.0";
   K_280           : aliased constant String := "pir";
   M_280           : aliased constant String := "Parrot Internal Representation";
   K_281           : aliased constant String := "editor-config";
   M_281           : aliased constant String := "EditorConfig";
   K_282           : aliased constant String := "go.sum";
   M_282           : aliased constant String := "Go Checksums";
   K_283           : aliased constant String := "ijm";
   M_283           : aliased constant String := "ImageJ Macro";
   K_284           : aliased constant String := "Dlang";
   M_284           : aliased constant String := "D";
   K_285           : aliased constant String := "node";
   M_285           : aliased constant String := "JavaScript";
   K_286           : aliased constant String := "cpp";
   M_286           : aliased constant String := "C++";
   K_287           : aliased constant String := "njk";
   M_287           : aliased constant String := "Nunjucks";
   K_288           : aliased constant String := "sum";
   M_288           : aliased constant String := "Checksums";
   K_289           : aliased constant String := "go work";
   M_289           : aliased constant String := "Go Workspace";
   K_290           : aliased constant String := "i7";
   M_290           : aliased constant String := "Inform 7";
   K_291           : aliased constant String := "lhaskell";
   M_291           : aliased constant String := "Literate Haskell";
   K_292           : aliased constant String := "mermaid example";
   M_292           : aliased constant String := "Mermaid";
   K_293           : aliased constant String := "topojson";
   M_293           : aliased constant String := "JSON";
   K_294           : aliased constant String := "sepolicy";
   M_294           : aliased constant String := "SELinux Policy";
   K_295           : aliased constant String := "sums";
   M_295           : aliased constant String := "Checksums";
   K_296           : aliased constant String := "blitz3d";
   M_296           : aliased constant String := "BlitzBasic";
   K_297           : aliased constant String := "winbatch";
   M_297           : aliased constant String := "Batchfile";
   K_298           : aliased constant String := "red/system";
   M_298           : aliased constant String := "Red";
   K_299           : aliased constant String := "fundamental";
   M_299           : aliased constant String := "Text";
   K_300           : aliased constant String := "aspx-vb";
   M_300           : aliased constant String := "ASP.NET";
   K_301           : aliased constant String := "ada95";
   M_301           : aliased constant String := "Ada";
   K_302           : aliased constant String := "macruby";
   M_302           : aliased constant String := "Ruby";
   K_303           : aliased constant String := "ragel-ruby";
   M_303           : aliased constant String := "Ragel";
   K_304           : aliased constant String := "adblock";
   M_304           : aliased constant String := "Adblock Filter List";
   K_305           : aliased constant String := "git-ignore";
   M_305           : aliased constant String := "Ignore List";
   K_306           : aliased constant String := "mps";
   M_306           : aliased constant String := "JetBrains MPS";
   K_307           : aliased constant String := "Rscript";
   M_307           : aliased constant String := "R";
   K_308           : aliased constant String := "wl";
   M_308           : aliased constant String := "Mathematica";
   K_309           : aliased constant String := "wrenlang";
   M_309           : aliased constant String := "Wren";
   K_310           : aliased constant String := "wolfram lang";
   M_310           : aliased constant String := "Mathematica";
   K_311           : aliased constant String := "fstar";
   M_311           : aliased constant String := "F*";
   K_312           : aliased constant String := "irc";
   M_312           : aliased constant String := "IRC log";
   K_313           : aliased constant String := "emacs muse";
   M_313           : aliased constant String := "Muse";
   K_314           : aliased constant String := "html+django";
   M_314           : aliased constant String := "Jinja";
   K_315           : aliased constant String := "java server page";
   M_315           : aliased constant String := "Groovy Server Pages";
   K_316           : aliased constant String := "AFDKO";
   M_316           : aliased constant String := "OpenType Feature File";
   K_317           : aliased constant String := "viml";
   M_317           : aliased constant String := "Vim Script";
   K_318           : aliased constant String := "ls";
   M_318           : aliased constant String := "LiveScript";
   K_319           : aliased constant String := "wgetrc";
   M_319           : aliased constant String := "Wget Config";
   K_320           : aliased constant String := "obj-c++";
   M_320           : aliased constant String := "Objective-C++";
   K_321           : aliased constant String := "osascript";
   M_321           : aliased constant String := "AppleScript";
   K_322           : aliased constant String := "live-script";
   M_322           : aliased constant String := "LiveScript";
   K_323           : aliased constant String := "pyrex";
   M_323           : aliased constant String := "Cython";
   K_324           : aliased constant String := "vimhelp";
   M_324           : aliased constant String := "Vim Help File";
   K_325           : aliased constant String := "mma";
   M_325           : aliased constant String := "Mathematica";
   K_326           : aliased constant String := "ignore";
   M_326           : aliased constant String := "Ignore List";
   K_327           : aliased constant String := "squeak";
   M_327           : aliased constant String := "Smalltalk";
   K_328           : aliased constant String := "terraform";
   M_328           : aliased constant String := "HCL";
   K_329           : aliased constant String := "mail";
   M_329           : aliased constant String := "E-mail";
   K_330           : aliased constant String := "wolfram language";
   M_330           : aliased constant String := "Mathematica";
   K_331           : aliased constant String := "acfm";
   M_331           : aliased constant String := "Adobe Font Metrics";
   K_332           : aliased constant String := "altium";
   M_332           : aliased constant String := "Altium Designer";
   K_333           : aliased constant String := "keyvalues";
   M_333           : aliased constant String := "Valve Data Format";
   K_334           : aliased constant String := "pasm";
   M_334           : aliased constant String := "Parrot Assembly";
   K_335           : aliased constant String := "hosts";
   M_335           : aliased constant String := "Hosts File";
   K_336           : aliased constant String := "gsp";
   M_336           : aliased constant String := "Groovy Server Pages";
   K_337           : aliased constant String := "bsv";
   M_337           : aliased constant String := "Bluespec";
   K_338           : aliased constant String := "amfm";
   M_338           : aliased constant String := "Adobe Font Metrics";
   K_339           : aliased constant String := "robots txt";
   M_339           : aliased constant String := "robots.txt";
   K_340           : aliased constant String := "ada2005";
   M_340           : aliased constant String := "Ada";
   K_341           : aliased constant String := "tl";
   M_341           : aliased constant String := "Type Language";
   K_342           : aliased constant String := "hbs";
   M_342           : aliased constant String := "Handlebars";
   K_343           : aliased constant String := "yas";
   M_343           : aliased constant String := "YASnippet";
   K_344           : aliased constant String := "robots";
   M_344           : aliased constant String := "robots.txt";
   K_345           : aliased constant String := "coffee";
   M_345           : aliased constant String := "CoffeeScript";
   K_346           : aliased constant String := "as3";
   M_346           : aliased constant String := "ActionScript";
   K_347           : aliased constant String := "ts";
   M_347           : aliased constant String := "TypeScript";
   K_348           : aliased constant String := "lhs";
   M_348           : aliased constant String := "Literate Haskell";
   K_349           : aliased constant String := "igor";
   M_349           : aliased constant String := "IGOR Pro";
   K_350           : aliased constant String := "ile rpg";
   M_350           : aliased constant String := "RPGLE";
   K_351           : aliased constant String := "visual basic for applications";
   M_351           : aliased constant String := "VBA";
   K_352           : aliased constant String := "bluespec classic";
   M_352           : aliased constant String := "Bluespec BH";
   K_353           : aliased constant String := "maxmsp";
   M_353           : aliased constant String := "Max";
   K_354           : aliased constant String := "odinlang";
   M_354           : aliased constant String := "Odin";
   K_355           : aliased constant String := "rbx";
   M_355           : aliased constant String := "Ruby";
   K_356           : aliased constant String := "flex";
   M_356           : aliased constant String := "Lex";
   K_357           : aliased constant String := "aconf";
   M_357           : aliased constant String := "ApacheConf";
   K_358           : aliased constant String := "nginx configuration file";
   M_358           : aliased constant String := "Nginx";
   K_359           : aliased constant String := "gitmodules";
   M_359           : aliased constant String := "Git Config";
   K_360           : aliased constant String := "gitignore";
   M_360           : aliased constant String := "Ignore List";
   K_361           : aliased constant String := "sdc";
   M_361           : aliased constant String := "Tcl";
   K_362           : aliased constant String := "nette object notation";
   M_362           : aliased constant String := "NEON";
   K_363           : aliased constant String := "bluespec bsv";
   M_363           : aliased constant String := "Bluespec";
   K_364           : aliased constant String := "manpage";
   M_364           : aliased constant String := "Roff";
   K_365           : aliased constant String := "xdc";
   M_365           : aliased constant String := "Tcl";

   Names : constant Name_Array := (
      K_0'Access, K_1'Access, K_2'Access, K_3'Access,
      K_4'Access, K_5'Access, K_6'Access, K_7'Access,
      K_8'Access, K_9'Access, K_10'Access, K_11'Access,
      K_12'Access, K_13'Access, K_14'Access, K_15'Access,
      K_16'Access, K_17'Access, K_18'Access, K_19'Access,
      K_20'Access, K_21'Access, K_22'Access, K_23'Access,
      K_24'Access, K_25'Access, K_26'Access, K_27'Access,
      K_28'Access, K_29'Access, K_30'Access, K_31'Access,
      K_32'Access, K_33'Access, K_34'Access, K_35'Access,
      K_36'Access, K_37'Access, K_38'Access, K_39'Access,
      K_40'Access, K_41'Access, K_42'Access, K_43'Access,
      K_44'Access, K_45'Access, K_46'Access, K_47'Access,
      K_48'Access, K_49'Access, K_50'Access, K_51'Access,
      K_52'Access, K_53'Access, K_54'Access, K_55'Access,
      K_56'Access, K_57'Access, K_58'Access, K_59'Access,
      K_60'Access, K_61'Access, K_62'Access, K_63'Access,
      K_64'Access, K_65'Access, K_66'Access, K_67'Access,
      K_68'Access, K_69'Access, K_70'Access, K_71'Access,
      K_72'Access, K_73'Access, K_74'Access, K_75'Access,
      K_76'Access, K_77'Access, K_78'Access, K_79'Access,
      K_80'Access, K_81'Access, K_82'Access, K_83'Access,
      K_84'Access, K_85'Access, K_86'Access, K_87'Access,
      K_88'Access, K_89'Access, K_90'Access, K_91'Access,
      K_92'Access, K_93'Access, K_94'Access, K_95'Access,
      K_96'Access, K_97'Access, K_98'Access, K_99'Access,
      K_100'Access, K_101'Access, K_102'Access, K_103'Access,
      K_104'Access, K_105'Access, K_106'Access, K_107'Access,
      K_108'Access, K_109'Access, K_110'Access, K_111'Access,
      K_112'Access, K_113'Access, K_114'Access, K_115'Access,
      K_116'Access, K_117'Access, K_118'Access, K_119'Access,
      K_120'Access, K_121'Access, K_122'Access, K_123'Access,
      K_124'Access, K_125'Access, K_126'Access, K_127'Access,
      K_128'Access, K_129'Access, K_130'Access, K_131'Access,
      K_132'Access, K_133'Access, K_134'Access, K_135'Access,
      K_136'Access, K_137'Access, K_138'Access, K_139'Access,
      K_140'Access, K_141'Access, K_142'Access, K_143'Access,
      K_144'Access, K_145'Access, K_146'Access, K_147'Access,
      K_148'Access, K_149'Access, K_150'Access, K_151'Access,
      K_152'Access, K_153'Access, K_154'Access, K_155'Access,
      K_156'Access, K_157'Access, K_158'Access, K_159'Access,
      K_160'Access, K_161'Access, K_162'Access, K_163'Access,
      K_164'Access, K_165'Access, K_166'Access, K_167'Access,
      K_168'Access, K_169'Access, K_170'Access, K_171'Access,
      K_172'Access, K_173'Access, K_174'Access, K_175'Access,
      K_176'Access, K_177'Access, K_178'Access, K_179'Access,
      K_180'Access, K_181'Access, K_182'Access, K_183'Access,
      K_184'Access, K_185'Access, K_186'Access, K_187'Access,
      K_188'Access, K_189'Access, K_190'Access, K_191'Access,
      K_192'Access, K_193'Access, K_194'Access, K_195'Access,
      K_196'Access, K_197'Access, K_198'Access, K_199'Access,
      K_200'Access, K_201'Access, K_202'Access, K_203'Access,
      K_204'Access, K_205'Access, K_206'Access, K_207'Access,
      K_208'Access, K_209'Access, K_210'Access, K_211'Access,
      K_212'Access, K_213'Access, K_214'Access, K_215'Access,
      K_216'Access, K_217'Access, K_218'Access, K_219'Access,
      K_220'Access, K_221'Access, K_222'Access, K_223'Access,
      K_224'Access, K_225'Access, K_226'Access, K_227'Access,
      K_228'Access, K_229'Access, K_230'Access, K_231'Access,
      K_232'Access, K_233'Access, K_234'Access, K_235'Access,
      K_236'Access, K_237'Access, K_238'Access, K_239'Access,
      K_240'Access, K_241'Access, K_242'Access, K_243'Access,
      K_244'Access, K_245'Access, K_246'Access, K_247'Access,
      K_248'Access, K_249'Access, K_250'Access, K_251'Access,
      K_252'Access, K_253'Access, K_254'Access, K_255'Access,
      K_256'Access, K_257'Access, K_258'Access, K_259'Access,
      K_260'Access, K_261'Access, K_262'Access, K_263'Access,
      K_264'Access, K_265'Access, K_266'Access, K_267'Access,
      K_268'Access, K_269'Access, K_270'Access, K_271'Access,
      K_272'Access, K_273'Access, K_274'Access, K_275'Access,
      K_276'Access, K_277'Access, K_278'Access, K_279'Access,
      K_280'Access, K_281'Access, K_282'Access, K_283'Access,
      K_284'Access, K_285'Access, K_286'Access, K_287'Access,
      K_288'Access, K_289'Access, K_290'Access, K_291'Access,
      K_292'Access, K_293'Access, K_294'Access, K_295'Access,
      K_296'Access, K_297'Access, K_298'Access, K_299'Access,
      K_300'Access, K_301'Access, K_302'Access, K_303'Access,
      K_304'Access, K_305'Access, K_306'Access, K_307'Access,
      K_308'Access, K_309'Access, K_310'Access, K_311'Access,
      K_312'Access, K_313'Access, K_314'Access, K_315'Access,
      K_316'Access, K_317'Access, K_318'Access, K_319'Access,
      K_320'Access, K_321'Access, K_322'Access, K_323'Access,
      K_324'Access, K_325'Access, K_326'Access, K_327'Access,
      K_328'Access, K_329'Access, K_330'Access, K_331'Access,
      K_332'Access, K_333'Access, K_334'Access, K_335'Access,
      K_336'Access, K_337'Access, K_338'Access, K_339'Access,
      K_340'Access, K_341'Access, K_342'Access, K_343'Access,
      K_344'Access, K_345'Access, K_346'Access, K_347'Access,
      K_348'Access, K_349'Access, K_350'Access, K_351'Access,
      K_352'Access, K_353'Access, K_354'Access, K_355'Access,
      K_356'Access, K_357'Access, K_358'Access, K_359'Access,
      K_360'Access, K_361'Access, K_362'Access, K_363'Access,
      K_364'Access, K_365'Access);

   Contents : constant Name_Array := (
      M_0'Access, M_1'Access, M_2'Access, M_3'Access,
      M_4'Access, M_5'Access, M_6'Access, M_7'Access,
      M_8'Access, M_9'Access, M_10'Access, M_11'Access,
      M_12'Access, M_13'Access, M_14'Access, M_15'Access,
      M_16'Access, M_17'Access, M_18'Access, M_19'Access,
      M_20'Access, M_21'Access, M_22'Access, M_23'Access,
      M_24'Access, M_25'Access, M_26'Access, M_27'Access,
      M_28'Access, M_29'Access, M_30'Access, M_31'Access,
      M_32'Access, M_33'Access, M_34'Access, M_35'Access,
      M_36'Access, M_37'Access, M_38'Access, M_39'Access,
      M_40'Access, M_41'Access, M_42'Access, M_43'Access,
      M_44'Access, M_45'Access, M_46'Access, M_47'Access,
      M_48'Access, M_49'Access, M_50'Access, M_51'Access,
      M_52'Access, M_53'Access, M_54'Access, M_55'Access,
      M_56'Access, M_57'Access, M_58'Access, M_59'Access,
      M_60'Access, M_61'Access, M_62'Access, M_63'Access,
      M_64'Access, M_65'Access, M_66'Access, M_67'Access,
      M_68'Access, M_69'Access, M_70'Access, M_71'Access,
      M_72'Access, M_73'Access, M_74'Access, M_75'Access,
      M_76'Access, M_77'Access, M_78'Access, M_79'Access,
      M_80'Access, M_81'Access, M_82'Access, M_83'Access,
      M_84'Access, M_85'Access, M_86'Access, M_87'Access,
      M_88'Access, M_89'Access, M_90'Access, M_91'Access,
      M_92'Access, M_93'Access, M_94'Access, M_95'Access,
      M_96'Access, M_97'Access, M_98'Access, M_99'Access,
      M_100'Access, M_101'Access, M_102'Access, M_103'Access,
      M_104'Access, M_105'Access, M_106'Access, M_107'Access,
      M_108'Access, M_109'Access, M_110'Access, M_111'Access,
      M_112'Access, M_113'Access, M_114'Access, M_115'Access,
      M_116'Access, M_117'Access, M_118'Access, M_119'Access,
      M_120'Access, M_121'Access, M_122'Access, M_123'Access,
      M_124'Access, M_125'Access, M_126'Access, M_127'Access,
      M_128'Access, M_129'Access, M_130'Access, M_131'Access,
      M_132'Access, M_133'Access, M_134'Access, M_135'Access,
      M_136'Access, M_137'Access, M_138'Access, M_139'Access,
      M_140'Access, M_141'Access, M_142'Access, M_143'Access,
      M_144'Access, M_145'Access, M_146'Access, M_147'Access,
      M_148'Access, M_149'Access, M_150'Access, M_151'Access,
      M_152'Access, M_153'Access, M_154'Access, M_155'Access,
      M_156'Access, M_157'Access, M_158'Access, M_159'Access,
      M_160'Access, M_161'Access, M_162'Access, M_163'Access,
      M_164'Access, M_165'Access, M_166'Access, M_167'Access,
      M_168'Access, M_169'Access, M_170'Access, M_171'Access,
      M_172'Access, M_173'Access, M_174'Access, M_175'Access,
      M_176'Access, M_177'Access, M_178'Access, M_179'Access,
      M_180'Access, M_181'Access, M_182'Access, M_183'Access,
      M_184'Access, M_185'Access, M_186'Access, M_187'Access,
      M_188'Access, M_189'Access, M_190'Access, M_191'Access,
      M_192'Access, M_193'Access, M_194'Access, M_195'Access,
      M_196'Access, M_197'Access, M_198'Access, M_199'Access,
      M_200'Access, M_201'Access, M_202'Access, M_203'Access,
      M_204'Access, M_205'Access, M_206'Access, M_207'Access,
      M_208'Access, M_209'Access, M_210'Access, M_211'Access,
      M_212'Access, M_213'Access, M_214'Access, M_215'Access,
      M_216'Access, M_217'Access, M_218'Access, M_219'Access,
      M_220'Access, M_221'Access, M_222'Access, M_223'Access,
      M_224'Access, M_225'Access, M_226'Access, M_227'Access,
      M_228'Access, M_229'Access, M_230'Access, M_231'Access,
      M_232'Access, M_233'Access, M_234'Access, M_235'Access,
      M_236'Access, M_237'Access, M_238'Access, M_239'Access,
      M_240'Access, M_241'Access, M_242'Access, M_243'Access,
      M_244'Access, M_245'Access, M_246'Access, M_247'Access,
      M_248'Access, M_249'Access, M_250'Access, M_251'Access,
      M_252'Access, M_253'Access, M_254'Access, M_255'Access,
      M_256'Access, M_257'Access, M_258'Access, M_259'Access,
      M_260'Access, M_261'Access, M_262'Access, M_263'Access,
      M_264'Access, M_265'Access, M_266'Access, M_267'Access,
      M_268'Access, M_269'Access, M_270'Access, M_271'Access,
      M_272'Access, M_273'Access, M_274'Access, M_275'Access,
      M_276'Access, M_277'Access, M_278'Access, M_279'Access,
      M_280'Access, M_281'Access, M_282'Access, M_283'Access,
      M_284'Access, M_285'Access, M_286'Access, M_287'Access,
      M_288'Access, M_289'Access, M_290'Access, M_291'Access,
      M_292'Access, M_293'Access, M_294'Access, M_295'Access,
      M_296'Access, M_297'Access, M_298'Access, M_299'Access,
      M_300'Access, M_301'Access, M_302'Access, M_303'Access,
      M_304'Access, M_305'Access, M_306'Access, M_307'Access,
      M_308'Access, M_309'Access, M_310'Access, M_311'Access,
      M_312'Access, M_313'Access, M_314'Access, M_315'Access,
      M_316'Access, M_317'Access, M_318'Access, M_319'Access,
      M_320'Access, M_321'Access, M_322'Access, M_323'Access,
      M_324'Access, M_325'Access, M_326'Access, M_327'Access,
      M_328'Access, M_329'Access, M_330'Access, M_331'Access,
      M_332'Access, M_333'Access, M_334'Access, M_335'Access,
      M_336'Access, M_337'Access, M_338'Access, M_339'Access,
      M_340'Access, M_341'Access, M_342'Access, M_343'Access,
      M_344'Access, M_345'Access, M_346'Access, M_347'Access,
      M_348'Access, M_349'Access, M_350'Access, M_351'Access,
      M_352'Access, M_353'Access, M_354'Access, M_355'Access,
      M_356'Access, M_357'Access, M_358'Access, M_359'Access,
      M_360'Access, M_361'Access, M_362'Access, M_363'Access,
      M_364'Access, M_365'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.AliasMap;
