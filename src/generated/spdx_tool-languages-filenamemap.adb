--  Advanced Resource Embedder 1.5.1
--  SPDX-License-Identifier: Apache-2.0
--  Filename mapping generated from filenames.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.FilenameMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 11) of Natural :=
     (1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 17);

   T1 : constant array (0 .. 11) of Unsigned_16 :=
     (444, 322, 107, 638, 186, 149, 3, 148, 164, 393, 3, 19);

   T2 : constant array (0 .. 11) of Unsigned_16 :=
     (685, 15, 464, 17, 319, 256, 334, 509, 491, 248, 588, 629);

   G : constant array (0 .. 766) of Unsigned_16 :=
     (0, 0, 0, 93, 0, 0, 246, 0, 122, 0, 0, 5, 263, 54, 0, 0, 233, 0, 313,
      0, 0, 320, 212, 0, 0, 117, 0, 0, 0, 0, 0, 0, 168, 0, 178, 171, 55, 0,
      0, 0, 0, 282, 148, 25, 0, 0, 0, 0, 271, 246, 0, 0, 0, 249, 0, 0, 95,
      0, 0, 0, 0, 105, 0, 0, 123, 0, 275, 0, 125, 0, 281, 0, 23, 0, 151, 31,
      23, 160, 0, 0, 36, 115, 0, 270, 0, 191, 0, 0, 0, 0, 0, 0, 0, 268, 0,
      0, 300, 35, 0, 104, 293, 84, 0, 0, 0, 313, 115, 0, 0, 0, 62, 0, 0,
      376, 300, 0, 0, 0, 0, 253, 0, 0, 126, 0, 0, 0, 313, 258, 46, 0, 68, 0,
      0, 0, 0, 0, 0, 183, 0, 0, 11, 0, 0, 107, 0, 119, 0, 0, 320, 11, 21,
      299, 354, 0, 66, 0, 98, 154, 264, 22, 321, 0, 55, 0, 82, 0, 0, 42, 92,
      61, 102, 200, 371, 0, 17, 0, 378, 0, 0, 302, 0, 0, 0, 0, 331, 171, 0,
      0, 94, 185, 0, 235, 34, 0, 162, 6, 71, 349, 53, 132, 0, 0, 25, 128, 0,
      74, 213, 0, 0, 0, 0, 15, 103, 32, 0, 0, 238, 27, 0, 220, 0, 0, 0, 0,
      87, 272, 24, 0, 0, 0, 329, 0, 0, 0, 0, 185, 329, 208, 0, 0, 0, 0, 17,
      291, 0, 304, 0, 0, 0, 269, 0, 144, 37, 294, 0, 0, 29, 0, 125, 250,
      172, 292, 270, 0, 0, 0, 0, 0, 292, 0, 0, 45, 14, 140, 36, 216, 95, 0,
      0, 336, 0, 300, 362, 334, 173, 0, 163, 0, 8, 210, 191, 37, 0, 0, 278,
      0, 252, 0, 98, 0, 185, 0, 0, 124, 0, 97, 216, 0, 0, 309, 0, 0, 63,
      298, 0, 285, 0, 0, 242, 188, 0, 311, 199, 0, 0, 199, 200, 304, 0, 13,
      0, 177, 0, 194, 0, 205, 0, 0, 91, 0, 0, 352, 309, 340, 359, 160, 0,
      28, 0, 199, 0, 0, 0, 232, 0, 0, 0, 5, 0, 0, 0, 246, 274, 0, 249, 0, 0,
      0, 0, 61, 123, 113, 0, 0, 0, 291, 0, 0, 325, 154, 0, 0, 0, 0, 0, 237,
      297, 43, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 3, 65, 98, 0, 65,
      149, 71, 0, 0, 0, 0, 274, 141, 0, 0, 195, 0, 126, 308, 19, 0, 74, 0,
      380, 47, 0, 0, 0, 0, 342, 0, 147, 64, 333, 301, 0, 0, 8, 0, 0, 193,
      197, 300, 55, 57, 242, 0, 273, 293, 0, 215, 0, 0, 0, 228, 0, 29, 0,
      350, 0, 0, 307, 27, 0, 332, 0, 0, 0, 362, 83, 354, 221, 181, 90, 0, 0,
      194, 189, 348, 130, 0, 0, 291, 353, 0, 65, 368, 116, 289, 281, 167,
      19, 0, 67, 318, 98, 4, 0, 14, 30, 0, 256, 41, 233, 0, 0, 316, 0, 0, 0,
      0, 66, 155, 168, 184, 27, 26, 0, 0, 0, 357, 81, 0, 0, 0, 0, 187, 50,
      136, 229, 0, 0, 0, 347, 64, 0, 0, 0, 0, 284, 358, 0, 58, 226, 177, 0,
      0, 0, 291, 185, 0, 0, 208, 207, 356, 287, 0, 66, 0, 214, 327, 248, 0,
      80, 306, 0, 236, 0, 57, 0, 0, 0, 0, 0, 0, 263, 0, 232, 347, 0, 0, 10,
      0, 380, 121, 0, 9, 0, 347, 329, 148, 0, 17, 250, 241, 0, 0, 340, 153,
      0, 186, 0, 0, 87, 0, 0, 40, 270, 224, 342, 32, 27, 130, 0, 265, 253,
      0, 0, 0, 0, 0, 381, 0, 0, 0, 0, 220, 149, 0, 191, 0, 0, 0, 0, 338,
      110, 24, 248, 0, 48, 290, 375, 371, 266, 143, 0, 0, 85, 378, 0, 131,
      0, 0, 344, 0, 0, 217, 0, 114, 244, 0, 355, 89, 82, 0, 0, 0, 0, 24,
      339, 0, 0, 200, 93, 0, 0, 6, 0, 0, 0, 123, 0, 363, 4, 20, 0, 0, 262,
      207, 0, 0, 66, 368, 0, 240, 86, 212, 160, 0, 0, 78, 159, 247, 181, 0,
      0, 0, 300, 144, 0, 40, 0, 0, 0, 0, 341, 336, 0, 0, 16, 165, 53, 0,
      101, 0, 0, 0, 0, 0, 169, 20, 0, 1, 182, 0, 0, 54, 251, 0, 117, 62, 0,
      0, 26, 0, 276, 259, 0, 25, 0, 54, 293, 0, 0, 123, 249, 0, 0, 0, 0,
      176, 0, 2, 338, 0);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 767;
         F2 := (F2 + Natural (T2 (K)) * J) mod 767;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 383;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "bashrc";
   M_0             : aliased constant String := "Shell";
   K_1             : aliased constant String := "zlogin";
   M_1             : aliased constant String := "Shell";
   K_2             : aliased constant String := "Gemfile";
   M_2             : aliased constant String := "Ruby";
   K_3             : aliased constant String := "ld.script";
   M_3             : aliased constant String := "Linker Script";
   K_4             : aliased constant String := ".env.development";
   M_4             : aliased constant String := "Dotenv";
   K_5             : aliased constant String := "Snakefile";
   M_5             : aliased constant String := "Snakemake";
   K_6             : aliased constant String := "Guardfile";
   M_6             : aliased constant String := "Ruby";
   K_7             : aliased constant String := "mix.lock";
   M_7             : aliased constant String := "Elixir";
   K_8             : aliased constant String := ".pryrc";
   M_8             : aliased constant String := "Ruby";
   K_9             : aliased constant String := ".justfile";
   M_9             : aliased constant String := "Just";
   K_10            : aliased constant String := "use.stable.mask";
   M_10            : aliased constant String := "Text";
   K_11            : aliased constant String := "LICENSE";
   M_11            : aliased constant String := "Text";
   K_12            : aliased constant String := "Package.resolved";
   M_12            : aliased constant String := "JSON";
   K_13            : aliased constant String := "httpd.conf";
   M_13            : aliased constant String := "ApacheConf";
   K_14            : aliased constant String := "vlcrc";
   M_14            : aliased constant String := "INI";
   K_15            : aliased constant String := "ssh_config";
   M_15            : aliased constant String := "SSH Config";
   K_16            : aliased constant String := ".nanorc";
   M_16            : aliased constant String := "nanorc";
   K_17            : aliased constant String := "pixi.lock";
   M_17            : aliased constant String := "YAML";
   K_18            : aliased constant String := "BUILD";
   M_18            : aliased constant String := "Starlark";
   K_19            : aliased constant String := "SHA256SUMS";
   M_19            : aliased constant String := "Checksums";
   K_20            : aliased constant String := "xmake.lua";
   M_20            : aliased constant String := "Xmake";
   K_21            : aliased constant String := "starfield";
   M_21            : aliased constant String := "Tcl";
   K_22            : aliased constant String := "fonts.dir";
   M_22            : aliased constant String := "X Font Directory Index";
   K_23            : aliased constant String := "Cask";
   M_23            : aliased constant String := "Emacs Lisp";
   K_24            : aliased constant String := "abbrev_defs";
   M_24            : aliased constant String := "Emacs Lisp";
   K_25            : aliased constant String := ".kshrc";
   M_25            : aliased constant String := "Shell";
   K_26            : aliased constant String := ".swcrc";
   M_26            : aliased constant String := "JSON with Comments";
   K_27            : aliased constant String := ".emacs.desktop";
   M_27            : aliased constant String := "Emacs Lisp";
   K_28            : aliased constant String := "mmn";
   M_28            : aliased constant String := "Roff";
   K_29            : aliased constant String := "SHA256SUMS.txt";
   M_29            : aliased constant String := "Checksums";
   K_30            : aliased constant String := "mmt";
   M_30            : aliased constant String := "Roff";
   K_31            : aliased constant String := ".classpath";
   M_31            : aliased constant String := "XML";
   K_32            : aliased constant String := "fonts.alias";
   M_32            : aliased constant String := "X Font Directory Index";
   K_33            : aliased constant String := "Earthfile";
   M_33            : aliased constant String := "Earthly";
   K_34            : aliased constant String := ".gvimrc";
   M_34            : aliased constant String := "Vim Script";
   K_35            : aliased constant String := "MD5SUMS";
   M_35            : aliased constant String := "Checksums";
   K_36            : aliased constant String := "contents.lr";
   M_36            : aliased constant String := "Markdown";
   K_37            : aliased constant String := "Brewfile";
   M_37            : aliased constant String := "Ruby";
   K_38            : aliased constant String := ".clangd";
   M_38            : aliased constant String := "YAML";
   K_39            : aliased constant String := "Fakefile";
   M_39            : aliased constant String := "Fancy";
   K_40            : aliased constant String := "Jarfile";
   M_40            : aliased constant String := "Ruby";
   K_41            : aliased constant String := "mcmod.info";
   M_41            : aliased constant String := "JSON";
   K_42            : aliased constant String := ".zshrc";
   M_42            : aliased constant String := "Shell";
   K_43            : aliased constant String := ".gitmodules";
   M_43            : aliased constant String := "Git Config";
   K_44            : aliased constant String := "WORKSPACE";
   M_44            : aliased constant String := "Starlark";
   K_45            : aliased constant String := ".bash_functions";
   M_45            : aliased constant String := "Shell";
   K_46            : aliased constant String := "Web.Release.config";
   M_46            : aliased constant String := "XML";
   K_47            : aliased constant String := "Web.config";
   M_47            : aliased constant String := "XML";
   K_48            : aliased constant String := "tmux.conf";
   M_48            : aliased constant String := "Shell";
   K_49            : aliased constant String := "initial_sids";
   M_49            : aliased constant String := "SELinux Policy";
   K_50            : aliased constant String := ".clang-format";
   M_50            : aliased constant String := "YAML";
   K_51            : aliased constant String := ".dockerignore";
   M_51            : aliased constant String := "Ignore List";
   K_52            : aliased constant String := "Dockerfile";
   M_52            : aliased constant String := "Dockerfile";
   K_53            : aliased constant String := "COPYRIGHT.regex";
   M_53            : aliased constant String := "Text";
   K_54            : aliased constant String := ".login";
   M_54            : aliased constant String := "Shell";
   K_55            : aliased constant String := "Cakefile";
   M_55            : aliased constant String := "CoffeeScript";
   K_56            : aliased constant String := "sshconfig";
   M_56            : aliased constant String := "SSH Config";
   K_57            : aliased constant String := "poetry.lock";
   M_57            : aliased constant String := "TOML";
   K_58            : aliased constant String := ".imgbotconfig";
   M_58            : aliased constant String := "JSON";
   K_59            : aliased constant String := ".prettierignore";
   M_59            : aliased constant String := "Ignore List";
   K_60            : aliased constant String := "Web.Debug.config";
   M_60            : aliased constant String := "XML";
   K_61            : aliased constant String := "NEWS";
   M_61            : aliased constant String := "Text";
   K_62            : aliased constant String := ".watchmanconfig";
   M_62            : aliased constant String := "JSON";
   K_63            : aliased constant String := ".gnus";
   M_63            : aliased constant String := "Emacs Lisp";
   K_64            : aliased constant String := "Phakefile";
   M_64            : aliased constant String := "PHP";
   K_65            : aliased constant String := "_emacs";
   M_65            : aliased constant String := "Emacs Lisp";
   K_66            : aliased constant String := "xcompose";
   M_66            : aliased constant String := "XCompose";
   K_67            : aliased constant String := ".factor-boot-rc";
   M_67            : aliased constant String := "Factor";
   K_68            : aliased constant String := "BUILD.bazel";
   M_68            : aliased constant String := "Starlark";
   K_69            : aliased constant String := "haproxy.cfg";
   M_69            : aliased constant String := "HAProxy";
   K_70            : aliased constant String := ".env.development.local";
   M_70            : aliased constant String := "Dotenv";
   K_71            : aliased constant String := "md5sum.txt";
   M_71            : aliased constant String := "Checksums";
   K_72            : aliased constant String := ".exrc";
   M_72            : aliased constant String := "Vim Script";
   K_73            : aliased constant String := "bash_aliases";
   M_73            : aliased constant String := "Shell";
   K_74            : aliased constant String := ".buckconfig";
   M_74            : aliased constant String := "INI";
   K_75            : aliased constant String := ".htaccess";
   M_75            : aliased constant String := "ApacheConf";
   K_76            : aliased constant String := ".php";
   M_76            : aliased constant String := "PHP";
   K_77            : aliased constant String := "cksums";
   M_77            : aliased constant String := "Checksums";
   K_78            : aliased constant String := "sshconfig.snip";
   M_78            : aliased constant String := "SSH Config";
   K_79            : aliased constant String := ".jscsrc";
   M_79            : aliased constant String := "JSON with Comments";
   K_80            : aliased constant String := ".git-blame-ignore-revs";
   M_80            : aliased constant String := "Git Revision List";
   K_81            : aliased constant String := "packages.config";
   M_81            : aliased constant String := "XML";
   K_82            : aliased constant String := "nginx.conf";
   M_82            : aliased constant String := "Nginx";
   K_83            : aliased constant String := ".zlogin";
   M_83            : aliased constant String := "Shell";
   K_84            : aliased constant String := "fonts.scale";
   M_84            : aliased constant String := "X Font Directory Index";
   K_85            : aliased constant String := ".latexmkrc";
   M_85            : aliased constant String := "Perl";
   K_86            : aliased constant String := "INSTALL.mysql";
   M_86            : aliased constant String := "Text";
   K_87            : aliased constant String := "package.use.mask";
   M_87            : aliased constant String := "Text";
   K_88            : aliased constant String := "DEPS";
   M_88            : aliased constant String := "Python";
   K_89            : aliased constant String := "meson.build";
   M_89            : aliased constant String := "Meson";
   K_90            : aliased constant String := ".envrc";
   M_90            : aliased constant String := "Shell";
   K_91            : aliased constant String := ".simplecov";
   M_91            : aliased constant String := "Ruby";
   K_92            : aliased constant String := ".project";
   M_92            : aliased constant String := "XML";
   K_93            : aliased constant String := "m3makefile";
   M_93            : aliased constant String := "Quake";
   K_94            : aliased constant String := "genfs_contexts";
   M_94            : aliased constant String := "SELinux Policy";
   K_95            : aliased constant String := ".env.dev";
   M_95            : aliased constant String := "Dotenv";
   K_96            : aliased constant String := ".Rprofile";
   M_96            : aliased constant String := "R";
   K_97            : aliased constant String := "MODULE.bazel.lock";
   M_97            : aliased constant String := "JSON";
   K_98            : aliased constant String := "Vagrantfile";
   M_98            : aliased constant String := "Ruby";
   K_99            : aliased constant String := "_dir_colors";
   M_99            : aliased constant String := "dircolors";
   K_100           : aliased constant String := ".jslintrc";
   M_100           : aliased constant String := "JSON with Comments";
   K_101           : aliased constant String := "SHA1SUMS";
   M_101           : aliased constant String := "Checksums";
   K_102           : aliased constant String := "go.work.sum";
   M_102           : aliased constant String := "Go Checksums";
   K_103           : aliased constant String := "Notebook";
   M_103           : aliased constant String := "Jupyter Notebook";
   K_104           : aliased constant String := "JUSTFILE";
   M_104           : aliased constant String := "Just";
   K_105           : aliased constant String := "bash_profile";
   M_105           : aliased constant String := "Shell";
   K_106           : aliased constant String := ".bash_profile";
   M_106           : aliased constant String := "Shell";
   K_107           : aliased constant String := ".env";
   M_107           : aliased constant String := "Dotenv";
   K_108           : aliased constant String := ".tm_properties";
   M_108           : aliased constant String := "TextMate Properties";
   K_109           : aliased constant String := "pom.xml";
   M_109           : aliased constant String := "Maven POM";
   K_110           : aliased constant String := "browserslist";
   M_110           : aliased constant String := "Browserslist";
   K_111           : aliased constant String := "checksums.txt";
   M_111           : aliased constant String := "Checksums";
   K_112           : aliased constant String := "BSDmakefile";
   M_112           : aliased constant String := "Makefile";
   K_113           : aliased constant String := ".curlrc";
   M_113           : aliased constant String := "cURL Config";
   K_114           : aliased constant String := ".atomignore";
   M_114           : aliased constant String := "Ignore List";
   K_115           : aliased constant String := ".vscodeignore";
   M_115           : aliased constant String := "Ignore List";
   K_116           : aliased constant String := "use.mask";
   M_116           : aliased constant String := "Text";
   K_117           : aliased constant String := ".scalafmt.conf";
   M_117           : aliased constant String := "HOCON";
   K_118           : aliased constant String := "vimrc";
   M_118           : aliased constant String := "Vim Script";
   K_119           : aliased constant String := "Mavenfile";
   M_119           : aliased constant String := "Ruby";
   K_120           : aliased constant String := ".eslintrc.json";
   M_120           : aliased constant String := "JSON with Comments";
   K_121           : aliased constant String := "read.me";
   M_121           : aliased constant String := "Text";
   K_122           : aliased constant String := "zprofile";
   M_122           : aliased constant String := "Shell";
   K_123           : aliased constant String := "Justfile";
   M_123           : aliased constant String := "Just";
   K_124           : aliased constant String := "go.work";
   M_124           : aliased constant String := "Go Workspace";
   K_125           : aliased constant String := "eqnrc";
   M_125           : aliased constant String := "Roff";
   K_126           : aliased constant String := "Cargo.toml.orig";
   M_126           : aliased constant String := "TOML";
   K_127           : aliased constant String := "security_classes";
   M_127           : aliased constant String := "SELinux Policy";
   K_128           : aliased constant String := "ant.xml";
   M_128           : aliased constant String := "Ant Build System";
   K_129           : aliased constant String := "README.mysql";
   M_129           : aliased constant String := "Text";
   K_130           : aliased constant String := "jsconfig.json";
   M_130           : aliased constant String := "JSON with Comments";
   K_131           : aliased constant String := "go.mod";
   M_131           : aliased constant String := "Go Module";
   K_132           : aliased constant String := "XCompose";
   M_132           : aliased constant String := "XCompose";
   K_133           : aliased constant String := "Puppetfile";
   M_133           : aliased constant String := "Ruby";
   K_134           : aliased constant String := ".scalafix.conf";
   M_134           : aliased constant String := "HOCON";
   K_135           : aliased constant String := "SHA512SUMS";
   M_135           : aliased constant String := "Checksums";
   K_136           : aliased constant String := ".eslintignore";
   M_136           : aliased constant String := "Ignore List";
   K_137           : aliased constant String := "yarn.lock";
   M_137           : aliased constant String := "YAML";
   K_138           : aliased constant String := ".profile";
   M_138           : aliased constant String := "Shell";
   K_139           : aliased constant String := ".npmrc";
   M_139           : aliased constant String := "NPM Config";
   K_140           : aliased constant String := "CITATIONS";
   M_140           : aliased constant String := "Text";
   K_141           : aliased constant String := "descrip.mmk";
   M_141           : aliased constant String := "Module Management System";
   K_142           : aliased constant String := "api-extractor.json";
   M_142           : aliased constant String := "JSON with Comments";
   K_143           : aliased constant String := "toolchain_installscript.qs";
   M_143           : aliased constant String := "Qt Script";
   K_144           : aliased constant String := "descrip.mms";
   M_144           : aliased constant String := "Module Management System";
   K_145           : aliased constant String := ".shellcheckrc";
   M_145           : aliased constant String := "ShellCheck Config";
   K_146           : aliased constant String := ".env.production";
   M_146           : aliased constant String := "Dotenv";
   K_147           : aliased constant String := "justfile";
   M_147           : aliased constant String := "Just";
   K_148           : aliased constant String := ".luacheckrc";
   M_148           : aliased constant String := "Lua";
   K_149           : aliased constant String := ".all-contributorsrc";
   M_149           : aliased constant String := "JSON";
   K_150           : aliased constant String := "uv.lock";
   M_150           : aliased constant String := "TOML";
   K_151           : aliased constant String := "gitignore_global";
   M_151           : aliased constant String := "Ignore List";
   K_152           : aliased constant String := "devcontainer.json";
   M_152           : aliased constant String := "JSON with Comments";
   K_153           : aliased constant String := "Emakefile";
   M_153           : aliased constant String := "Erlang";
   K_154           : aliased constant String := "zshenv";
   M_154           : aliased constant String := "Shell";
   K_155           : aliased constant String := "CITATION";
   M_155           : aliased constant String := "Text";
   K_156           : aliased constant String := ".nvimrc";
   M_156           : aliased constant String := "Vim Script";
   K_157           : aliased constant String := "Gopkg.lock";
   M_157           : aliased constant String := "TOML";
   K_158           : aliased constant String := ".flaskenv";
   M_158           : aliased constant String := "Shell";
   K_159           : aliased constant String := ".env.ci";
   M_159           : aliased constant String := "Dotenv";
   K_160           : aliased constant String := ".vercelignore";
   M_160           : aliased constant String := "Ignore List";
   K_161           : aliased constant String := ".dircolors";
   M_161           : aliased constant String := "dircolors";
   K_162           : aliased constant String := "Makefile.wat";
   M_162           : aliased constant String := "Makefile";
   K_163           : aliased constant String := ".yardopts";
   M_163           : aliased constant String := "Option List";
   K_164           : aliased constant String := "SConscript";
   M_164           : aliased constant String := "Python";
   K_165           : aliased constant String := ".bash_history";
   M_165           : aliased constant String := "Shell";
   K_166           : aliased constant String := "Settings.StyleCop";
   M_166           : aliased constant String := "XML";
   K_167           : aliased constant String := ".gn";
   M_167           : aliased constant String := "GN";
   K_168           : aliased constant String := "_vimrc";
   M_168           : aliased constant String := "Vim Script";
   K_169           : aliased constant String := "nanorc";
   M_169           : aliased constant String := "nanorc";
   K_170           : aliased constant String := "Berksfile";
   M_170           : aliased constant String := "Ruby";
   K_171           : aliased constant String := "MANIFEST.MF";
   M_171           : aliased constant String := "JAR Manifest";
   K_172           : aliased constant String := "Gemfile.lock";
   M_172           : aliased constant String := "Gemfile.lock";
   K_173           : aliased constant String := ".tmux.conf";
   M_173           : aliased constant String := "Shell";
   K_174           : aliased constant String := ".env.example";
   M_174           : aliased constant String := "Dotenv";
   K_175           : aliased constant String := "troffrc-end";
   M_175           : aliased constant String := "Roff";
   K_176           : aliased constant String := "readme.1st";
   M_176           : aliased constant String := "Text";
   K_177           : aliased constant String := "Modulefile";
   M_177           : aliased constant String := "Puppet";
   K_178           : aliased constant String := ".abbrev_defs";
   M_178           : aliased constant String := "Emacs Lisp";
   K_179           : aliased constant String := "sshd-config";
   M_179           : aliased constant String := "SSH Config";
   K_180           : aliased constant String := "click.me";
   M_180           : aliased constant String := "Text";
   K_181           : aliased constant String := "MODULE.bazel";
   M_181           : aliased constant String := "Starlark";
   K_182           : aliased constant String := "package.mask";
   M_182           : aliased constant String := "Text";
   K_183           : aliased constant String := "Dangerfile";
   M_183           : aliased constant String := "Ruby";
   K_184           : aliased constant String := "Makefile.boot";
   M_184           : aliased constant String := "Makefile";
   K_185           : aliased constant String := "Thorfile";
   M_185           : aliased constant String := "Ruby";
   K_186           : aliased constant String := ".zlogout";
   M_186           : aliased constant String := "Shell";
   K_187           : aliased constant String := "rebar.lock";
   M_187           : aliased constant String := "Erlang";
   K_188           : aliased constant String := "Jenkinsfile";
   M_188           : aliased constant String := "Groovy";
   K_189           : aliased constant String := ".auto-changelog";
   M_189           : aliased constant String := "JSON";
   K_190           : aliased constant String := ".ignore";
   M_190           : aliased constant String := "Ignore List";
   K_191           : aliased constant String := ".browserslistrc";
   M_191           : aliased constant String := "Browserslist";
   K_192           : aliased constant String := "go.sum";
   M_192           : aliased constant String := "Go Checksums";
   K_193           : aliased constant String := ".dir_colors";
   M_193           : aliased constant String := "dircolors";
   K_194           : aliased constant String := "tslint.json";
   M_194           : aliased constant String := "JSON with Comments";
   K_195           : aliased constant String := ".devcontainer.json";
   M_195           : aliased constant String := "JSON with Comments";
   K_196           : aliased constant String := "Makefile.inc";
   M_196           : aliased constant String := "Makefile";
   K_197           : aliased constant String := ".viper";
   M_197           : aliased constant String := "Emacs Lisp";
   K_198           : aliased constant String := "Podfile";
   M_198           : aliased constant String := "Ruby";
   K_199           : aliased constant String := "Capfile";
   M_199           : aliased constant String := "Ruby";
   K_200           : aliased constant String := ".htmlhintrc";
   M_200           : aliased constant String := "JSON";
   K_201           : aliased constant String := ".nycrc";
   M_201           : aliased constant String := "JSON";
   K_202           : aliased constant String := "App.config";
   M_202           : aliased constant String := "XML";
   K_203           : aliased constant String := ".php_cs";
   M_203           : aliased constant String := "PHP";
   K_204           : aliased constant String := "ackrc";
   M_204           : aliased constant String := "Option List";
   K_205           : aliased constant String := ".bash_aliases";
   M_205           : aliased constant String := "Shell";
   K_206           : aliased constant String := "hosts.txt";
   M_206           : aliased constant String := "Hosts File";
   K_207           : aliased constant String := "cabal.project";
   M_207           : aliased constant String := "Cabal Config";
   K_208           : aliased constant String := "keep.me";
   M_208           : aliased constant String := "Text";
   K_209           : aliased constant String := "makefile.sco";
   M_209           : aliased constant String := "Makefile";
   K_210           : aliased constant String := "Buildfile";
   M_210           : aliased constant String := "Ruby";
   K_211           : aliased constant String := "m3overrides";
   M_211           : aliased constant String := "Quake";
   K_212           : aliased constant String := "Fastfile";
   M_212           : aliased constant String := "Ruby";
   K_213           : aliased constant String := ".babelignore";
   M_213           : aliased constant String := "Ignore List";
   K_214           : aliased constant String := "requirements.txt";
   M_214           : aliased constant String := "Pip Requirements";
   K_215           : aliased constant String := ".bashrc";
   M_215           : aliased constant String := "Shell";
   K_216           : aliased constant String := "owh";
   M_216           : aliased constant String := "Tcl";
   K_217           : aliased constant String := ".tern-config";
   M_217           : aliased constant String := "JSON";
   K_218           : aliased constant String := ".spacemacs";
   M_218           : aliased constant String := "Emacs Lisp";
   K_219           : aliased constant String := "Rexfile";
   M_219           : aliased constant String := "Perl";
   K_220           : aliased constant String := "language-configuration.json";
   M_220           : aliased constant String := "JSON with Comments";
   K_221           : aliased constant String := "Procfile";
   M_221           : aliased constant String := "Procfile";
   K_222           : aliased constant String := ".nodemonignore";
   M_222           : aliased constant String := "Ignore List";
   K_223           : aliased constant String := ".easignore";
   M_223           : aliased constant String := "Ignore List";
   K_224           : aliased constant String := "delete.me";
   M_224           : aliased constant String := "Text";
   K_225           : aliased constant String := "Android.bp";
   M_225           : aliased constant String := "Soong";
   K_226           : aliased constant String := "_redirects";
   M_226           : aliased constant String := "Redirect Rules";
   K_227           : aliased constant String := ".gitignore";
   M_227           : aliased constant String := "Ignore List";
   K_228           : aliased constant String := "NuGet.config";
   M_228           : aliased constant String := "XML";
   K_229           : aliased constant String := "build.xml";
   M_229           : aliased constant String := "Ant Build System";
   K_230           : aliased constant String := "composer.lock";
   M_230           : aliased constant String := "JSON";
   K_231           : aliased constant String := "CODEOWNERS";
   M_231           : aliased constant String := "CODEOWNERS";
   K_232           : aliased constant String := ".arcconfig";
   M_232           : aliased constant String := "JSON";
   K_233           : aliased constant String := "apache2.conf";
   M_233           : aliased constant String := "ApacheConf";
   K_234           : aliased constant String := "Snapfile";
   M_234           : aliased constant String := "Ruby";
   K_235           : aliased constant String := "firestore.rules";
   M_235           : aliased constant String := "Cloud Firestore Security Rules";
   K_236           : aliased constant String := "Kbuild";
   M_236           : aliased constant String := "Makefile";
   K_237           : aliased constant String := "rebar.config.lock";
   M_237           : aliased constant String := "Erlang";
   K_238           : aliased constant String := "cshrc";
   M_238           : aliased constant String := "Shell";
   K_239           : aliased constant String := ".env.test";
   M_239           : aliased constant String := "Dotenv";
   K_240           : aliased constant String := "pdm.lock";
   M_240           : aliased constant String := "TOML";
   K_241           : aliased constant String := "pylintrc";
   M_241           : aliased constant String := "INI";
   K_242           : aliased constant String := ".pylintrc";
   M_242           : aliased constant String := "INI";
   K_243           : aliased constant String := ".cproject";
   M_243           : aliased constant String := "XML";
   K_244           : aliased constant String := "README.nss";
   M_244           : aliased constant String := "Text";
   K_245           : aliased constant String := "WORKSPACE.bzlmod";
   M_245           : aliased constant String := "Starlark";
   K_246           : aliased constant String := "Makefile.am";
   M_246           : aliased constant String := "Makefile";
   K_247           : aliased constant String := "robots.txt";
   M_247           : aliased constant String := "robots.txt";
   K_248           : aliased constant String := ".vimrc";
   M_248           : aliased constant String := "Vim Script";
   K_249           : aliased constant String := ".env.staging";
   M_249           : aliased constant String := "Dotenv";
   K_250           : aliased constant String := "README.me";
   M_250           : aliased constant String := "Text";
   K_251           : aliased constant String := "file_contexts";
   M_251           : aliased constant String := "SELinux Policy";
   K_252           : aliased constant String := "Nukefile";
   M_252           : aliased constant String := "Nu";
   K_253           : aliased constant String := "_dircolors";
   M_253           : aliased constant String := "dircolors";
   K_254           : aliased constant String := "cabal.config";
   M_254           : aliased constant String := "Cabal Config";
   K_255           : aliased constant String := "CITATION.cff";
   M_255           : aliased constant String := "YAML";
   K_256           : aliased constant String := ".wgetrc";
   M_256           : aliased constant String := "Wget Config";
   K_257           : aliased constant String := ".babelrc";
   M_257           : aliased constant String := "JSON with Comments";
   K_258           : aliased constant String := "buildozer.spec";
   M_258           : aliased constant String := "INI";
   K_259           : aliased constant String := "test.me";
   M_259           : aliased constant String := "Text";
   K_260           : aliased constant String := ".coffeelintignore";
   M_260           : aliased constant String := "Ignore List";
   K_261           : aliased constant String := "Makefile.frag";
   M_261           : aliased constant String := "Makefile";
   K_262           : aliased constant String := "cpanfile";
   M_262           : aliased constant String := "Perl";
   K_263           : aliased constant String := "kshrc";
   M_263           : aliased constant String := "Shell";
   K_264           : aliased constant String := ".clang-tidy";
   M_264           : aliased constant String := "YAML";
   K_265           : aliased constant String := "nextflow.config";
   M_265           : aliased constant String := "Nextflow";
   K_266           : aliased constant String := ".gitattributes";
   M_266           : aliased constant String := "Git Attributes";
   K_267           : aliased constant String := ".php_cs.dist";
   M_267           : aliased constant String := "PHP";
   K_268           : aliased constant String := "Singularity";
   M_268           : aliased constant String := "Singularity";
   K_269           : aliased constant String := ".tern-project";
   M_269           : aliased constant String := "JSON";
   K_270           : aliased constant String := "Deliverfile";
   M_270           : aliased constant String := "Ruby";
   K_271           : aliased constant String := "deno.lock";
   M_271           : aliased constant String := "JSON";
   K_272           : aliased constant String := ".jshintrc";
   M_272           : aliased constant String := "JSON with Comments";
   K_273           : aliased constant String := "port_contexts";
   M_273           : aliased constant String := "SELinux Policy";
   K_274           : aliased constant String := "nim.cfg";
   M_274           : aliased constant String := "Nim";
   K_275           : aliased constant String := "ROOT";
   M_275           : aliased constant String := "Isabelle ROOT";
   K_276           : aliased constant String := "Kconfig";
   M_276           : aliased constant String := "Makefile";
   K_277           : aliased constant String := ".markdownlintignore";
   M_277           : aliased constant String := "Ignore List";
   K_278           : aliased constant String := "profile";
   M_278           : aliased constant String := "Shell";
   K_279           : aliased constant String := ".npmignore";
   M_279           : aliased constant String := "Ignore List";
   K_280           : aliased constant String := ".env.prod";
   M_280           : aliased constant String := "Dotenv";
   K_281           : aliased constant String := "ack";
   M_281           : aliased constant String := "Perl";
   K_282           : aliased constant String := "_curlrc";
   M_282           : aliased constant String := "cURL Config";
   K_283           : aliased constant String := "lexer.x";
   M_283           : aliased constant String := "Lex";
   K_284           : aliased constant String := ".emacs";
   M_284           : aliased constant String := "Emacs Lisp";
   K_285           : aliased constant String := "zshrc";
   M_285           : aliased constant String := "Shell";
   K_286           : aliased constant String := ".env.sample";
   M_286           : aliased constant String := "Dotenv";
   K_287           : aliased constant String := "troffrc";
   M_287           : aliased constant String := "Roff";
   K_288           : aliased constant String := ".env.testing";
   M_288           : aliased constant String := "Dotenv";
   K_289           : aliased constant String := "DIR_COLORS";
   M_289           : aliased constant String := "dircolors";
   K_290           : aliased constant String := "HOSTS";
   M_290           : aliased constant String := "INI,Hosts File";
   K_291           : aliased constant String := ".editorconfig";
   M_291           : aliased constant String := "EditorConfig";
   K_292           : aliased constant String := ".gemrc";
   M_292           : aliased constant String := "YAML";
   K_293           : aliased constant String := ".factor-rc";
   M_293           : aliased constant String := "Factor";
   K_294           : aliased constant String := "Makefile.in";
   M_294           : aliased constant String := "Makefile";
   K_295           : aliased constant String := "PKGBUILD";
   M_295           : aliased constant String := "Shell";
   K_296           : aliased constant String := "meson_options.txt";
   M_296           : aliased constant String := "Meson";
   K_297           : aliased constant String := "login";
   M_297           : aliased constant String := "Shell";
   K_298           : aliased constant String := "GNUmakefile";
   M_298           : aliased constant String := "Makefile";
   K_299           : aliased constant String := "requirements-dev.txt";
   M_299           : aliased constant String := "Pip Requirements";
   K_300           : aliased constant String := ".inputrc";
   M_300           : aliased constant String := "Readline Config";
   K_301           : aliased constant String := "inputrc";
   M_301           : aliased constant String := "Readline Config";
   K_302           : aliased constant String := "Pipfile";
   M_302           : aliased constant String := "TOML";
   K_303           : aliased constant String := "gradlew";
   M_303           : aliased constant String := "Shell";
   K_304           : aliased constant String := "INSTALL";
   M_304           : aliased constant String := "Text";
   K_305           : aliased constant String := ".eleventyignore";
   M_305           : aliased constant String := "Ignore List";
   K_306           : aliased constant String := "flake.lock";
   M_306           : aliased constant String := "JSON";
   K_307           : aliased constant String := "language-subtag-registry.txt";
   M_307           : aliased constant String := "Record Jar";
   K_308           : aliased constant String := "CMakeLists.txt";
   M_308           : aliased constant String := "CMake";
   K_309           : aliased constant String := "COPYING.regex";
   M_309           : aliased constant String := "Text";
   K_310           : aliased constant String := "buildfile";
   M_310           : aliased constant String := "Ruby";
   K_311           : aliased constant String := ".rspec";
   M_311           : aliased constant String := "Option List";
   K_312           : aliased constant String := ".irbrc";
   M_312           : aliased constant String := "Ruby";
   K_313           : aliased constant String := "Containerfile";
   M_313           : aliased constant String := "Dockerfile";
   K_314           : aliased constant String := "nvimrc";
   M_314           : aliased constant String := "Vim Script";
   K_315           : aliased constant String := "wscript";
   M_315           : aliased constant String := "Python";
   K_316           : aliased constant String := "SConstruct";
   M_316           : aliased constant String := "Python";
   K_317           : aliased constant String := "FONTLOG";
   M_317           : aliased constant String := "Text";
   K_318           : aliased constant String := "suite.rc";
   M_318           : aliased constant String := "Cylc";
   K_319           : aliased constant String := ".c8rc";
   M_319           : aliased constant String := "JSON";
   K_320           : aliased constant String := "package.use.stable.mask";
   M_320           : aliased constant String := "Text";
   K_321           : aliased constant String := "dune-project";
   M_321           : aliased constant String := "Dune";
   K_322           : aliased constant String := "kakrc";
   M_322           : aliased constant String := "KakouneScript";
   K_323           : aliased constant String := "riemann.config";
   M_323           : aliased constant String := "Clojure";
   K_324           : aliased constant String := "BUCK";
   M_324           : aliased constant String := "Starlark";
   K_325           : aliased constant String := "bun.lock";
   M_325           : aliased constant String := "JSON";
   K_326           : aliased constant String := "installscript.qs";
   M_326           : aliased constant String := "Qt Script";
   K_327           : aliased constant String := "gvimrc";
   M_327           : aliased constant String := "Vim Script";
   K_328           : aliased constant String := "rebar.config";
   M_328           : aliased constant String := "Erlang";
   K_329           : aliased constant String := "bash_logout";
   M_329           : aliased constant String := "Shell";
   K_330           : aliased constant String := "expr-dist";
   M_330           : aliased constant String := "R";
   K_331           : aliased constant String := "mocha.opts";
   M_331           : aliased constant String := "Option List";
   K_332           : aliased constant String := "project.godot";
   M_332           : aliased constant String := "Godot Resource";
   K_333           : aliased constant String := "zlogout";
   M_333           : aliased constant String := "Shell";
   K_334           : aliased constant String := "Makefile";
   M_334           : aliased constant String := "Makefile";
   K_335           : aliased constant String := ".env.local";
   M_335           : aliased constant String := "Dotenv";
   K_336           : aliased constant String := "latexmkrc";
   M_336           : aliased constant String := "Perl";
   K_337           : aliased constant String := ".JUSTFILE";
   M_337           : aliased constant String := "Just";
   K_338           : aliased constant String := "COPYING";
   M_338           : aliased constant String := "Text";
   K_339           : aliased constant String := "Makefile.PL";
   M_339           : aliased constant String := "Perl";
   K_340           : aliased constant String := "Tiltfile";
   M_340           : aliased constant String := "Starlark";
   K_341           : aliased constant String := "WORKSPACE.bazel";
   M_341           : aliased constant String := "Starlark";
   K_342           : aliased constant String := "Caddyfile";
   M_342           : aliased constant String := "Caddyfile";
   K_343           : aliased constant String := ".coveragerc";
   M_343           : aliased constant String := "INI";
   K_344           : aliased constant String := "Appraisals";
   M_344           : aliased constant String := "Ruby";
   K_345           : aliased constant String := "man";
   M_345           : aliased constant String := "Shell";
   K_346           : aliased constant String := ".flake8";
   M_346           : aliased constant String := "INI";
   K_347           : aliased constant String := ".ackrc";
   M_347           : aliased constant String := "Option List";
   K_348           : aliased constant String := "Slakefile";
   M_348           : aliased constant String := "LiveScript";
   K_349           : aliased constant String := "Cargo.lock";
   M_349           : aliased constant String := "TOML";
   K_350           : aliased constant String := ".gclient";
   M_350           : aliased constant String := "Python";
   K_351           : aliased constant String := ".bash_logout";
   M_351           : aliased constant String := "Shell";
   K_352           : aliased constant String := "sshd_config";
   M_352           : aliased constant String := "SSH Config";
   K_353           : aliased constant String := "Jakefile";
   M_353           : aliased constant String := "JavaScript";
   K_354           : aliased constant String := "dir_colors";
   M_354           : aliased constant String := "dircolors";
   K_355           : aliased constant String := ".gitconfig";
   M_355           : aliased constant String := "Git Config";
   K_356           : aliased constant String := "configure.ac";
   M_356           : aliased constant String := "M4Sugar";
   K_357           : aliased constant String := ".cvsignore";
   M_357           : aliased constant String := "Ignore List";
   K_358           : aliased constant String := "Rakefile";
   M_358           : aliased constant String := "Ruby";
   K_359           : aliased constant String := ".stylelintignore";
   M_359           : aliased constant String := "Ignore List";
   K_360           : aliased constant String := "9fs";
   M_360           : aliased constant String := "Shell";
   K_361           : aliased constant String := "makefile";
   M_361           : aliased constant String := "Makefile";
   K_362           : aliased constant String := "Steepfile";
   M_362           : aliased constant String := "Ruby";
   K_363           : aliased constant String := "gitignore-global";
   M_363           : aliased constant String := "Ignore List";
   K_364           : aliased constant String := "ssh-config";
   M_364           : aliased constant String := "SSH Config";
   K_365           : aliased constant String := ".zprofile";
   M_365           : aliased constant String := "Shell";
   K_366           : aliased constant String := "glide.lock";
   M_366           : aliased constant String := "YAML";
   K_367           : aliased constant String := ".Justfile";
   M_367           : aliased constant String := "Just";
   K_368           : aliased constant String := ".bzrignore";
   M_368           : aliased constant String := "Ignore List";
   K_369           : aliased constant String := "tsconfig.json";
   M_369           : aliased constant String := "JSON with Comments";
   K_370           : aliased constant String := "encodings.dir";
   M_370           : aliased constant String := "X Font Directory Index";
   K_371           : aliased constant String := "hosts";
   M_371           : aliased constant String := "INI,Hosts File";
   K_372           : aliased constant String := "LICENSE.mysql";
   M_372           : aliased constant String := "Text";
   K_373           : aliased constant String := ".XCompose";
   M_373           : aliased constant String := "XCompose";
   K_374           : aliased constant String := "Lexer.x";
   M_374           : aliased constant String := "Lex";
   K_375           : aliased constant String := "Project.ede";
   M_375           : aliased constant String := "Emacs Lisp";
   K_376           : aliased constant String := "mkfile";
   M_376           : aliased constant String := "Makefile";
   K_377           : aliased constant String := "Pipfile.lock";
   M_377           : aliased constant String := "JSON";
   K_378           : aliased constant String := ".zshenv";
   M_378           : aliased constant String := "Shell";
   K_379           : aliased constant String := "crontab";
   M_379           : aliased constant String := "crontab";
   K_380           : aliased constant String := "APKBUILD";
   M_380           : aliased constant String := "Alpine Abuild";
   K_381           : aliased constant String := "fp-lib-table";
   M_381           : aliased constant String := "KiCad Layout";
   K_382           : aliased constant String := ".cshrc";
   M_382           : aliased constant String := "Shell";

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
      K_380'Access, K_381'Access, K_382'Access);

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
      M_380'Access, M_381'Access, M_382'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.FilenameMap;
