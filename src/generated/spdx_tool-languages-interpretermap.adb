--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Interpreter mapping generated from interpreters.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.InterpreterMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 5) of Natural :=
     (1, 2, 3, 4, 5, 7);

   T1 : constant array (0 .. 5) of Unsigned_16 :=
     (66, 37, 192, 291, 268, 194);

   T2 : constant array (0 .. 5) of Unsigned_16 :=
     (212, 169, 30, 210, 102, 40);

   G : constant array (0 .. 300) of Unsigned_8 :=
     (0, 91, 0, 0, 44, 54, 18, 0, 64, 0, 123, 0, 138, 0, 0, 12, 0, 0, 0, 0,
      0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 137, 109, 0, 0, 0, 6, 0, 0, 0, 107,
      0, 0, 0, 0, 101, 22, 0, 0, 42, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0, 1, 0,
      75, 0, 0, 143, 0, 62, 106, 122, 0, 72, 111, 29, 47, 0, 97, 0, 5, 0, 0,
      60, 0, 77, 0, 67, 107, 7, 84, 115, 0, 82, 1, 0, 57, 125, 0, 0, 0, 37,
      12, 0, 106, 0, 30, 29, 0, 69, 0, 94, 5, 0, 0, 143, 141, 85, 0, 45, 32,
      0, 0, 20, 120, 0, 86, 0, 48, 58, 129, 0, 121, 56, 0, 56, 0, 108, 0,
      11, 0, 0, 0, 81, 0, 0, 21, 25, 94, 0, 0, 0, 60, 18, 5, 47, 0, 0, 0,
      22, 0, 0, 21, 68, 0, 23, 108, 69, 0, 7, 0, 75, 0, 0, 0, 83, 0, 0, 5,
      70, 0, 56, 0, 48, 100, 0, 0, 0, 0, 56, 50, 0, 0, 127, 0, 0, 132, 0, 0,
      0, 0, 112, 0, 69, 54, 0, 52, 0, 121, 29, 64, 46, 0, 5, 0, 135, 13, 95,
      85, 80, 0, 91, 46, 0, 3, 0, 61, 0, 0, 0, 7, 28, 0, 83, 0, 0, 109, 9,
      23, 0, 0, 0, 2, 40, 0, 118, 58, 55, 0, 86, 113, 148, 0, 0, 0, 0, 0, 0,
      131, 26, 38, 61, 53, 0, 149, 47, 106, 54, 98, 15, 0, 0, 136, 88, 0, 0,
      0, 32, 21, 74, 0, 85, 0, 33, 47, 148, 0, 96, 131, 40, 0, 0, 0, 95, 14,
      100, 0, 0, 0, 0, 0, 108, 0);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 301;
         F2 := (F2 + Natural (T2 (K)) * J) mod 301;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 150;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "tclsh";
   M_0             : aliased constant String := "Tcl";
   K_1             : aliased constant String := "M2";
   M_1             : aliased constant String := "Macaulay2";
   K_2             : aliased constant String := "regina";
   M_2             : aliased constant String := "REXX";
   K_3             : aliased constant String := "mathsat5";
   M_3             : aliased constant String := "SMT";
   K_4             : aliased constant String := "gnuplot";
   M_4             : aliased constant String := "Gnuplot";
   K_5             : aliased constant String := "jqq";
   M_5             : aliased constant String := "jq";
   K_6             : aliased constant String := "tcsh";
   M_6             : aliased constant String := "Tcsh";
   K_7             : aliased constant String := "v8";
   M_7             : aliased constant String := "JavaScript";
   K_8             : aliased constant String := "ash";
   M_8             : aliased constant String := "Shell";
   K_9             : aliased constant String := "rust-script";
   M_9             : aliased constant String := "Rust";
   K_10            : aliased constant String := "jruby";
   M_10            : aliased constant String := "Ruby";
   K_11            : aliased constant String := "ssed";
   M_11            : aliased constant String := "sed";
   K_12            : aliased constant String := "ksh";
   M_12            : aliased constant String := "Shell";
   K_13            : aliased constant String := "smtinterpol";
   M_13            : aliased constant String := "SMT";
   K_14            : aliased constant String := "rexx";
   M_14            : aliased constant String := "REXX";
   K_15            : aliased constant String := "gosh";
   M_15            : aliased constant String := "Scheme";
   K_16            : aliased constant String := "asy";
   M_16            : aliased constant String := "Asymptote";
   K_17            : aliased constant String := "zsh";
   M_17            : aliased constant String := "Shell";
   K_18            : aliased constant String := "nu";
   M_18            : aliased constant String := "Nushell";
   K_19            : aliased constant String := "ecl";
   M_19            : aliased constant String := "Common Lisp";
   K_20            : aliased constant String := "nush";
   M_20            : aliased constant String := "Nu";
   K_21            : aliased constant String := "dyalog";
   M_21            : aliased constant String := "APL";
   K_22            : aliased constant String := "tcc";
   M_22            : aliased constant String := "C";
   K_23            : aliased constant String := "php";
   M_23            : aliased constant String := "PHP";
   K_24            : aliased constant String := "make";
   M_24            : aliased constant String := "Makefile";
   K_25            : aliased constant String := "fennel";
   M_25            : aliased constant String := "Fennel";
   K_26            : aliased constant String := "lua";
   M_26            : aliased constant String := "Terra, Lua";
   K_27            : aliased constant String := "aplx";
   M_27            : aliased constant String := "APL";
   K_28            : aliased constant String := "stp";
   M_28            : aliased constant String := "SMT";
   K_29            : aliased constant String := "openrc-run";
   M_29            : aliased constant String := "OpenRC runscript";
   K_30            : aliased constant String := "apl";
   M_30            : aliased constant String := "APL";
   K_31            : aliased constant String := "bigloo";
   M_31            : aliased constant String := "Scheme";
   K_32            : aliased constant String := "dash";
   M_32            : aliased constant String := "Shell";
   K_33            : aliased constant String := "rakudo";
   M_33            : aliased constant String := "Raku";
   K_34            : aliased constant String := "nodejs";
   M_34            : aliased constant String := "JavaScript";
   K_35            : aliased constant String := "sbcl";
   M_35            : aliased constant String := "Common Lisp";
   K_36            : aliased constant String := "gjs";
   M_36            : aliased constant String := "JavaScript";
   K_37            : aliased constant String := "minised";
   M_37            : aliased constant String := "sed";
   K_38            : aliased constant String := "newlisp";
   M_38            : aliased constant String := "NewLisp";
   K_39            : aliased constant String := "pike";
   M_39            : aliased constant String := "Pike";
   K_40            : aliased constant String := "mksh";
   M_40            : aliased constant String := "Shell";
   K_41            : aliased constant String := "makeinfo";
   M_41            : aliased constant String := "Texinfo";
   K_42            : aliased constant String := "qjs";
   M_42            : aliased constant String := "JavaScript";
   K_43            : aliased constant String := "janet";
   M_43            : aliased constant String := "Janet";
   K_44            : aliased constant String := "deno";
   M_44            : aliased constant String := "TypeScript";
   K_45            : aliased constant String := "sh";
   M_45            : aliased constant String := "Shell";
   K_46            : aliased constant String := "pypy";
   M_46            : aliased constant String := "Python";
   K_47            : aliased constant String := "python";
   M_47            : aliased constant String := "Python";
   K_48            : aliased constant String := "perl6";
   M_48            : aliased constant String := "Raku, Pod 6";
   K_49            : aliased constant String := "swipl";
   M_49            : aliased constant String := "Prolog";
   K_50            : aliased constant String := "nextflow";
   M_50            : aliased constant String := "Nextflow";
   K_51            : aliased constant String := "chicken";
   M_51            : aliased constant String := "Scheme";
   K_52            : aliased constant String := "hy";
   M_52            : aliased constant String := "Hy";
   K_53            : aliased constant String := "v8-shell";
   M_53            : aliased constant String := "JavaScript";
   K_54            : aliased constant String := "pdksh";
   M_54            : aliased constant String := "Shell";
   K_55            : aliased constant String := "fish";
   M_55            : aliased constant String := "fish";
   K_56            : aliased constant String := "gerbview";
   M_56            : aliased constant String := "Gerber Image";
   K_57            : aliased constant String := "py";
   M_57            : aliased constant String := "Python";
   K_58            : aliased constant String := "cperl";
   M_58            : aliased constant String := "Perl";
   K_59            : aliased constant String := "gsed";
   M_59            : aliased constant String := "sed";
   K_60            : aliased constant String := "gojq";
   M_60            : aliased constant String := "jq";
   K_61            : aliased constant String := "gawk";
   M_61            : aliased constant String := "Awk";
   K_62            : aliased constant String := "bash";
   M_62            : aliased constant String := "Shell";
   K_63            : aliased constant String := "aidl";
   M_63            : aliased constant String := "AIDL";
   K_64            : aliased constant String := "scsynth";
   M_64            : aliased constant String := "SuperCollider";
   K_65            : aliased constant String := "python2";
   M_65            : aliased constant String := "Python";
   K_66            : aliased constant String := "python3";
   M_66            : aliased constant String := "Python";
   K_67            : aliased constant String := "parrot";
   M_67            : aliased constant String := "Parrot Internal Representation, Parrot As"
       & "sembly";
   K_68            : aliased constant String := "bb";
   M_68            : aliased constant String := "Clojure";
   K_69            : aliased constant String := "perl";
   M_69            : aliased constant String := "Perl, Pod";
   K_70            : aliased constant String := "qmake";
   M_70            : aliased constant String := "QMake";
   K_71            : aliased constant String := "yices2";
   M_71            : aliased constant String := "SMT";
   K_72            : aliased constant String := "boogie";
   M_72            : aliased constant String := "Boogie";
   K_73            : aliased constant String := "sclang";
   M_73            : aliased constant String := "SuperCollider";
   K_74            : aliased constant String := "ocaml";
   M_74            : aliased constant String := "OCaml, ReScript";
   K_75            : aliased constant String := "jconsole";
   M_75            : aliased constant String := "J";
   K_76            : aliased constant String := "dafny";
   M_76            : aliased constant String := "Dafny";
   K_77            : aliased constant String := "scheme";
   M_77            : aliased constant String := "Scheme";
   K_78            : aliased constant String := "chakra";
   M_78            : aliased constant String := "JavaScript";
   K_79            : aliased constant String := "RouterOS";
   M_79            : aliased constant String := "RouterOS Script";
   K_80            : aliased constant String := "rhino";
   M_80            : aliased constant String := "JavaScript";
   K_81            : aliased constant String := "scala";
   M_81            : aliased constant String := "Scala";
   K_82            : aliased constant String := "scenic";
   M_82            : aliased constant String := "Scenic";
   K_83            : aliased constant String := "ccl";
   M_83            : aliased constant String := "Common Lisp";
   K_84            : aliased constant String := "elvish";
   M_84            : aliased constant String := "Elvish";
   K_85            : aliased constant String := "pwsh";
   M_85            : aliased constant String := "PowerShell";
   K_86            : aliased constant String := "rune";
   M_86            : aliased constant String := "E";
   K_87            : aliased constant String := "ocamlrun";
   M_87            : aliased constant String := "OCaml";
   K_88            : aliased constant String := "wish";
   M_88            : aliased constant String := "Tcl";
   K_89            : aliased constant String := "eui";
   M_89            : aliased constant String := "Euphoria";
   K_90            : aliased constant String := "instantfpc";
   M_90            : aliased constant String := "Pascal";
   K_91            : aliased constant String := "ocamlscript";
   M_91            : aliased constant String := "OCaml";
   K_92            : aliased constant String := "runghc";
   M_92            : aliased constant String := "Haskell";
   K_93            : aliased constant String := "z3";
   M_93            : aliased constant String := "SMT";
   K_94            : aliased constant String := "jq";
   M_94            : aliased constant String := "jq";
   K_95            : aliased constant String := "dart";
   M_95            : aliased constant String := "Dart";
   K_96            : aliased constant String := "r6rs";
   M_96            : aliased constant String := "Scheme";
   K_97            : aliased constant String := "js";
   M_97            : aliased constant String := "JavaScript";
   K_98            : aliased constant String := "rake";
   M_98            : aliased constant String := "Ruby";
   K_99            : aliased constant String := "jolie";
   M_99            : aliased constant String := "Jolie";
   K_100           : aliased constant String := "gerbv";
   M_100           : aliased constant String := "Gerber Image";
   K_101           : aliased constant String := "verit";
   M_101           : aliased constant String := "SMT";
   K_102           : aliased constant String := "sed";
   M_102           : aliased constant String := "sed";
   K_103           : aliased constant String := "awk";
   M_103           : aliased constant String := "Awk";
   K_104           : aliased constant String := "runhaskell";
   M_104           : aliased constant String := "Haskell";
   K_105           : aliased constant String := "d8";
   M_105           : aliased constant String := "JavaScript";
   K_106           : aliased constant String := "rc";
   M_106           : aliased constant String := "Shell";
   K_107           : aliased constant String := "raku";
   M_107           : aliased constant String := "Raku";
   K_108           : aliased constant String := "nawk";
   M_108           : aliased constant String := "Awk";
   K_109           : aliased constant String := "groovy";
   M_109           : aliased constant String := "Groovy";
   K_110           : aliased constant String := "gn";
   M_110           : aliased constant String := "GN";
   K_111           : aliased constant String := "elixir";
   M_111           : aliased constant String := "Elixir";
   K_112           : aliased constant String := "csh";
   M_112           : aliased constant String := "Tcsh";
   K_113           : aliased constant String := "jqjq";
   M_113           : aliased constant String := "jq";
   K_114           : aliased constant String := "csi";
   M_114           : aliased constant String := "Scheme";
   K_115           : aliased constant String := "clisp";
   M_115           : aliased constant String := "Common Lisp";
   K_116           : aliased constant String := "racket";
   M_116           : aliased constant String := "Racket";
   K_117           : aliased constant String := "pil";
   M_117           : aliased constant String := "PicoLisp";
   K_118           : aliased constant String := "lisp";
   M_118           : aliased constant String := "Common Lisp";
   K_119           : aliased constant String := "mawk";
   M_119           : aliased constant String := "Awk";
   K_120           : aliased constant String := "ioke";
   M_120           : aliased constant String := "Ioke";
   K_121           : aliased constant String := "pypy3";
   M_121           : aliased constant String := "Python";
   K_122           : aliased constant String := "node";
   M_122           : aliased constant String := "JavaScript";
   K_123           : aliased constant String := "escript";
   M_123           : aliased constant String := "Erlang";
   K_124           : aliased constant String := "macruby";
   M_124           : aliased constant String := "Ruby";
   K_125           : aliased constant String := "euiw";
   M_125           : aliased constant String := "Euphoria";
   K_126           : aliased constant String := "Rscript";
   M_126           : aliased constant String := "R";
   K_127           : aliased constant String := "cvc4";
   M_127           : aliased constant String := "SMT";
   K_128           : aliased constant String := "opensmt";
   M_128           : aliased constant String := "SMT";
   K_129           : aliased constant String := "crystal";
   M_129           : aliased constant String := "Crystal";
   K_130           : aliased constant String := "osascript";
   M_130           : aliased constant String := "AppleScript";
   K_131           : aliased constant String := "cwl-runner";
   M_131           : aliased constant String := "Common Workflow Language";
   K_132           : aliased constant String := "jaq";
   M_132           : aliased constant String := "jq";
   K_133           : aliased constant String := "mmi";
   M_133           : aliased constant String := "Mercury";
   K_134           : aliased constant String := "moon";
   M_134           : aliased constant String := "MoonScript";
   K_135           : aliased constant String := "lsl";
   M_135           : aliased constant String := "LSL";
   K_136           : aliased constant String := "yap";
   M_136           : aliased constant String := "Prolog";
   K_137           : aliased constant String := "ts-node";
   M_137           : aliased constant String := "TypeScript";
   K_138           : aliased constant String := "boolector";
   M_138           : aliased constant String := "SMT";
   K_139           : aliased constant String := "picolisp";
   M_139           : aliased constant String := "PicoLisp";
   K_140           : aliased constant String := "coffee";
   M_140           : aliased constant String := "CoffeeScript";
   K_141           : aliased constant String := "runhugs";
   M_141           : aliased constant String := "Haskell";
   K_142           : aliased constant String := "smt-rat";
   M_142           : aliased constant String := "SMT";
   K_143           : aliased constant String := "julia";
   M_143           : aliased constant String := "Julia";
   K_144           : aliased constant String := "guile";
   M_144           : aliased constant String := "Scheme";
   K_145           : aliased constant String := "query-json";
   M_145           : aliased constant String := "jq";
   K_146           : aliased constant String := "io";
   M_146           : aliased constant String := "Io";
   K_147           : aliased constant String := "rbx";
   M_147           : aliased constant String := "Ruby";
   K_148           : aliased constant String := "dtrace";
   M_148           : aliased constant String := "DTrace";
   K_149           : aliased constant String := "ruby";
   M_149           : aliased constant String := "Ruby";

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
      K_148'Access, K_149'Access);

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
      M_148'Access, M_149'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.InterpreterMap;
