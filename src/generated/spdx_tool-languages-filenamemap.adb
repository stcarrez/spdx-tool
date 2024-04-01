--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Extensions mapping generated from extensions.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.FilenameMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 10) of Natural :=
     (1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 17);

   T1 : constant array (0 .. 10) of Unsigned_16 :=
     (394, 606, 549, 340, 277, 111, 218, 41, 444, 497, 507);

   T2 : constant array (0 .. 10) of Unsigned_16 :=
     (222, 475, 561, 494, 703, 28, 110, 20, 100, 356, 306);

   G : constant array (0 .. 722) of Unsigned_16 :=
     (0, 0, 160, 77, 121, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 318, 0, 133,
      0, 0, 0, 0, 0, 0, 0, 0, 109, 105, 165, 0, 0, 0, 0, 0, 0, 0, 0, 196, 0,
      0, 0, 0, 0, 0, 185, 192, 0, 0, 251, 0, 0, 0, 0, 152, 0, 181, 166, 108,
      0, 0, 222, 0, 92, 14, 0, 129, 21, 0, 56, 0, 224, 0, 151, 0, 0, 0, 0,
      186, 0, 0, 213, 270, 0, 0, 0, 0, 0, 56, 0, 233, 241, 79, 0, 175, 0, 0,
      116, 177, 282, 291, 38, 0, 0, 0, 236, 232, 0, 176, 0, 300, 336, 0,
      118, 192, 211, 83, 0, 0, 266, 0, 325, 0, 0, 0, 42, 251, 0, 30, 18, 0,
      345, 0, 0, 0, 0, 14, 77, 0, 80, 230, 343, 0, 0, 0, 0, 0, 356, 0, 156,
      243, 0, 0, 131, 17, 0, 0, 204, 0, 0, 0, 158, 0, 201, 0, 0, 99, 0, 207,
      258, 0, 0, 0, 0, 15, 0, 41, 0, 149, 0, 113, 79, 77, 74, 104, 265, 297,
      0, 0, 0, 0, 0, 126, 0, 0, 0, 0, 115, 356, 0, 0, 0, 0, 260, 17, 78, 71,
      0, 0, 0, 0, 0, 119, 0, 81, 0, 0, 0, 0, 106, 0, 0, 0, 0, 155, 0, 0,
      104, 256, 50, 115, 81, 28, 213, 0, 27, 0, 0, 0, 0, 79, 0, 285, 222,
      80, 0, 251, 333, 0, 0, 0, 0, 0, 0, 0, 163, 332, 0, 0, 0, 298, 0, 201,
      80, 131, 179, 353, 0, 58, 141, 0, 0, 354, 29, 222, 0, 259, 16, 316,
      23, 83, 31, 112, 0, 0, 349, 259, 0, 0, 0, 81, 92, 0, 335, 190, 236,
      206, 0, 144, 0, 178, 0, 99, 0, 0, 0, 0, 285, 171, 199, 0, 197, 332, 0,
      0, 87, 0, 0, 128, 0, 0, 76, 8, 337, 128, 0, 205, 304, 0, 292, 0, 111,
      271, 0, 90, 0, 36, 346, 89, 64, 111, 0, 74, 283, 303, 0, 82, 0, 0, 28,
      2, 0, 0, 0, 0, 0, 0, 0, 66, 0, 102, 200, 0, 0, 0, 0, 62, 247, 0, 0,
      14, 340, 0, 268, 135, 0, 0, 155, 0, 0, 22, 0, 0, 0, 0, 0, 0, 136, 0,
      328, 41, 29, 0, 0, 0, 0, 98, 193, 0, 253, 204, 0, 7, 234, 0, 12, 43,
      288, 0, 0, 0, 63, 12, 0, 235, 0, 0, 304, 3, 74, 0, 70, 0, 295, 197,
      37, 0, 0, 0, 0, 0, 0, 0, 9, 360, 2, 1, 0, 0, 240, 313, 0, 0, 0, 163,
      50, 0, 231, 154, 201, 344, 321, 341, 19, 0, 0, 0, 0, 143, 58, 0, 203,
      317, 352, 0, 0, 6, 183, 174, 178, 336, 0, 0, 0, 0, 192, 0, 193, 0,
      288, 0, 206, 0, 0, 53, 217, 0, 0, 0, 203, 258, 337, 0, 0, 0, 305, 0,
      0, 0, 188, 16, 171, 28, 0, 0, 38, 323, 31, 0, 0, 11, 21, 356, 290,
      302, 120, 0, 106, 326, 0, 0, 0, 170, 277, 0, 0, 193, 0, 0, 0, 0, 0,
      359, 50, 84, 54, 0, 0, 13, 0, 0, 0, 0, 0, 28, 0, 0, 302, 205, 65, 0,
      33, 122, 0, 125, 0, 228, 40, 172, 292, 0, 152, 301, 0, 0, 0, 119, 74,
      113, 215, 280, 0, 0, 103, 0, 0, 46, 5, 130, 277, 0, 284, 68, 260, 0,
      320, 0, 293, 62, 49, 0, 59, 0, 0, 10, 127, 0, 334, 49, 0, 88, 279,
      223, 0, 0, 0, 0, 79, 0, 246, 0, 332, 187, 247, 247, 350, 0, 0, 150, 0,
      4, 0, 0, 136, 123, 43, 0, 33, 102, 85, 44, 202, 0, 51, 265, 274, 235,
      0, 281, 0, 0, 199, 0, 246, 0, 0, 119, 0, 72, 287, 130, 31, 209, 263,
      137, 122, 0, 270, 0, 0, 0, 0, 0, 186, 216, 0, 0, 77, 294, 319, 0, 342,
      0, 0, 167, 0, 0, 0, 40, 66, 125, 0, 0, 61, 0, 0, 20, 278, 0, 28, 0,
      352, 153, 275, 303, 25, 0, 240, 0, 0, 134, 0, 100, 0, 0, 0, 348, 45,
      73, 154, 0, 17, 243, 0, 0, 0, 0, 322, 93, 259, 345, 0);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 723;
         F2 := (F2 + Natural (T2 (K)) * J) mod 723;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 361;
   end Hash;


   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := ".vimrc";
   M_0             : aliased constant String := "Vim Script";
   K_1             : aliased constant String := "fonts.alias";
   M_1             : aliased constant String := "X Font Directory Index";
   K_2             : aliased constant String := "packages.config";
   M_2             : aliased constant String := "XML";
   K_3             : aliased constant String := "mix.lock";
   M_3             : aliased constant String := "Elixir";
   K_4             : aliased constant String := ".kshrc";
   M_4             : aliased constant String := "Shell";
   K_5             : aliased constant String := "BUILD";
   M_5             : aliased constant String := "Starlark";
   K_6             : aliased constant String := ".editorconfig";
   M_6             : aliased constant String := "EditorConfig";
   K_7             : aliased constant String := ".vscodeignore";
   M_7             : aliased constant String := "Ignore List";
   K_8             : aliased constant String := "App.config";
   M_8             : aliased constant String := "XML";
   K_9             : aliased constant String := ".bzrignore";
   M_9             : aliased constant String := "Ignore List";
   K_10            : aliased constant String := ".gitignore";
   M_10            : aliased constant String := "Ignore List";
   K_11            : aliased constant String := "go.work.sum";
   M_11            : aliased constant String := "Go Checksums";
   K_12            : aliased constant String := "inputrc";
   M_12            : aliased constant String := "Readline Config";
   K_13            : aliased constant String := "language-configuration.json";
   M_13            : aliased constant String := "JSON with Comments";
   K_14            : aliased constant String := ".emacs.desktop";
   M_14            : aliased constant String := "Emacs Lisp";
   K_15            : aliased constant String := "mocha.opts";
   M_15            : aliased constant String := "Option List";
   K_16            : aliased constant String := "SConscript";
   M_16            : aliased constant String := "Python";
   K_17            : aliased constant String := "APKBUILD";
   M_17            : aliased constant String := "Alpine Abuild";
   K_18            : aliased constant String := ".npmignore";
   M_18            : aliased constant String := "Ignore List";
   K_19            : aliased constant String := "README.nss";
   M_19            : aliased constant String := "Text";
   K_20            : aliased constant String := "initial_sids";
   M_20            : aliased constant String := "SELinux Policy";
   K_21            : aliased constant String := "_emacs";
   M_21            : aliased constant String := "Emacs Lisp";
   K_22            : aliased constant String := "genfs_contexts";
   M_22            : aliased constant String := "SELinux Policy";
   K_23            : aliased constant String := ".env.staging";
   M_23            : aliased constant String := "Dotenv";
   K_24            : aliased constant String := "Settings.StyleCop";
   M_24            : aliased constant String := "XML";
   K_25            : aliased constant String := "Kbuild";
   M_25            : aliased constant String := "Makefile";
   K_26            : aliased constant String := ".coveragerc";
   M_26            : aliased constant String := "INI";
   K_27            : aliased constant String := "pdm.lock";
   M_27            : aliased constant String := "TOML";
   K_28            : aliased constant String := "ant.xml";
   M_28            : aliased constant String := "Ant Build System";
   K_29            : aliased constant String := ".curlrc";
   M_29            : aliased constant String := "cURL Config";
   K_30            : aliased constant String := "file_contexts";
   M_30            : aliased constant String := "SELinux Policy";
   K_31            : aliased constant String := "troffrc-end";
   M_31            : aliased constant String := "Roff";
   K_32            : aliased constant String := "tmux.conf";
   M_32            : aliased constant String := "Shell";
   K_33            : aliased constant String := "GNUmakefile";
   M_33            : aliased constant String := "Makefile";
   K_34            : aliased constant String := "build.xml";
   M_34            : aliased constant String := "Ant Build System";
   K_35            : aliased constant String := ".vercelignore";
   M_35            : aliased constant String := "Ignore List";
   K_36            : aliased constant String := "Justfile";
   M_36            : aliased constant String := "Just";
   K_37            : aliased constant String := "README.mysql";
   M_37            : aliased constant String := "Text";
   K_38            : aliased constant String := ".all-contributorsrc";
   M_38            : aliased constant String := "JSON";
   K_39            : aliased constant String := ".env.production";
   M_39            : aliased constant String := "Dotenv";
   K_40            : aliased constant String := ".login";
   M_40            : aliased constant String := "Shell";
   K_41            : aliased constant String := "Emakefile";
   M_41            : aliased constant String := "Erlang";
   K_42            : aliased constant String := "security_classes";
   M_42            : aliased constant String := "SELinux Policy";
   K_43            : aliased constant String := ".bash_profile";
   M_43            : aliased constant String := "Shell";
   K_44            : aliased constant String := ".tmux.conf";
   M_44            : aliased constant String := "Shell";
   K_45            : aliased constant String := "api-extractor.json";
   M_45            : aliased constant String := "JSON with Comments";
   K_46            : aliased constant String := "readme.1st";
   M_46            : aliased constant String := "Text";
   K_47            : aliased constant String := "Android.bp";
   M_47            : aliased constant String := "Soong";
   K_48            : aliased constant String := "expr-dist";
   M_48            : aliased constant String := "R";
   K_49            : aliased constant String := "click.me";
   M_49            : aliased constant String := "Text";
   K_50            : aliased constant String := "Rexfile";
   M_50            : aliased constant String := "Perl";
   K_51            : aliased constant String := ".php";
   M_51            : aliased constant String := "PHP";
   K_52            : aliased constant String := "go.mod";
   M_52            : aliased constant String := "Go Module";
   K_53            : aliased constant String := "cpanfile";
   M_53            : aliased constant String := "Perl";
   K_54            : aliased constant String := ".env";
   M_54            : aliased constant String := "Dotenv";
   K_55            : aliased constant String := ".env.example";
   M_55            : aliased constant String := "Dotenv";
   K_56            : aliased constant String := "firestore.rules";
   M_56            : aliased constant String := "Cloud Firestore Security Rules";
   K_57            : aliased constant String := ".gvimrc";
   M_57            : aliased constant String := "Vim Script";
   K_58            : aliased constant String := "Brewfile";
   M_58            : aliased constant String := "Ruby";
   K_59            : aliased constant String := ".nanorc";
   M_59            : aliased constant String := "nanorc";
   K_60            : aliased constant String := "Makefile";
   M_60            : aliased constant String := "Makefile";
   K_61            : aliased constant String := "tslint.json";
   M_61            : aliased constant String := "JSON with Comments";
   K_62            : aliased constant String := "bashrc";
   M_62            : aliased constant String := "Shell";
   K_63            : aliased constant String := ".viper";
   M_63            : aliased constant String := "Emacs Lisp";
   K_64            : aliased constant String := "COPYRIGHT.regex";
   M_64            : aliased constant String := "Text";
   K_65            : aliased constant String := "kakrc";
   M_65            : aliased constant String := "KakouneScript";
   K_66            : aliased constant String := "delete.me";
   M_66            : aliased constant String := "Text";
   K_67            : aliased constant String := "Jakefile";
   M_67            : aliased constant String := "JavaScript";
   K_68            : aliased constant String := ".yardopts";
   M_68            : aliased constant String := "Option List";
   K_69            : aliased constant String := "fp-lib-table";
   M_69            : aliased constant String := "KiCad Layout";
   K_70            : aliased constant String := ".bash_functions";
   M_70            : aliased constant String := "Shell";
   K_71            : aliased constant String := ".babelignore";
   M_71            : aliased constant String := "Ignore List";
   K_72            : aliased constant String := "go.work";
   M_72            : aliased constant String := "Go Workspace";
   K_73            : aliased constant String := "riemann.config";
   M_73            : aliased constant String := "Clojure";
   K_74            : aliased constant String := ".jshintrc";
   M_74            : aliased constant String := "JSON with Comments";
   K_75            : aliased constant String := "package.use.stable.mask";
   M_75            : aliased constant String := "Text";
   K_76            : aliased constant String := "deno.lock";
   M_76            : aliased constant String := "JSON";
   K_77            : aliased constant String := "JUSTFILE";
   M_77            : aliased constant String := "Just";
   K_78            : aliased constant String := "justfile";
   M_78            : aliased constant String := "Just";
   K_79            : aliased constant String := ".flaskenv";
   M_79            : aliased constant String := "Shell";
   K_80            : aliased constant String := "FONTLOG";
   M_80            : aliased constant String := "Text";
   K_81            : aliased constant String := "language-subtag-registry.txt";
   M_81            : aliased constant String := "Record Jar";
   K_82            : aliased constant String := "installscript.qs";
   M_82            : aliased constant String := "Qt Script";
   K_83            : aliased constant String := ".imgbotconfig";
   M_83            : aliased constant String := "JSON";
   K_84            : aliased constant String := ".htaccess";
   M_84            : aliased constant String := "ApacheConf";
   K_85            : aliased constant String := ".cvsignore";
   M_85            : aliased constant String := "Ignore List";
   K_86            : aliased constant String := ".zlogin";
   M_86            : aliased constant String := "Shell";
   K_87            : aliased constant String := "SHA1SUMS";
   M_87            : aliased constant String := "Checksums";
   K_88            : aliased constant String := ".cproject";
   M_88            : aliased constant String := "XML";
   K_89            : aliased constant String := ".stylelintignore";
   M_89            : aliased constant String := "Ignore List";
   K_90            : aliased constant String := ".wgetrc";
   M_90            : aliased constant String := "Wget Config";
   K_91            : aliased constant String := "SHA256SUMS";
   M_91            : aliased constant String := "Checksums";
   K_92            : aliased constant String := "Web.Release.config";
   M_92            : aliased constant String := "XML";
   K_93            : aliased constant String := "CMakeLists.txt";
   M_93            : aliased constant String := "CMake";
   K_94            : aliased constant String := "gitignore_global";
   M_94            : aliased constant String := "Ignore List";
   K_95            : aliased constant String := "Dockerfile";
   M_95            : aliased constant String := "Dockerfile";
   K_96            : aliased constant String := "ackrc";
   M_96            : aliased constant String := "Option List";
   K_97            : aliased constant String := "Makefile.am";
   M_97            : aliased constant String := "Makefile";
   K_98            : aliased constant String := "man";
   M_98            : aliased constant String := "Shell";
   K_99            : aliased constant String := "LICENSE.mysql";
   M_99            : aliased constant String := "Text";
   K_100           : aliased constant String := "abbrev_defs";
   M_100           : aliased constant String := "Emacs Lisp";
   K_101           : aliased constant String := "nvimrc";
   M_101           : aliased constant String := "Vim Script";
   K_102           : aliased constant String := "NEWS";
   M_102           : aliased constant String := "Text";
   K_103           : aliased constant String := "SConstruct";
   M_103           : aliased constant String := "Python";
   K_104           : aliased constant String := "yarn.lock";
   M_104           : aliased constant String := "YAML";
   K_105           : aliased constant String := "makefile";
   M_105           : aliased constant String := "Makefile";
   K_106           : aliased constant String := "Snakefile";
   M_106           : aliased constant String := "Snakemake";
   K_107           : aliased constant String := "Appraisals";
   M_107           : aliased constant String := "Ruby";
   K_108           : aliased constant String := ".watchmanconfig";
   M_108           : aliased constant String := "JSON";
   K_109           : aliased constant String := "buildfile";
   M_109           : aliased constant String := "Ruby";
   K_110           : aliased constant String := "CITATIONS";
   M_110           : aliased constant String := "Text";
   K_111           : aliased constant String := "haproxy.cfg";
   M_111           : aliased constant String := "HAProxy";
   K_112           : aliased constant String := "nim.cfg";
   M_112           : aliased constant String := "Nim";
   K_113           : aliased constant String := "WORKSPACE";
   M_113           : aliased constant String := "Starlark";
   K_114           : aliased constant String := ".prettierignore";
   M_114           : aliased constant String := "Ignore List";
   K_115           : aliased constant String := ".dircolors";
   M_115           : aliased constant String := "dircolors";
   K_116           : aliased constant String := "Puppetfile";
   M_116           : aliased constant String := "Ruby";
   K_117           : aliased constant String := ".jslintrc";
   M_117           : aliased constant String := "JSON with Comments";
   K_118           : aliased constant String := "xcompose";
   M_118           : aliased constant String := "XCompose";
   K_119           : aliased constant String := "composer.lock";
   M_119           : aliased constant String := "JSON";
   K_120           : aliased constant String := ".tm_properties";
   M_120           : aliased constant String := "TextMate Properties";
   K_121           : aliased constant String := ".rspec";
   M_121           : aliased constant String := "Option List";
   K_122           : aliased constant String := ".atomignore";
   M_122           : aliased constant String := "Ignore List";
   K_123           : aliased constant String := "CODEOWNERS";
   M_123           : aliased constant String := "CODEOWNERS";
   K_124           : aliased constant String := ".env.sample";
   M_124           : aliased constant String := "Dotenv";
   K_125           : aliased constant String := "Makefile.in";
   M_125           : aliased constant String := "Makefile";
   K_126           : aliased constant String := ".Rprofile";
   M_126           : aliased constant String := "R";
   K_127           : aliased constant String := "bash_logout";
   M_127           : aliased constant String := "Shell";
   K_128           : aliased constant String := "Guardfile";
   M_128           : aliased constant String := "Ruby";
   K_129           : aliased constant String := "profile";
   M_129           : aliased constant String := "Shell";
   K_130           : aliased constant String := "read.me";
   M_130           : aliased constant String := "Text";
   K_131           : aliased constant String := ".auto-changelog";
   M_131           : aliased constant String := "JSON";
   K_132           : aliased constant String := "jsconfig.json";
   M_132           : aliased constant String := "JSON with Comments";
   K_133           : aliased constant String := "flake.lock";
   M_133           : aliased constant String := "JSON";
   K_134           : aliased constant String := ".php_cs";
   M_134           : aliased constant String := "PHP";
   K_135           : aliased constant String := "WORKSPACE.bazel";
   M_135           : aliased constant String := "Starlark";
   K_136           : aliased constant String := ".simplecov";
   M_136           : aliased constant String := "Ruby";
   K_137           : aliased constant String := ".inputrc";
   M_137           : aliased constant String := "Readline Config";
   K_138           : aliased constant String := "COPYING.regex";
   M_138           : aliased constant String := "Text";
   K_139           : aliased constant String := "zshrc";
   M_139           : aliased constant String := "Shell";
   K_140           : aliased constant String := "keep.me";
   M_140           : aliased constant String := "Text";
   K_141           : aliased constant String := "Makefile.PL";
   M_141           : aliased constant String := "Perl";
   K_142           : aliased constant String := "rebar.config.lock";
   M_142           : aliased constant String := "Erlang";
   K_143           : aliased constant String := "robots.txt";
   M_143           : aliased constant String := "robots.txt";
   K_144           : aliased constant String := ".project";
   M_144           : aliased constant String := "XML";
   K_145           : aliased constant String := "Project.ede";
   M_145           : aliased constant String := "Emacs Lisp";
   K_146           : aliased constant String := "Fastfile";
   M_146           : aliased constant String := "Ruby";
   K_147           : aliased constant String := ".htmlhintrc";
   M_147           : aliased constant String := "JSON";
   K_148           : aliased constant String := "zshenv";
   M_148           : aliased constant String := "Shell";
   K_149           : aliased constant String := "m3makefile";
   M_149           : aliased constant String := "Quake";
   K_150           : aliased constant String := "ssh_config";
   M_150           : aliased constant String := "SSH Config";
   K_151           : aliased constant String := "_redirects";
   M_151           : aliased constant String := "Redirect Rules";
   K_152           : aliased constant String := ".eslintignore";
   M_152           : aliased constant String := "Ignore List";
   K_153           : aliased constant String := "SHA256SUMS.txt";
   M_153           : aliased constant String := "Checksums";
   K_154           : aliased constant String := ".coffeelintignore";
   M_154           : aliased constant String := "Ignore List";
   K_155           : aliased constant String := ".XCompose";
   M_155           : aliased constant String := "XCompose";
   K_156           : aliased constant String := "Modulefile";
   M_156           : aliased constant String := "Puppet";
   K_157           : aliased constant String := ".gnus";
   M_157           : aliased constant String := "Emacs Lisp";
   K_158           : aliased constant String := "pom.xml";
   M_158           : aliased constant String := "Maven POM";
   K_159           : aliased constant String := "vlcrc";
   M_159           : aliased constant String := "INI";
   K_160           : aliased constant String := "Singularity";
   M_160           : aliased constant String := "Singularity";
   K_161           : aliased constant String := ".ackrc";
   M_161           : aliased constant String := "Option List";
   K_162           : aliased constant String := "project.godot";
   M_162           : aliased constant String := "Godot Resource";
   K_163           : aliased constant String := "cshrc";
   M_163           : aliased constant String := "Shell";
   K_164           : aliased constant String := ".bash_history";
   M_164           : aliased constant String := "Shell";
   K_165           : aliased constant String := ".classpath";
   M_165           : aliased constant String := "XML";
   K_166           : aliased constant String := "latexmkrc";
   M_166           : aliased constant String := "Perl";
   K_167           : aliased constant String := "Rakefile";
   M_167           : aliased constant String := "Ruby";
   K_168           : aliased constant String := "Podfile";
   M_168           : aliased constant String := "Ruby";
   K_169           : aliased constant String := "lexer.x";
   M_169           : aliased constant String := "Lex";
   K_170           : aliased constant String := "NuGet.config";
   M_170           : aliased constant String := "XML";
   K_171           : aliased constant String := "Gopkg.lock";
   M_171           : aliased constant String := "TOML";
   K_172           : aliased constant String := "bash_aliases";
   M_172           : aliased constant String := "Shell";
   K_173           : aliased constant String := ".jscsrc";
   M_173           : aliased constant String := "JSON with Comments";
   K_174           : aliased constant String := ".php_cs.dist";
   M_174           : aliased constant String := "PHP";
   K_175           : aliased constant String := "checksums.txt";
   M_175           : aliased constant String := "Checksums";
   K_176           : aliased constant String := ".latexmkrc";
   M_176           : aliased constant String := "Perl";
   K_177           : aliased constant String := "MANIFEST.MF";
   M_177           : aliased constant String := "JAR Manifest";
   K_178           : aliased constant String := "Vagrantfile";
   M_178           : aliased constant String := "Ruby";
   K_179           : aliased constant String := "Makefile.boot";
   M_179           : aliased constant String := "Makefile";
   K_180           : aliased constant String := "_vimrc";
   M_180           : aliased constant String := "Vim Script";
   K_181           : aliased constant String := "Thorfile";
   M_181           : aliased constant String := "Ruby";
   K_182           : aliased constant String := "Makefile.inc";
   M_182           : aliased constant String := "Makefile";
   K_183           : aliased constant String := ".shellcheckrc";
   M_183           : aliased constant String := "ShellCheck Config";
   K_184           : aliased constant String := "PKGBUILD";
   M_184           : aliased constant String := "Shell";
   K_185           : aliased constant String := "Jarfile";
   M_185           : aliased constant String := "Ruby";
   K_186           : aliased constant String := "md5sum.txt";
   M_186           : aliased constant String := "Checksums";
   K_187           : aliased constant String := "use.stable.mask";
   M_187           : aliased constant String := "Text";
   K_188           : aliased constant String := ".emacs";
   M_188           : aliased constant String := "Emacs Lisp";
   K_189           : aliased constant String := "_dir_colors";
   M_189           : aliased constant String := "dircolors";
   K_190           : aliased constant String := "Makefile.wat";
   M_190           : aliased constant String := "Makefile";
   K_191           : aliased constant String := "cabal.project";
   M_191           : aliased constant String := "Cabal Config";
   K_192           : aliased constant String := "sshconfig";
   M_192           : aliased constant String := "SSH Config";
   K_193           : aliased constant String := "Makefile.frag";
   M_193           : aliased constant String := "Makefile";
   K_194           : aliased constant String := ".gn";
   M_194           : aliased constant String := "GN";
   K_195           : aliased constant String := "Tiltfile";
   M_195           : aliased constant String := "Starlark";
   K_196           : aliased constant String := "sshd_config";
   M_196           : aliased constant String := "SSH Config";
   K_197           : aliased constant String := ".zshrc";
   M_197           : aliased constant String := "Shell";
   K_198           : aliased constant String := "XCompose";
   M_198           : aliased constant String := "XCompose";
   K_199           : aliased constant String := ".bashrc";
   M_199           : aliased constant String := "Shell";
   K_200           : aliased constant String := "Fakefile";
   M_200           : aliased constant String := "Fancy";
   K_201           : aliased constant String := "Deliverfile";
   M_201           : aliased constant String := "Ruby";
   K_202           : aliased constant String := "BUILD.bazel";
   M_202           : aliased constant String := "Starlark";
   K_203           : aliased constant String := ".env.test";
   M_203           : aliased constant String := "Dotenv";
   K_204           : aliased constant String := "fonts.scale";
   M_204           : aliased constant String := "X Font Directory Index";
   K_205           : aliased constant String := ".env.development";
   M_205           : aliased constant String := "Dotenv";
   K_206           : aliased constant String := ".clang-tidy";
   M_206           : aliased constant String := "YAML";
   K_207           : aliased constant String := "SHA512SUMS";
   M_207           : aliased constant String := "Checksums";
   K_208           : aliased constant String := "Cakefile";
   M_208           : aliased constant String := "CoffeeScript";
   K_209           : aliased constant String := ".dockerignore";
   M_209           : aliased constant String := "Ignore List";
   K_210           : aliased constant String := ".flake8";
   M_210           : aliased constant String := "INI";
   K_211           : aliased constant String := "buildozer.spec";
   M_211           : aliased constant String := "INI";
   K_212           : aliased constant String := "_curlrc";
   M_212           : aliased constant String := "cURL Config";
   K_213           : aliased constant String := ".pryrc";
   M_213           : aliased constant String := "Ruby";
   K_214           : aliased constant String := ".nodemonignore";
   M_214           : aliased constant String := "Ignore List";
   K_215           : aliased constant String := "encodings.dir";
   M_215           : aliased constant String := "X Font Directory Index";
   K_216           : aliased constant String := "port_contexts";
   M_216           : aliased constant String := "SELinux Policy";
   K_217           : aliased constant String := "Steepfile";
   M_217           : aliased constant String := "Ruby";
   K_218           : aliased constant String := "_dircolors";
   M_218           : aliased constant String := "dircolors";
   K_219           : aliased constant String := "descrip.mmk";
   M_219           : aliased constant String := "Module Management System";
   K_220           : aliased constant String := "BSDmakefile";
   M_220           : aliased constant String := "Makefile";
   K_221           : aliased constant String := ".cshrc";
   M_221           : aliased constant String := "Shell";
   K_222           : aliased constant String := "zlogout";
   M_222           : aliased constant String := "Shell";
   K_223           : aliased constant String := "Web.Debug.config";
   M_223           : aliased constant String := "XML";
   K_224           : aliased constant String := "Gemfile.lock";
   M_224           : aliased constant String := "Gemfile.lock";
   K_225           : aliased constant String := "rebar.config";
   M_225           : aliased constant String := "Erlang";
   K_226           : aliased constant String := ".c8rc";
   M_226           : aliased constant String := "JSON";
   K_227           : aliased constant String := ".pylintrc";
   M_227           : aliased constant String := "INI";
   K_228           : aliased constant String := "mcmod.info";
   M_228           : aliased constant String := "JSON";
   K_229           : aliased constant String := "descrip.mms";
   M_229           : aliased constant String := "Module Management System";
   K_230           : aliased constant String := ".markdownlintignore";
   M_230           : aliased constant String := "Ignore List";
   K_231           : aliased constant String := "Berksfile";
   M_231           : aliased constant String := "Ruby";
   K_232           : aliased constant String := "devcontainer.json";
   M_232           : aliased constant String := "JSON with Comments";
   K_233           : aliased constant String := ".git-blame-ignore-revs";
   M_233           : aliased constant String := "Git Revision List";
   K_234           : aliased constant String := ".eslintrc.json";
   M_234           : aliased constant String := "JSON with Comments";
   K_235           : aliased constant String := "apache2.conf";
   M_235           : aliased constant String := "ApacheConf";
   K_236           : aliased constant String := "gitignore-global";
   M_236           : aliased constant String := "Ignore List";
   K_237           : aliased constant String := "sshconfig.snip";
   M_237           : aliased constant String := "SSH Config";
   K_238           : aliased constant String := "Earthfile";
   M_238           : aliased constant String := "Earthly";
   K_239           : aliased constant String := "meson_options.txt";
   M_239           : aliased constant String := "Meson";
   K_240           : aliased constant String := ".devcontainer.json";
   M_240           : aliased constant String := "JSON with Comments";
   K_241           : aliased constant String := "use.mask";
   M_241           : aliased constant String := "Text";
   K_242           : aliased constant String := "meson.build";
   M_242           : aliased constant String := "Meson";
   K_243           : aliased constant String := "package.mask";
   M_243           : aliased constant String := "Text";
   K_244           : aliased constant String := ".dir_colors";
   M_244           : aliased constant String := "dircolors";
   K_245           : aliased constant String := ".factor-rc";
   M_245           : aliased constant String := "Factor";
   K_246           : aliased constant String := "Gemfile";
   M_246           : aliased constant String := "Ruby";
   K_247           : aliased constant String := ".nvimrc";
   M_247           : aliased constant String := "Vim Script";
   K_248           : aliased constant String := "Mavenfile";
   M_248           : aliased constant String := "Ruby";
   K_249           : aliased constant String := "Pipfile.lock";
   M_249           : aliased constant String := "JSON";
   K_250           : aliased constant String := ".profile";
   M_250           : aliased constant String := "Shell";
   K_251           : aliased constant String := "BUCK";
   M_251           : aliased constant String := "Starlark";
   K_252           : aliased constant String := ".browserslistrc";
   M_252           : aliased constant String := "Browserslist";
   K_253           : aliased constant String := "glide.lock";
   M_253           : aliased constant String := "YAML";
   K_254           : aliased constant String := "toolchain_installscript.qs";
   M_254           : aliased constant String := "Qt Script";
   K_255           : aliased constant String := "LICENSE";
   M_255           : aliased constant String := "Text";
   K_256           : aliased constant String := "Cargo.lock";
   M_256           : aliased constant String := "TOML";
   K_257           : aliased constant String := ".babelrc";
   M_257           : aliased constant String := "JSON with Comments";
   K_258           : aliased constant String := "gradlew";
   M_258           : aliased constant String := "Shell";
   K_259           : aliased constant String := "INSTALL.mysql";
   M_259           : aliased constant String := "Text";
   K_260           : aliased constant String := "configure.ac";
   M_260           : aliased constant String := "M4Sugar";
   K_261           : aliased constant String := "starfield";
   M_261           : aliased constant String := "Tcl";
   K_262           : aliased constant String := ".gclient";
   M_262           : aliased constant String := "Python";
   K_263           : aliased constant String := ".env.local";
   M_263           : aliased constant String := "Dotenv";
   K_264           : aliased constant String := "INSTALL";
   M_264           : aliased constant String := "Text";
   K_265           : aliased constant String := "pylintrc";
   M_265           : aliased constant String := "INI";
   K_266           : aliased constant String := "wscript";
   M_266           : aliased constant String := "Python";
   K_267           : aliased constant String := "httpd.conf";
   M_267           : aliased constant String := "ApacheConf";
   K_268           : aliased constant String := "requirements.txt";
   M_268           : aliased constant String := "Pip Requirements";
   K_269           : aliased constant String := ".zprofile";
   M_269           : aliased constant String := "Shell";
   K_270           : aliased constant String := ".gitconfig";
   M_270           : aliased constant String := "Git Config";
   K_271           : aliased constant String := ".bash_aliases";
   M_271           : aliased constant String := "Shell";
   K_272           : aliased constant String := ".exrc";
   M_272           : aliased constant String := "Vim Script";
   K_273           : aliased constant String := "MD5SUMS";
   M_273           : aliased constant String := "Checksums";
   K_274           : aliased constant String := "9fs";
   M_274           : aliased constant String := "Shell";
   K_275           : aliased constant String := "cabal.config";
   M_275           : aliased constant String := "Cabal Config";
   K_276           : aliased constant String := "nanorc";
   M_276           : aliased constant String := "nanorc";
   K_277           : aliased constant String := "Dangerfile";
   M_277           : aliased constant String := "Ruby";
   K_278           : aliased constant String := "dir_colors";
   M_278           : aliased constant String := "dircolors";
   K_279           : aliased constant String := ".tern-project";
   M_279           : aliased constant String := "JSON";
   K_280           : aliased constant String := "Containerfile";
   M_280           : aliased constant String := "Dockerfile";
   K_281           : aliased constant String := ".clang-format";
   M_281           : aliased constant String := "YAML";
   K_282           : aliased constant String := "go.sum";
   M_282           : aliased constant String := "Go Checksums";
   K_283           : aliased constant String := "Cask";
   M_283           : aliased constant String := "Emacs Lisp";
   K_284           : aliased constant String := "ROOT";
   M_284           : aliased constant String := "Isabelle ROOT";
   K_285           : aliased constant String := "Pipfile";
   M_285           : aliased constant String := "TOML";
   K_286           : aliased constant String := "CITATION.cff";
   M_286           : aliased constant String := "YAML";
   K_287           : aliased constant String := "gvimrc";
   M_287           : aliased constant String := "Vim Script";
   K_288           : aliased constant String := ".env.ci";
   M_288           : aliased constant String := "Dotenv";
   K_289           : aliased constant String := ".scalafix.conf";
   M_289           : aliased constant String := "HOCON";
   K_290           : aliased constant String := "Notebook";
   M_290           : aliased constant String := "Jupyter Notebook";
   K_291           : aliased constant String := ".zshenv";
   M_291           : aliased constant String := "Shell";
   K_292           : aliased constant String := "vimrc";
   M_292           : aliased constant String := "Vim Script";
   K_293           : aliased constant String := ".luacheckrc";
   M_293           : aliased constant String := "Lua";
   K_294           : aliased constant String := "Web.config";
   M_294           : aliased constant String := "XML";
   K_295           : aliased constant String := "test.me";
   M_295           : aliased constant String := "Text";
   K_296           : aliased constant String := "tsconfig.json";
   M_296           : aliased constant String := "JSON with Comments";
   K_297           : aliased constant String := "kshrc";
   M_297           : aliased constant String := "Shell";
   K_298           : aliased constant String := "COPYING";
   M_298           : aliased constant String := "Text";
   K_299           : aliased constant String := "Lexer.x";
   M_299           : aliased constant String := "Lex";
   K_300           : aliased constant String := ".env.prod";
   M_300           : aliased constant String := "Dotenv";
   K_301           : aliased constant String := "HOSTS";
   M_301           : aliased constant String := "INI, Hosts File";
   K_302           : aliased constant String := "eqnrc";
   M_302           : aliased constant String := "Roff";
   K_303           : aliased constant String := "owh";
   M_303           : aliased constant String := "Tcl";
   K_304           : aliased constant String := "ssh-config";
   M_304           : aliased constant String := "SSH Config";
   K_305           : aliased constant String := ".nycrc";
   M_305           : aliased constant String := "JSON";
   K_306           : aliased constant String := ".eleventyignore";
   M_306           : aliased constant String := "Ignore List";
   K_307           : aliased constant String := "DIR_COLORS";
   M_307           : aliased constant String := "dircolors";
   K_308           : aliased constant String := "Snapfile";
   M_308           : aliased constant String := "Ruby";
   K_309           : aliased constant String := "Capfile";
   M_309           : aliased constant String := "Ruby";
   K_310           : aliased constant String := ".arcconfig";
   M_310           : aliased constant String := "JSON";
   K_311           : aliased constant String := "contents.lr";
   M_311           : aliased constant String := "Markdown";
   K_312           : aliased constant String := ".npmrc";
   M_312           : aliased constant String := "NPM Config";
   K_313           : aliased constant String := "Phakefile";
   M_313           : aliased constant String := "PHP";
   K_314           : aliased constant String := ".spacemacs";
   M_314           : aliased constant String := "Emacs Lisp";
   K_315           : aliased constant String := "browserslist";
   M_315           : aliased constant String := "Browserslist";
   K_316           : aliased constant String := ".gemrc";
   M_316           : aliased constant String := "YAML";
   K_317           : aliased constant String := "Procfile";
   M_317           : aliased constant String := "Procfile";
   K_318           : aliased constant String := "ld.script";
   M_318           : aliased constant String := "Linker Script";
   K_319           : aliased constant String := "MODULE.bazel";
   M_319           : aliased constant String := "Starlark";
   K_320           : aliased constant String := ".scalafmt.conf";
   M_320           : aliased constant String := "HOCON";
   K_321           : aliased constant String := ".abbrev_defs";
   M_321           : aliased constant String := "Emacs Lisp";
   K_322           : aliased constant String := "bash_profile";
   M_322           : aliased constant String := "Shell";
   K_323           : aliased constant String := "zprofile";
   M_323           : aliased constant String := "Shell";
   K_324           : aliased constant String := "Nukefile";
   M_324           : aliased constant String := "Nu";
   K_325           : aliased constant String := ".gitmodules";
   M_325           : aliased constant String := "Git Config";
   K_326           : aliased constant String := ".env.dev";
   M_326           : aliased constant String := "Dotenv";
   K_327           : aliased constant String := "zlogin";
   M_327           : aliased constant String := "Shell";
   K_328           : aliased constant String := ".tern-config";
   M_328           : aliased constant String := "JSON";
   K_329           : aliased constant String := "poetry.lock";
   M_329           : aliased constant String := "TOML";
   K_330           : aliased constant String := ".factor-boot-rc";
   M_330           : aliased constant String := "Factor";
   K_331           : aliased constant String := "hosts";
   M_331           : aliased constant String := "INI, Hosts File";
   K_332           : aliased constant String := "mmn";
   M_332           : aliased constant String := "Roff";
   K_333           : aliased constant String := "nginx.conf";
   M_333           : aliased constant String := "Nginx";
   K_334           : aliased constant String := "Jenkinsfile";
   M_334           : aliased constant String := "Groovy";
   K_335           : aliased constant String := ".swcrc";
   M_335           : aliased constant String := "JSON with Comments";
   K_336           : aliased constant String := ".bash_logout";
   M_336           : aliased constant String := "Shell";
   K_337           : aliased constant String := "README.me";
   M_337           : aliased constant String := "Text";
   K_338           : aliased constant String := "mmt";
   M_338           : aliased constant String := "Roff";
   K_339           : aliased constant String := "ack";
   M_339           : aliased constant String := "Perl";
   K_340           : aliased constant String := "requirements-dev.txt";
   M_340           : aliased constant String := "Pip Requirements";
   K_341           : aliased constant String := "CITATION";
   M_341           : aliased constant String := "Text";
   K_342           : aliased constant String := "login";
   M_342           : aliased constant String := "Shell";
   K_343           : aliased constant String := "nextflow.config";
   M_343           : aliased constant String := "Nextflow";
   K_344           : aliased constant String := "m3overrides";
   M_344           : aliased constant String := "Quake";
   K_345           : aliased constant String := "DEPS";
   M_345           : aliased constant String := "Python";
   K_346           : aliased constant String := "rebar.lock";
   M_346           : aliased constant String := "Erlang";
   K_347           : aliased constant String := "sshd-config";
   M_347           : aliased constant String := "SSH Config";
   K_348           : aliased constant String := "Buildfile";
   M_348           : aliased constant String := "Ruby";
   K_349           : aliased constant String := "cksums";
   M_349           : aliased constant String := "Checksums";
   K_350           : aliased constant String := "mkfile";
   M_350           : aliased constant String := "Makefile";
   K_351           : aliased constant String := "troffrc";
   M_351           : aliased constant String := "Roff";
   K_352           : aliased constant String := ".gitattributes";
   M_352           : aliased constant String := "Git Attributes";
   K_353           : aliased constant String := ".zlogout";
   M_353           : aliased constant String := "Shell";
   K_354           : aliased constant String := ".env.testing";
   M_354           : aliased constant String := "Dotenv";
   K_355           : aliased constant String := ".irbrc";
   M_355           : aliased constant String := "Ruby";
   K_356           : aliased constant String := ".env.development.local";
   M_356           : aliased constant String := "Dotenv";
   K_357           : aliased constant String := "package.use.mask";
   M_357           : aliased constant String := "Text";
   K_358           : aliased constant String := "Slakefile";
   M_358           : aliased constant String := "LiveScript";
   K_359           : aliased constant String := "makefile.sco";
   M_359           : aliased constant String := "Makefile";
   K_360           : aliased constant String := "fonts.dir";
   M_360           : aliased constant String := "X Font Directory Index";

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
      K_360'Access);

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
      M_360'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.FilenameMap;
