--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Extensions mapping generated from extensions.json
package SPDX_Tool.Languages.ExtensionMap is

   type Content_Access is access constant String;

   type Name_Access is access constant String;

   Names_Count : constant := 1363;
   type Name_Array is array (Natural range <>) of Name_Access;

   Names : constant Name_Array;

   Contents : constant Name_Array;

   --  Returns the mapping that corresponds to the name or null.
   function Get_Mapping (Name : String) return
      access constant String;

private

   K_0             : aliased constant String := "har";
   M_0             : aliased constant String := "JSON";
   K_1             : aliased constant String := "gd";
   M_1             : aliased constant String := "GDScript,GAP";
   K_2             : aliased constant String := "janet";
   M_2             : aliased constant String := "Janet";
   K_3             : aliased constant String := "bib";
   M_3             : aliased constant String := "BibTeX";
   K_4             : aliased constant String := "pde";
   M_4             : aliased constant String := "Processing";
   K_5             : aliased constant String := "rdoc";
   M_5             : aliased constant String := "RDoc";
   K_6             : aliased constant String := "lua";
   M_6             : aliased constant String := "Lua";
   K_7             : aliased constant String := "gf";
   M_7             : aliased constant String := "Grammatical Framework";
   K_8             : aliased constant String := "4dm";
   M_8             : aliased constant String := "4D";
   K_9             : aliased constant String := "spec";
   M_9             : aliased constant String := "Python,Ruby,RPM Spec";
   K_10            : aliased constant String := "god";
   M_10            : aliased constant String := "Ruby";
   K_11            : aliased constant String := "_ls";
   M_11            : aliased constant String := "LiveScript";
   K_12            : aliased constant String := "gi";
   M_12            : aliased constant String := "GAP";
   K_13            : aliased constant String := "gn";
   M_13            : aliased constant String := "GN";
   K_14            : aliased constant String := "odin";
   M_14            : aliased constant String := "Odin,Object Data Instance Notation";
   K_15            : aliased constant String := "zpl";
   M_15            : aliased constant String := "Zimpl";
   K_16            : aliased constant String := "go";
   M_16            : aliased constant String := "Go";
   K_17            : aliased constant String := "crc32";
   M_17            : aliased constant String := "Checksums";
   K_18            : aliased constant String := "gp";
   M_18            : aliased constant String := "Gnuplot";
   K_19            : aliased constant String := "ixx";
   M_19            : aliased constant String := "C++";
   K_20            : aliased constant String := "ndproj";
   M_20            : aliased constant String := "XML";
   K_21            : aliased constant String := "f77";
   M_21            : aliased constant String := "Fortran";
   K_22            : aliased constant String := "gs";
   M_22            : aliased constant String := "JavaScript,Gosu,Genie,GLSL";
   K_23            : aliased constant String := "orc";
   M_23            : aliased constant String := "Csound";
   K_24            : aliased constant String := "gv";
   M_24            : aliased constant String := "Graphviz (DOT)";
   K_25            : aliased constant String := "pegjs";
   M_25            : aliased constant String := "PEG.js";
   K_26            : aliased constant String := "org";
   M_26            : aliased constant String := "Org";
   K_27            : aliased constant String := "sthlp";
   M_27            : aliased constant String := "Stata";
   K_28            : aliased constant String := "astro";
   M_28            : aliased constant String := "Astro";
   K_29            : aliased constant String := "apib";
   M_29            : aliased constant String := "API Blueprint";
   K_30            : aliased constant String := "8xp";
   M_30            : aliased constant String := "TI Program";
   K_31            : aliased constant String := "tmCommand";
   M_31            : aliased constant String := "XML Property List";
   K_32            : aliased constant String := "txi";
   M_32            : aliased constant String := "Texinfo";
   K_33            : aliased constant String := "epsi";
   M_33            : aliased constant String := "PostScript";
   K_34            : aliased constant String := "cproject";
   M_34            : aliased constant String := "XML";
   K_35            : aliased constant String := "txl";
   M_35            : aliased constant String := "TXL";
   K_36            : aliased constant String := "awk";
   M_36            : aliased constant String := "Awk";
   K_37            : aliased constant String := "sas";
   M_37            : aliased constant String := "SAS";
   K_38            : aliased constant String := "roc";
   M_38            : aliased constant String := "Roc";
   K_39            : aliased constant String := "abnf";
   M_39            : aliased constant String := "ABNF";
   K_40            : aliased constant String := "styl";
   M_40            : aliased constant String := "Stylus";
   K_41            : aliased constant String := "ipynb";
   M_41            : aliased constant String := "Jupyter Notebook";
   K_42            : aliased constant String := "1in";
   M_42            : aliased constant String := "Roff Manpage,Roff";
   K_43            : aliased constant String := "dtd";
   M_43            : aliased constant String := "DTD";
   K_44            : aliased constant String := "txt";
   M_44            : aliased constant String := "Vim Help File,Text,Adblock Filter List";
   K_45            : aliased constant String := "mustache";
   M_45            : aliased constant String := "Mustache";
   K_46            : aliased constant String := "hcl";
   M_46            : aliased constant String := "HCL";
   K_47            : aliased constant String := "religo";
   M_47            : aliased constant String := "ReasonLIGO";
   K_48            : aliased constant String := "lagda";
   M_48            : aliased constant String := "Literate Agda";
   K_49            : aliased constant String := "txx";
   M_49            : aliased constant String := "C++";
   K_50            : aliased constant String := "pfa";
   M_50            : aliased constant String := "PostScript";
   K_51            : aliased constant String := "intr";
   M_51            : aliased constant String := "Dylan";
   K_52            : aliased constant String := "mir";
   M_52            : aliased constant String := "YAML";
   K_53            : aliased constant String := "wiki";
   M_53            : aliased constant String := "Wikitext";
   K_54            : aliased constant String := "ig";
   M_54            : aliased constant String := "Modula-3";
   K_55            : aliased constant String := "1";
   M_55            : aliased constant String := "Roff Manpage,Roff";
   K_56            : aliased constant String := "dts";
   M_56            : aliased constant String := "Device Tree Source";
   K_57            : aliased constant String := "2";
   M_57            : aliased constant String := "Roff Manpage,Roff";
   K_58            : aliased constant String := "ik";
   M_58            : aliased constant String := "Ioke";
   K_59            : aliased constant String := "psgi";
   M_59            : aliased constant String := "Perl";
   K_60            : aliased constant String := "3";
   M_60            : aliased constant String := "Roff Manpage,Roff";
   K_61            : aliased constant String := "f90";
   M_61            : aliased constant String := "Fortran Free Form";
   K_62            : aliased constant String := "4";
   M_62            : aliased constant String := "Roff Manpage,Roff";
   K_63            : aliased constant String := "5";
   M_63            : aliased constant String := "Roff Manpage,Roff";
   K_64            : aliased constant String := "6";
   M_64            : aliased constant String := "Roff Manpage,Roff";
   K_65            : aliased constant String := "io";
   M_65            : aliased constant String := "Io";
   K_66            : aliased constant String := "dtx";
   M_66            : aliased constant String := "TeX";
   K_67            : aliased constant String := "gql";
   M_67            : aliased constant String := "GraphQL";
   K_68            : aliased constant String := "7";
   M_68            : aliased constant String := "Roff Manpage,Roff";
   K_69            : aliased constant String := "weechatlog";
   M_69            : aliased constant String := "IRC log";
   K_70            : aliased constant String := "xib";
   M_70            : aliased constant String := "XML";
   K_71            : aliased constant String := "8";
   M_71            : aliased constant String := "Roff Manpage,Roff";
   K_72            : aliased constant String := "f95";
   M_72            : aliased constant String := "Fortran Free Form";
   K_73            : aliased constant String := "scd";
   M_73            : aliased constant String := "SuperCollider,Markdown";
   K_74            : aliased constant String := "9";
   M_74            : aliased constant String := "Roff Manpage,Roff";
   K_75            : aliased constant String := "lvproj";
   M_75            : aliased constant String := "LabVIEW";
   K_76            : aliased constant String := "sce";
   M_76            : aliased constant String := "Scilab";
   K_77            : aliased constant String := "hxsl";
   M_77            : aliased constant String := "Haxe";
   K_78            : aliased constant String := "fish";
   M_78            : aliased constant String := "fish";
   K_79            : aliased constant String := "postcss";
   M_79            : aliased constant String := "PostCSS";
   K_80            : aliased constant String := "sch";
   M_80            : aliased constant String := "XML,Scheme,KiCad Schematic,Eagle";
   K_81            : aliased constant String := "sci";
   M_81            : aliased constant String := "Scilab";
   K_82            : aliased constant String := "pmod";
   M_82            : aliased constant String := "Pike";
   K_83            : aliased constant String := "pbtxt";
   M_83            : aliased constant String := "Protocol Buffer Text Format";
   K_84            : aliased constant String := "cljc";
   M_84            : aliased constant String := "Clojure";
   K_85            : aliased constant String := "scm";
   M_85            : aliased constant String := "Scheme";
   K_86            : aliased constant String := "sco";
   M_86            : aliased constant String := "Csound Score";
   K_87            : aliased constant String := "razor";
   M_87            : aliased constant String := "HTML+Razor";
   K_88            : aliased constant String := "sublime-commands";
   M_88            : aliased constant String := "JSON with Comments";
   K_89            : aliased constant String := "mkd";
   M_89            : aliased constant String := "Markdown";
   K_90            : aliased constant String := "reek";
   M_90            : aliased constant String := "YAML";
   K_91            : aliased constant String := "shproj";
   M_91            : aliased constant String := "XML";
   K_92            : aliased constant String := "m2";
   M_92            : aliased constant String := "Macaulay2";
   K_93            : aliased constant String := "jsfl";
   M_93            : aliased constant String := "JavaScript";
   K_94            : aliased constant String := "m3";
   M_94            : aliased constant String := "Modula-3";
   K_95            : aliased constant String := "m4";
   M_95            : aliased constant String := "M4,M4Sugar";
   K_96            : aliased constant String := "cljs";
   M_96            : aliased constant String := "Clojure";
   K_97            : aliased constant String := "S";
   M_97            : aliased constant String := "Assembly";
   K_98            : aliased constant String := "cljx";
   M_98            : aliased constant String := "Clojure";
   K_99            : aliased constant String := "ccproj";
   M_99            : aliased constant String := "XML";
   K_100           : aliased constant String := "axs.erb";
   M_100           : aliased constant String := "NetLinx+ERB";
   K_101           : aliased constant String := "mumps";
   M_101           : aliased constant String := "M";
   K_102           : aliased constant String := "gsc";
   M_102           : aliased constant String := "GSC";
   K_103           : aliased constant String := "opencl";
   M_103           : aliased constant String := "OpenCL";
   K_104           : aliased constant String := "purs";
   M_104           : aliased constant String := "PureScript";
   K_105           : aliased constant String := "texi";
   M_105           : aliased constant String := "Texinfo";
   K_106           : aliased constant String := "a51";
   M_106           : aliased constant String := "Assembly";
   K_107           : aliased constant String := "gsh";
   M_107           : aliased constant String := "GSC";
   K_108           : aliased constant String := "rest.txt";
   M_108           : aliased constant String := "reStructuredText";
   K_109           : aliased constant String := "mcmeta";
   M_109           : aliased constant String := "JSON";
   K_110           : aliased constant String := "b";
   M_110           : aliased constant String := "Limbo,Brainfuck";
   K_111           : aliased constant String := "php";
   M_111           : aliased constant String := "PHP,Hack";
   K_112           : aliased constant String := "uno";
   M_112           : aliased constant String := "Uno";
   K_113           : aliased constant String := "c";
   M_113           : aliased constant String := "C";
   K_114           : aliased constant String := "sed";
   M_114           : aliased constant String := "sed";
   K_115           : aliased constant String := "d";
   M_115           : aliased constant String := "D,Makefile,DTrace";
   K_116           : aliased constant String := "spin";
   M_116           : aliased constant String := "Propeller Spin";
   K_117           : aliased constant String := "e";
   M_117           : aliased constant String := "Euphoria,Eiffel,E";
   K_118           : aliased constant String := "ks";
   M_118           : aliased constant String := "Kickstart,KerboScript";
   K_119           : aliased constant String := "f";
   M_119           : aliased constant String := "Fortran,Forth,Filebench WML";
   K_120           : aliased constant String := "ashx";
   M_120           : aliased constant String := "ASP.NET";
   K_121           : aliased constant String := "gsp";
   M_121           : aliased constant String := "Groovy Server Pages";
   K_122           : aliased constant String := "kt";
   M_122           : aliased constant String := "Kotlin";
   K_123           : aliased constant String := "g";
   M_123           : aliased constant String := "GAP,G-code";
   K_124           : aliased constant String := "h";
   M_124           : aliased constant String := "C++,C,Objective-C";
   K_125           : aliased constant String := "kv";
   M_125           : aliased constant String := "kvlang";
   K_126           : aliased constant String := "i";
   M_126           : aliased constant String := "Assembly,SWIG,Motorola 68K Assembly";
   K_127           : aliased constant String := "textproto";
   M_127           : aliased constant String := "Protocol Buffer Text Format";
   K_128           : aliased constant String := "j";
   M_128           : aliased constant String := "Objective-J,Jasmin";
   K_129           : aliased constant String := "graphqls";
   M_129           : aliased constant String := "GraphQL";
   K_130           : aliased constant String := "gst";
   M_130           : aliased constant String := "XML,Gosu";
   K_131           : aliased constant String := "ampl";
   M_131           : aliased constant String := "AMPL";
   K_132           : aliased constant String := "l";
   M_132           : aliased constant String := "Roff,PicoLisp,Lex,Common Lisp";
   K_133           : aliased constant String := "m";
   M_133           : aliased constant String := "Objective-C,Mercury,Mathematica,MUF,MATLA"
       & "B,M,Limbo";
   K_134           : aliased constant String := "bmx";
   M_134           : aliased constant String := "BlitzMax";
   K_135           : aliased constant String := "topojson";
   M_135           : aliased constant String := "JSON";
   K_136           : aliased constant String := "vba";
   M_136           : aliased constant String := "VBA,Vim Script";
   K_137           : aliased constant String := "n";
   M_137           : aliased constant String := "Roff,Nemerle";
   K_138           : aliased constant String := "gsx";
   M_138           : aliased constant String := "Gosu";
   K_139           : aliased constant String := "p";
   M_139           : aliased constant String := "OpenEdge ABL,Gnuplot";
   K_140           : aliased constant String := "q";
   M_140           : aliased constant String := "q,HiveQL";
   K_141           : aliased constant String := "wikitext";
   M_141           : aliased constant String := "Wikitext";
   K_142           : aliased constant String := "r";
   M_142           : aliased constant String := "R,Rez,Rebol";
   K_143           : aliased constant String := "darcspatch";
   M_143           : aliased constant String := "Darcs Patch";
   K_144           : aliased constant String := "s";
   M_144           : aliased constant String := "Unix Assembly,Motorola 68K Assembly";
   K_145           : aliased constant String := "mmd";
   M_145           : aliased constant String := "Mermaid";
   K_146           : aliased constant String := "rsc";
   M_146           : aliased constant String := "RouterOS Script,Rascal";
   K_147           : aliased constant String := "t";
   M_147           : aliased constant String := "Perl,Turing,Terra,Raku";
   K_148           : aliased constant String := "ejs";
   M_148           : aliased constant String := "EJS";
   K_149           : aliased constant String := "v";
   M_149           : aliased constant String := "Verilog,V,Coq";
   K_150           : aliased constant String := "w";
   M_150           : aliased constant String := "OpenEdge ABL,CWeb";
   K_151           : aliased constant String := "x";
   M_151           : aliased constant String := "RPC,Logos,Linker Script,DirectX 3D File";
   K_152           : aliased constant String := "rsh";
   M_152           : aliased constant String := "RenderScript";
   K_153           : aliased constant String := "y";
   M_153           : aliased constant String := "Yacc";
   K_154           : aliased constant String := "dpatch";
   M_154           : aliased constant String := "Darcs Patch";
   K_155           : aliased constant String := "jspre";
   M_155           : aliased constant String := "JavaScript";
   K_156           : aliased constant String := "mmk";
   M_156           : aliased constant String := "Module Management System";
   K_157           : aliased constant String := "psm1";
   M_157           : aliased constant String := "PowerShell";
   K_158           : aliased constant String := "rego";
   M_158           : aliased constant String := "Open Policy Agent";
   K_159           : aliased constant String := "ma";
   M_159           : aliased constant String := "Mathematica";
   K_160           : aliased constant String := "pl6";
   M_160           : aliased constant String := "Raku";
   K_161           : aliased constant String := "vbs";
   M_161           : aliased constant String := "VBScript";
   K_162           : aliased constant String := "mc";
   M_162           : aliased constant String := "M4,Win32 Message File,Monkey C";
   K_163           : aliased constant String := "md";
   M_163           : aliased constant String := "Markdown,GCC Machine Description";
   K_164           : aliased constant String := "upc";
   M_164           : aliased constant String := "Unified Parallel C";
   K_165           : aliased constant String := "me";
   M_165           : aliased constant String := "Roff";
   K_166           : aliased constant String := "mms";
   M_166           : aliased constant String := "Module Management System";
   K_167           : aliased constant String := "sublime-menu";
   M_167           : aliased constant String := "JSON with Comments";
   K_168           : aliased constant String := "mg";
   M_168           : aliased constant String := "Modula-3";
   K_169           : aliased constant String := "rss";
   M_169           : aliased constant String := "XML";
   K_170           : aliased constant String := "rst";
   M_170           : aliased constant String := "reStructuredText";
   K_171           : aliased constant String := "move";
   M_171           : aliased constant String := "Move";
   K_172           : aliased constant String := "jisonlex";
   M_172           : aliased constant String := "Jison Lex";
   K_173           : aliased constant String := "mk";
   M_173           : aliased constant String := "Makefile";
   K_174           : aliased constant String := "ml";
   M_174           : aliased constant String := "OCaml,Standard ML";
   K_175           : aliased constant String := "rsx";
   M_175           : aliased constant String := "R";
   K_176           : aliased constant String := "mm";
   M_176           : aliased constant String := "XML,Objective-C++";
   K_177           : aliased constant String := "eclass";
   M_177           : aliased constant String := "Gentoo Eclass";
   K_178           : aliased constant String := "mo";
   M_178           : aliased constant String := "Motoko,Modelica";
   K_179           : aliased constant String := "jelly";
   M_179           : aliased constant String := "XML";
   K_180           : aliased constant String := "boo";
   M_180           : aliased constant String := "Boo";
   K_181           : aliased constant String := "ms";
   M_181           : aliased constant String := "Unix Assembly,Roff,MAXScript";
   K_182           : aliased constant String := "mt";
   M_182           : aliased constant String := "Mathematica";
   K_183           : aliased constant String := "mu";
   M_183           : aliased constant String := "mupad";
   K_184           : aliased constant String := "opal";
   M_184           : aliased constant String := "Opal";
   K_185           : aliased constant String := "code-workspace";
   M_185           : aliased constant String := "JSON with Comments";
   K_186           : aliased constant String := "xmi";
   M_186           : aliased constant String := "XML";
   K_187           : aliased constant String := "oxh";
   M_187           : aliased constant String := "Ox";
   K_188           : aliased constant String := "xml";
   M_188           : aliased constant String := "XML";
   K_189           : aliased constant String := "mq4";
   M_189           : aliased constant String := "MQL4";
   K_190           : aliased constant String := "elm";
   M_190           : aliased constant String := "Elm";
   K_191           : aliased constant String := "oxygene";
   M_191           : aliased constant String := "Oxygene";
   K_192           : aliased constant String := "mq5";
   M_192           : aliased constant String := "MQL5";
   K_193           : aliased constant String := "cypher";
   M_193           : aliased constant String := "Cypher";
   K_194           : aliased constant String := "curry";
   M_194           : aliased constant String := "Curry";
   K_195           : aliased constant String := "xmp";
   M_195           : aliased constant String := "XML";
   K_196           : aliased constant String := "nas";
   M_196           : aliased constant String := "Assembly,Nasal";
   K_197           : aliased constant String := "dircolors";
   M_197           : aliased constant String := "dircolors";
   K_198           : aliased constant String := "hic";
   M_198           : aliased constant String := "Clojure";
   K_199           : aliased constant String := "vdf";
   M_199           : aliased constant String := "Valve Data Format";
   K_200           : aliased constant String := "oxo";
   M_200           : aliased constant String := "Ox";
   K_201           : aliased constant String := "mod";
   M_201           : aliased constant String := "XML,Modula-2,Linux Kernel Module,AMPL";
   K_202           : aliased constant String := "asn1";
   M_202           : aliased constant String := "ASN.1";
   K_203           : aliased constant String := "elv";
   M_203           : aliased constant String := "Elvish";
   K_204           : aliased constant String := "mkdn";
   M_204           : aliased constant String := "Markdown";
   K_205           : aliased constant String := "ccp";
   M_205           : aliased constant String := "COBOL";
   K_206           : aliased constant String := "moo";
   M_206           : aliased constant String := "Moocode,Mercury";
   K_207           : aliased constant String := "plb";
   M_207           : aliased constant String := "PLSQL";
   K_208           : aliased constant String := "bones";
   M_208           : aliased constant String := "JavaScript";
   K_209           : aliased constant String := "4DForm";
   M_209           : aliased constant String := "JSON";
   K_210           : aliased constant String := "numpyw";
   M_210           : aliased constant String := "NumPy";
   K_211           : aliased constant String := "ol";
   M_211           : aliased constant String := "Jolie";
   K_212           : aliased constant String := "yap";
   M_212           : aliased constant String := "Prolog";
   K_213           : aliased constant String := "mxml";
   M_213           : aliased constant String := "XML";
   K_214           : aliased constant String := "url";
   M_214           : aliased constant String := "INI";
   K_215           : aliased constant String := "mbox";
   M_215           : aliased constant String := "E-mail";
   K_216           : aliased constant String := "yar";
   M_216           : aliased constant String := "YARA";
   K_217           : aliased constant String := "perl";
   M_217           : aliased constant String := "Perl";
   K_218           : aliased constant String := "axaml";
   M_218           : aliased constant String := "XML";
   K_219           : aliased constant String := "os";
   M_219           : aliased constant String := "1C Enterprise";
   K_220           : aliased constant String := "pls";
   M_220           : aliased constant String := "PLSQL";
   K_221           : aliased constant String := "plt";
   M_221           : aliased constant String := "Prolog,Gnuplot";
   K_222           : aliased constant String := "sig";
   M_222           : aliased constant String := "Standard ML";
   K_223           : aliased constant String := "tcsh";
   M_223           : aliased constant String := "Tcsh";
   K_224           : aliased constant String := "urs";
   M_224           : aliased constant String := "UrWeb";
   K_225           : aliased constant String := "webmanifest";
   M_225           : aliased constant String := "JSON";
   K_226           : aliased constant String := "ncl";
   M_226           : aliased constant String := "XML,Text,NCL,Gerber Image";
   K_227           : aliased constant String := "ox";
   M_227           : aliased constant String := "Ox";
   K_228           : aliased constant String := "plx";
   M_228           : aliased constant String := "Perl";
   K_229           : aliased constant String := "oz";
   M_229           : aliased constant String := "Oz";
   K_230           : aliased constant String := "smt2";
   M_230           : aliased constant String := "SMT";
   K_231           : aliased constant String := "mkdown";
   M_231           : aliased constant String := "Markdown";
   K_232           : aliased constant String := "tfstate";
   M_232           : aliased constant String := "JSON";
   K_233           : aliased constant String := "ent";
   M_233           : aliased constant String := "DTD";
   K_234           : aliased constant String := "ssjs";
   M_234           : aliased constant String := "JavaScript";
   K_235           : aliased constant String := "mqh";
   M_235           : aliased constant String := "MQL5,MQL4";
   K_236           : aliased constant String := "env";
   M_236           : aliased constant String := "Dotenv";
   K_237           : aliased constant String := "sublime-completions";
   M_237           : aliased constant String := "JSON with Comments";
   K_238           : aliased constant String := "scaml";
   M_238           : aliased constant String := "Scaml";
   K_239           : aliased constant String := "d-objdump";
   M_239           : aliased constant String := "D-ObjDump";
   K_240           : aliased constant String := "ql";
   M_240           : aliased constant String := "CodeQL";
   K_241           : aliased constant String := "pprx";
   M_241           : aliased constant String := "REXX";
   K_242           : aliased constant String := "wisp";
   M_242           : aliased constant String := "wisp";
   K_243           : aliased constant String := "cobol";
   M_243           : aliased constant String := "COBOL";
   K_244           : aliased constant String := "bsl";
   M_244           : aliased constant String := "1C Enterprise";
   K_245           : aliased constant String := "slint";
   M_245           : aliased constant String := "Slint";
   K_246           : aliased constant String := "textile";
   M_246           : aliased constant String := "Textile";
   K_247           : aliased constant String := "befunge";
   M_247           : aliased constant String := "Befunge";
   K_248           : aliased constant String := "qs";
   M_248           : aliased constant String := "Qt Script,Q#";
   K_249           : aliased constant String := "gyp";
   M_249           : aliased constant String := "Python";
   K_250           : aliased constant String := "axi.erb";
   M_250           : aliased constant String := "NetLinx+ERB";
   K_251           : aliased constant String := "jsonnet";
   M_251           : aliased constant String := "Jsonnet";
   K_252           : aliased constant String := "_coffee";
   M_252           : aliased constant String := "CoffeeScript";
   K_253           : aliased constant String := "jsproj";
   M_253           : aliased constant String := "XML";
   K_254           : aliased constant String := "bsv";
   M_254           : aliased constant String := "Bluespec";
   K_255           : aliased constant String := "asset";
   M_255           : aliased constant String := "Unity3D Asset";
   K_256           : aliased constant String := "epj";
   M_256           : aliased constant String := "Ecere Projects";
   K_257           : aliased constant String := "xql";
   M_257           : aliased constant String := "XQuery";
   K_258           : aliased constant String := "xqm";
   M_258           : aliased constant String := "XQuery";
   K_259           : aliased constant String := "matlab";
   M_259           : aliased constant String := "MATLAB";
   K_260           : aliased constant String := "vhd";
   M_260           : aliased constant String := "VHDL";
   K_261           : aliased constant String := "vhf";
   M_261           : aliased constant String := "VHDL";
   K_262           : aliased constant String := "xojo_menu";
   M_262           : aliased constant String := "Xojo";
   K_263           : aliased constant String := "msd";
   M_263           : aliased constant String := "JetBrains MPS";
   K_264           : aliased constant String := "cirru";
   M_264           : aliased constant String := "Cirru";
   K_265           : aliased constant String := "eps";
   M_265           : aliased constant String := "PostScript";
   K_266           : aliased constant String := "vhi";
   M_266           : aliased constant String := "VHDL";
   K_267           : aliased constant String := "webidl";
   M_267           : aliased constant String := "WebIDL";
   K_268           : aliased constant String := "cocci";
   M_268           : aliased constant String := "SmPL";
   K_269           : aliased constant String := "cgi";
   M_269           : aliased constant String := "Python,Perl,Shell";
   K_270           : aliased constant String := "eam.fs";
   M_270           : aliased constant String := "Formatted";
   K_271           : aliased constant String := "numpy";
   M_271           : aliased constant String := "NumPy";
   K_272           : aliased constant String := "xliff";
   M_272           : aliased constant String := "XML";
   K_273           : aliased constant String := "xqy";
   M_273           : aliased constant String := "XQuery";
   K_274           : aliased constant String := "vho";
   M_274           : aliased constant String := "VHDL";
   K_275           : aliased constant String := "qbs";
   M_275           : aliased constant String := "QML";
   K_276           : aliased constant String := "gnuplot";
   M_276           : aliased constant String := "Gnuplot";
   K_277           : aliased constant String := "vhs";
   M_277           : aliased constant String := "VHDL";
   K_278           : aliased constant String := "sc";
   M_278           : aliased constant String := "SuperCollider,Scala";
   K_279           : aliased constant String := "vht";
   M_279           : aliased constant String := "VHDL";
   K_280           : aliased constant String := "aidl";
   M_280           : aliased constant String := "AIDL";
   K_281           : aliased constant String := "mss";
   M_281           : aliased constant String := "CartoCSS";
   K_282           : aliased constant String := "vhw";
   M_282           : aliased constant String := "VHDL";
   K_283           : aliased constant String := "sh";
   M_283           : aliased constant String := "Shell";
   K_284           : aliased constant String := "sj";
   M_284           : aliased constant String := "Objective-J";
   K_285           : aliased constant String := "sl";
   M_285           : aliased constant String := "Slash";
   K_286           : aliased constant String := "sma";
   M_286           : aliased constant String := "Pawn";
   K_287           : aliased constant String := "cats";
   M_287           : aliased constant String := "C";
   K_288           : aliased constant String := "graphql";
   M_288           : aliased constant String := "GraphQL";
   K_289           : aliased constant String := "sp";
   M_289           : aliased constant String := "SourcePawn";
   K_290           : aliased constant String := "erb";
   M_290           : aliased constant String := "HTML+ERB";
   K_291           : aliased constant String := "xsd";
   M_291           : aliased constant String := "XML";
   K_292           : aliased constant String := "ss";
   M_292           : aliased constant String := "Scheme";
   K_293           : aliased constant String := "aspx";
   M_293           : aliased constant String := "ASP.NET";
   K_294           : aliased constant String := "st";
   M_294           : aliased constant String := "StringTemplate,Smalltalk";
   K_295           : aliased constant String := "sv";
   M_295           : aliased constant String := "SystemVerilog";
   K_296           : aliased constant String := "xsh";
   M_296           : aliased constant String := "Xonsh";
   K_297           : aliased constant String := "ceylon";
   M_297           : aliased constant String := "Ceylon";
   K_298           : aliased constant String := "sw";
   M_298           : aliased constant String := "XML,Sway";
   K_299           : aliased constant String := "smk";
   M_299           : aliased constant String := "Snakemake";
   K_300           : aliased constant String := "sml";
   M_300           : aliased constant String := "Standard ML";
   K_301           : aliased constant String := "xsl";
   M_301           : aliased constant String := "XSLT";
   K_302           : aliased constant String := "erl";
   M_302           : aliased constant String := "Erlang";
   K_303           : aliased constant String := "smt";
   M_303           : aliased constant String := "SMT";
   K_304           : aliased constant String := "mud";
   M_304           : aliased constant String := "ZIL";
   K_305           : aliased constant String := "glyphs";
   M_305           : aliased constant String := "OpenStep Property List";
   K_306           : aliased constant String := "muf";
   M_306           : aliased constant String := "MUF";
   K_307           : aliased constant String := "smithy";
   M_307           : aliased constant String := "Smithy";
   K_308           : aliased constant String := "cil";
   M_308           : aliased constant String := "CIL";
   K_309           : aliased constant String := "tab";
   M_309           : aliased constant String := "SQL";
   K_310           : aliased constant String := "svelte";
   M_310           : aliased constant String := "Svelte";
   K_311           : aliased constant String := "tac";
   M_311           : aliased constant String := "Python";
   K_312           : aliased constant String := "toit";
   M_312           : aliased constant String := "Toit";
   K_313           : aliased constant String := "plantuml";
   M_313           : aliased constant String := "PlantUML";
   K_314           : aliased constant String := "robot";
   M_314           : aliased constant String := "RobotFramework";
   K_315           : aliased constant String := "tag";
   M_315           : aliased constant String := "Java Server Pages";
   K_316           : aliased constant String := "erb.deface";
   M_316           : aliased constant String := "HTML+ERB";
   K_317           : aliased constant String := "prc";
   M_317           : aliased constant String := "SQL,PLSQL";
   K_318           : aliased constant String := "uc";
   M_318           : aliased constant String := "UnrealScript";
   K_319           : aliased constant String := "prg";
   M_319           : aliased constant String := "xBase";
   K_320           : aliased constant String := "csproj";
   M_320           : aliased constant String := "XML";
   K_321           : aliased constant String := "pri";
   M_321           : aliased constant String := "QMake";
   K_322           : aliased constant String := "ui";
   M_322           : aliased constant String := "XML";
   K_323           : aliased constant String := "TextGrid";
   M_323           : aliased constant String := "TextGrid";
   K_324           : aliased constant String := "decls";
   M_324           : aliased constant String := "BlitzBasic";
   K_325           : aliased constant String := "h++";
   M_325           : aliased constant String := "C++";
   K_326           : aliased constant String := "pro";
   M_326           : aliased constant String := "INI,QMake,Prolog,Proguard,IDL";
   K_327           : aliased constant String := "ice";
   M_327           : aliased constant String := "JSON,Slice";
   K_328           : aliased constant String := "asciidoc";
   M_328           : aliased constant String := "AsciiDoc";
   K_329           : aliased constant String := "geojson";
   M_329           : aliased constant String := "JSON";
   K_330           : aliased constant String := "ur";
   M_330           : aliased constant String := "UrWeb";
   K_331           : aliased constant String := "qasm";
   M_331           : aliased constant String := "OpenQASM";
   K_332           : aliased constant String := "icl";
   M_332           : aliased constant String := "Clean";
   K_333           : aliased constant String := "asddls";
   M_333           : aliased constant String := "ABAP CDS";
   K_334           : aliased constant String := "prw";
   M_334           : aliased constant String := "xBase";
   K_335           : aliased constant String := "ux";
   M_335           : aliased constant String := "XML";
   K_336           : aliased constant String := "yml.mysql";
   M_336           : aliased constant String := "YAML";
   K_337           : aliased constant String := "nim";
   M_337           : aliased constant String := "Nim";
   K_338           : aliased constant String := "sol";
   M_338           : aliased constant String := "Solidity,Gerber Image";
   K_339           : aliased constant String := "xul";
   M_339           : aliased constant String := "XML";
   K_340           : aliased constant String := "nit";
   M_340           : aliased constant String := "Nit";
   K_341           : aliased constant String := "dylan";
   M_341           : aliased constant String := "Dylan";
   K_342           : aliased constant String := "hqf";
   M_342           : aliased constant String := "SQF";
   K_343           : aliased constant String := "ccxml";
   M_343           : aliased constant String := "XML";
   K_344           : aliased constant String := "sfproj";
   M_344           : aliased constant String := "XML";
   K_345           : aliased constant String := "nix";
   M_345           : aliased constant String := "Nix";
   K_346           : aliased constant String := "soy";
   M_346           : aliased constant String := "Closure Templates";
   K_347           : aliased constant String := "gdbinit";
   M_347           : aliased constant String := "GDB";
   K_348           : aliased constant String := "hql";
   M_348           : aliased constant String := "HiveQL";
   K_349           : aliased constant String := "tcc";
   M_349           : aliased constant String := "C++";
   K_350           : aliased constant String := "html";
   M_350           : aliased constant String := "HTML,Ecmarkup";
   K_351           : aliased constant String := "rbfrm";
   M_351           : aliased constant String := "REALbasic";
   K_352           : aliased constant String := "zone";
   M_352           : aliased constant String := "DNS Zone";
   K_353           : aliased constant String := "eclxml";
   M_353           : aliased constant String := "ECL";
   K_354           : aliased constant String := "4th";
   M_354           : aliased constant String := "Forth";
   K_355           : aliased constant String := "nimrod";
   M_355           : aliased constant String := "Nim";
   K_356           : aliased constant String := "meta";
   M_356           : aliased constant String := "Unity3D Asset";
   K_357           : aliased constant String := "sublime-project";
   M_357           : aliased constant String := "JSON with Comments";
   K_358           : aliased constant String := "x10";
   M_358           : aliased constant String := "X10";
   K_359           : aliased constant String := "handlebars";
   M_359           : aliased constant String := "Handlebars";
   K_360           : aliased constant String := "tcl";
   M_360           : aliased constant String := "Tcl";
   K_361           : aliased constant String := "csdef";
   M_361           : aliased constant String := "XML";
   K_362           : aliased constant String := "wl";
   M_362           : aliased constant String := "Mathematica";
   K_363           : aliased constant String := "objdump";
   M_363           : aliased constant String := "ObjDump";
   K_364           : aliased constant String := "nginxconf";
   M_364           : aliased constant String := "Nginx";
   K_365           : aliased constant String := "make";
   M_365           : aliased constant String := "Makefile";
   K_366           : aliased constant String := "gshader";
   M_366           : aliased constant String := "GLSL";
   K_367           : aliased constant String := "pkgproj";
   M_367           : aliased constant String := "XML";
   K_368           : aliased constant String := "sqf";
   M_368           : aliased constant String := "SQF";
   K_369           : aliased constant String := "ws";
   M_369           : aliased constant String := "Witcher Script";
   K_370           : aliased constant String := "rviz";
   M_370           : aliased constant String := "YAML";
   K_371           : aliased constant String := "bats";
   M_371           : aliased constant String := "Shell";
   K_372           : aliased constant String := "podspec";
   M_372           : aliased constant String := "Ruby";
   K_373           : aliased constant String := "sql";
   M_373           : aliased constant String := "TSQL,SQLPL,SQL,PLpgSQL,PLSQL";
   K_374           : aliased constant String := "mako";
   M_374           : aliased constant String := "Mako";
   K_375           : aliased constant String := "cmd";
   M_375           : aliased constant String := "Batchfile";
   K_376           : aliased constant String := "hsc";
   M_376           : aliased constant String := "Haskell";
   K_377           : aliased constant String := "properties";
   M_377           : aliased constant String := "INI,Java Properties";
   K_378           : aliased constant String := "toml";
   M_378           : aliased constant String := "TOML";
   K_379           : aliased constant String := "cmake.in";
   M_379           : aliased constant String := "CMake";
   K_380           : aliased constant String := "gitconfig";
   M_380           : aliased constant String := "Git Config";
   K_381           : aliased constant String := "tea";
   M_381           : aliased constant String := "Tea";
   K_382           : aliased constant String := "ada";
   M_382           : aliased constant String := "Ada";
   K_383           : aliased constant String := "adb";
   M_383           : aliased constant String := "Ada";
   K_384           : aliased constant String := "cmp";
   M_384           : aliased constant String := "Gerber Image";
   K_385           : aliased constant String := "livemd";
   M_385           : aliased constant String := "Markdown";
   K_386           : aliased constant String := "rest";
   M_386           : aliased constant String := "reStructuredText";
   K_387           : aliased constant String := "lbx";
   M_387           : aliased constant String := "TeX";
   K_388           : aliased constant String := "hs-boot";
   M_388           : aliased constant String := "Haskell";
   K_389           : aliased constant String := "pike";
   M_389           : aliased constant String := "Pike";
   K_390           : aliased constant String := "myt";
   M_390           : aliased constant String := "Myghty";
   K_391           : aliased constant String := "gdnlib";
   M_391           : aliased constant String := "Godot Resource";
   K_392           : aliased constant String := "1m";
   M_392           : aliased constant String := "Roff Manpage,Roff";
   K_393           : aliased constant String := "resx";
   M_393           : aliased constant String := "XML";
   K_394           : aliased constant String := "xtend";
   M_394           : aliased constant String := "Xtend";
   K_395           : aliased constant String := "lektorproject";
   M_395           : aliased constant String := "INI";
   K_396           : aliased constant String := "avsc";
   M_396           : aliased constant String := "JSON";
   K_397           : aliased constant String := "ado";
   M_397           : aliased constant String := "Stata";
   K_398           : aliased constant String := "adp";
   M_398           : aliased constant String := "Tcl";
   K_399           : aliased constant String := "tmSnippet";
   M_399           : aliased constant String := "XML Property List";
   K_400           : aliased constant String := "dae";
   M_400           : aliased constant String := "COLLADA";
   K_401           : aliased constant String := "sublime-syntax";
   M_401           : aliased constant String := "YAML";
   K_402           : aliased constant String := "ads";
   M_402           : aliased constant String := "Ada";
   K_403           : aliased constant String := "1x";
   M_403           : aliased constant String := "Roff Manpage,Roff";
   K_404           : aliased constant String := "tex";
   M_404           : aliased constant String := "TeX";
   K_405           : aliased constant String := "yy";
   M_405           : aliased constant String := "JSON,Yacc";
   K_406           : aliased constant String := "cob";
   M_406           : aliased constant String := "COBOL";
   K_407           : aliased constant String := "wsdl";
   M_407           : aliased constant String := "XML";
   K_408           : aliased constant String := "snakefile";
   M_408           : aliased constant String := "Snakemake";
   K_409           : aliased constant String := "sss";
   M_409           : aliased constant String := "SugarSS";
   K_410           : aliased constant String := "rbxs";
   M_410           : aliased constant String := "Lua";
   K_411           : aliased constant String := "tool";
   M_411           : aliased constant String := "Shell";
   K_412           : aliased constant String := "exs";
   M_412           : aliased constant String := "Elixir";
   K_413           : aliased constant String := "pcss";
   M_413           : aliased constant String := "PostCSS";
   K_414           : aliased constant String := "jinja";
   M_414           : aliased constant String := "Jinja";
   K_415           : aliased constant String := "rchit";
   M_415           : aliased constant String := "GLSL";
   K_416           : aliased constant String := "prisma";
   M_416           : aliased constant String := "Prisma";
   K_417           : aliased constant String := "parrot";
   M_417           : aliased constant String := "Parrot";
   K_418           : aliased constant String := "com";
   M_418           : aliased constant String := "DIGITAL Command Language";
   K_419           : aliased constant String := "service";
   M_419           : aliased constant String := "desktop";
   K_420           : aliased constant String := "lds";
   M_420           : aliased constant String := "Linker Script";
   K_421           : aliased constant String := "coq";
   M_421           : aliased constant String := "Coq";
   K_422           : aliased constant String := "lvclass";
   M_422           : aliased constant String := "LabVIEW";
   K_423           : aliased constant String := "flf";
   M_423           : aliased constant String := "FIGlet Font";
   K_424           : aliased constant String := "pxd";
   M_424           : aliased constant String := "Cython";
   K_425           : aliased constant String := "sage";
   M_425           : aliased constant String := "Sage";
   K_426           : aliased constant String := "3m";
   M_426           : aliased constant String := "Roff Manpage,Roff";
   K_427           : aliased constant String := "yml";
   M_427           : aliased constant String := "YAML,OASv3-yaml,OASv2-yaml,MiniYAML";
   K_428           : aliased constant String := "pxi";
   M_428           : aliased constant String := "Cython";
   K_429           : aliased constant String := "scpt";
   M_429           : aliased constant String := "AppleScript";
   K_430           : aliased constant String := "afm";
   M_430           : aliased constant String := "Adobe Font Metrics";
   K_431           : aliased constant String := "krl";
   M_431           : aliased constant String := "KRL";
   K_432           : aliased constant String := "3p";
   M_432           : aliased constant String := "Roff Manpage,Roff";
   K_433           : aliased constant String := "c++";
   M_433           : aliased constant String := "C++";
   K_434           : aliased constant String := "x3d";
   M_434           : aliased constant String := "XML";
   K_435           : aliased constant String := "nearley";
   M_435           : aliased constant String := "Nearley";
   K_436           : aliased constant String := "3x";
   M_436           : aliased constant String := "Roff Manpage,Roff";
   K_437           : aliased constant String := "nasl";
   M_437           : aliased constant String := "NASL";
   K_438           : aliased constant String := "nasm";
   M_438           : aliased constant String := "Assembly";
   K_439           : aliased constant String := "wdl";
   M_439           : aliased constant String := "WDL";
   K_440           : aliased constant String := "dcl";
   M_440           : aliased constant String := "Clean";
   K_441           : aliased constant String := "markdown";
   M_441           : aliased constant String := "Markdown";
   K_442           : aliased constant String := "cmake";
   M_442           : aliased constant String := "CMake";
   K_443           : aliased constant String := "iced";
   M_443           : aliased constant String := "CoffeeScript";
   K_444           : aliased constant String := "nuspec";
   M_444           : aliased constant String := "XML";
   K_445           : aliased constant String := "gitignore";
   M_445           : aliased constant String := "Ignore List";
   K_446           : aliased constant String := "xproc";
   M_446           : aliased constant String := "XProc";
   K_447           : aliased constant String := "lfe";
   M_447           : aliased constant String := "LFE";
   K_448           : aliased constant String := "xsjs";
   M_448           : aliased constant String := "JavaScript";
   K_449           : aliased constant String := "cljs.hl";
   M_449           : aliased constant String := "Clojure";
   K_450           : aliased constant String := "xproj";
   M_450           : aliased constant String := "XML";
   K_451           : aliased constant String := "qll";
   M_451           : aliased constant String := "CodeQL";
   K_452           : aliased constant String := "zap";
   M_452           : aliased constant String := "ZAP";
   K_453           : aliased constant String := "cql";
   M_453           : aliased constant String := "SQL";
   K_454           : aliased constant String := "pogo";
   M_454           : aliased constant String := "PogoScript";
   K_455           : aliased constant String := "fnc";
   M_455           : aliased constant String := "PLSQL";
   K_456           : aliased constant String := "vshader";
   M_456           : aliased constant String := "GLSL";
   K_457           : aliased constant String := "ninja";
   M_457           : aliased constant String := "Ninja";
   K_458           : aliased constant String := "vimrc";
   M_458           : aliased constant String := "Vim Script";
   K_459           : aliased constant String := "vrx";
   M_459           : aliased constant String := "GLSL";
   K_460           : aliased constant String := "ahk";
   M_460           : aliased constant String := "AutoHotkey";
   K_461           : aliased constant String := "fnl";
   M_461           : aliased constant String := "Fennel";
   K_462           : aliased constant String := "ktm";
   M_462           : aliased constant String := "Kotlin";
   K_463           : aliased constant String := "cjsx";
   M_463           : aliased constant String := "CoffeeScript";
   K_464           : aliased constant String := "jake";
   M_464           : aliased constant String := "JavaScript";
   K_465           : aliased constant String := "kts";
   M_465           : aliased constant String := "Kotlin";
   K_466           : aliased constant String := "apacheconf";
   M_466           : aliased constant String := "ApacheConf";
   K_467           : aliased constant String := "rst.txt";
   M_467           : aliased constant String := "reStructuredText";
   K_468           : aliased constant String := "mirah";
   M_468           : aliased constant String := "Mirah";
   K_469           : aliased constant String := "c++objdump";
   M_469           : aliased constant String := "Cpp-ObjDump";
   K_470           : aliased constant String := "ditamap";
   M_470           : aliased constant String := "XML";
   K_471           : aliased constant String := "nqp";
   M_471           : aliased constant String := "Raku";
   K_472           : aliased constant String := "zimpl";
   M_472           : aliased constant String := "Zimpl";
   K_473           : aliased constant String := "csc";
   M_473           : aliased constant String := "GSC";
   K_474           : aliased constant String := "qhelp";
   M_474           : aliased constant String := "XML";
   K_475           : aliased constant String := "xslt";
   M_475           : aliased constant String := "XSLT";
   K_476           : aliased constant String := "csd";
   M_476           : aliased constant String := "Csound Document";
   K_477           : aliased constant String := "gbl";
   M_477           : aliased constant String := "Gerber Image";
   K_478           : aliased constant String := "csh";
   M_478           : aliased constant String := "Tcsh";
   K_479           : aliased constant String := "gbo";
   M_479           : aliased constant String := "Gerber Image";
   K_480           : aliased constant String := "vtl";
   M_480           : aliased constant String := "Velocity Template Language";
   K_481           : aliased constant String := "gbp";
   M_481           : aliased constant String := "Gerber Image";
   K_482           : aliased constant String := "csl";
   M_482           : aliased constant String := "XML,Kusto";
   K_483           : aliased constant String := "gbr";
   M_483           : aliased constant String := "Gerber Image";
   K_484           : aliased constant String := "slim";
   M_484           : aliased constant String := "Slim";
   K_485           : aliased constant String := "gbs";
   M_485           : aliased constant String := "Gerber Image";
   K_486           : aliased constant String := "lhs";
   M_486           : aliased constant String := "Literate Haskell";
   K_487           : aliased constant String := "hoon";
   M_487           : aliased constant String := "hoon";
   K_488           : aliased constant String := "mspec";
   M_488           : aliased constant String := "Ruby";
   K_489           : aliased constant String := "vtt";
   M_489           : aliased constant String := "WebVTT";
   K_490           : aliased constant String := "css";
   M_490           : aliased constant String := "CSS";
   K_491           : aliased constant String := "csv";
   M_491           : aliased constant String := "CSV";
   K_492           : aliased constant String := "hats";
   M_492           : aliased constant String := "ATS";
   K_493           : aliased constant String := "csx";
   M_493           : aliased constant String := "C#";
   K_494           : aliased constant String := "fpp";
   M_494           : aliased constant String := "Fortran";
   K_495           : aliased constant String := "rbi";
   M_495           : aliased constant String := "Ruby";
   K_496           : aliased constant String := "nse";
   M_496           : aliased constant String := "Lua";
   K_497           : aliased constant String := "nawk";
   M_497           : aliased constant String := "Awk";
   K_498           : aliased constant String := "click";
   M_498           : aliased constant String := "Click";
   K_499           : aliased constant String := "ligo";
   M_499           : aliased constant String := "LigoLANG";
   K_500           : aliased constant String := "nsh";
   M_500           : aliased constant String := "NSIS";
   K_501           : aliased constant String := "volt";
   M_501           : aliased constant String := "Volt";
   K_502           : aliased constant String := "abap";
   M_502           : aliased constant String := "ABAP";
   K_503           : aliased constant String := "nsi";
   M_503           : aliased constant String := "NSIS";
   K_504           : aliased constant String := "iml";
   M_504           : aliased constant String := "XML";
   K_505           : aliased constant String := "gdb";
   M_505           : aliased constant String := "GDB";
   K_506           : aliased constant String := "mask";
   M_506           : aliased constant String := "Unity3D Asset,Mask";
   K_507           : aliased constant String := "yang";
   M_507           : aliased constant String := "YANG";
   K_508           : aliased constant String := "rbs";
   M_508           : aliased constant String := "RBS";
   K_509           : aliased constant String := "rbw";
   M_509           : aliased constant String := "Ruby";
   K_510           : aliased constant String := "depproj";
   M_510           : aliased constant String := "XML";
   K_511           : aliased constant String := "nss";
   M_511           : aliased constant String := "NWScript";
   K_512           : aliased constant String := "rbx";
   M_512           : aliased constant String := "Ruby";
   K_513           : aliased constant String := "cue";
   M_513           : aliased constant String := "Cue Sheet,CUE";
   K_514           : aliased constant String := "sublime-macro";
   M_514           : aliased constant String := "JSON with Comments";
   K_515           : aliased constant String := "cuh";
   M_515           : aliased constant String := "Cuda";
   K_516           : aliased constant String := "texinfo";
   M_516           : aliased constant String := "Texinfo";
   K_517           : aliased constant String := "zep";
   M_517           : aliased constant String := "Zephir";
   K_518           : aliased constant String := "mkvi";
   M_518           : aliased constant String := "TeX";
   K_519           : aliased constant String := "scxml";
   M_519           : aliased constant String := "XML";
   K_520           : aliased constant String := "mediawiki";
   M_520           : aliased constant String := "Wikitext";
   K_521           : aliased constant String := "frg";
   M_521           : aliased constant String := "GLSL";
   K_522           : aliased constant String := "edgeql";
   M_522           : aliased constant String := "EdgeQL";
   K_523           : aliased constant String := "p6l";
   M_523           : aliased constant String := "Raku";
   K_524           : aliased constant String := "tmLanguage";
   M_524           : aliased constant String := "XML Property List";
   K_525           : aliased constant String := "tml";
   M_525           : aliased constant String := "XML";
   K_526           : aliased constant String := "p6m";
   M_526           : aliased constant String := "Raku";
   K_527           : aliased constant String := "frm";
   M_527           : aliased constant String := "VBA,Visual Basic 6.0";
   K_528           : aliased constant String := "rdf";
   M_528           : aliased constant String := "XML";
   K_529           : aliased constant String := "xsp.metadata";
   M_529           : aliased constant String := "XPages";
   K_530           : aliased constant String := "jav";
   M_530           : aliased constant String := "Java";
   K_531           : aliased constant String := "creole";
   M_531           : aliased constant String := "Creole";
   K_532           : aliased constant String := "als";
   M_532           : aliased constant String := "Alloy";
   K_533           : aliased constant String := "frt";
   M_533           : aliased constant String := "Forth";
   K_534           : aliased constant String := "iol";
   M_534           : aliased constant String := "Jolie";
   K_535           : aliased constant String := "sublime-build";
   M_535           : aliased constant String := "JSON with Comments";
   K_536           : aliased constant String := "grace";
   M_536           : aliased constant String := "Grace";
   K_537           : aliased constant String := "rakumod";
   M_537           : aliased constant String := "Raku";
   K_538           : aliased constant String := "nut";
   M_538           : aliased constant String := "Squirrel";
   K_539           : aliased constant String := "mtml";
   M_539           : aliased constant String := "MTML";
   K_540           : aliased constant String := "cwl";
   M_540           : aliased constant String := "Common Workflow Language";
   K_541           : aliased constant String := "launch";
   M_541           : aliased constant String := "XML";
   K_542           : aliased constant String := "toc";
   M_542           : aliased constant String := "World of Warcraft Addon Data,TeX";
   K_543           : aliased constant String := "fsti";
   M_543           : aliased constant String := "F*";
   K_544           : aliased constant String := "story";
   M_544           : aliased constant String := "Gherkin";
   K_545           : aliased constant String := "3in";
   M_545           : aliased constant String := "Roff Manpage,Roff";
   K_546           : aliased constant String := "kicad_wks";
   M_546           : aliased constant String := "KiCad Layout";
   K_547           : aliased constant String := "emacs";
   M_547           : aliased constant String := "Emacs Lisp";
   K_548           : aliased constant String := "jcl";
   M_548           : aliased constant String := "JCL";
   K_549           : aliased constant String := "fth";
   M_549           : aliased constant String := "Forth";
   K_550           : aliased constant String := "nproj";
   M_550           : aliased constant String := "XML";
   K_551           : aliased constant String := "gradle";
   M_551           : aliased constant String := "Gradle";
   K_552           : aliased constant String := "yul";
   M_552           : aliased constant String := "Yul";
   K_553           : aliased constant String := "ftl";
   M_553           : aliased constant String := "FreeMarker,Fluent";
   K_554           : aliased constant String := "roff";
   M_554           : aliased constant String := "Roff";
   K_555           : aliased constant String := "dotsettings";
   M_555           : aliased constant String := "XML";
   K_556           : aliased constant String := "rake";
   M_556           : aliased constant String := "Ruby";
   K_557           : aliased constant String := "chpl";
   M_557           : aliased constant String := "Chapel";
   K_558           : aliased constant String := "ant";
   M_558           : aliased constant String := "XML";
   K_559           : aliased constant String := "wlk";
   M_559           : aliased constant String := "Wollok";
   K_560           : aliased constant String := "yara";
   M_560           : aliased constant String := "YARA";
   K_561           : aliased constant String := "mermaid";
   M_561           : aliased constant String := "Mermaid";
   K_562           : aliased constant String := "cabal";
   M_562           : aliased constant String := "Cabal Config";
   K_563           : aliased constant String := "builds";
   M_563           : aliased constant String := "XML";
   K_564           : aliased constant String := "mawk";
   M_564           : aliased constant String := "Awk";
   K_565           : aliased constant String := "flex";
   M_565           : aliased constant String := "JFlex";
   K_566           : aliased constant String := "wlt";
   M_566           : aliased constant String := "Mathematica";
   K_567           : aliased constant String := "zig";
   M_567           : aliased constant String := "Zig";
   K_568           : aliased constant String := "raku";
   M_568           : aliased constant String := "Raku";
   K_569           : aliased constant String := "ring";
   M_569           : aliased constant String := "Ring";
   K_570           : aliased constant String := "gltf";
   M_570           : aliased constant String := "JSON";
   K_571           : aliased constant String := "zil";
   M_571           : aliased constant String := "ZIL";
   K_572           : aliased constant String := "f03";
   M_572           : aliased constant String := "Fortran Free Form";
   K_573           : aliased constant String := "podsl";
   M_573           : aliased constant String := "Common Lisp";
   K_574           : aliased constant String := "f08";
   M_574           : aliased constant String := "Fortran Free Form";
   K_575           : aliased constant String := "cyp";
   M_575           : aliased constant String := "Cypher";
   K_576           : aliased constant String := "md2";
   M_576           : aliased constant String := "Checksums";
   K_577           : aliased constant String := "bbx";
   M_577           : aliased constant String := "TeX";
   K_578           : aliased constant String := "md4";
   M_578           : aliased constant String := "Checksums";
   K_579           : aliased constant String := "pgsql";
   M_579           : aliased constant String := "PLpgSQL";
   K_580           : aliased constant String := "md5";
   M_580           : aliased constant String := "Checksums";
   K_581           : aliased constant String := "apl";
   M_581           : aliased constant String := "APL";
   K_582           : aliased constant String := "monkey2";
   M_582           : aliased constant String := "Monkey";
   K_583           : aliased constant String := "vsixmanifest";
   M_583           : aliased constant String := "XML";
   K_584           : aliased constant String := "glade";
   M_584           : aliased constant String := "XML";
   K_585           : aliased constant String := "cairo";
   M_585           : aliased constant String := "Cairo";
   K_586           : aliased constant String := "app";
   M_586           : aliased constant String := "Erlang";
   K_587           : aliased constant String := "d2";
   M_587           : aliased constant String := "D2";
   K_588           : aliased constant String := "clar";
   M_588           : aliased constant String := "Clarity";
   K_589           : aliased constant String := "rs.in";
   M_589           : aliased constant String := "Rust";
   K_590           : aliased constant String := "raml";
   M_590           : aliased constant String := "RAML";
   K_591           : aliased constant String := "sublime_session";
   M_591           : aliased constant String := "JSON with Comments";
   K_592           : aliased constant String := "bb";
   M_592           : aliased constant String := "Clojure,BlitzBasic,BitBake";
   K_593           : aliased constant String := "isl";
   M_593           : aliased constant String := "Inno Setup";
   K_594           : aliased constant String := "javascript";
   M_594           : aliased constant String := "JavaScript";
   K_595           : aliased constant String := "be";
   M_595           : aliased constant String := "Berry";
   K_596           : aliased constant String := "bf";
   M_596           : aliased constant String := "HyPhy,Brainfuck,Befunge,Beef";
   K_597           : aliased constant String := "bdf";
   M_597           : aliased constant String := "Glyph Bitmap Distribution Format";
   K_598           : aliased constant String := "bi";
   M_598           : aliased constant String := "FreeBasic";
   K_599           : aliased constant String := "builder";
   M_599           : aliased constant String := "Ruby";
   K_600           : aliased constant String := "iss";
   M_600           : aliased constant String := "Inno Setup";
   K_601           : aliased constant String := "sha224";
   M_601           : aliased constant String := "Checksums";
   K_602           : aliased constant String := "frag";
   M_602           : aliased constant String := "JavaScript,GLSL";
   K_603           : aliased constant String := "rbtbar";
   M_603           : aliased constant String := "REALbasic";
   K_604           : aliased constant String := "haml.deface";
   M_604           : aliased constant String := "Haml";
   K_605           : aliased constant String := "bs";
   M_605           : aliased constant String := "BrighterScript,Bluespec BH,Bikeshed";
   K_606           : aliased constant String := "lpr";
   M_606           : aliased constant String := "Pascal";
   K_607           : aliased constant String := "gjs";
   M_607           : aliased constant String := "Glimmer JS";
   K_608           : aliased constant String := "arc";
   M_608           : aliased constant String := "Arc";
   K_609           : aliased constant String := "dtsi";
   M_609           : aliased constant String := "Device Tree Source";
   K_610           : aliased constant String := "xbm";
   M_610           : aliased constant String := "X BitMap";
   K_611           : aliased constant String := "bdy";
   M_611           : aliased constant String := "PLSQL";
   K_612           : aliased constant String := "sha1";
   M_612           : aliased constant String := "Checksums";
   K_613           : aliased constant String := "fxh";
   M_613           : aliased constant String := "HLSL";
   K_614           : aliased constant String := "sha2";
   M_614           : aliased constant String := "Checksums";
   K_615           : aliased constant String := "xojo_script";
   M_615           : aliased constant String := "Xojo";
   K_616           : aliased constant String := "sha3";
   M_616           : aliased constant String := "Checksums";
   K_617           : aliased constant String := "dtso";
   M_617           : aliased constant String := "Device Tree Source";
   K_618           : aliased constant String := "nanorc";
   M_618           : aliased constant String := "nanorc";
   K_619           : aliased constant String := "lookml";
   M_619           : aliased constant String := "LookML";
   K_620           : aliased constant String := "yyp";
   M_620           : aliased constant String := "JSON";
   K_621           : aliased constant String := "ruby";
   M_621           : aliased constant String := "Ruby";
   K_622           : aliased constant String := "arr";
   M_622           : aliased constant String := "Pyret";
   K_623           : aliased constant String := "dart";
   M_623           : aliased constant String := "Dart";
   K_624           : aliased constant String := "tst";
   M_624           : aliased constant String := "Scilab,GAP";
   K_625           : aliased constant String := "dof";
   M_625           : aliased constant String := "INI";
   K_626           : aliased constant String := "rbmnu";
   M_626           : aliased constant String := "REALbasic";
   K_627           : aliased constant String := "psd1";
   M_627           : aliased constant String := "PowerShell";
   K_628           : aliased constant String := "tsv";
   M_628           : aliased constant String := "TSV";
   K_629           : aliased constant String := "doh";
   M_629           : aliased constant String := "Stata";
   K_630           : aliased constant String := "fancypack";
   M_630           : aliased constant String := "Fancy";
   K_631           : aliased constant String := "tsx";
   M_631           : aliased constant String := "XML,TSX";
   K_632           : aliased constant String := "sass";
   M_632           : aliased constant String := "Sass";
   K_633           : aliased constant String := "cshtml";
   M_633           : aliased constant String := "HTML+Razor";
   K_634           : aliased constant String := "pac";
   M_634           : aliased constant String := "JavaScript";
   K_635           : aliased constant String := "di";
   M_635           : aliased constant String := "D";
   K_636           : aliased constant String := "glf";
   M_636           : aliased constant String := "Glyph";
   K_637           : aliased constant String := "mdx";
   M_637           : aliased constant String := "MDX";
   K_638           : aliased constant String := "dot";
   M_638           : aliased constant String := "Graphviz (DOT)";
   K_639           : aliased constant String := "dm";
   M_639           : aliased constant String := "DM";
   K_640           : aliased constant String := "pan";
   M_640           : aliased constant String := "Pan";
   K_641           : aliased constant String := "tmTheme";
   M_641           : aliased constant String := "XML Property List";
   K_642           : aliased constant String := "dll.config";
   M_642           : aliased constant String := "XML";
   K_643           : aliased constant String := "do";
   M_643           : aliased constant String := "Stata";
   K_644           : aliased constant String := "xdc";
   M_644           : aliased constant String := "Tcl";
   K_645           : aliased constant String := "hocon";
   M_645           : aliased constant String := "HOCON";
   K_646           : aliased constant String := "pas";
   M_646           : aliased constant String := "Pascal";
   K_647           : aliased constant String := "asax";
   M_647           : aliased constant String := "ASP.NET";
   K_648           : aliased constant String := "pat";
   M_648           : aliased constant String := "Max";
   K_649           : aliased constant String := "urdf";
   M_649           : aliased constant String := "XML";
   K_650           : aliased constant String := "ooc";
   M_650           : aliased constant String := "ooc";
   K_651           : aliased constant String := "logtalk";
   M_651           : aliased constant String := "Logtalk";
   K_652           : aliased constant String := "mdoc";
   M_652           : aliased constant String := "Roff Manpage,Roff";
   K_653           : aliased constant String := "lvlib";
   M_653           : aliased constant String := "LabVIEW";
   K_654           : aliased constant String := "sha512";
   M_654           : aliased constant String := "Checksums";
   K_655           : aliased constant String := "PrjPCB";
   M_655           : aliased constant String := "Altium Designer";
   K_656           : aliased constant String := "ecl";
   M_656           : aliased constant String := "ECLiPSe,ECL";
   K_657           : aliased constant String := "ecr";
   M_657           : aliased constant String := "HTML+ECR";
   K_658           : aliased constant String := "ect";
   M_658           : aliased constant String := "EJS";
   K_659           : aliased constant String := "dats";
   M_659           : aliased constant String := "ATS";
   K_660           : aliased constant String := "filters";
   M_660           : aliased constant String := "XML";
   K_661           : aliased constant String := "puml";
   M_661           : aliased constant String := "PlantUML";
   K_662           : aliased constant String := "tesc";
   M_662           : aliased constant String := "GLSL";
   K_663           : aliased constant String := "tese";
   M_663           : aliased constant String := "GLSL";
   K_664           : aliased constant String := "antlers.html";
   M_664           : aliased constant String := "Antlers";
   K_665           : aliased constant String := "cfml";
   M_665           : aliased constant String := "ColdFusion";
   K_666           : aliased constant String := "pck";
   M_666           : aliased constant String := "PLSQL";
   K_667           : aliased constant String := "prolog";
   M_667           : aliased constant String := "Prolog";
   K_668           : aliased constant String := "watchr";
   M_668           : aliased constant String := "Ruby";
   K_669           : aliased constant String := "yasnippet";
   M_669           : aliased constant String := "YASnippet";
   K_670           : aliased constant String := "gni";
   M_670           : aliased constant String := "GN";
   K_671           : aliased constant String := "coffee";
   M_671           : aliased constant String := "CoffeeScript";
   K_672           : aliased constant String := "workbook";
   M_672           : aliased constant String := "Markdown";
   K_673           : aliased constant String := "fp";
   M_673           : aliased constant String := "GLSL";
   K_674           : aliased constant String := "desktop";
   M_674           : aliased constant String := "desktop";
   K_675           : aliased constant String := "fr";
   M_675           : aliased constant String := "Text,Frege,Forth";
   K_676           : aliased constant String := "moon";
   M_676           : aliased constant String := "MoonScript";
   K_677           : aliased constant String := "fs";
   M_677           : aliased constant String := "GLSL,Forth,Filterscript,F#";
   K_678           : aliased constant String := "ascx";
   M_678           : aliased constant String := "ASP.NET";
   K_679           : aliased constant String := "maxproj";
   M_679           : aliased constant String := "Max";
   K_680           : aliased constant String := "fx";
   M_680           : aliased constant String := "HLSL,FLUX";
   K_681           : aliased constant String := "gnu";
   M_681           : aliased constant String := "Gnuplot";
   K_682           : aliased constant String := "fy";
   M_682           : aliased constant String := "Fancy";
   K_683           : aliased constant String := "feature";
   M_683           : aliased constant String := "Gherkin";
   K_684           : aliased constant String := "ltx";
   M_684           : aliased constant String := "TeX";
   K_685           : aliased constant String := "3qt";
   M_685           : aliased constant String := "Roff Manpage,Roff";
   K_686           : aliased constant String := "bibtex";
   M_686           : aliased constant String := "BibTeX";
   K_687           : aliased constant String := "vxml";
   M_687           : aliased constant String := "XML";
   K_688           : aliased constant String := "dsc";
   M_688           : aliased constant String := "DenizenScript,Debian Package Control File";
   K_689           : aliased constant String := "rnh";
   M_689           : aliased constant String := "RUNOFF";
   K_690           : aliased constant String := "eex";
   M_690           : aliased constant String := "HTML+EEX";
   K_691           : aliased constant String := "j2";
   M_691           : aliased constant String := "Jinja";
   K_692           : aliased constant String := "js.erb";
   M_692           : aliased constant String := "JavaScript+ERB";
   K_693           : aliased constant String := "nlogo";
   M_693           : aliased constant String := "NetLogo";
   K_694           : aliased constant String := "zcml";
   M_694           : aliased constant String := "XML";
   K_695           : aliased constant String := "ronn";
   M_695           : aliased constant String := "Markdown";
   K_696           : aliased constant String := "lisp";
   M_696           : aliased constant String := "NewLisp,Common Lisp";
   K_697           : aliased constant String := "hb";
   M_697           : aliased constant String := "Harbour";
   K_698           : aliased constant String := "dsl";
   M_698           : aliased constant String := "ASL";
   K_699           : aliased constant String := "hc";
   M_699           : aliased constant String := "HolyC";
   K_700           : aliased constant String := "rno";
   M_700           : aliased constant String := "Roff,RUNOFF";
   K_701           : aliased constant String := "hbs";
   M_701           : aliased constant String := "Handlebars";
   K_702           : aliased constant String := "monkey";
   M_702           : aliased constant String := "Monkey";
   K_703           : aliased constant String := "gpb";
   M_703           : aliased constant String := "Gerber Image";
   K_704           : aliased constant String := "xojo_code";
   M_704           : aliased constant String := "Xojo";
   K_705           : aliased constant String := "dsp";
   M_705           : aliased constant String := "Microsoft Developer Studio Project,Faust";
   K_706           : aliased constant String := "hh";
   M_706           : aliased constant String := "C++,Hack";
   K_707           : aliased constant String := "pluginspec";
   M_707           : aliased constant String := "XML,Ruby";
   K_708           : aliased constant String := "rnw";
   M_708           : aliased constant String := "Sweave";
   K_709           : aliased constant String := "pep";
   M_709           : aliased constant String := "Pep8";
   K_710           : aliased constant String := "per";
   M_710           : aliased constant String := "Genero per";
   K_711           : aliased constant String := "targets";
   M_711           : aliased constant String := "XML";
   K_712           : aliased constant String := "hs";
   M_712           : aliased constant String := "Haskell";
   K_713           : aliased constant String := "escript";
   M_713           : aliased constant String := "Erlang";
   K_714           : aliased constant String := "mysql";
   M_714           : aliased constant String := "SQL";
   K_715           : aliased constant String := "gpr";
   M_715           : aliased constant String := "GNAT Project";
   K_716           : aliased constant String := "clixml";
   M_716           : aliased constant String := "XML";
   K_717           : aliased constant String := "lean";
   M_717           : aliased constant String := "Lean 4,Lean";
   K_718           : aliased constant String := "gpt";
   M_718           : aliased constant String := "Gerber Image";
   K_719           : aliased constant String := "hx";
   M_719           : aliased constant String := "Haxe";
   K_720           : aliased constant String := "axd";
   M_720           : aliased constant String := "ASP.NET";
   K_721           : aliased constant String := "hy";
   M_721           : aliased constant String := "Hy";
   K_722           : aliased constant String := "sbl";
   M_722           : aliased constant String := "Snowball";
   K_723           : aliased constant String := "lark";
   M_723           : aliased constant String := "Lark";
   K_724           : aliased constant String := "ml4";
   M_724           : aliased constant String := "OCaml";
   K_725           : aliased constant String := "axi";
   M_725           : aliased constant String := "NetLinx";
   K_726           : aliased constant String := "osm";
   M_726           : aliased constant String := "XML";
   K_727           : aliased constant String := "praat";
   M_727           : aliased constant String := "Praat";
   K_728           : aliased constant String := "sbt";
   M_728           : aliased constant String := "Scala";
   K_729           : aliased constant String := "xht";
   M_729           : aliased constant String := "HTML";
   K_730           : aliased constant String := "typ";
   M_730           : aliased constant String := "XML,Typst";
   K_731           : aliased constant String := "6pl";
   M_731           : aliased constant String := "Raku";
   K_732           : aliased constant String := "ejs.t";
   M_732           : aliased constant String := "EJS";
   K_733           : aliased constant String := "6pm";
   M_733           : aliased constant String := "Raku";
   K_734           : aliased constant String := "kicad_sch";
   M_734           : aliased constant String := "KiCad Schematic";
   K_735           : aliased constant String := "axs";
   M_735           : aliased constant String := "NetLinx";
   K_736           : aliased constant String := "cake";
   M_736           : aliased constant String := "CoffeeScript,C#";
   K_737           : aliased constant String := "reds";
   M_737           : aliased constant String := "Red";
   K_738           : aliased constant String := "shen";
   M_738           : aliased constant String := "Shen";
   K_739           : aliased constant String := "4gl";
   M_739           : aliased constant String := "Genero 4gl";
   K_740           : aliased constant String := "mjs";
   M_740           : aliased constant String := "JavaScript";
   K_741           : aliased constant String := "axml";
   M_741           : aliased constant String := "XML";
   K_742           : aliased constant String := "mathematica";
   M_742           : aliased constant String := "Mathematica";
   K_743           : aliased constant String := "kak";
   M_743           : aliased constant String := "KakouneScript";
   K_744           : aliased constant String := "zsh";
   M_744           : aliased constant String := "Shell";
   K_745           : aliased constant String := "jl";
   M_745           : aliased constant String := "Julia";
   K_746           : aliased constant String := "rpy";
   M_746           : aliased constant String := "Python,Ren'Py";
   K_747           : aliased constant String := "mjml";
   M_747           : aliased constant String := "XML";
   K_748           : aliased constant String := "sdc";
   M_748           : aliased constant String := "Tcl";
   K_749           : aliased constant String := "jq";
   M_749           : aliased constant String := "jq,JSONiq";
   K_750           : aliased constant String := "js";
   M_750           : aliased constant String := "JavaScript";
   K_751           : aliased constant String := "avdl";
   M_751           : aliased constant String := "Avro IDL";
   K_752           : aliased constant String := "grt";
   M_752           : aliased constant String := "Groovy";
   K_753           : aliased constant String := "geom";
   M_753           : aliased constant String := "GLSL";
   K_754           : aliased constant String := "cscfg";
   M_754           : aliased constant String := "XML";
   K_755           : aliased constant String := "bbclass";
   M_755           : aliased constant String := "BitBake";
   K_756           : aliased constant String := "scad";
   M_756           : aliased constant String := "OpenSCAD";
   K_757           : aliased constant String := "4DProject";
   M_757           : aliased constant String := "JSON";
   K_758           : aliased constant String := "mli";
   M_758           : aliased constant String := "OCaml";
   K_759           : aliased constant String := "wxi";
   M_759           : aliased constant String := "XML";
   K_760           : aliased constant String := "mll";
   M_760           : aliased constant String := "OCaml";
   K_761           : aliased constant String := "jsonld";
   M_761           : aliased constant String := "JSONLD";
   K_762           : aliased constant String := "wxl";
   M_762           : aliased constant String := "XML";
   K_763           : aliased constant String := "dwl";
   M_763           : aliased constant String := "DataWeave";
   K_764           : aliased constant String := "pic";
   M_764           : aliased constant String := "Pic";
   K_765           : aliased constant String := "ld";
   M_765           : aliased constant String := "Linker Script";
   K_766           : aliased constant String := "xml.dist";
   M_766           : aliased constant String := "XML";
   K_767           : aliased constant String := "pig";
   M_767           : aliased constant String := "PigLatin";
   K_768           : aliased constant String := "wxs";
   M_768           : aliased constant String := "XML";
   K_769           : aliased constant String := "ll";
   M_769           : aliased constant String := "LLVM";
   K_770           : aliased constant String := "mly";
   M_770           : aliased constant String := "OCaml";
   K_771           : aliased constant String := "sqlrpgle";
   M_771           : aliased constant String := "RPGLE";
   K_772           : aliased constant String := "gtl";
   M_772           : aliased constant String := "Gerber Image";
   K_773           : aliased constant String := "sfd";
   M_773           : aliased constant String := "Spline Font Database";
   K_774           : aliased constant String := "pir";
   M_774           : aliased constant String := "Parrot Internal Representation";
   K_775           : aliased constant String := "ls";
   M_775           : aliased constant String := "LoomScript,LiveScript";
   K_776           : aliased constant String := "gto";
   M_776           : aliased constant String := "Gerber Image";
   K_777           : aliased constant String := "gtp";
   M_777           : aliased constant String := "Gerber Image";
   K_778           : aliased constant String := "xlf";
   M_778           : aliased constant String := "XML";
   K_779           : aliased constant String := "cppobjdump";
   M_779           : aliased constant String := "Cpp-ObjDump";
   K_780           : aliased constant String := "imba";
   M_780           : aliased constant String := "Imba";
   K_781           : aliased constant String := "gts";
   M_781           : aliased constant String := "Glimmer TS,Gerber Image";
   K_782           : aliased constant String := "plsql";
   M_782           : aliased constant String := "PLSQL";
   K_783           : aliased constant String := "ahkl";
   M_783           : aliased constant String := "AutoHotkey";
   K_784           : aliased constant String := "ly";
   M_784           : aliased constant String := "LilyPond";
   K_785           : aliased constant String := "forth";
   M_785           : aliased constant String := "Forth";
   K_786           : aliased constant String := "self";
   M_786           : aliased constant String := "Self";
   K_787           : aliased constant String := "sarif";
   M_787           : aliased constant String := "JSON";
   K_788           : aliased constant String := "sublime-mousemap";
   M_788           : aliased constant String := "JSON with Comments";
   K_789           : aliased constant String := "natvis";
   M_789           : aliased constant String := "XML";
   K_790           : aliased constant String := "owl";
   M_790           : aliased constant String := "Web Ontology Language";
   K_791           : aliased constant String := "snap";
   M_791           : aliased constant String := "Jest Snapshot";
   K_792           : aliased constant String := "pyde";
   M_792           : aliased constant String := "Python";
   K_793           : aliased constant String := "tfvars";
   M_793           : aliased constant String := "HCL";
   K_794           : aliased constant String := "mdwn";
   M_794           : aliased constant String := "Markdown";
   K_795           : aliased constant String := "sfv";
   M_795           : aliased constant String := "Simple File Verification";
   K_796           : aliased constant String := "emacs.desktop";
   M_796           : aliased constant String := "Emacs Lisp";
   K_797           : aliased constant String := "rtf";
   M_797           : aliased constant String := "Rich Text Format";
   K_798           : aliased constant String := "hhi";
   M_798           : aliased constant String := "Hack";
   K_799           : aliased constant String := "vcl";
   M_799           : aliased constant String := "VCL";
   K_800           : aliased constant String := "zsh-theme";
   M_800           : aliased constant String := "Shell";
   K_801           : aliased constant String := "cbl";
   M_801           : aliased constant String := "COBOL";
   K_802           : aliased constant String := "p4";
   M_802           : aliased constant String := "P4";
   K_803           : aliased constant String := "vert";
   M_803           : aliased constant String := "GLSL";
   K_804           : aliased constant String := "hack";
   M_804           : aliased constant String := "Hack";
   K_805           : aliased constant String := "p6";
   M_805           : aliased constant String := "Raku";
   K_806           : aliased constant String := "pm6";
   M_806           : aliased constant String := "Raku";
   K_807           : aliased constant String := "nb";
   M_807           : aliased constant String := "Text,Mathematica";
   K_808           : aliased constant String := "pkb";
   M_808           : aliased constant String := "PLSQL";
   K_809           : aliased constant String := "nc";
   M_809           : aliased constant String := "nesC";
   K_810           : aliased constant String := "dyl";
   M_810           : aliased constant String := "Dylan";
   K_811           : aliased constant String := "p8";
   M_811           : aliased constant String := "Lua";
   K_812           : aliased constant String := "irclog";
   M_812           : aliased constant String := "IRC log";
   K_813           : aliased constant String := "ne";
   M_813           : aliased constant String := "Nearley";
   K_814           : aliased constant String := "nf";
   M_814           : aliased constant String := "Nextflow";
   K_815           : aliased constant String := "wren";
   M_815           : aliased constant String := "Wren";
   K_816           : aliased constant String := "xsp-config";
   M_816           : aliased constant String := "XPages";
   K_817           : aliased constant String := "kicad_mod";
   M_817           : aliased constant String := "KiCad Layout";
   K_818           : aliased constant String := "ni";
   M_818           : aliased constant String := "Inform 7";
   K_819           : aliased constant String := "cbx";
   M_819           : aliased constant String := "TeX";
   K_820           : aliased constant String := "i7x";
   M_820           : aliased constant String := "Inform 7";
   K_821           : aliased constant String := "xacro";
   M_821           : aliased constant String := "XML";
   K_822           : aliased constant String := "nl";
   M_822           : aliased constant String := "NewLisp,NL";
   K_823           : aliased constant String := "pkl";
   M_823           : aliased constant String := "Pickle";
   K_824           : aliased constant String := "vbproj";
   M_824           : aliased constant String := "XML";
   K_825           : aliased constant String := "scrbl";
   M_825           : aliased constant String := "Racket";
   K_826           : aliased constant String := "code-snippets";
   M_826           : aliased constant String := "JSON with Comments";
   K_827           : aliased constant String := "bpl";
   M_827           : aliased constant String := "Boogie";
   K_828           : aliased constant String := "no";
   M_828           : aliased constant String := "Text";
   K_829           : aliased constant String := "php3";
   M_829           : aliased constant String := "PHP";
   K_830           : aliased constant String := "php4";
   M_830           : aliased constant String := "PHP";
   K_831           : aliased constant String := "nr";
   M_831           : aliased constant String := "Roff";
   K_832           : aliased constant String := "php5";
   M_832           : aliased constant String := "PHP";
   K_833           : aliased constant String := "jsb";
   M_833           : aliased constant String := "JavaScript";
   K_834           : aliased constant String := "pks";
   M_834           : aliased constant String := "PLSQL";
   K_835           : aliased constant String := "tfstate.backup";
   M_835           : aliased constant String := "JSON";
   K_836           : aliased constant String := "nu";
   M_836           : aliased constant String := "Nushell,Nu";
   K_837           : aliased constant String := "fshader";
   M_837           : aliased constant String := "GLSL";
   K_838           : aliased constant String := "druby";
   M_838           : aliased constant String := "Mirah";
   K_839           : aliased constant String := "jsh";
   M_839           : aliased constant String := "Java";
   K_840           : aliased constant String := "ny";
   M_840           : aliased constant String := "Common Lisp";
   K_841           : aliased constant String := "eml";
   M_841           : aliased constant String := "E-mail";
   K_842           : aliased constant String := "nbp";
   M_842           : aliased constant String := "Mathematica";
   K_843           : aliased constant String := "gvy";
   M_843           : aliased constant String := "Groovy";
   K_844           : aliased constant String := "jsm";
   M_844           : aliased constant String := "JavaScript";
   K_845           : aliased constant String := "cdc";
   M_845           : aliased constant String := "Cadence";
   K_846           : aliased constant String := "rbuistate";
   M_846           : aliased constant String := "REALbasic";
   K_847           : aliased constant String := "jsp";
   M_847           : aliased constant String := "Java Server Pages";
   K_848           : aliased constant String := "cdf";
   M_848           : aliased constant String := "Mathematica";
   K_849           : aliased constant String := "jss";
   M_849           : aliased constant String := "JavaScript";
   K_850           : aliased constant String := "command";
   M_850           : aliased constant String := "Shell";
   K_851           : aliased constant String := "scala";
   M_851           : aliased constant String := "Scala";
   K_852           : aliased constant String := "jst";
   M_852           : aliased constant String := "EJS";
   K_853           : aliased constant String := "gleam";
   M_853           : aliased constant String := "Gleam";
   K_854           : aliased constant String := "r2";
   M_854           : aliased constant String := "Rebol";
   K_855           : aliased constant String := "fsproj";
   M_855           : aliased constant String := "XML";
   K_856           : aliased constant String := "jsx";
   M_856           : aliased constant String := "JavaScript";
   K_857           : aliased constant String := "r3";
   M_857           : aliased constant String := "Rebol";
   K_858           : aliased constant String := "veo";
   M_858           : aliased constant String := "Verilog";
   K_859           : aliased constant String := "mpl";
   M_859           : aliased constant String := "JetBrains MPS";
   K_860           : aliased constant String := "bicep";
   M_860           : aliased constant String := "Bicep";
   K_861           : aliased constant String := "pb";
   M_861           : aliased constant String := "PureBasic";
   K_862           : aliased constant String := "cxx-objdump";
   M_862           : aliased constant String := "Cpp-ObjDump";
   K_863           : aliased constant String := "cds";
   M_863           : aliased constant String := "CAP CDS";
   K_864           : aliased constant String := "pd";
   M_864           : aliased constant String := "Pure Data";
   K_865           : aliased constant String := "flux";
   M_865           : aliased constant String := "FLUX";
   K_866           : aliased constant String := "2da";
   M_866           : aliased constant String := "2-Dimensional Array";
   K_867           : aliased constant String := "mps";
   M_867           : aliased constant String := "JetBrains MPS";
   K_868           : aliased constant String := "brd";
   M_868           : aliased constant String := "KiCad Legacy Layout,Eagle";
   K_869           : aliased constant String := "ph";
   M_869           : aliased constant String := "Perl";
   K_870           : aliased constant String := "pascal";
   M_870           : aliased constant String := "Pascal";
   K_871           : aliased constant String := "omgrofl";
   M_871           : aliased constant String := "Omgrofl";
   K_872           : aliased constant String := "fan";
   M_872           : aliased constant String := "Fantom";
   K_873           : aliased constant String := "pl";
   M_873           : aliased constant String := "Perl,Raku,Prolog";
   K_874           : aliased constant String := "pml";
   M_874           : aliased constant String := "Promela";
   K_875           : aliased constant String := "polar";
   M_875           : aliased constant String := "Polar";
   K_876           : aliased constant String := "pm";
   M_876           : aliased constant String := "Perl,X PixMap,Raku";
   K_877           : aliased constant String := "po";
   M_877           : aliased constant String := "Gettext Catalog";
   K_878           : aliased constant String := "pp";
   M_878           : aliased constant String := "Puppet,Pascal";
   K_879           : aliased constant String := "latte";
   M_879           : aliased constant String := "Latte";
   K_880           : aliased constant String := "bro";
   M_880           : aliased constant String := "Zeek";
   K_881           : aliased constant String := "ps";
   M_881           : aliased constant String := "PostScript";
   K_882           : aliased constant String := "asmx";
   M_882           : aliased constant String := "ASP.NET";
   K_883           : aliased constant String := "pt";
   M_883           : aliased constant String := "XML";
   K_884           : aliased constant String := "brs";
   M_884           : aliased constant String := "Brightscript";
   K_885           : aliased constant String := "py";
   M_885           : aliased constant String := "Python";
   K_886           : aliased constant String := "xpl";
   M_886           : aliased constant String := "XProc";
   K_887           : aliased constant String := "xpm";
   M_887           : aliased constant String := "X PixMap";
   K_888           : aliased constant String := "cfc";
   M_888           : aliased constant String := "ColdFusion CFC";
   K_889           : aliased constant String := "sjs";
   M_889           : aliased constant String := "JavaScript";
   K_890           : aliased constant String := "mrc";
   M_890           : aliased constant String := "mIRC Script";
   K_891           : aliased constant String := "cfg";
   M_891           : aliased constant String := "INI,HAProxy";
   K_892           : aliased constant String := "muse";
   M_892           : aliased constant String := "Muse";
   K_893           : aliased constant String := "edge";
   M_893           : aliased constant String := "Edge";
   K_894           : aliased constant String := "phps";
   M_894           : aliased constant String := "PHP";
   K_895           : aliased constant String := "phpt";
   M_895           : aliased constant String := "PHP";
   K_896           : aliased constant String := "regex";
   M_896           : aliased constant String := "Regular Expression";
   K_897           : aliased constant String := "Dsr";
   M_897           : aliased constant String := "Visual Basic 6.0";
   K_898           : aliased constant String := "xpy";
   M_898           : aliased constant String := "Python";
   K_899           : aliased constant String := "cfm";
   M_899           : aliased constant String := "ColdFusion";
   K_900           : aliased constant String := "twig";
   M_900           : aliased constant String := "Twig";
   K_901           : aliased constant String := "rb";
   M_901           : aliased constant String := "Ruby";
   K_902           : aliased constant String := "kid";
   M_902           : aliased constant String := "Genshi";
   K_903           : aliased constant String := "capnp";
   M_903           : aliased constant String := "Cap'n Proto";
   K_904           : aliased constant String := "blade";
   M_904           : aliased constant String := "Blade";
   K_905           : aliased constant String := "pod";
   M_905           : aliased constant String := "Pod 6,Pod";
   K_906           : aliased constant String := "rd";
   M_906           : aliased constant String := "R";
   K_907           : aliased constant String := "re";
   M_907           : aliased constant String := "C++,Reason";
   K_908           : aliased constant String := "rg";
   M_908           : aliased constant String := "Rouge";
   K_909           : aliased constant String := "anim";
   M_909           : aliased constant String := "Unity3D Asset";
   K_910           : aliased constant String := "JSON-tmLanguage";
   M_910           : aliased constant String := "JSON";
   K_911           : aliased constant String := "rl";
   M_911           : aliased constant String := "Ragel";
   K_912           : aliased constant String := "sparql";
   M_912           : aliased constant String := "SPARQL";
   K_913           : aliased constant String := "es6";
   M_913           : aliased constant String := "JavaScript";
   K_914           : aliased constant String := "rq";
   M_914           : aliased constant String := "SPARQL";
   K_915           : aliased constant String := "sld";
   M_915           : aliased constant String := "Scheme";
   K_916           : aliased constant String := "por";
   M_916           : aliased constant String := "Portugol";
   K_917           : aliased constant String := "kit";
   M_917           : aliased constant String := "Kit";
   K_918           : aliased constant String := "rs";
   M_918           : aliased constant String := "XML,Rust,RenderScript";
   K_919           : aliased constant String := "pot";
   M_919           : aliased constant String := "Gettext Catalog";
   K_920           : aliased constant String := "sublime-settings";
   M_920           : aliased constant String := "JSON with Comments";
   K_921           : aliased constant String := "ru";
   M_921           : aliased constant String := "Ruby";
   K_922           : aliased constant String := "pov";
   M_922           : aliased constant String := "POV-Ray SDL";
   K_923           : aliased constant String := "swift";
   M_923           : aliased constant String := "Swift";
   K_924           : aliased constant String := "xrl";
   M_924           : aliased constant String := "Erlang";
   K_925           : aliased constant String := "sln";
   M_925           : aliased constant String := "Microsoft Visual Studio Solution";
   K_926           : aliased constant String := "blade.php";
   M_926           : aliased constant String := "Blade";
   K_927           : aliased constant String := "sls";
   M_927           : aliased constant String := "Scheme,SaltStack";
   K_928           : aliased constant String := "rbuild";
   M_928           : aliased constant String := "Ruby";
   K_929           : aliased constant String := "xsjslib";
   M_929           : aliased constant String := "JavaScript";
   K_930           : aliased constant String := "talon";
   M_930           : aliased constant String := "Talon";
   K_931           : aliased constant String := "mligo";
   M_931           : aliased constant String := "CameLIGO";
   K_932           : aliased constant String := "mkii";
   M_932           : aliased constant String := "TeX";
   K_933           : aliased constant String := "SchDoc";
   M_933           : aliased constant String := "Altium Designer";
   K_934           : aliased constant String := "ps1";
   M_934           : aliased constant String := "PowerShell";
   K_935           : aliased constant String := "vim";
   M_935           : aliased constant String := "Vim Script";
   K_936           : aliased constant String := "nims";
   M_936           : aliased constant String := "Nim";
   K_937           : aliased constant String := "fea";
   M_937           : aliased constant String := "OpenType Feature File";
   K_938           : aliased constant String := "json";
   M_938           : aliased constant String := "JSON,OASv3-json,OASv2-json";
   K_939           : aliased constant String := "mtl";
   M_939           : aliased constant String := "Wavefront Material";
   K_940           : aliased constant String := "unity";
   M_940           : aliased constant String := "Unity3D Asset";
   K_941           : aliased constant String := "wast";
   M_941           : aliased constant String := "WebAssembly";
   K_942           : aliased constant String := "chs";
   M_942           : aliased constant String := "C2hs Haskell";
   K_943           : aliased constant String := "kojo";
   M_943           : aliased constant String := "Scala";
   K_944           : aliased constant String := "te";
   M_944           : aliased constant String := "SELinux Policy";
   K_945           : aliased constant String := "mts";
   M_945           : aliased constant String := "TypeScript";
   K_946           : aliased constant String := "pact";
   M_946           : aliased constant String := "Pact";
   K_947           : aliased constant String := "tf";
   M_947           : aliased constant String := "HCL";
   K_948           : aliased constant String := "viw";
   M_948           : aliased constant String := "SQL";
   K_949           : aliased constant String := "mkiv";
   M_949           : aliased constant String := "TeX";
   K_950           : aliased constant String := "tres";
   M_950           : aliased constant String := "Godot Resource";
   K_951           : aliased constant String := "yaml-tmlanguage";
   M_951           : aliased constant String := "YAML";
   K_952           : aliased constant String := "tl";
   M_952           : aliased constant String := "Type Language";
   K_953           : aliased constant String := "rhtml";
   M_953           : aliased constant String := "HTML+ERB";
   K_954           : aliased constant String := "stan";
   M_954           : aliased constant String := "Stan";
   K_955           : aliased constant String := "tm";
   M_955           : aliased constant String := "Tcl";
   K_956           : aliased constant String := "numsc";
   M_956           : aliased constant String := "NumPy";
   K_957           : aliased constant String := "star";
   M_957           : aliased constant String := "Starlark,STAR";
   K_958           : aliased constant String := "xojo_report";
   M_958           : aliased constant String := "Xojo";
   K_959           : aliased constant String := "ts";
   M_959           : aliased constant String := "XML,TypeScript";
   K_960           : aliased constant String := "gemspec";
   M_960           : aliased constant String := "Ruby";
   K_961           : aliased constant String := "tu";
   M_961           : aliased constant String := "Turing";
   K_962           : aliased constant String := "yacc";
   M_962           : aliased constant String := "Yacc";
   K_963           : aliased constant String := "cl2";
   M_963           : aliased constant String := "Clojure";
   K_964           : aliased constant String := "minid";
   M_964           : aliased constant String := "MiniD";
   K_965           : aliased constant String := "bison";
   M_965           : aliased constant String := "Bison";
   K_966           : aliased constant String := "snip";
   M_966           : aliased constant String := "Vim Snippet";
   K_967           : aliased constant String := "dockerfile";
   M_967           : aliased constant String := "Dockerfile";
   K_968           : aliased constant String := "tmac";
   M_968           : aliased constant String := "Roff";
   K_969           : aliased constant String := "sha384";
   M_969           : aliased constant String := "Checksums";
   K_970           : aliased constant String := "xspec";
   M_970           : aliased constant String := "XML";
   K_971           : aliased constant String := "trigger";
   M_971           : aliased constant String := "Shell,Apex";
   K_972           : aliased constant String := "hpp";
   M_972           : aliased constant String := "C++";
   K_973           : aliased constant String := "vb";
   M_973           : aliased constant String := "Visual Basic .NET";
   K_974           : aliased constant String := "fxml";
   M_974           : aliased constant String := "XML";
   K_975           : aliased constant String := "psc";
   M_975           : aliased constant String := "Papyrus";
   K_976           : aliased constant String := "cjs";
   M_976           : aliased constant String := "JavaScript";
   K_977           : aliased constant String := "iuml";
   M_977           : aliased constant String := "PlantUML";
   K_978           : aliased constant String := "vh";
   M_978           : aliased constant String := "SystemVerilog";
   K_979           : aliased constant String := "bash";
   M_979           : aliased constant String := "Shell";
   K_980           : aliased constant String := "kml";
   M_980           : aliased constant String := "XML";
   K_981           : aliased constant String := "wlua";
   M_981           : aliased constant String := "Lua";
   K_982           : aliased constant String := "eliom";
   M_982           : aliased constant String := "OCaml";
   K_983           : aliased constant String := "idc";
   M_983           : aliased constant String := "C";
   K_984           : aliased constant String := "spc";
   M_984           : aliased constant String := "PLSQL";
   K_985           : aliased constant String := "jade";
   M_985           : aliased constant String := "Pug";
   K_986           : aliased constant String := "jslib";
   M_986           : aliased constant String := "JavaScript";
   K_987           : aliased constant String := "vs";
   M_987           : aliased constant String := "GLSL";
   K_988           : aliased constant String := "hlean";
   M_988           : aliased constant String := "Lean";
   K_989           : aliased constant String := "njk";
   M_989           : aliased constant String := "Nunjucks";
   K_990           : aliased constant String := "vw";
   M_990           : aliased constant String := "PLSQL";
   K_991           : aliased constant String := "vy";
   M_991           : aliased constant String := "Vyper";
   K_992           : aliased constant String := "pod6";
   M_992           : aliased constant String := "Pod 6";
   K_993           : aliased constant String := "vmb";
   M_993           : aliased constant String := "Vim Script";
   K_994           : aliased constant String := "idr";
   M_994           : aliased constant String := "Idris";
   K_995           : aliased constant String := "njs";
   M_995           : aliased constant String := "JavaScript";
   K_996           : aliased constant String := "sps";
   M_996           : aliased constant String := "Scheme";
   K_997           : aliased constant String := "clj";
   M_997           : aliased constant String := "Clojure";
   K_998           : aliased constant String := "html.hl";
   M_998           : aliased constant String := "HTML";
   K_999           : aliased constant String := "hrl";
   M_999           : aliased constant String := "Erlang";
   K_1000          : aliased constant String := "las";
   M_1000          : aliased constant String := "Lasso";
   K_1001          : aliased constant String := "nim.cfg";
   M_1001          : aliased constant String := "Nim";
   K_1002          : aliased constant String := "clp";
   M_1002          : aliased constant String := "CLIPS";
   K_1003          : aliased constant String := "haml";
   M_1003          : aliased constant String := "Haml";
   K_1004          : aliased constant String := "pub";
   M_1004          : aliased constant String := "Public Key";
   K_1005          : aliased constant String := "xc";
   M_1005          : aliased constant String := "XC";
   K_1006          : aliased constant String := "cls";
   M_1006          : aliased constant String := "VBA,Visual Basic 6.0,TeX,OpenEdge ABL,Obj"
       & "ectScript,Apex";
   K_1007          : aliased constant String := "gypi";
   M_1007          : aliased constant String := "Python";
   K_1008          : aliased constant String := "mxt";
   M_1008          : aliased constant String := "Max";
   K_1009          : aliased constant String := "db2";
   M_1009          : aliased constant String := "SQLPL";
   K_1010          : aliased constant String := "pug";
   M_1010          : aliased constant String := "Pug";
   K_1011          : aliased constant String := "clw";
   M_1011          : aliased constant String := "Clarion";
   K_1012          : aliased constant String := "xi";
   M_1012          : aliased constant String := "Logos";
   K_1013          : aliased constant String := "grxml";
   M_1013          : aliased constant String := "XML";
   K_1014          : aliased constant String := "pddl";
   M_1014          : aliased constant String := "PDDL";
   K_1015          : aliased constant String := "xm";
   M_1015          : aliased constant String := "Logos";
   K_1016          : aliased constant String := "sra";
   M_1016          : aliased constant String := "PowerBuilder";
   K_1017          : aliased constant String := "diff";
   M_1017          : aliased constant String := "Diff";
   K_1018          : aliased constant String := "bzl";
   M_1018          : aliased constant String := "Starlark";
   K_1019          : aliased constant String := "rbres";
   M_1019          : aliased constant String := "REALbasic";
   K_1020          : aliased constant String := "chem";
   M_1020          : aliased constant String := "Pic";
   K_1021          : aliased constant String := "xq";
   M_1021          : aliased constant String := "XQuery";
   K_1022          : aliased constant String := "groovy";
   M_1022          : aliased constant String := "Groovy";
   K_1023          : aliased constant String := "dhall";
   M_1023          : aliased constant String := "Dhall";
   K_1024          : aliased constant String := "xs";
   M_1024          : aliased constant String := "XS";
   K_1025          : aliased constant String := "nimble";
   M_1025          : aliased constant String := "Nim";
   K_1026          : aliased constant String := "lslp";
   M_1026          : aliased constant String := "LSL";
   K_1027          : aliased constant String := "marko";
   M_1027          : aliased constant String := "Marko";
   K_1028          : aliased constant String := "wat";
   M_1028          : aliased constant String := "WebAssembly";
   K_1029          : aliased constant String := "hta";
   M_1029          : aliased constant String := "HTML";
   K_1030          : aliased constant String := "rbbas";
   M_1030          : aliased constant String := "REALbasic";
   K_1031          : aliased constant String := "cnc";
   M_1031          : aliased constant String := "G-code";
   K_1032          : aliased constant String := "srt";
   M_1032          : aliased constant String := "SubRip Text,SRecode Template";
   K_1033          : aliased constant String := "cnf";
   M_1033          : aliased constant String := "INI";
   K_1034          : aliased constant String := "ob2";
   M_1034          : aliased constant String := "Oberon";
   K_1035          : aliased constant String := "sru";
   M_1035          : aliased constant String := "PowerBuilder";
   K_1036          : aliased constant String := "sexp";
   M_1036          : aliased constant String := "Common Lisp";
   K_1037          : aliased constant String := "srw";
   M_1037          : aliased constant String := "PowerBuilder";
   K_1038          : aliased constant String := "maxpat";
   M_1038          : aliased constant String := "Max";
   K_1039          : aliased constant String := "py3";
   M_1039          : aliased constant String := "Python";
   K_1040          : aliased constant String := "htm";
   M_1040          : aliased constant String := "HTML";
   K_1041          : aliased constant String := "editorconfig";
   M_1041          : aliased constant String := "EditorConfig";
   K_1042          : aliased constant String := "angelscript";
   M_1042          : aliased constant String := "AngelScript";
   K_1043          : aliased constant String := "vala";
   M_1043          : aliased constant String := "Vala";
   K_1044          : aliased constant String := "zeek";
   M_1044          : aliased constant String := "Zeek";
   K_1045          : aliased constant String := "jison";
   M_1045          : aliased constant String := "Jison";
   K_1046          : aliased constant String := "kql";
   M_1046          : aliased constant String := "Kusto";
   K_1047          : aliased constant String := "fcgi";
   M_1047          : aliased constant String := "Python,Perl,Lua,Shell,Ruby,PHP";
   K_1048          : aliased constant String := "pwn";
   M_1048          : aliased constant String := "Pawn";
   K_1049          : aliased constant String := "factor";
   M_1049          : aliased constant String := "Factor";
   K_1050          : aliased constant String := "zs";
   M_1050          : aliased constant String := "ZenScript";
   K_1051          : aliased constant String := "rabl";
   M_1051          : aliased constant String := "Ruby";
   K_1052          : aliased constant String := "eye";
   M_1052          : aliased constant String := "Ruby";
   K_1053          : aliased constant String := "wgsl";
   M_1053          : aliased constant String := "WGSL";
   K_1054          : aliased constant String := "cljscm";
   M_1054          : aliased constant String := "Clojure";
   K_1055          : aliased constant String := "stl";
   M_1055          : aliased constant String := "STL";
   K_1056          : aliased constant String := "vssettings";
   M_1056          : aliased constant String := "XML";
   K_1057          : aliased constant String := "less";
   M_1057          : aliased constant String := "Less";
   K_1058          : aliased constant String := "plist";
   M_1058          : aliased constant String := "XML Property List,OpenStep Property List";
   K_1059          : aliased constant String := "PcbDoc";
   M_1059          : aliased constant String := "Altium Designer";
   K_1060          : aliased constant String := "litcoffee";
   M_1060          : aliased constant String := "Literate CoffeeScript";
   K_1061          : aliased constant String := "vcxproj";
   M_1061          : aliased constant String := "XML";
   K_1062          : aliased constant String := "sty";
   M_1062          : aliased constant String := "TeX";
   K_1063          : aliased constant String := "sha256sum";
   M_1063          : aliased constant String := "Checksums";
   K_1064          : aliased constant String := "circom";
   M_1064          : aliased constant String := "Circom";
   K_1065          : aliased constant String := "agc";
   M_1065          : aliased constant String := "Apollo Guidance Computer";
   K_1066          : aliased constant String := "cpp";
   M_1066          : aliased constant String := "C++";
   K_1067          : aliased constant String := "sagews";
   M_1067          : aliased constant String := "Sage";
   K_1068          : aliased constant String := "cps";
   M_1068          : aliased constant String := "Component Pascal";
   K_1069          : aliased constant String := "obj";
   M_1069          : aliased constant String := "Wavefront Object";
   K_1070          : aliased constant String := "lex";
   M_1070          : aliased constant String := "Lex";
   K_1071          : aliased constant String := "OutJob";
   M_1071          : aliased constant String := "Altium Designer";
   K_1072          : aliased constant String := "lkml";
   M_1072          : aliased constant String := "LookML";
   K_1073          : aliased constant String := "ksh";
   M_1073          : aliased constant String := "Shell";
   K_1074          : aliased constant String := "agda";
   M_1074          : aliased constant String := "Agda";
   K_1075          : aliased constant String := "gaml";
   M_1075          : aliased constant String := "GAML";
   K_1076          : aliased constant String := "pyi";
   M_1076          : aliased constant String := "Python";
   K_1077          : aliased constant String := "cpy";
   M_1077          : aliased constant String := "COBOL";
   K_1078          : aliased constant String := "stTheme";
   M_1078          : aliased constant String := "XML Property List";
   K_1079          : aliased constant String := "x68";
   M_1079          : aliased constant String := "Motorola 68K Assembly";
   K_1080          : aliased constant String := "jflex";
   M_1080          : aliased constant String := "JFlex";
   K_1081          : aliased constant String := "pyp";
   M_1081          : aliased constant String := "Python";
   K_1082          : aliased constant String := "emberscript";
   M_1082          : aliased constant String := "EmberScript";
   K_1083          : aliased constant String := "pyt";
   M_1083          : aliased constant String := "Python";
   K_1084          : aliased constant String := "svg";
   M_1084          : aliased constant String := "SVG";
   K_1085          : aliased constant String := "thy";
   M_1085          : aliased constant String := "Isabelle";
   K_1086          : aliased constant String := "svh";
   M_1086          : aliased constant String := "SystemVerilog";
   K_1087          : aliased constant String := "ddl";
   M_1087          : aliased constant String := "SQL,PLSQL";
   K_1088          : aliased constant String := "lidr";
   M_1088          : aliased constant String := "Idris";
   K_1089          : aliased constant String := "pyw";
   M_1089          : aliased constant String := "Python";
   K_1090          : aliased constant String := "ijm";
   M_1090          : aliased constant String := "ImageJ Macro";
   K_1091          : aliased constant String := "ksy";
   M_1091          : aliased constant String := "Kaitai Struct";
   K_1092          : aliased constant String := "conll";
   M_1092          : aliased constant String := "CoNLL-U";
   K_1093          : aliased constant String := "pyx";
   M_1093          : aliased constant String := "Cython";
   K_1094          : aliased constant String := "html.leex";
   M_1094          : aliased constant String := "HTML+EEX";
   K_1095          : aliased constant String := "wsgi";
   M_1095          : aliased constant String := "Python";
   K_1096          : aliased constant String := "props";
   M_1096          : aliased constant String := "XML";
   K_1097          : aliased constant String := "storyboard";
   M_1097          : aliased constant String := "XML";
   K_1098          : aliased constant String := "workflow";
   M_1098          : aliased constant String := "XML,HCL";
   K_1099          : aliased constant String := "qmd";
   M_1099          : aliased constant String := "RMarkdown";
   K_1100          : aliased constant String := "tmPreferences";
   M_1100          : aliased constant String := "XML Property List";
   K_1101          : aliased constant String := "json5";
   M_1101          : aliased constant String := "JSON5";
   K_1102          : aliased constant String := "ijs";
   M_1102          : aliased constant String := "J";
   K_1103          : aliased constant String := "pytb";
   M_1103          : aliased constant String := "Python traceback";
   K_1104          : aliased constant String := "antlers.php";
   M_1104          : aliased constant String := "Antlers";
   K_1105          : aliased constant String := "vsh";
   M_1105          : aliased constant String := "GLSL";
   K_1106          : aliased constant String := "ihlp";
   M_1106          : aliased constant String := "Stata";
   K_1107          : aliased constant String := "qml";
   M_1107          : aliased constant String := "QML";
   K_1108          : aliased constant String := "gap";
   M_1108          : aliased constant String := "GAP";
   K_1109          : aliased constant String := "odd";
   M_1109          : aliased constant String := "XML";
   K_1110          : aliased constant String := "tftpl";
   M_1110          : aliased constant String := "Terraform Template";
   K_1111          : aliased constant String := "lgt";
   M_1111          : aliased constant String := "Logtalk";
   K_1112          : aliased constant String := "http";
   M_1112          : aliased constant String := "HTTP";
   K_1113          : aliased constant String := "gtpl";
   M_1113          : aliased constant String := "Groovy";
   K_1114          : aliased constant String := "eliomi";
   M_1114          : aliased constant String := "OCaml";
   K_1115          : aliased constant String := "rexx";
   M_1115          : aliased constant String := "REXX";
   K_1116          : aliased constant String := "scss";
   M_1116          : aliased constant String := "SCSS";
   K_1117          : aliased constant String := "hxx";
   M_1117          : aliased constant String := "C++";
   K_1118          : aliased constant String := "scenic";
   M_1118          : aliased constant String := "Scenic";
   K_1119          : aliased constant String := "vapi";
   M_1119          : aliased constant String := "Vala";
   K_1120          : aliased constant String := "lasso8";
   M_1120          : aliased constant String := "Lasso";
   K_1121          : aliased constant String := "lasso9";
   M_1121          : aliased constant String := "Lasso";
   K_1122          : aliased constant String := "for";
   M_1122          : aliased constant String := "Fortran,Forth,Formatted";
   K_1123          : aliased constant String := "cpp-objdump";
   M_1123          : aliased constant String := "Cpp-ObjDump";
   K_1124          : aliased constant String := "rockspec";
   M_1124          : aliased constant String := "Lua";
   K_1125          : aliased constant String := "cginc";
   M_1125          : aliased constant String := "HLSL";
   K_1126          : aliased constant String := "ps1xml";
   M_1126          : aliased constant String := "XML";
   K_1127          : aliased constant String := "metal";
   M_1127          : aliased constant String := "Metal";
   K_1128          : aliased constant String := "dfm";
   M_1128          : aliased constant String := "Pascal";
   K_1129          : aliased constant String := "pd_lua";
   M_1129          : aliased constant String := "Lua";
   K_1130          : aliased constant String := "prawn";
   M_1130          : aliased constant String := "Ruby";
   K_1131          : aliased constant String := "prefs";
   M_1131          : aliased constant String := "INI";
   K_1132          : aliased constant String := "lid";
   M_1132          : aliased constant String := "Dylan";
   K_1133          : aliased constant String := "hlsl";
   M_1133          : aliased constant String := "HLSL";
   K_1134          : aliased constant String := "glslf";
   M_1134          : aliased constant String := "GLSL";
   K_1135          : aliased constant String := "raw";
   M_1135          : aliased constant String := "Raw token data";
   K_1136          : aliased constant String := "snippets";
   M_1136          : aliased constant String := "Vim Snippet";
   K_1137          : aliased constant String := "tscn";
   M_1137          : aliased constant String := "Godot Resource";
   K_1138          : aliased constant String := "yaml";
   M_1138          : aliased constant String := "YAML,OASv3-yaml,OASv2-yaml,MiniYAML";
   K_1139          : aliased constant String := "sublime-snippet";
   M_1139          : aliased constant String := "XML";
   K_1140          : aliased constant String := "vue";
   M_1140          : aliased constant String := "Vue";
   K_1141          : aliased constant String := "jsonc";
   M_1141          : aliased constant String := "JSON with Comments";
   K_1142          : aliased constant String := "dfy";
   M_1142          : aliased constant String := "Dafny";
   K_1143          : aliased constant String := "ily";
   M_1143          : aliased constant String := "LilyPond";
   K_1144          : aliased constant String := "gco";
   M_1144          : aliased constant String := "G-code";
   K_1145          : aliased constant String := "tla";
   M_1145          : aliased constant String := "TLA";
   K_1146          : aliased constant String := "ctl";
   M_1146          : aliased constant String := "Visual Basic 6.0";
   K_1147          : aliased constant String := "yaml.sed";
   M_1147          : aliased constant String := "YAML";
   K_1148          : aliased constant String := "jsonl";
   M_1148          : aliased constant String := "JSON";
   K_1149          : aliased constant String := "antlers.xml";
   M_1149          : aliased constant String := "Antlers";
   K_1150          : aliased constant String := "ctp";
   M_1150          : aliased constant String := "PHP";
   K_1151          : aliased constant String := "glslv";
   M_1151          : aliased constant String := "GLSL";
   K_1152          : aliased constant String := "hzp";
   M_1152          : aliased constant String := "XML";
   K_1153          : aliased constant String := "cts";
   M_1153          : aliased constant String := "TypeScript";
   K_1154          : aliased constant String := "bbappend";
   M_1154          : aliased constant String := "BitBake";
   K_1155          : aliased constant String := "nginx";
   M_1155          : aliased constant String := "Nginx";
   K_1156          : aliased constant String := "yrl";
   M_1156          : aliased constant String := "Erlang";
   K_1157          : aliased constant String := "golo";
   M_1157          : aliased constant String := "Golo";
   K_1158          : aliased constant String := "phtml";
   M_1158          : aliased constant String := "HTML+PHP";
   K_1159          : aliased constant String := "inc";
   M_1159          : aliased constant String := "C++,Assembly,SourcePawn,SQL,Pawn,Pascal,P"
       & "OV-Ray SDL,PHP,NASL,Motorola 68K Assembly,HTML,BitBake";
   K_1160          : aliased constant String := "rktd";
   M_1160          : aliased constant String := "Racket";
   K_1161          : aliased constant String := "vark";
   M_1161          : aliased constant String := "Gosu";
   K_1162          : aliased constant String := "mata";
   M_1162          : aliased constant String := "Stata";
   K_1163          : aliased constant String := "sh-session";
   M_1163          : aliased constant String := "ShellSession";
   K_1164          : aliased constant String := "srdf";
   M_1164          : aliased constant String := "XML";
   K_1165          : aliased constant String := "tlv";
   M_1165          : aliased constant String := "TL-Verilog";
   K_1166          : aliased constant String := "shader";
   M_1166          : aliased constant String := "ShaderLab,GLSL";
   K_1167          : aliased constant String := "ini";
   M_1167          : aliased constant String := "INI";
   K_1168          : aliased constant String := "snippet";
   M_1168          : aliased constant String := "Vim Snippet";
   K_1169          : aliased constant String := "maxhelp";
   M_1169          : aliased constant String := "Max";
   K_1170          : aliased constant String := "ink";
   M_1170          : aliased constant String := "Ink";
   K_1171          : aliased constant String := "esdl";
   M_1171          : aliased constant String := "EdgeQL";
   K_1172          : aliased constant String := "rktl";
   M_1172          : aliased constant String := "Racket";
   K_1173          : aliased constant String := "vstemplate";
   M_1173          : aliased constant String := "XML";
   K_1174          : aliased constant String := "inl";
   M_1174          : aliased constant String := "C++";
   K_1175          : aliased constant String := "proto";
   M_1175          : aliased constant String := "Protocol Buffer";
   K_1176          : aliased constant String := "rebol";
   M_1176          : aliased constant String := "Rebol";
   K_1177          : aliased constant String := "syntax";
   M_1177          : aliased constant String := "YAML";
   K_1178          : aliased constant String := "vbhtml";
   M_1178          : aliased constant String := "Visual Basic .NET";
   K_1179          : aliased constant String := "webapp";
   M_1179          : aliased constant String := "JSON";
   K_1180          : aliased constant String := "ino";
   M_1180          : aliased constant String := "C++";
   K_1181          : aliased constant String := "ged";
   M_1181          : aliased constant String := "GEDCOM";
   K_1182          : aliased constant String := "wit";
   M_1182          : aliased constant String := "WebAssembly Interface Type";
   K_1183          : aliased constant String := "gdns";
   M_1183          : aliased constant String := "Godot Resource";
   K_1184          : aliased constant String := "mlir";
   M_1184          : aliased constant String := "MLIR";
   K_1185          : aliased constant String := "regexp";
   M_1185          : aliased constant String := "Regular Expression";
   K_1186          : aliased constant String := "ins";
   M_1186          : aliased constant String := "TeX";
   K_1187          : aliased constant String := "prefab";
   M_1187          : aliased constant String := "Unity3D Asset";
   K_1188          : aliased constant String := "rpgle";
   M_1188          : aliased constant String := "RPGLE";
   K_1189          : aliased constant String := "cppm";
   M_1189          : aliased constant String := "C++";
   K_1190          : aliased constant String := "thrift";
   M_1190          : aliased constant String := "Thrift";
   K_1191          : aliased constant String := "boot";
   M_1191          : aliased constant String := "Clojure";
   K_1192          : aliased constant String := "coffee.md";
   M_1192          : aliased constant String := "Literate CoffeeScript";
   K_1193          : aliased constant String := "plot";
   M_1193          : aliased constant String := "Gnuplot";
   K_1194          : aliased constant String := "gradle.kts";
   M_1194          : aliased constant String := "Gradle Kotlin DSL";
   K_1195          : aliased constant String := "8xp.txt";
   M_1195          : aliased constant String := "TI Program";
   K_1196          : aliased constant String := "geo";
   M_1196          : aliased constant String := "GLSL";
   K_1197          : aliased constant String := "ebuild";
   M_1197          : aliased constant String := "Gentoo Ebuild";
   K_1198          : aliased constant String := "sublime-workspace";
   M_1198          : aliased constant String := "JSON with Comments";
   K_1199          : aliased constant String := "adml";
   M_1199          : aliased constant String := "XML";
   K_1200          : aliased constant String := "fsh";
   M_1200          : aliased constant String := "GLSL";
   K_1201          : aliased constant String := "ebnf";
   M_1201          : aliased constant String := "EBNF";
   K_1202          : aliased constant String := "fsi";
   M_1202          : aliased constant String := "F#";
   K_1203          : aliased constant String := "reb";
   M_1203          : aliased constant String := "Rebol";
   K_1204          : aliased constant String := "red";
   M_1204          : aliased constant String := "Red";
   K_1205          : aliased constant String := "bicepparam";
   M_1205          : aliased constant String := "Bicep";
   K_1206          : aliased constant String := "ston";
   M_1206          : aliased constant String := "STON";
   K_1207          : aliased constant String := "c++-objdump";
   M_1207          : aliased constant String := "Cpp-ObjDump";
   K_1208          : aliased constant String := "reg";
   M_1208          : aliased constant String := "Windows Registry Entries";
   K_1209          : aliased constant String := "rei";
   M_1209          : aliased constant String := "Reason";
   K_1210          : aliased constant String := "ipf";
   M_1210          : aliased constant String := "IGOR Pro";
   K_1211          : aliased constant String := "admx";
   M_1211          : aliased constant String := "XML";
   K_1212          : aliased constant String := "fst";
   M_1212          : aliased constant String := "F*";
   K_1213          : aliased constant String := "mint";
   M_1213          : aliased constant String := "Mint";
   K_1214          : aliased constant String := "zmpl";
   M_1214          : aliased constant String := "Zimpl";
   K_1215          : aliased constant String := "wixproj";
   M_1215          : aliased constant String := "XML";
   K_1216          : aliased constant String := "fsx";
   M_1216          : aliased constant String := "F#";
   K_1217          : aliased constant String := "desktop.in";
   M_1217          : aliased constant String := "desktop";
   K_1218          : aliased constant String := "libsonnet";
   M_1218          : aliased constant String := "Jsonnet";
   K_1219          : aliased constant String := "res";
   M_1219          : aliased constant String := "XML,ReScript";
   K_1220          : aliased constant String := "sublime-theme";
   M_1220          : aliased constant String := "JSON with Comments";
   K_1221          : aliased constant String := "ipp";
   M_1221          : aliased constant String := "C++";
   K_1222          : aliased constant String := "djs";
   M_1222          : aliased constant String := "Dogescript";
   K_1223          : aliased constant String := "rex";
   M_1223          : aliased constant String := "REXX";
   K_1224          : aliased constant String := "sh.in";
   M_1224          : aliased constant String := "Shell";
   K_1225          : aliased constant String := "vhost";
   M_1225          : aliased constant String := "Nginx,ApacheConf";
   K_1226          : aliased constant String := "app.src";
   M_1226          : aliased constant String := "Erlang";
   K_1227          : aliased constant String := "lmi";
   M_1227          : aliased constant String := "Python";
   K_1228          : aliased constant String := "bal";
   M_1228          : aliased constant String := "Ballerina";
   K_1229          : aliased constant String := "glsl";
   M_1229          : aliased constant String := "GLSL";
   K_1230          : aliased constant String := "xaml";
   M_1230          : aliased constant String := "XML";
   K_1231          : aliased constant String := "adoc";
   M_1231          : aliased constant String := "AsciiDoc";
   K_1232          : aliased constant String := "tpb";
   M_1232          : aliased constant String := "PLSQL";
   K_1233          : aliased constant String := "bas";
   M_1233          : aliased constant String := "VBA,Visual Basic 6.0,FreeBasic,BASIC";
   K_1234          : aliased constant String := "bat";
   M_1234          : aliased constant String := "Batchfile";
   K_1235          : aliased constant String := "pasm";
   M_1235          : aliased constant String := "Parrot Assembly";
   K_1236          : aliased constant String := "duby";
   M_1236          : aliased constant String := "Mirah";
   K_1237          : aliased constant String := "cson";
   M_1237          : aliased constant String := "CSON";
   K_1238          : aliased constant String := "tpl";
   M_1238          : aliased constant String := "Smarty";
   K_1239          : aliased constant String := "pony";
   M_1239          : aliased constant String := "Pony";
   K_1240          : aliased constant String := "cxx";
   M_1240          : aliased constant String := "C++";
   K_1241          : aliased constant String := "tpp";
   M_1241          : aliased constant String := "C++";
   K_1242          : aliased constant String := "fun";
   M_1242          : aliased constant String := "Standard ML";
   K_1243          : aliased constant String := "tps";
   M_1243          : aliased constant String := "PLSQL";
   K_1244          : aliased constant String := "mak";
   M_1244          : aliased constant String := "Makefile";
   K_1245          : aliased constant String := "fut";
   M_1245          : aliased constant String := "Futhark";
   K_1246          : aliased constant String := "man";
   M_1246          : aliased constant String := "Roff Manpage,Roff";
   K_1247          : aliased constant String := "mao";
   M_1247          : aliased constant String := "Mako";
   K_1248          : aliased constant String := "conllu";
   M_1248          : aliased constant String := "CoNLL-U";
   K_1249          : aliased constant String := "dlm";
   M_1249          : aliased constant String := "IDL";
   K_1250          : aliased constant String := "mdown";
   M_1250          : aliased constant String := "Markdown";
   K_1251          : aliased constant String := "mat";
   M_1251          : aliased constant String := "Unity3D Asset";
   K_1252          : aliased constant String := "udf";
   M_1252          : aliased constant String := "SQL";
   K_1253          : aliased constant String := "aj";
   M_1253          : aliased constant String := "AspectJ";
   K_1254          : aliased constant String := "rmiss";
   M_1254          : aliased constant String := "GLSL";
   K_1255          : aliased constant String := "al";
   M_1255          : aliased constant String := "Perl,AL";
   K_1256          : aliased constant String := "xhtml";
   M_1256          : aliased constant String := "HTML";
   K_1257          : aliased constant String := "udo";
   M_1257          : aliased constant String := "Csound";
   K_1258          : aliased constant String := "xquery";
   M_1258          : aliased constant String := "XQuery";
   K_1259          : aliased constant String := "lol";
   M_1259          : aliased constant String := "LOLCODE";
   K_1260          : aliased constant String := "as";
   M_1260          : aliased constant String := "AngelScript,ActionScript";
   K_1261          : aliased constant String := "mojo";
   M_1261          : aliased constant String := "XML,Mojo";
   K_1262          : aliased constant String := "aw";
   M_1262          : aliased constant String := "PHP";
   K_1263          : aliased constant String := "riot";
   M_1263          : aliased constant String := "Riot";
   K_1264          : aliased constant String := "xojo_window";
   M_1264          : aliased constant String := "Xojo";
   K_1265          : aliased constant String := "trg";
   M_1265          : aliased constant String := "PLSQL";
   K_1266          : aliased constant String := "gawk";
   M_1266          : aliased constant String := "Awk";
   K_1267          : aliased constant String := "patch";
   M_1267          : aliased constant String := "Diff";
   K_1268          : aliased constant String := "dita";
   M_1268          : aliased constant String := "XML";
   K_1269          : aliased constant String := "jinja2";
   M_1269          : aliased constant String := "Jinja";
   K_1270          : aliased constant String := "hlsli";
   M_1270          : aliased constant String := "HLSL";
   K_1271          : aliased constant String := "psc1";
   M_1271          : aliased constant String := "XML";
   K_1272          : aliased constant String := "whiley";
   M_1272          : aliased constant String := "Whiley";
   K_1273          : aliased constant String := "cc";
   M_1273          : aliased constant String := "C++";
   K_1274          : aliased constant String := "linq";
   M_1274          : aliased constant String := "C#";
   K_1275          : aliased constant String := "lasso";
   M_1275          : aliased constant String := "Lasso";
   K_1276          : aliased constant String := "vhdl";
   M_1276          : aliased constant String := "VHDL";
   K_1277          : aliased constant String := "mcr";
   M_1277          : aliased constant String := "MAXScript";
   K_1278          : aliased constant String := "ch";
   M_1278          : aliased constant String := "xBase,Charity";
   K_1279          : aliased constant String := "ck";
   M_1279          : aliased constant String := "ChucK";
   K_1280          : aliased constant String := "html.heex";
   M_1280          : aliased constant String := "HTML+EEX";
   K_1281          : aliased constant String := "cl";
   M_1281          : aliased constant String := "OpenCL,Cool,Common Lisp";
   K_1282          : aliased constant String := "smali";
   M_1282          : aliased constant String := "Smali";
   K_1283          : aliased constant String := "dyalog";
   M_1283          : aliased constant String := "APL";
   K_1284          : aliased constant String := "makefile";
   M_1284          : aliased constant String := "Makefile";
   K_1285          : aliased constant String := "cp";
   M_1285          : aliased constant String := "C++,Component Pascal";
   K_1286          : aliased constant String := "xzap";
   M_1286          : aliased constant String := "ZAP";
   K_1287          : aliased constant String := "c-objdump";
   M_1287          : aliased constant String := "C-ObjDump";
   K_1288          : aliased constant String := "cr";
   M_1288          : aliased constant String := "Crystal";
   K_1289          : aliased constant String := "au3";
   M_1289          : aliased constant String := "AutoIt";
   K_1290          : aliased constant String := "gko";
   M_1290          : aliased constant String := "Gerber Image";
   K_1291          : aliased constant String := "cs";
   M_1291          : aliased constant String := "Smalltalk,C#";
   K_1292          : aliased constant String := "hxml";
   M_1292          : aliased constant String := "HXML";
   K_1293          : aliased constant String := "ct";
   M_1293          : aliased constant String := "XML";
   K_1294          : aliased constant String := "mdpolicy";
   M_1294          : aliased constant String := "XML";
   K_1295          : aliased constant String := "cu";
   M_1295          : aliased constant String := "Cuda";
   K_1296          : aliased constant String := "sublime_metrics";
   M_1296          : aliased constant String := "JSON with Comments";
   K_1297          : aliased constant String := "cw";
   M_1297          : aliased constant String := "Redcode";
   K_1298          : aliased constant String := "asc";
   M_1298          : aliased constant String := "Public Key,AsciiDoc,AGS Script";
   K_1299          : aliased constant String := "jscad";
   M_1299          : aliased constant String := "JavaScript";
   K_1300          : aliased constant String := "cy";
   M_1300          : aliased constant String := "Cycript";
   K_1301          : aliased constant String := "asd";
   M_1301          : aliased constant String := "Common Lisp";
   K_1302          : aliased constant String := "ash";
   M_1302          : aliased constant String := "AGS Script";
   K_1303          : aliased constant String := "proj";
   M_1303          : aliased constant String := "XML";
   K_1304          : aliased constant String := "ttl";
   M_1304          : aliased constant String := "Turtle";
   K_1305          : aliased constant String := "applescript";
   M_1305          : aliased constant String := "AppleScript";
   K_1306          : aliased constant String := "asl";
   M_1306          : aliased constant String := "ASL";
   K_1307          : aliased constant String := "sieve";
   M_1307          : aliased constant String := "Sieve";
   K_1308          : aliased constant String := "asm";
   M_1308          : aliased constant String := "Assembly,Motorola 68K Assembly";
   K_1309          : aliased constant String := "liquid";
   M_1309          : aliased constant String := "Liquid";
   K_1310          : aliased constant String := "asn";
   M_1310          : aliased constant String := "ASN.1";
   K_1311          : aliased constant String := "java";
   M_1311          : aliased constant String := "Java";
   K_1312          : aliased constant String := "asp";
   M_1312          : aliased constant String := "Classic ASP";
   K_1313          : aliased constant String := "neon";
   M_1313          : aliased constant String := "NEON";
   K_1314          : aliased constant String := "g4";
   M_1314          : aliased constant String := "ANTLR";
   K_1315          : aliased constant String := "ditaval";
   M_1315          : aliased constant String := "XML";
   K_1316          : aliased constant String := "gcode";
   M_1316          : aliased constant String := "G-code";
   K_1317          : aliased constant String := "nomad";
   M_1317          : aliased constant String := "HCL";
   K_1318          : aliased constant String := "sats";
   M_1318          : aliased constant String := "ATS";
   K_1319          : aliased constant String := "eb";
   M_1319          : aliased constant String := "Easybuild";
   K_1320          : aliased constant String := "asy";
   M_1320          : aliased constant String := "LTspice Symbol,Asymptote";
   K_1321          : aliased constant String := "ec";
   M_1321          : aliased constant String := "eC";
   K_1322          : aliased constant String := "matah";
   M_1322          : aliased constant String := "Stata";
   K_1323          : aliased constant String := "xojo_toolbar";
   M_1323          : aliased constant String := "Xojo";
   K_1324          : aliased constant String := "eh";
   M_1324          : aliased constant String := "eC";
   K_1325          : aliased constant String := "rkt";
   M_1325          : aliased constant String := "Racket";
   K_1326          : aliased constant String := "dpr";
   M_1326          : aliased constant String := "Pascal";
   K_1327          : aliased constant String := "_js";
   M_1327          : aliased constant String := "JavaScript";
   K_1328          : aliased constant String := "pbi";
   M_1328          : aliased constant String := "PureBasic";
   K_1329          : aliased constant String := "el";
   M_1329          : aliased constant String := "Emacs Lisp";
   K_1330          : aliased constant String := "gmi";
   M_1330          : aliased constant String := "Gemini";
   K_1331          : aliased constant String := "em";
   M_1331          : aliased constant String := "EmberScript";
   K_1332          : aliased constant String := "tcl.in";
   M_1332          : aliased constant String := "Tcl";
   K_1333          : aliased constant String := "mcfunction";
   M_1333          : aliased constant String := "mcfunction";
   K_1334          : aliased constant String := "arpa";
   M_1334          : aliased constant String := "DNS Zone";
   K_1335          : aliased constant String := "gml";
   M_1335          : aliased constant String := "XML,Graph Modeling Language,Gerber Image,"
       & "Game Maker Language";
   K_1336          : aliased constant String := "sha256";
   M_1336          : aliased constant String := "Checksums";
   K_1337          : aliased constant String := "lsl";
   M_1337          : aliased constant String := "LSL";
   K_1338          : aliased constant String := "eq";
   M_1338          : aliased constant String := "EQ";
   K_1339          : aliased constant String := "ivy";
   M_1339          : aliased constant String := "XML";
   K_1340          : aliased constant String := "kicad_pcb";
   M_1340          : aliased constant String := "KiCad Layout";
   K_1341          : aliased constant String := "edc";
   M_1341          : aliased constant String := "Edje Data Collection";
   K_1342          : aliased constant String := "es";
   M_1342          : aliased constant String := "JavaScript,Erlang";
   K_1343          : aliased constant String := "opa";
   M_1343          : aliased constant String := "Opa";
   K_1344          : aliased constant String := "mkfile";
   M_1344          : aliased constant String := "Makefile";
   K_1345          : aliased constant String := "pbt";
   M_1345          : aliased constant String := "Protocol Buffer Text Format,PowerBuilder";
   K_1346          : aliased constant String := "cs.pp";
   M_1346          : aliased constant String := "C#";
   K_1347          : aliased constant String := "lsp";
   M_1347          : aliased constant String := "NewLisp,Common Lisp";
   K_1348          : aliased constant String := "gms";
   M_1348          : aliased constant String := "GAMS";
   K_1349          : aliased constant String := "3pm";
   M_1349          : aliased constant String := "Roff Manpage,Roff";
   K_1350          : aliased constant String := "ex";
   M_1350          : aliased constant String := "Elixir,Euphoria";
   K_1351          : aliased constant String := "aug";
   M_1351          : aliased constant String := "Augeas";
   K_1352          : aliased constant String := "gmx";
   M_1352          : aliased constant String := "XML";
   K_1353          : aliased constant String := "edn";
   M_1353          : aliased constant String := "edn";
   K_1354          : aliased constant String := "thor";
   M_1354          : aliased constant String := "Ruby";
   K_1355          : aliased constant String := "auk";
   M_1355          : aliased constant String := "Awk";
   K_1356          : aliased constant String := "jbuilder";
   M_1356          : aliased constant String := "Ruby";
   K_1357          : aliased constant String := "rmd";
   M_1357          : aliased constant String := "RMarkdown";
   K_1358          : aliased constant String := "sublime-keymap";
   M_1358          : aliased constant String := "JSON with Comments";
   K_1359          : aliased constant String := "tmux";
   M_1359          : aliased constant String := "Shell";
   K_1360          : aliased constant String := "wsf";
   M_1360          : aliased constant String := "XML";
   K_1361          : aliased constant String := "i3";
   M_1361          : aliased constant String := "Modula-3";
   K_1362          : aliased constant String := "aux";
   M_1362          : aliased constant String := "TeX";

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
      K_364'Access, K_365'Access, K_366'Access, K_367'Access,
      K_368'Access, K_369'Access, K_370'Access, K_371'Access,
      K_372'Access, K_373'Access, K_374'Access, K_375'Access,
      K_376'Access, K_377'Access, K_378'Access, K_379'Access,
      K_380'Access, K_381'Access, K_382'Access, K_383'Access,
      K_384'Access, K_385'Access, K_386'Access, K_387'Access,
      K_388'Access, K_389'Access, K_390'Access, K_391'Access,
      K_392'Access, K_393'Access, K_394'Access, K_395'Access,
      K_396'Access, K_397'Access, K_398'Access, K_399'Access,
      K_400'Access, K_401'Access, K_402'Access, K_403'Access,
      K_404'Access, K_405'Access, K_406'Access, K_407'Access,
      K_408'Access, K_409'Access, K_410'Access, K_411'Access,
      K_412'Access, K_413'Access, K_414'Access, K_415'Access,
      K_416'Access, K_417'Access, K_418'Access, K_419'Access,
      K_420'Access, K_421'Access, K_422'Access, K_423'Access,
      K_424'Access, K_425'Access, K_426'Access, K_427'Access,
      K_428'Access, K_429'Access, K_430'Access, K_431'Access,
      K_432'Access, K_433'Access, K_434'Access, K_435'Access,
      K_436'Access, K_437'Access, K_438'Access, K_439'Access,
      K_440'Access, K_441'Access, K_442'Access, K_443'Access,
      K_444'Access, K_445'Access, K_446'Access, K_447'Access,
      K_448'Access, K_449'Access, K_450'Access, K_451'Access,
      K_452'Access, K_453'Access, K_454'Access, K_455'Access,
      K_456'Access, K_457'Access, K_458'Access, K_459'Access,
      K_460'Access, K_461'Access, K_462'Access, K_463'Access,
      K_464'Access, K_465'Access, K_466'Access, K_467'Access,
      K_468'Access, K_469'Access, K_470'Access, K_471'Access,
      K_472'Access, K_473'Access, K_474'Access, K_475'Access,
      K_476'Access, K_477'Access, K_478'Access, K_479'Access,
      K_480'Access, K_481'Access, K_482'Access, K_483'Access,
      K_484'Access, K_485'Access, K_486'Access, K_487'Access,
      K_488'Access, K_489'Access, K_490'Access, K_491'Access,
      K_492'Access, K_493'Access, K_494'Access, K_495'Access,
      K_496'Access, K_497'Access, K_498'Access, K_499'Access,
      K_500'Access, K_501'Access, K_502'Access, K_503'Access,
      K_504'Access, K_505'Access, K_506'Access, K_507'Access,
      K_508'Access, K_509'Access, K_510'Access, K_511'Access,
      K_512'Access, K_513'Access, K_514'Access, K_515'Access,
      K_516'Access, K_517'Access, K_518'Access, K_519'Access,
      K_520'Access, K_521'Access, K_522'Access, K_523'Access,
      K_524'Access, K_525'Access, K_526'Access, K_527'Access,
      K_528'Access, K_529'Access, K_530'Access, K_531'Access,
      K_532'Access, K_533'Access, K_534'Access, K_535'Access,
      K_536'Access, K_537'Access, K_538'Access, K_539'Access,
      K_540'Access, K_541'Access, K_542'Access, K_543'Access,
      K_544'Access, K_545'Access, K_546'Access, K_547'Access,
      K_548'Access, K_549'Access, K_550'Access, K_551'Access,
      K_552'Access, K_553'Access, K_554'Access, K_555'Access,
      K_556'Access, K_557'Access, K_558'Access, K_559'Access,
      K_560'Access, K_561'Access, K_562'Access, K_563'Access,
      K_564'Access, K_565'Access, K_566'Access, K_567'Access,
      K_568'Access, K_569'Access, K_570'Access, K_571'Access,
      K_572'Access, K_573'Access, K_574'Access, K_575'Access,
      K_576'Access, K_577'Access, K_578'Access, K_579'Access,
      K_580'Access, K_581'Access, K_582'Access, K_583'Access,
      K_584'Access, K_585'Access, K_586'Access, K_587'Access,
      K_588'Access, K_589'Access, K_590'Access, K_591'Access,
      K_592'Access, K_593'Access, K_594'Access, K_595'Access,
      K_596'Access, K_597'Access, K_598'Access, K_599'Access,
      K_600'Access, K_601'Access, K_602'Access, K_603'Access,
      K_604'Access, K_605'Access, K_606'Access, K_607'Access,
      K_608'Access, K_609'Access, K_610'Access, K_611'Access,
      K_612'Access, K_613'Access, K_614'Access, K_615'Access,
      K_616'Access, K_617'Access, K_618'Access, K_619'Access,
      K_620'Access, K_621'Access, K_622'Access, K_623'Access,
      K_624'Access, K_625'Access, K_626'Access, K_627'Access,
      K_628'Access, K_629'Access, K_630'Access, K_631'Access,
      K_632'Access, K_633'Access, K_634'Access, K_635'Access,
      K_636'Access, K_637'Access, K_638'Access, K_639'Access,
      K_640'Access, K_641'Access, K_642'Access, K_643'Access,
      K_644'Access, K_645'Access, K_646'Access, K_647'Access,
      K_648'Access, K_649'Access, K_650'Access, K_651'Access,
      K_652'Access, K_653'Access, K_654'Access, K_655'Access,
      K_656'Access, K_657'Access, K_658'Access, K_659'Access,
      K_660'Access, K_661'Access, K_662'Access, K_663'Access,
      K_664'Access, K_665'Access, K_666'Access, K_667'Access,
      K_668'Access, K_669'Access, K_670'Access, K_671'Access,
      K_672'Access, K_673'Access, K_674'Access, K_675'Access,
      K_676'Access, K_677'Access, K_678'Access, K_679'Access,
      K_680'Access, K_681'Access, K_682'Access, K_683'Access,
      K_684'Access, K_685'Access, K_686'Access, K_687'Access,
      K_688'Access, K_689'Access, K_690'Access, K_691'Access,
      K_692'Access, K_693'Access, K_694'Access, K_695'Access,
      K_696'Access, K_697'Access, K_698'Access, K_699'Access,
      K_700'Access, K_701'Access, K_702'Access, K_703'Access,
      K_704'Access, K_705'Access, K_706'Access, K_707'Access,
      K_708'Access, K_709'Access, K_710'Access, K_711'Access,
      K_712'Access, K_713'Access, K_714'Access, K_715'Access,
      K_716'Access, K_717'Access, K_718'Access, K_719'Access,
      K_720'Access, K_721'Access, K_722'Access, K_723'Access,
      K_724'Access, K_725'Access, K_726'Access, K_727'Access,
      K_728'Access, K_729'Access, K_730'Access, K_731'Access,
      K_732'Access, K_733'Access, K_734'Access, K_735'Access,
      K_736'Access, K_737'Access, K_738'Access, K_739'Access,
      K_740'Access, K_741'Access, K_742'Access, K_743'Access,
      K_744'Access, K_745'Access, K_746'Access, K_747'Access,
      K_748'Access, K_749'Access, K_750'Access, K_751'Access,
      K_752'Access, K_753'Access, K_754'Access, K_755'Access,
      K_756'Access, K_757'Access, K_758'Access, K_759'Access,
      K_760'Access, K_761'Access, K_762'Access, K_763'Access,
      K_764'Access, K_765'Access, K_766'Access, K_767'Access,
      K_768'Access, K_769'Access, K_770'Access, K_771'Access,
      K_772'Access, K_773'Access, K_774'Access, K_775'Access,
      K_776'Access, K_777'Access, K_778'Access, K_779'Access,
      K_780'Access, K_781'Access, K_782'Access, K_783'Access,
      K_784'Access, K_785'Access, K_786'Access, K_787'Access,
      K_788'Access, K_789'Access, K_790'Access, K_791'Access,
      K_792'Access, K_793'Access, K_794'Access, K_795'Access,
      K_796'Access, K_797'Access, K_798'Access, K_799'Access,
      K_800'Access, K_801'Access, K_802'Access, K_803'Access,
      K_804'Access, K_805'Access, K_806'Access, K_807'Access,
      K_808'Access, K_809'Access, K_810'Access, K_811'Access,
      K_812'Access, K_813'Access, K_814'Access, K_815'Access,
      K_816'Access, K_817'Access, K_818'Access, K_819'Access,
      K_820'Access, K_821'Access, K_822'Access, K_823'Access,
      K_824'Access, K_825'Access, K_826'Access, K_827'Access,
      K_828'Access, K_829'Access, K_830'Access, K_831'Access,
      K_832'Access, K_833'Access, K_834'Access, K_835'Access,
      K_836'Access, K_837'Access, K_838'Access, K_839'Access,
      K_840'Access, K_841'Access, K_842'Access, K_843'Access,
      K_844'Access, K_845'Access, K_846'Access, K_847'Access,
      K_848'Access, K_849'Access, K_850'Access, K_851'Access,
      K_852'Access, K_853'Access, K_854'Access, K_855'Access,
      K_856'Access, K_857'Access, K_858'Access, K_859'Access,
      K_860'Access, K_861'Access, K_862'Access, K_863'Access,
      K_864'Access, K_865'Access, K_866'Access, K_867'Access,
      K_868'Access, K_869'Access, K_870'Access, K_871'Access,
      K_872'Access, K_873'Access, K_874'Access, K_875'Access,
      K_876'Access, K_877'Access, K_878'Access, K_879'Access,
      K_880'Access, K_881'Access, K_882'Access, K_883'Access,
      K_884'Access, K_885'Access, K_886'Access, K_887'Access,
      K_888'Access, K_889'Access, K_890'Access, K_891'Access,
      K_892'Access, K_893'Access, K_894'Access, K_895'Access,
      K_896'Access, K_897'Access, K_898'Access, K_899'Access,
      K_900'Access, K_901'Access, K_902'Access, K_903'Access,
      K_904'Access, K_905'Access, K_906'Access, K_907'Access,
      K_908'Access, K_909'Access, K_910'Access, K_911'Access,
      K_912'Access, K_913'Access, K_914'Access, K_915'Access,
      K_916'Access, K_917'Access, K_918'Access, K_919'Access,
      K_920'Access, K_921'Access, K_922'Access, K_923'Access,
      K_924'Access, K_925'Access, K_926'Access, K_927'Access,
      K_928'Access, K_929'Access, K_930'Access, K_931'Access,
      K_932'Access, K_933'Access, K_934'Access, K_935'Access,
      K_936'Access, K_937'Access, K_938'Access, K_939'Access,
      K_940'Access, K_941'Access, K_942'Access, K_943'Access,
      K_944'Access, K_945'Access, K_946'Access, K_947'Access,
      K_948'Access, K_949'Access, K_950'Access, K_951'Access,
      K_952'Access, K_953'Access, K_954'Access, K_955'Access,
      K_956'Access, K_957'Access, K_958'Access, K_959'Access,
      K_960'Access, K_961'Access, K_962'Access, K_963'Access,
      K_964'Access, K_965'Access, K_966'Access, K_967'Access,
      K_968'Access, K_969'Access, K_970'Access, K_971'Access,
      K_972'Access, K_973'Access, K_974'Access, K_975'Access,
      K_976'Access, K_977'Access, K_978'Access, K_979'Access,
      K_980'Access, K_981'Access, K_982'Access, K_983'Access,
      K_984'Access, K_985'Access, K_986'Access, K_987'Access,
      K_988'Access, K_989'Access, K_990'Access, K_991'Access,
      K_992'Access, K_993'Access, K_994'Access, K_995'Access,
      K_996'Access, K_997'Access, K_998'Access, K_999'Access,
      K_1000'Access, K_1001'Access, K_1002'Access, K_1003'Access,
      K_1004'Access, K_1005'Access, K_1006'Access, K_1007'Access,
      K_1008'Access, K_1009'Access, K_1010'Access, K_1011'Access,
      K_1012'Access, K_1013'Access, K_1014'Access, K_1015'Access,
      K_1016'Access, K_1017'Access, K_1018'Access, K_1019'Access,
      K_1020'Access, K_1021'Access, K_1022'Access, K_1023'Access,
      K_1024'Access, K_1025'Access, K_1026'Access, K_1027'Access,
      K_1028'Access, K_1029'Access, K_1030'Access, K_1031'Access,
      K_1032'Access, K_1033'Access, K_1034'Access, K_1035'Access,
      K_1036'Access, K_1037'Access, K_1038'Access, K_1039'Access,
      K_1040'Access, K_1041'Access, K_1042'Access, K_1043'Access,
      K_1044'Access, K_1045'Access, K_1046'Access, K_1047'Access,
      K_1048'Access, K_1049'Access, K_1050'Access, K_1051'Access,
      K_1052'Access, K_1053'Access, K_1054'Access, K_1055'Access,
      K_1056'Access, K_1057'Access, K_1058'Access, K_1059'Access,
      K_1060'Access, K_1061'Access, K_1062'Access, K_1063'Access,
      K_1064'Access, K_1065'Access, K_1066'Access, K_1067'Access,
      K_1068'Access, K_1069'Access, K_1070'Access, K_1071'Access,
      K_1072'Access, K_1073'Access, K_1074'Access, K_1075'Access,
      K_1076'Access, K_1077'Access, K_1078'Access, K_1079'Access,
      K_1080'Access, K_1081'Access, K_1082'Access, K_1083'Access,
      K_1084'Access, K_1085'Access, K_1086'Access, K_1087'Access,
      K_1088'Access, K_1089'Access, K_1090'Access, K_1091'Access,
      K_1092'Access, K_1093'Access, K_1094'Access, K_1095'Access,
      K_1096'Access, K_1097'Access, K_1098'Access, K_1099'Access,
      K_1100'Access, K_1101'Access, K_1102'Access, K_1103'Access,
      K_1104'Access, K_1105'Access, K_1106'Access, K_1107'Access,
      K_1108'Access, K_1109'Access, K_1110'Access, K_1111'Access,
      K_1112'Access, K_1113'Access, K_1114'Access, K_1115'Access,
      K_1116'Access, K_1117'Access, K_1118'Access, K_1119'Access,
      K_1120'Access, K_1121'Access, K_1122'Access, K_1123'Access,
      K_1124'Access, K_1125'Access, K_1126'Access, K_1127'Access,
      K_1128'Access, K_1129'Access, K_1130'Access, K_1131'Access,
      K_1132'Access, K_1133'Access, K_1134'Access, K_1135'Access,
      K_1136'Access, K_1137'Access, K_1138'Access, K_1139'Access,
      K_1140'Access, K_1141'Access, K_1142'Access, K_1143'Access,
      K_1144'Access, K_1145'Access, K_1146'Access, K_1147'Access,
      K_1148'Access, K_1149'Access, K_1150'Access, K_1151'Access,
      K_1152'Access, K_1153'Access, K_1154'Access, K_1155'Access,
      K_1156'Access, K_1157'Access, K_1158'Access, K_1159'Access,
      K_1160'Access, K_1161'Access, K_1162'Access, K_1163'Access,
      K_1164'Access, K_1165'Access, K_1166'Access, K_1167'Access,
      K_1168'Access, K_1169'Access, K_1170'Access, K_1171'Access,
      K_1172'Access, K_1173'Access, K_1174'Access, K_1175'Access,
      K_1176'Access, K_1177'Access, K_1178'Access, K_1179'Access,
      K_1180'Access, K_1181'Access, K_1182'Access, K_1183'Access,
      K_1184'Access, K_1185'Access, K_1186'Access, K_1187'Access,
      K_1188'Access, K_1189'Access, K_1190'Access, K_1191'Access,
      K_1192'Access, K_1193'Access, K_1194'Access, K_1195'Access,
      K_1196'Access, K_1197'Access, K_1198'Access, K_1199'Access,
      K_1200'Access, K_1201'Access, K_1202'Access, K_1203'Access,
      K_1204'Access, K_1205'Access, K_1206'Access, K_1207'Access,
      K_1208'Access, K_1209'Access, K_1210'Access, K_1211'Access,
      K_1212'Access, K_1213'Access, K_1214'Access, K_1215'Access,
      K_1216'Access, K_1217'Access, K_1218'Access, K_1219'Access,
      K_1220'Access, K_1221'Access, K_1222'Access, K_1223'Access,
      K_1224'Access, K_1225'Access, K_1226'Access, K_1227'Access,
      K_1228'Access, K_1229'Access, K_1230'Access, K_1231'Access,
      K_1232'Access, K_1233'Access, K_1234'Access, K_1235'Access,
      K_1236'Access, K_1237'Access, K_1238'Access, K_1239'Access,
      K_1240'Access, K_1241'Access, K_1242'Access, K_1243'Access,
      K_1244'Access, K_1245'Access, K_1246'Access, K_1247'Access,
      K_1248'Access, K_1249'Access, K_1250'Access, K_1251'Access,
      K_1252'Access, K_1253'Access, K_1254'Access, K_1255'Access,
      K_1256'Access, K_1257'Access, K_1258'Access, K_1259'Access,
      K_1260'Access, K_1261'Access, K_1262'Access, K_1263'Access,
      K_1264'Access, K_1265'Access, K_1266'Access, K_1267'Access,
      K_1268'Access, K_1269'Access, K_1270'Access, K_1271'Access,
      K_1272'Access, K_1273'Access, K_1274'Access, K_1275'Access,
      K_1276'Access, K_1277'Access, K_1278'Access, K_1279'Access,
      K_1280'Access, K_1281'Access, K_1282'Access, K_1283'Access,
      K_1284'Access, K_1285'Access, K_1286'Access, K_1287'Access,
      K_1288'Access, K_1289'Access, K_1290'Access, K_1291'Access,
      K_1292'Access, K_1293'Access, K_1294'Access, K_1295'Access,
      K_1296'Access, K_1297'Access, K_1298'Access, K_1299'Access,
      K_1300'Access, K_1301'Access, K_1302'Access, K_1303'Access,
      K_1304'Access, K_1305'Access, K_1306'Access, K_1307'Access,
      K_1308'Access, K_1309'Access, K_1310'Access, K_1311'Access,
      K_1312'Access, K_1313'Access, K_1314'Access, K_1315'Access,
      K_1316'Access, K_1317'Access, K_1318'Access, K_1319'Access,
      K_1320'Access, K_1321'Access, K_1322'Access, K_1323'Access,
      K_1324'Access, K_1325'Access, K_1326'Access, K_1327'Access,
      K_1328'Access, K_1329'Access, K_1330'Access, K_1331'Access,
      K_1332'Access, K_1333'Access, K_1334'Access, K_1335'Access,
      K_1336'Access, K_1337'Access, K_1338'Access, K_1339'Access,
      K_1340'Access, K_1341'Access, K_1342'Access, K_1343'Access,
      K_1344'Access, K_1345'Access, K_1346'Access, K_1347'Access,
      K_1348'Access, K_1349'Access, K_1350'Access, K_1351'Access,
      K_1352'Access, K_1353'Access, K_1354'Access, K_1355'Access,
      K_1356'Access, K_1357'Access, K_1358'Access, K_1359'Access,
      K_1360'Access, K_1361'Access, K_1362'Access);

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
      M_364'Access, M_365'Access, M_366'Access, M_367'Access,
      M_368'Access, M_369'Access, M_370'Access, M_371'Access,
      M_372'Access, M_373'Access, M_374'Access, M_375'Access,
      M_376'Access, M_377'Access, M_378'Access, M_379'Access,
      M_380'Access, M_381'Access, M_382'Access, M_383'Access,
      M_384'Access, M_385'Access, M_386'Access, M_387'Access,
      M_388'Access, M_389'Access, M_390'Access, M_391'Access,
      M_392'Access, M_393'Access, M_394'Access, M_395'Access,
      M_396'Access, M_397'Access, M_398'Access, M_399'Access,
      M_400'Access, M_401'Access, M_402'Access, M_403'Access,
      M_404'Access, M_405'Access, M_406'Access, M_407'Access,
      M_408'Access, M_409'Access, M_410'Access, M_411'Access,
      M_412'Access, M_413'Access, M_414'Access, M_415'Access,
      M_416'Access, M_417'Access, M_418'Access, M_419'Access,
      M_420'Access, M_421'Access, M_422'Access, M_423'Access,
      M_424'Access, M_425'Access, M_426'Access, M_427'Access,
      M_428'Access, M_429'Access, M_430'Access, M_431'Access,
      M_432'Access, M_433'Access, M_434'Access, M_435'Access,
      M_436'Access, M_437'Access, M_438'Access, M_439'Access,
      M_440'Access, M_441'Access, M_442'Access, M_443'Access,
      M_444'Access, M_445'Access, M_446'Access, M_447'Access,
      M_448'Access, M_449'Access, M_450'Access, M_451'Access,
      M_452'Access, M_453'Access, M_454'Access, M_455'Access,
      M_456'Access, M_457'Access, M_458'Access, M_459'Access,
      M_460'Access, M_461'Access, M_462'Access, M_463'Access,
      M_464'Access, M_465'Access, M_466'Access, M_467'Access,
      M_468'Access, M_469'Access, M_470'Access, M_471'Access,
      M_472'Access, M_473'Access, M_474'Access, M_475'Access,
      M_476'Access, M_477'Access, M_478'Access, M_479'Access,
      M_480'Access, M_481'Access, M_482'Access, M_483'Access,
      M_484'Access, M_485'Access, M_486'Access, M_487'Access,
      M_488'Access, M_489'Access, M_490'Access, M_491'Access,
      M_492'Access, M_493'Access, M_494'Access, M_495'Access,
      M_496'Access, M_497'Access, M_498'Access, M_499'Access,
      M_500'Access, M_501'Access, M_502'Access, M_503'Access,
      M_504'Access, M_505'Access, M_506'Access, M_507'Access,
      M_508'Access, M_509'Access, M_510'Access, M_511'Access,
      M_512'Access, M_513'Access, M_514'Access, M_515'Access,
      M_516'Access, M_517'Access, M_518'Access, M_519'Access,
      M_520'Access, M_521'Access, M_522'Access, M_523'Access,
      M_524'Access, M_525'Access, M_526'Access, M_527'Access,
      M_528'Access, M_529'Access, M_530'Access, M_531'Access,
      M_532'Access, M_533'Access, M_534'Access, M_535'Access,
      M_536'Access, M_537'Access, M_538'Access, M_539'Access,
      M_540'Access, M_541'Access, M_542'Access, M_543'Access,
      M_544'Access, M_545'Access, M_546'Access, M_547'Access,
      M_548'Access, M_549'Access, M_550'Access, M_551'Access,
      M_552'Access, M_553'Access, M_554'Access, M_555'Access,
      M_556'Access, M_557'Access, M_558'Access, M_559'Access,
      M_560'Access, M_561'Access, M_562'Access, M_563'Access,
      M_564'Access, M_565'Access, M_566'Access, M_567'Access,
      M_568'Access, M_569'Access, M_570'Access, M_571'Access,
      M_572'Access, M_573'Access, M_574'Access, M_575'Access,
      M_576'Access, M_577'Access, M_578'Access, M_579'Access,
      M_580'Access, M_581'Access, M_582'Access, M_583'Access,
      M_584'Access, M_585'Access, M_586'Access, M_587'Access,
      M_588'Access, M_589'Access, M_590'Access, M_591'Access,
      M_592'Access, M_593'Access, M_594'Access, M_595'Access,
      M_596'Access, M_597'Access, M_598'Access, M_599'Access,
      M_600'Access, M_601'Access, M_602'Access, M_603'Access,
      M_604'Access, M_605'Access, M_606'Access, M_607'Access,
      M_608'Access, M_609'Access, M_610'Access, M_611'Access,
      M_612'Access, M_613'Access, M_614'Access, M_615'Access,
      M_616'Access, M_617'Access, M_618'Access, M_619'Access,
      M_620'Access, M_621'Access, M_622'Access, M_623'Access,
      M_624'Access, M_625'Access, M_626'Access, M_627'Access,
      M_628'Access, M_629'Access, M_630'Access, M_631'Access,
      M_632'Access, M_633'Access, M_634'Access, M_635'Access,
      M_636'Access, M_637'Access, M_638'Access, M_639'Access,
      M_640'Access, M_641'Access, M_642'Access, M_643'Access,
      M_644'Access, M_645'Access, M_646'Access, M_647'Access,
      M_648'Access, M_649'Access, M_650'Access, M_651'Access,
      M_652'Access, M_653'Access, M_654'Access, M_655'Access,
      M_656'Access, M_657'Access, M_658'Access, M_659'Access,
      M_660'Access, M_661'Access, M_662'Access, M_663'Access,
      M_664'Access, M_665'Access, M_666'Access, M_667'Access,
      M_668'Access, M_669'Access, M_670'Access, M_671'Access,
      M_672'Access, M_673'Access, M_674'Access, M_675'Access,
      M_676'Access, M_677'Access, M_678'Access, M_679'Access,
      M_680'Access, M_681'Access, M_682'Access, M_683'Access,
      M_684'Access, M_685'Access, M_686'Access, M_687'Access,
      M_688'Access, M_689'Access, M_690'Access, M_691'Access,
      M_692'Access, M_693'Access, M_694'Access, M_695'Access,
      M_696'Access, M_697'Access, M_698'Access, M_699'Access,
      M_700'Access, M_701'Access, M_702'Access, M_703'Access,
      M_704'Access, M_705'Access, M_706'Access, M_707'Access,
      M_708'Access, M_709'Access, M_710'Access, M_711'Access,
      M_712'Access, M_713'Access, M_714'Access, M_715'Access,
      M_716'Access, M_717'Access, M_718'Access, M_719'Access,
      M_720'Access, M_721'Access, M_722'Access, M_723'Access,
      M_724'Access, M_725'Access, M_726'Access, M_727'Access,
      M_728'Access, M_729'Access, M_730'Access, M_731'Access,
      M_732'Access, M_733'Access, M_734'Access, M_735'Access,
      M_736'Access, M_737'Access, M_738'Access, M_739'Access,
      M_740'Access, M_741'Access, M_742'Access, M_743'Access,
      M_744'Access, M_745'Access, M_746'Access, M_747'Access,
      M_748'Access, M_749'Access, M_750'Access, M_751'Access,
      M_752'Access, M_753'Access, M_754'Access, M_755'Access,
      M_756'Access, M_757'Access, M_758'Access, M_759'Access,
      M_760'Access, M_761'Access, M_762'Access, M_763'Access,
      M_764'Access, M_765'Access, M_766'Access, M_767'Access,
      M_768'Access, M_769'Access, M_770'Access, M_771'Access,
      M_772'Access, M_773'Access, M_774'Access, M_775'Access,
      M_776'Access, M_777'Access, M_778'Access, M_779'Access,
      M_780'Access, M_781'Access, M_782'Access, M_783'Access,
      M_784'Access, M_785'Access, M_786'Access, M_787'Access,
      M_788'Access, M_789'Access, M_790'Access, M_791'Access,
      M_792'Access, M_793'Access, M_794'Access, M_795'Access,
      M_796'Access, M_797'Access, M_798'Access, M_799'Access,
      M_800'Access, M_801'Access, M_802'Access, M_803'Access,
      M_804'Access, M_805'Access, M_806'Access, M_807'Access,
      M_808'Access, M_809'Access, M_810'Access, M_811'Access,
      M_812'Access, M_813'Access, M_814'Access, M_815'Access,
      M_816'Access, M_817'Access, M_818'Access, M_819'Access,
      M_820'Access, M_821'Access, M_822'Access, M_823'Access,
      M_824'Access, M_825'Access, M_826'Access, M_827'Access,
      M_828'Access, M_829'Access, M_830'Access, M_831'Access,
      M_832'Access, M_833'Access, M_834'Access, M_835'Access,
      M_836'Access, M_837'Access, M_838'Access, M_839'Access,
      M_840'Access, M_841'Access, M_842'Access, M_843'Access,
      M_844'Access, M_845'Access, M_846'Access, M_847'Access,
      M_848'Access, M_849'Access, M_850'Access, M_851'Access,
      M_852'Access, M_853'Access, M_854'Access, M_855'Access,
      M_856'Access, M_857'Access, M_858'Access, M_859'Access,
      M_860'Access, M_861'Access, M_862'Access, M_863'Access,
      M_864'Access, M_865'Access, M_866'Access, M_867'Access,
      M_868'Access, M_869'Access, M_870'Access, M_871'Access,
      M_872'Access, M_873'Access, M_874'Access, M_875'Access,
      M_876'Access, M_877'Access, M_878'Access, M_879'Access,
      M_880'Access, M_881'Access, M_882'Access, M_883'Access,
      M_884'Access, M_885'Access, M_886'Access, M_887'Access,
      M_888'Access, M_889'Access, M_890'Access, M_891'Access,
      M_892'Access, M_893'Access, M_894'Access, M_895'Access,
      M_896'Access, M_897'Access, M_898'Access, M_899'Access,
      M_900'Access, M_901'Access, M_902'Access, M_903'Access,
      M_904'Access, M_905'Access, M_906'Access, M_907'Access,
      M_908'Access, M_909'Access, M_910'Access, M_911'Access,
      M_912'Access, M_913'Access, M_914'Access, M_915'Access,
      M_916'Access, M_917'Access, M_918'Access, M_919'Access,
      M_920'Access, M_921'Access, M_922'Access, M_923'Access,
      M_924'Access, M_925'Access, M_926'Access, M_927'Access,
      M_928'Access, M_929'Access, M_930'Access, M_931'Access,
      M_932'Access, M_933'Access, M_934'Access, M_935'Access,
      M_936'Access, M_937'Access, M_938'Access, M_939'Access,
      M_940'Access, M_941'Access, M_942'Access, M_943'Access,
      M_944'Access, M_945'Access, M_946'Access, M_947'Access,
      M_948'Access, M_949'Access, M_950'Access, M_951'Access,
      M_952'Access, M_953'Access, M_954'Access, M_955'Access,
      M_956'Access, M_957'Access, M_958'Access, M_959'Access,
      M_960'Access, M_961'Access, M_962'Access, M_963'Access,
      M_964'Access, M_965'Access, M_966'Access, M_967'Access,
      M_968'Access, M_969'Access, M_970'Access, M_971'Access,
      M_972'Access, M_973'Access, M_974'Access, M_975'Access,
      M_976'Access, M_977'Access, M_978'Access, M_979'Access,
      M_980'Access, M_981'Access, M_982'Access, M_983'Access,
      M_984'Access, M_985'Access, M_986'Access, M_987'Access,
      M_988'Access, M_989'Access, M_990'Access, M_991'Access,
      M_992'Access, M_993'Access, M_994'Access, M_995'Access,
      M_996'Access, M_997'Access, M_998'Access, M_999'Access,
      M_1000'Access, M_1001'Access, M_1002'Access, M_1003'Access,
      M_1004'Access, M_1005'Access, M_1006'Access, M_1007'Access,
      M_1008'Access, M_1009'Access, M_1010'Access, M_1011'Access,
      M_1012'Access, M_1013'Access, M_1014'Access, M_1015'Access,
      M_1016'Access, M_1017'Access, M_1018'Access, M_1019'Access,
      M_1020'Access, M_1021'Access, M_1022'Access, M_1023'Access,
      M_1024'Access, M_1025'Access, M_1026'Access, M_1027'Access,
      M_1028'Access, M_1029'Access, M_1030'Access, M_1031'Access,
      M_1032'Access, M_1033'Access, M_1034'Access, M_1035'Access,
      M_1036'Access, M_1037'Access, M_1038'Access, M_1039'Access,
      M_1040'Access, M_1041'Access, M_1042'Access, M_1043'Access,
      M_1044'Access, M_1045'Access, M_1046'Access, M_1047'Access,
      M_1048'Access, M_1049'Access, M_1050'Access, M_1051'Access,
      M_1052'Access, M_1053'Access, M_1054'Access, M_1055'Access,
      M_1056'Access, M_1057'Access, M_1058'Access, M_1059'Access,
      M_1060'Access, M_1061'Access, M_1062'Access, M_1063'Access,
      M_1064'Access, M_1065'Access, M_1066'Access, M_1067'Access,
      M_1068'Access, M_1069'Access, M_1070'Access, M_1071'Access,
      M_1072'Access, M_1073'Access, M_1074'Access, M_1075'Access,
      M_1076'Access, M_1077'Access, M_1078'Access, M_1079'Access,
      M_1080'Access, M_1081'Access, M_1082'Access, M_1083'Access,
      M_1084'Access, M_1085'Access, M_1086'Access, M_1087'Access,
      M_1088'Access, M_1089'Access, M_1090'Access, M_1091'Access,
      M_1092'Access, M_1093'Access, M_1094'Access, M_1095'Access,
      M_1096'Access, M_1097'Access, M_1098'Access, M_1099'Access,
      M_1100'Access, M_1101'Access, M_1102'Access, M_1103'Access,
      M_1104'Access, M_1105'Access, M_1106'Access, M_1107'Access,
      M_1108'Access, M_1109'Access, M_1110'Access, M_1111'Access,
      M_1112'Access, M_1113'Access, M_1114'Access, M_1115'Access,
      M_1116'Access, M_1117'Access, M_1118'Access, M_1119'Access,
      M_1120'Access, M_1121'Access, M_1122'Access, M_1123'Access,
      M_1124'Access, M_1125'Access, M_1126'Access, M_1127'Access,
      M_1128'Access, M_1129'Access, M_1130'Access, M_1131'Access,
      M_1132'Access, M_1133'Access, M_1134'Access, M_1135'Access,
      M_1136'Access, M_1137'Access, M_1138'Access, M_1139'Access,
      M_1140'Access, M_1141'Access, M_1142'Access, M_1143'Access,
      M_1144'Access, M_1145'Access, M_1146'Access, M_1147'Access,
      M_1148'Access, M_1149'Access, M_1150'Access, M_1151'Access,
      M_1152'Access, M_1153'Access, M_1154'Access, M_1155'Access,
      M_1156'Access, M_1157'Access, M_1158'Access, M_1159'Access,
      M_1160'Access, M_1161'Access, M_1162'Access, M_1163'Access,
      M_1164'Access, M_1165'Access, M_1166'Access, M_1167'Access,
      M_1168'Access, M_1169'Access, M_1170'Access, M_1171'Access,
      M_1172'Access, M_1173'Access, M_1174'Access, M_1175'Access,
      M_1176'Access, M_1177'Access, M_1178'Access, M_1179'Access,
      M_1180'Access, M_1181'Access, M_1182'Access, M_1183'Access,
      M_1184'Access, M_1185'Access, M_1186'Access, M_1187'Access,
      M_1188'Access, M_1189'Access, M_1190'Access, M_1191'Access,
      M_1192'Access, M_1193'Access, M_1194'Access, M_1195'Access,
      M_1196'Access, M_1197'Access, M_1198'Access, M_1199'Access,
      M_1200'Access, M_1201'Access, M_1202'Access, M_1203'Access,
      M_1204'Access, M_1205'Access, M_1206'Access, M_1207'Access,
      M_1208'Access, M_1209'Access, M_1210'Access, M_1211'Access,
      M_1212'Access, M_1213'Access, M_1214'Access, M_1215'Access,
      M_1216'Access, M_1217'Access, M_1218'Access, M_1219'Access,
      M_1220'Access, M_1221'Access, M_1222'Access, M_1223'Access,
      M_1224'Access, M_1225'Access, M_1226'Access, M_1227'Access,
      M_1228'Access, M_1229'Access, M_1230'Access, M_1231'Access,
      M_1232'Access, M_1233'Access, M_1234'Access, M_1235'Access,
      M_1236'Access, M_1237'Access, M_1238'Access, M_1239'Access,
      M_1240'Access, M_1241'Access, M_1242'Access, M_1243'Access,
      M_1244'Access, M_1245'Access, M_1246'Access, M_1247'Access,
      M_1248'Access, M_1249'Access, M_1250'Access, M_1251'Access,
      M_1252'Access, M_1253'Access, M_1254'Access, M_1255'Access,
      M_1256'Access, M_1257'Access, M_1258'Access, M_1259'Access,
      M_1260'Access, M_1261'Access, M_1262'Access, M_1263'Access,
      M_1264'Access, M_1265'Access, M_1266'Access, M_1267'Access,
      M_1268'Access, M_1269'Access, M_1270'Access, M_1271'Access,
      M_1272'Access, M_1273'Access, M_1274'Access, M_1275'Access,
      M_1276'Access, M_1277'Access, M_1278'Access, M_1279'Access,
      M_1280'Access, M_1281'Access, M_1282'Access, M_1283'Access,
      M_1284'Access, M_1285'Access, M_1286'Access, M_1287'Access,
      M_1288'Access, M_1289'Access, M_1290'Access, M_1291'Access,
      M_1292'Access, M_1293'Access, M_1294'Access, M_1295'Access,
      M_1296'Access, M_1297'Access, M_1298'Access, M_1299'Access,
      M_1300'Access, M_1301'Access, M_1302'Access, M_1303'Access,
      M_1304'Access, M_1305'Access, M_1306'Access, M_1307'Access,
      M_1308'Access, M_1309'Access, M_1310'Access, M_1311'Access,
      M_1312'Access, M_1313'Access, M_1314'Access, M_1315'Access,
      M_1316'Access, M_1317'Access, M_1318'Access, M_1319'Access,
      M_1320'Access, M_1321'Access, M_1322'Access, M_1323'Access,
      M_1324'Access, M_1325'Access, M_1326'Access, M_1327'Access,
      M_1328'Access, M_1329'Access, M_1330'Access, M_1331'Access,
      M_1332'Access, M_1333'Access, M_1334'Access, M_1335'Access,
      M_1336'Access, M_1337'Access, M_1338'Access, M_1339'Access,
      M_1340'Access, M_1341'Access, M_1342'Access, M_1343'Access,
      M_1344'Access, M_1345'Access, M_1346'Access, M_1347'Access,
      M_1348'Access, M_1349'Access, M_1350'Access, M_1351'Access,
      M_1352'Access, M_1353'Access, M_1354'Access, M_1355'Access,
      M_1356'Access, M_1357'Access, M_1358'Access, M_1359'Access,
      M_1360'Access, M_1361'Access, M_1362'Access);

end SPDX_Tool.Languages.ExtensionMap;
