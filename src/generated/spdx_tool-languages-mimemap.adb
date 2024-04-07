--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Mime mapping generated from mimes.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.MimeMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 6) of Natural :=
     (6, 8, 9, 10, 11, 13, 15);

   T1 : constant array (0 .. 6) of Unsigned_8 :=
     (22, 33, 125, 136, 186, 25, 208);

   T2 : constant array (0 .. 6) of Unsigned_8 :=
     (162, 88, 103, 161, 122, 52, 129);

   G : constant array (0 .. 224) of Unsigned_8 :=
     (4, 0, 0, 0, 0, 0, 0, 0, 24, 53, 26, 0, 57, 0, 0, 35, 0, 18, 0, 48, 7,
      62, 0, 37, 0, 0, 0, 0, 0, 100, 19, 14, 0, 32, 0, 0, 0, 0, 0, 27, 17,
      0, 0, 0, 2, 37, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0,
      41, 0, 0, 94, 22, 0, 0, 0, 54, 0, 2, 0, 91, 19, 88, 0, 0, 0, 0, 0, 11,
      0, 7, 0, 58, 62, 0, 0, 0, 0, 0, 0, 0, 0, 67, 0, 52, 0, 0, 0, 71, 25,
      32, 38, 16, 29, 92, 0, 0, 106, 0, 42, 103, 0, 0, 53, 72, 0, 7, 9, 57,
      28, 109, 0, 0, 23, 65, 52, 0, 0, 0, 0, 21, 0, 8, 0, 0, 0, 0, 79, 1,
      107, 72, 0, 0, 74, 33, 40, 0, 0, 34, 95, 0, 110, 0, 0, 77, 80, 40, 0,
      33, 6, 27, 0, 85, 0, 70, 26, 0, 0, 71, 108, 14, 37, 82, 12, 76, 10, 0,
      78, 100, 92, 0, 5, 0, 57, 29, 11, 0, 13, 0, 0, 0, 45, 0, 0, 16, 94,
      97, 0, 70, 87, 0, 0, 0, 12, 0, 0, 89, 90, 71, 87, 0, 0, 18, 49, 67,
      61, 14, 99, 0, 69);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 225;
         F2 := (F2 + Natural (T2 (K)) * J) mod 225;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 112;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "text/x-cobol";
   M_0             : aliased constant String := "COBOL";
   K_1             : aliased constant String := "text/x-coffeescript";
   M_1             : aliased constant String := "CoffeeScript, CSON, EmberScript";
   K_2             : aliased constant String := "text/apl";
   M_2             : aliased constant String := "APL";
   K_3             : aliased constant String := "text/x-c++src";
   M_3             : aliased constant String := "Game Maker Language, AngelScript, Squirre"
       & "l, AGS Script, SWIG, C++, Cuda, Edje Data Collection, Metal";
   K_4             : aliased constant String := "text/x-sas";
   M_4             : aliased constant String := "SAS";
   K_5             : aliased constant String := "text/x-ecl";
   M_5             : aliased constant String := "ECL";
   K_6             : aliased constant String := "text/x-textile";
   M_6             : aliased constant String := "Textile";
   K_7             : aliased constant String := "text/x-pascal";
   M_7             : aliased constant String := "Pascal, LigoLANG, Component Pascal";
   K_8             : aliased constant String := "text/x-lua";
   M_8             : aliased constant String := "Terra, Lua";
   K_9             : aliased constant String := "text/x-vhdl";
   M_9             : aliased constant String := "VHDL";
   K_10            : aliased constant String := "text/x-diff";
   M_10            : aliased constant String := "Diff";
   K_11            : aliased constant String := "text/x-tcl";
   M_11            : aliased constant String := "Glyph, Tcl";
   K_12            : aliased constant String := "application/json";
   M_12            : aliased constant String := "Ecere Projects, JSON, Jupyter Notebook, M"
       & "ax, OASv2-json, JSON5, JSONLD, JSONiq, OASv3-json";
   K_13            : aliased constant String := "text/x-eiffel";
   M_13            : aliased constant String := "Eiffel";
   K_14            : aliased constant String := "application/mbox";
   M_14            : aliased constant String := "E-mail";
   K_15            : aliased constant String := "message/http";
   M_15            : aliased constant String := "HTTP";
   K_16            : aliased constant String := "text/x-java";
   M_16            : aliased constant String := "Apex, UnrealScript, Java, ChucK";
   K_17            : aliased constant String := "text/x-scheme";
   M_17            : aliased constant String := "Nu, Janet, Scheme";
   K_18            : aliased constant String := "text/jsx";
   M_18            : aliased constant String := "Astro, TSX";
   K_19            : aliased constant String := "application/x-aspx";
   M_19            : aliased constant String := "ASP.NET";
   K_20            : aliased constant String := "text/x-sql";
   M_20            : aliased constant String := "SQLPL, PLpgSQL, SQL";
   K_21            : aliased constant String := "text/x-dylan";
   M_21            : aliased constant String := "Dylan";
   K_22            : aliased constant String := "text/x-systemverilog";
   M_22            : aliased constant String := "Bluespec, SystemVerilog";
   K_23            : aliased constant String := "text/x-rsrc";
   M_23            : aliased constant String := "R";
   K_24            : aliased constant String := "text/x-perl";
   M_24            : aliased constant String := "Perl, Raku, Pod";
   K_25            : aliased constant String := "text/x-octave";
   M_25            : aliased constant String := "MATLAB";
   K_26            : aliased constant String := "application/x-erb";
   M_26            : aliased constant String := "HTML+ERB";
   K_27            : aliased constant String := "text/x-objectivec";
   M_27            : aliased constant String := "Objective-C++, Objective-C";
   K_28            : aliased constant String := "application/dart";
   M_28            : aliased constant String := "Dart";
   K_29            : aliased constant String := "text/x-haskell";
   M_29            : aliased constant String := "Grammatical Framework, PureScript, C2hs H"
       & "askell, Bluespec BH, Cabal Config, Dhall, Haskell";
   K_30            : aliased constant String := "text/x-ocaml";
   M_30            : aliased constant String := "CameLIGO, OCaml, Standard ML";
   K_31            : aliased constant String := "text/x-scala";
   M_31            : aliased constant String := "Scala";
   K_32            : aliased constant String := "text/x-pug";
   M_32            : aliased constant String := "Pug";
   K_33            : aliased constant String := "text/x-brainfuck";
   M_33            : aliased constant String := "Brainfuck";
   K_34            : aliased constant String := "text/x-csharp";
   M_34            : aliased constant String := "Uno, Beef, C#, EQ";
   K_35            : aliased constant String := "text/x-sass";
   M_35            : aliased constant String := "Sass";
   K_36            : aliased constant String := "text/x-go";
   M_36            : aliased constant String := "Go, V";
   K_37            : aliased constant String := "text/x-properties";
   M_37            : aliased constant String := "Windows Registry Entries, INI, ShellCheck"
       & " Config, Simple File Verification, Java Properties, Win32 Message File"
       & ", TextMate Properties, EditorConfig, Record Jar, Git Config";
   K_38            : aliased constant String := "text/x-groovy";
   M_38            : aliased constant String := "Groovy";
   K_39            : aliased constant String := "application/x-powershell";
   M_39            : aliased constant String := "PowerShell";
   K_40            : aliased constant String := "application/pgp";
   M_40            : aliased constant String := "Public Key";
   K_41            : aliased constant String := "text/turtle";
   M_41            : aliased constant String := "Turtle";
   K_42            : aliased constant String := "application/sieve";
   M_42            : aliased constant String := "Sieve";
   K_43            : aliased constant String := "text/x-literate-haskell";
   M_43            : aliased constant String := "Literate Haskell";
   K_44            : aliased constant String := "text/x-protobuf";
   M_44            : aliased constant String := "Protocol Buffer";
   K_45            : aliased constant String := "text/x-oz";
   M_45            : aliased constant String := "Oz";
   K_46            : aliased constant String := "text/x-fortran";
   M_46            : aliased constant String := "Fortran Free Form, Fortran";
   K_47            : aliased constant String := "text/x-ebnf";
   M_47            : aliased constant String := "Lark, EBNF";
   K_48            : aliased constant String := "text/x-plsql";
   M_48            : aliased constant String := "PLSQL";
   K_49            : aliased constant String := "text/x-spreadsheet";
   M_49            : aliased constant String := "LTspice Symbol";
   K_50            : aliased constant String := "text/x-twig";
   M_50            : aliased constant String := "Twig";
   K_51            : aliased constant String := "text/x-factor";
   M_51            : aliased constant String := "Factor";
   K_52            : aliased constant String := "text/x-forth";
   M_52            : aliased constant String := "MUF, Forth";
   K_53            : aliased constant String := "text/x-rustsrc";
   M_53            : aliased constant String := "ReasonLIGO, Rust, Reason, ReScript, Sway";
   K_54            : aliased constant String := "text/x-mumps";
   M_54            : aliased constant String := "M";
   K_55            : aliased constant String := "text/x-rpm-spec";
   M_55            : aliased constant String := "RPM Spec";
   K_56            : aliased constant String := "text/x-crystal";
   M_56            : aliased constant String := "Crystal";
   K_57            : aliased constant String := "text/css";
   M_57            : aliased constant String := "Less, CSS, Cloud Firestore Security Rules";
   K_58            : aliased constant String := "text/velocity";
   M_58            : aliased constant String := "Velocity Template Language";
   K_59            : aliased constant String := "text/x-modelica";
   M_59            : aliased constant String := "Modelica";
   K_60            : aliased constant String := "text/xml";
   M_60            : aliased constant String := "XProc, XPages, COLLADA, Eagle, Maven POM,"
       & " JetBrains MPS, XML, Genshi, LabVIEW, XML Property List, SVG, XSLT";
   K_61            : aliased constant String := "application/sparql-query";
   M_61            : aliased constant String := "SPARQL";
   K_62            : aliased constant String := "text/x-gfm";
   M_62            : aliased constant String := "RMarkdown, MDX, Markdown";
   K_63            : aliased constant String := "text/x-smarty";
   M_63            : aliased constant String := "Mustache, Smarty, Latte";
   K_64            : aliased constant String := "application/xml";
   M_64            : aliased constant String := "Ant Build System";
   K_65            : aliased constant String := "text/mirc";
   M_65            : aliased constant String := "IRC log";
   K_66            : aliased constant String := "text/x-toml";
   M_66            : aliased constant String := "TOML";
   K_67            : aliased constant String := "text/x-common-lisp";
   M_67            : aliased constant String := "Emacs Lisp, NetLogo, NewLisp, WebAssembly"
       & ", KiCad Layout, SRecode Template, GCC Machine Description, Common Lisp"
       & ", LFE";
   K_68            : aliased constant String := "text/x-dockerfile";
   M_68            : aliased constant String := "Dockerfile";
   K_69            : aliased constant String := "text/vbscript";
   M_69            : aliased constant String := "VBScript";
   K_70            : aliased constant String := "text/x-haxe";
   M_70            : aliased constant String := "Haxe";
   K_71            : aliased constant String := "text/x-verilog";
   M_71            : aliased constant String := "Verilog";
   K_72            : aliased constant String := "text/x-rst";
   M_72            : aliased constant String := "reStructuredText";
   K_73            : aliased constant String := "text/x-clojure";
   M_73            : aliased constant String := "edn, Rouge, Clojure, wisp";
   K_74            : aliased constant String := "text/x-stex";
   M_74            : aliased constant String := "TeX, BibTeX";
   K_75            : aliased constant String := "text/x-fsharp";
   M_75            : aliased constant String := "F#";
   K_76            : aliased constant String := "text/x-stsrc";
   M_76            : aliased constant String := "Smalltalk";
   K_77            : aliased constant String := "text/x-haml";
   M_77            : aliased constant String := "Haml";
   K_78            : aliased constant String := "application/xquery";
   M_78            : aliased constant String := "XQuery";
   K_79            : aliased constant String := "text/x-julia";
   M_79            : aliased constant String := "Julia";
   K_80            : aliased constant String := "text/x-kotlin";
   M_80            : aliased constant String := "Kotlin, Asymptote";
   K_81            : aliased constant String := "text/x-ruby";
   M_81            : aliased constant String := "RBS, Ruby, HCL, Mirah, Terraform Template";
   K_82            : aliased constant String := "text/x-cython";
   M_82            : aliased constant String := "Cython";
   K_83            : aliased constant String := "text/x-erlang";
   M_83            : aliased constant String := "Erlang";
   K_84            : aliased constant String := "text/x-slim";
   M_84            : aliased constant String := "Slim";
   K_85            : aliased constant String := "text/x-django";
   M_85            : aliased constant String := "Jinja";
   K_86            : aliased constant String := "text/x-elm";
   M_86            : aliased constant String := "Elm";
   K_87            : aliased constant String := "text/html";
   M_87            : aliased constant String := "MTML, HTML+EEX, Bikeshed, HTML, Kit, HTML"
       & "+Razor, StringTemplate, Svelte, HTML+ECR, Ecmarkup, Marko";
   K_88            : aliased constant String := "text/x-swift";
   M_88            : aliased constant String := "Swift";
   K_89            : aliased constant String := "application/javascript";
   M_89            : aliased constant String := "Jest Snapshot, JavaScript+ERB";
   K_90            : aliased constant String := "text/troff";
   M_90            : aliased constant String := "Roff, Roff Manpage, Pic";
   K_91            : aliased constant String := "text/x-puppet";
   M_91            : aliased constant String := "Puppet";
   K_92            : aliased constant String := "text/x-vb";
   M_92            : aliased constant String := "VBA, FreeBasic, Visual Basic 6.0, Visual "
       & "Basic .NET";
   K_93            : aliased constant String := "text/x-webidl";
   M_93            : aliased constant String := "WebIDL, WebAssembly Interface Type";
   K_94            : aliased constant String := "text/x-csrc";
   M_94            : aliased constant String := "X BitMap, HolyC, XS, XC, OpenCL, X PixMap"
       & ", Smithy, NWScript, Monkey C, DTrace, C, GSC, Unified Parallel C";
   K_95            : aliased constant String := "text/x-yaml";
   M_95            : aliased constant String := "RAML, OASv2-yaml, Unity3D Asset, SaltStac"
       & "k, Kaitai Struct, DenizenScript, LookML, OASv3-yaml, Common Workflow L"
       & "anguage, MiniYAML, YAML";
   K_96            : aliased constant String := "text/x-ttcn-asn";
   M_96            : aliased constant String := "ASN.1";
   K_97            : aliased constant String := "text/x-cmake";
   M_97            : aliased constant String := "CMake, Makefile";
   K_98            : aliased constant String := "text/x-mathematica";
   M_98            : aliased constant String := "Mathematica";
   K_99            : aliased constant String := "text/x-nginx-conf";
   M_99            : aliased constant String := "Nginx";
   K_100           : aliased constant String := "text/javascript";
   M_100           : aliased constant String := "PEG.js, Cycript, JSON with Comments, Qt S"
       & "cript, JavaScript";
   K_101           : aliased constant String := "application/x-jsp";
   M_101           : aliased constant String := "Java Server Pages, Groovy Server Pages";
   K_102           : aliased constant String := "text/x-idl";
   M_102           : aliased constant String := "IDL";
   K_103           : aliased constant String := "text/x-d";
   M_103           : aliased constant String := "Volt, D";
   K_104           : aliased constant String := "application/x-httpd-php";
   M_104           : aliased constant String := "HTML+PHP, Hack, PHP";
   K_105           : aliased constant String := "text/x-scss";
   M_105           : aliased constant String := "SCSS";
   K_106           : aliased constant String := "text/x-sh";
   M_106           : aliased constant String := "OpenRC runscript, ShellSession, Ignore Li"
       & "st, Nushell, Tcsh, Alpine Abuild, Gentoo Ebuild, Option List, Gentoo E"
       & "class, Shell, Git Attributes";
   K_107           : aliased constant String := "application/typescript";
   M_107           : aliased constant String := "TypeScript";
   K_108           : aliased constant String := "text/x-soy";
   M_108           : aliased constant String := "Closure Templates";
   K_109           : aliased constant String := "text/x-nsis";
   M_109           : aliased constant String := "NSIS";
   K_110           : aliased constant String := "text/x-python";
   M_110           : aliased constant String := "NumPy, Starlark, GN, Mojo, Xonsh, Sage, S"
       & "nakemake, Easybuild, Python";
   K_111           : aliased constant String := "text/x-livescript";
   M_111           : aliased constant String := "LiveScript";

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
      K_108'Access, K_109'Access, K_110'Access, K_111'Access);

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
      M_108'Access, M_109'Access, M_110'Access, M_111'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.MimeMap;
