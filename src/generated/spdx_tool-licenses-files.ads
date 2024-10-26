--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  License templates extracted from https://github.com/spdx/license-list-data.git
package SPDX_Tool.Licenses.Files is

   Names_Count : constant := 519;
   Names : constant Name_Array;

   --  Returns the data stream with the given name or null.
   function Get_Content (Name : String) return
      access constant Buffer_Type;

private

   K_0             : aliased constant String := "Apache-2.0-alt";
   K_1             : aliased constant String := "gnat-asis";
   K_2             : aliased constant String := "gnat-gcc";
   K_3             : aliased constant String := "gnat-gcc-exception";
   K_4             : aliased constant String := "standard/0BSD";
   K_5             : aliased constant String := "standard/389-exception";
   K_6             : aliased constant String := "standard/AAL";
   K_7             : aliased constant String := "standard/ADSL";
   K_8             : aliased constant String := "standard/AFL-1.1";
   K_9             : aliased constant String := "standard/AFL-1.2";
   K_10            : aliased constant String := "standard/AFL-2.0";
   K_11            : aliased constant String := "standard/AFL-2.1";
   K_12            : aliased constant String := "standard/AFL-3.0";
   K_13            : aliased constant String := "standard/AGPL-3.0";
   K_14            : aliased constant String := "standard/AGPL-3.0-only";
   K_15            : aliased constant String := "standard/AGPL-3.0-or-later";
   K_16            : aliased constant String := "standard/AMD-newlib";
   K_17            : aliased constant String := "standard/AML";
   K_18            : aliased constant String := "standard/AML-glslang";
   K_19            : aliased constant String := "standard/AMPAS";
   K_20            : aliased constant String := "standard/ANTLR-PD";
   K_21            : aliased constant String := "standard/ANTLR-PD-fallback";
   K_22            : aliased constant String := "standard/APAFML";
   K_23            : aliased constant String := "standard/APSL-2.0";
   K_24            : aliased constant String := "standard/ASWF-Digital-Assets-1.0";
   K_25            : aliased constant String := "standard/ASWF-Digital-Assets-1.1";
   K_26            : aliased constant String := "standard/Abstyles";
   K_27            : aliased constant String := "standard/AdaCore-doc";
   K_28            : aliased constant String := "standard/Adobe-2006";
   K_29            : aliased constant String := "standard/Adobe-Display-PostScript";
   K_30            : aliased constant String := "standard/Adobe-Glyph";
   K_31            : aliased constant String := "standard/Adobe-Utopia";
   K_32            : aliased constant String := "standard/Afmparse";
   K_33            : aliased constant String := "standard/Apache-1.0";
   K_34            : aliased constant String := "standard/Apache-1.1";
   K_35            : aliased constant String := "standard/Apache-2.0";
   K_36            : aliased constant String := "standard/App-s2p";
   K_37            : aliased constant String := "standard/Asterisk-exception";
   K_38            : aliased constant String := "standard/Autoconf-exception-2.0";
   K_39            : aliased constant String := "standard/Autoconf-exception-3.0";
   K_40            : aliased constant String := "standard/Autoconf-exception-generic";
   K_41            : aliased constant String := "standard/Autoconf-exception-generic-3.0";
   K_42            : aliased constant String := "standard/Autoconf-exception-macro";
   K_43            : aliased constant String := "standard/BSD-1-Clause";
   K_44            : aliased constant String := "standard/BSD-2-Clause";
   K_45            : aliased constant String := "standard/BSD-2-Clause-Darwin";
   K_46            : aliased constant String := "standard/BSD-2-Clause-FreeBSD";
   K_47            : aliased constant String := "standard/BSD-2-Clause-NetBSD";
   K_48            : aliased constant String := "standard/BSD-2-Clause-Patent";
   K_49            : aliased constant String := "standard/BSD-2-Clause-Views";
   K_50            : aliased constant String := "standard/BSD-2-clause-first-lines";
   K_51            : aliased constant String := "standard/BSD-3-Clause";
   K_52            : aliased constant String := "standard/BSD-3-Clause-Attribution";
   K_53            : aliased constant String := "standard/BSD-3-Clause-Clear";
   K_54            : aliased constant String := "standard/BSD-3-Clause-HP";
   K_55            : aliased constant String := "standard/BSD-3-Clause-LBNL";
   K_56            : aliased constant String := "standard/BSD-3-Clause-Modification";
   K_57            : aliased constant String := "standard/BSD-3-Clause-No-Military-License";
   K_58            : aliased constant String := "standard/BSD-3-Clause-No-Nuclear-License";
   K_59            : aliased constant String := "standard/BSD-3-Clause-No-Nuclear-License-2014";
   K_60            : aliased constant String := "standard/BSD-3-Clause-No-Nuclear-Warranty";
   K_61            : aliased constant String := "standard/BSD-3-Clause-Open-MPI";
   K_62            : aliased constant String := "standard/BSD-3-Clause-Sun";
   K_63            : aliased constant String := "standard/BSD-3-Clause-acpica";
   K_64            : aliased constant String := "standard/BSD-3-Clause-flex";
   K_65            : aliased constant String := "standard/BSD-4-Clause";
   K_66            : aliased constant String := "standard/BSD-4-Clause-Shortened";
   K_67            : aliased constant String := "standard/BSD-4-Clause-UC";
   K_68            : aliased constant String := "standard/BSD-4.3RENO";
   K_69            : aliased constant String := "standard/BSD-4.3TAHOE";
   K_70            : aliased constant String := "standard/BSD-Advertising-Acknowledgement";
   K_71            : aliased constant String := "standard/BSD-Attribution-HPND-disclaimer";
   K_72            : aliased constant String := "standard/BSD-Inferno-Nettverk";
   K_73            : aliased constant String := "standard/BSD-Source-Code";
   K_74            : aliased constant String := "standard/BSD-Source-beginning-file";
   K_75            : aliased constant String := "standard/BSD-Systemics";
   K_76            : aliased constant String := "standard/BSD-Systemics-W3Works";
   K_77            : aliased constant String := "standard/BSL-1.0";
   K_78            : aliased constant String := "standard/BUSL-1.1";
   K_79            : aliased constant String := "standard/Baekmuk";
   K_80            : aliased constant String := "standard/Bahyph";
   K_81            : aliased constant String := "standard/Barr";
   K_82            : aliased constant String := "standard/Beerware";
   K_83            : aliased constant String := "standard/Bison-exception-1.24";
   K_84            : aliased constant String := "standard/Bison-exception-2.2";
   K_85            : aliased constant String := "standard/BitTorrent-1.0";
   K_86            : aliased constant String := "standard/BitTorrent-1.1";
   K_87            : aliased constant String := "standard/Bitstream-Charter";
   K_88            : aliased constant String := "standard/Bitstream-Vera";
   K_89            : aliased constant String := "standard/BlueOak-1.0.0";
   K_90            : aliased constant String := "standard/Boehm-GC";
   K_91            : aliased constant String := "standard/Bootloader-exception";
   K_92            : aliased constant String := "standard/Borceux";
   K_93            : aliased constant String := "standard/Brian-Gladman-2-Clause";
   K_94            : aliased constant String := "standard/Brian-Gladman-3-Clause";
   K_95            : aliased constant String := "standard/CC-PDDC";
   K_96            : aliased constant String := "standard/CDLA-Permissive-2.0";
   K_97            : aliased constant String := "standard/CFITSIO";
   K_98            : aliased constant String := "standard/CLISP-exception-2.0";
   K_99            : aliased constant String := "standard/CMU-Mach";
   K_100           : aliased constant String := "standard/CMU-Mach-nodoc";
   K_101           : aliased constant String := "standard/CNRI-Python";
   K_102           : aliased constant String := "standard/COIL-1.0";
   K_103           : aliased constant String := "standard/CPAL-1.0";
   K_104           : aliased constant String := "standard/CUA-OPL-1.0";
   K_105           : aliased constant String := "standard/Caldera";
   K_106           : aliased constant String := "standard/Caldera-no-preamble";
   K_107           : aliased constant String := "standard/Classpath-exception-2.0";
   K_108           : aliased constant String := "standard/Clips";
   K_109           : aliased constant String := "standard/Cornell-Lossless-JPEG";
   K_110           : aliased constant String := "standard/Cronyx";
   K_111           : aliased constant String := "standard/Crossword";
   K_112           : aliased constant String := "standard/CrystalStacker";
   K_113           : aliased constant String := "standard/Cube";
   K_114           : aliased constant String := "standard/DEC-3-Clause";
   K_115           : aliased constant String := "standard/DL-DE-BY-2.0";
   K_116           : aliased constant String := "standard/DL-DE-ZERO-2.0";
   K_117           : aliased constant String := "standard/DRL-1.0";
   K_118           : aliased constant String := "standard/DRL-1.1";
   K_119           : aliased constant String := "standard/DSDP";
   K_120           : aliased constant String := "standard/DigiRule-FOSS-exception";
   K_121           : aliased constant String := "standard/Dotseqn";
   K_122           : aliased constant String := "standard/ECL-1.0";
   K_123           : aliased constant String := "standard/ECL-2.0";
   K_124           : aliased constant String := "standard/EFL-1.0";
   K_125           : aliased constant String := "standard/EFL-2.0";
   K_126           : aliased constant String := "standard/EUDatagrid";
   K_127           : aliased constant String := "standard/Elastic-2.0";
   K_128           : aliased constant String := "standard/Entessa";
   K_129           : aliased constant String := "standard/Eurosym";
   K_130           : aliased constant String := "standard/FBM";
   K_131           : aliased constant String := "standard/FLTK-exception";
   K_132           : aliased constant String := "standard/FSFAP";
   K_133           : aliased constant String := "standard/FSFAP-no-warranty-disclaimer";
   K_134           : aliased constant String := "standard/FSFUL";
   K_135           : aliased constant String := "standard/FSFULLR";
   K_136           : aliased constant String := "standard/FSFULLRWD";
   K_137           : aliased constant String := "standard/Fair";
   K_138           : aliased constant String := "standard/Fawkes-Runtime-exception";
   K_139           : aliased constant String := "standard/Ferguson-Twofish";
   K_140           : aliased constant String := "standard/Font-exception-2.0";
   K_141           : aliased constant String := "standard/FreeBSD-DOC";
   K_142           : aliased constant String := "standard/Furuseth";
   K_143           : aliased constant String := "standard/GCC-exception-2.0";
   K_144           : aliased constant String := "standard/GCC-exception-2.0-note";
   K_145           : aliased constant String := "standard/GCC-exception-3.1";
   K_146           : aliased constant String := "standard/GCR-docs";
   K_147           : aliased constant String := "standard/GD";
   K_148           : aliased constant String := "standard/GFDL-1.1";
   K_149           : aliased constant String := "standard/GFDL-1.1-invariants-only";
   K_150           : aliased constant String := "standard/GFDL-1.1-invariants-or-later";
   K_151           : aliased constant String := "standard/GFDL-1.1-no-invariants-only";
   K_152           : aliased constant String := "standard/GFDL-1.1-no-invariants-or-later";
   K_153           : aliased constant String := "standard/GFDL-1.1-only";
   K_154           : aliased constant String := "standard/GFDL-1.1-or-later";
   K_155           : aliased constant String := "standard/GFDL-1.2";
   K_156           : aliased constant String := "standard/GFDL-1.2-invariants-only";
   K_157           : aliased constant String := "standard/GFDL-1.2-invariants-or-later";
   K_158           : aliased constant String := "standard/GFDL-1.2-no-invariants-only";
   K_159           : aliased constant String := "standard/GFDL-1.2-no-invariants-or-later";
   K_160           : aliased constant String := "standard/GFDL-1.2-only";
   K_161           : aliased constant String := "standard/GFDL-1.2-or-later";
   K_162           : aliased constant String := "standard/GFDL-1.3";
   K_163           : aliased constant String := "standard/GFDL-1.3-invariants-only";
   K_164           : aliased constant String := "standard/GFDL-1.3-invariants-or-later";
   K_165           : aliased constant String := "standard/GFDL-1.3-no-invariants-only";
   K_166           : aliased constant String := "standard/GFDL-1.3-no-invariants-or-later";
   K_167           : aliased constant String := "standard/GFDL-1.3-only";
   K_168           : aliased constant String := "standard/GFDL-1.3-or-later";
   K_169           : aliased constant String := "standard/GL2PS";
   K_170           : aliased constant String := "standard/GLWTPL";
   K_171           : aliased constant String := "standard/GNAT-exception";
   K_172           : aliased constant String := "standard/GNOME-examples-exception";
   K_173           : aliased constant String := "standard/GNU-compiler-exception";
   K_174           : aliased constant String := "standard/GPL-1.0";
   K_175           : aliased constant String := "standard/GPL-1.0+";
   K_176           : aliased constant String := "standard/GPL-1.0-only";
   K_177           : aliased constant String := "standard/GPL-1.0-or-later";
   K_178           : aliased constant String := "standard/GPL-2.0";
   K_179           : aliased constant String := "standard/GPL-2.0+";
   K_180           : aliased constant String := "standard/GPL-2.0-only";
   K_181           : aliased constant String := "standard/GPL-2.0-or-later";
   K_182           : aliased constant String := "standard/GPL-2.0-with-GCC-exception";
   K_183           : aliased constant String := "standard/GPL-2.0-with-autoconf-exception";
   K_184           : aliased constant String := "standard/GPL-2.0-with-bison-exception";
   K_185           : aliased constant String := "standard/GPL-2.0-with-classpath-exception";
   K_186           : aliased constant String := "standard/GPL-2.0-with-font-exception";
   K_187           : aliased constant String := "standard/GPL-3.0";
   K_188           : aliased constant String := "standard/GPL-3.0+";
   K_189           : aliased constant String := "standard/GPL-3.0-interface-exception";
   K_190           : aliased constant String := "standard/GPL-3.0-linking-exception";
   K_191           : aliased constant String := "standard/GPL-3.0-linking-source-exception";
   K_192           : aliased constant String := "standard/GPL-3.0-only";
   K_193           : aliased constant String := "standard/GPL-3.0-or-later";
   K_194           : aliased constant String := "standard/GPL-3.0-with-GCC-exception";
   K_195           : aliased constant String := "standard/GPL-3.0-with-autoconf-exception";
   K_196           : aliased constant String := "standard/GPL-CC-1.0";
   K_197           : aliased constant String := "standard/GStreamer-exception-2005";
   K_198           : aliased constant String := "standard/GStreamer-exception-2008";
   K_199           : aliased constant String := "standard/Giftware";
   K_200           : aliased constant String := "standard/Glulxe";
   K_201           : aliased constant String := "standard/Gmsh-exception";
   K_202           : aliased constant String := "standard/Graphics-Gems";
   K_203           : aliased constant String := "standard/HP-1986";
   K_204           : aliased constant String := "standard/HP-1989";
   K_205           : aliased constant String := "standard/HPND";
   K_206           : aliased constant String := "standard/HPND-DEC";
   K_207           : aliased constant String := "standard/HPND-Fenneberg-Livingston";
   K_208           : aliased constant String := "standard/HPND-INRIA-IMAG";
   K_209           : aliased constant String := "standard/HPND-Kevlin-Henney";
   K_210           : aliased constant String := "standard/HPND-MIT-disclaimer";
   K_211           : aliased constant String := "standard/HPND-Markus-Kuhn";
   K_212           : aliased constant String := "standard/HPND-Pbmplus";
   K_213           : aliased constant String := "standard/HPND-UC";
   K_214           : aliased constant String := "standard/HPND-UC-export-US";
   K_215           : aliased constant String := "standard/HPND-doc";
   K_216           : aliased constant String := "standard/HPND-doc-sell";
   K_217           : aliased constant String := "standard/HPND-export-US";
   K_218           : aliased constant String := "standard/HPND-export-US-modify";
   K_219           : aliased constant String := "standard/HPND-sell-MIT-disclaimer-xserver";
   K_220           : aliased constant String := "standard/HPND-sell-regexpr";
   K_221           : aliased constant String := "standard/HPND-sell-variant";
   K_222           : aliased constant String := "standard/HPND-sell-variant-MIT-disclaimer";
   K_223           : aliased constant String := "standard/HTMLTIDY";
   K_224           : aliased constant String := "standard/HaskellReport";
   K_225           : aliased constant String := "standard/IBM-pibs";
   K_226           : aliased constant String := "standard/ICU";
   K_227           : aliased constant String := "standard/IEC-Code-Components-EULA";
   K_228           : aliased constant String := "standard/IJG-short";
   K_229           : aliased constant String := "standard/ISC";
   K_230           : aliased constant String := "standard/ISC-Veillard";
   K_231           : aliased constant String := "standard/Imlib2";
   K_232           : aliased constant String := "standard/Info-ZIP";
   K_233           : aliased constant String := "standard/Inner-Net-2.0";
   K_234           : aliased constant String := "standard/Intel";
   K_235           : aliased constant String := "standard/Interbase-1.0";
   K_236           : aliased constant String := "standard/JPL-image";
   K_237           : aliased constant String := "standard/JPNIC";
   K_238           : aliased constant String := "standard/JSON";
   K_239           : aliased constant String := "standard/Jam";
   K_240           : aliased constant String := "standard/JasPer-2.0";
   K_241           : aliased constant String := "standard/Kastrup";
   K_242           : aliased constant String := "standard/Kazlib";
   K_243           : aliased constant String := "standard/KiCad-libraries-exception";
   K_244           : aliased constant String := "standard/Knuth-CTAN";
   K_245           : aliased constant String := "standard/LGPL-2.0";
   K_246           : aliased constant String := "standard/LGPL-2.0+";
   K_247           : aliased constant String := "standard/LGPL-2.0-only";
   K_248           : aliased constant String := "standard/LGPL-2.0-or-later";
   K_249           : aliased constant String := "standard/LGPL-2.1";
   K_250           : aliased constant String := "standard/LGPL-2.1+";
   K_251           : aliased constant String := "standard/LGPL-2.1-only";
   K_252           : aliased constant String := "standard/LGPL-2.1-or-later";
   K_253           : aliased constant String := "standard/LGPL-3.0-linking-exception";
   K_254           : aliased constant String := "standard/LLGPL";
   K_255           : aliased constant String := "standard/LLVM-exception";
   K_256           : aliased constant String := "standard/LOOP";
   K_257           : aliased constant String := "standard/LPD-document";
   K_258           : aliased constant String := "standard/LPPL-1.0";
   K_259           : aliased constant String := "standard/LPPL-1.1";
   K_260           : aliased constant String := "standard/LPPL-1.2";
   K_261           : aliased constant String := "standard/LPPL-1.3a";
   K_262           : aliased constant String := "standard/LPPL-1.3c";
   K_263           : aliased constant String := "standard/LZMA-SDK-9.11-to-9.20";
   K_264           : aliased constant String := "standard/LZMA-SDK-9.22";
   K_265           : aliased constant String := "standard/LZMA-exception";
   K_266           : aliased constant String := "standard/Latex2e";
   K_267           : aliased constant String := "standard/Latex2e-translated-notice";
   K_268           : aliased constant String := "standard/Leptonica";
   K_269           : aliased constant String := "standard/Libtool-exception";
   K_270           : aliased constant String := "standard/Linux-OpenIB";
   K_271           : aliased constant String := "standard/Linux-man-pages-1-para";
   K_272           : aliased constant String := "standard/Linux-man-pages-copyleft";
   K_273           : aliased constant String := "standard/Linux-man-pages-copyleft-2-para";
   K_274           : aliased constant String := "standard/Linux-man-pages-copyleft-var";
   K_275           : aliased constant String := "standard/Linux-syscall-note";
   K_276           : aliased constant String := "standard/Lucida-Bitmap-Fonts";
   K_277           : aliased constant String := "standard/MIT";
   K_278           : aliased constant String := "standard/MIT-0";
   K_279           : aliased constant String := "standard/MIT-CMU";
   K_280           : aliased constant String := "standard/MIT-Festival";
   K_281           : aliased constant String := "standard/MIT-Khronos-old";
   K_282           : aliased constant String := "standard/MIT-Modern-Variant";
   K_283           : aliased constant String := "standard/MIT-Wu";
   K_284           : aliased constant String := "standard/MIT-advertising";
   K_285           : aliased constant String := "standard/MIT-enna";
   K_286           : aliased constant String := "standard/MIT-feh";
   K_287           : aliased constant String := "standard/MIT-open-group";
   K_288           : aliased constant String := "standard/MIT-testregex";
   K_289           : aliased constant String := "standard/MITNFA";
   K_290           : aliased constant String := "standard/MMIXware";
   K_291           : aliased constant String := "standard/MPEG-SSG";
   K_292           : aliased constant String := "standard/MPL-1.0";
   K_293           : aliased constant String := "standard/MPL-1.1";
   K_294           : aliased constant String := "standard/MPL-2.0";
   K_295           : aliased constant String := "standard/MPL-2.0-no-copyleft-exception";
   K_296           : aliased constant String := "standard/MS-LPL";
   K_297           : aliased constant String := "standard/MS-PL";
   K_298           : aliased constant String := "standard/MS-RL";
   K_299           : aliased constant String := "standard/MTLL";
   K_300           : aliased constant String := "standard/Mackerras-3-Clause";
   K_301           : aliased constant String := "standard/Mackerras-3-Clause-acknowledgment";
   K_302           : aliased constant String := "standard/MakeIndex";
   K_303           : aliased constant String := "standard/Martin-Birgmeier";
   K_304           : aliased constant String := "standard/McPhee-slideshow";
   K_305           : aliased constant String := "standard/Minpack";
   K_306           : aliased constant String := "standard/MirOS";
   K_307           : aliased constant String := "standard/MulanPSL-1.0";
   K_308           : aliased constant String := "standard/MulanPSL-2.0";
   K_309           : aliased constant String := "standard/Multics";
   K_310           : aliased constant String := "standard/Mup";
   K_311           : aliased constant String := "standard/NAIST-2003";
   K_312           : aliased constant String := "standard/NCL";
   K_313           : aliased constant String := "standard/NCSA";
   K_314           : aliased constant String := "standard/NICTA-1.0";
   K_315           : aliased constant String := "standard/NIST-PD";
   K_316           : aliased constant String := "standard/NIST-PD-fallback";
   K_317           : aliased constant String := "standard/NIST-Software";
   K_318           : aliased constant String := "standard/NLPL";
   K_319           : aliased constant String := "standard/NRL";
   K_320           : aliased constant String := "standard/NTP";
   K_321           : aliased constant String := "standard/NTP-0";
   K_322           : aliased constant String := "standard/Naumen";
   K_323           : aliased constant String := "standard/NetCDF";
   K_324           : aliased constant String := "standard/Newsletr";
   K_325           : aliased constant String := "standard/Nokia-Qt-exception-1.1";
   K_326           : aliased constant String := "standard/Noweb";
   K_327           : aliased constant String := "standard/Nunit";
   K_328           : aliased constant String := "standard/OAR";
   K_329           : aliased constant String := "standard/OCCT-exception-1.0";
   K_330           : aliased constant String := "standard/OCLC-2.0";
   K_331           : aliased constant String := "standard/OCaml-LGPL-linking-exception";
   K_332           : aliased constant String := "standard/OFFIS";
   K_333           : aliased constant String := "standard/OGC-1.0";
   K_334           : aliased constant String := "standard/OLDAP-2.0";
   K_335           : aliased constant String := "standard/OLDAP-2.0.1";
   K_336           : aliased constant String := "standard/OLDAP-2.1";
   K_337           : aliased constant String := "standard/OLDAP-2.2";
   K_338           : aliased constant String := "standard/OLDAP-2.2.1";
   K_339           : aliased constant String := "standard/OLDAP-2.2.2";
   K_340           : aliased constant String := "standard/OLDAP-2.3";
   K_341           : aliased constant String := "standard/OLDAP-2.4";
   K_342           : aliased constant String := "standard/OLDAP-2.5";
   K_343           : aliased constant String := "standard/OLDAP-2.6";
   K_344           : aliased constant String := "standard/OLDAP-2.7";
   K_345           : aliased constant String := "standard/OLDAP-2.8";
   K_346           : aliased constant String := "standard/OML";
   K_347           : aliased constant String := "standard/OSL-1.0";
   K_348           : aliased constant String := "standard/OSL-1.1";
   K_349           : aliased constant String := "standard/OSL-2.0";
   K_350           : aliased constant String := "standard/OSL-2.1";
   K_351           : aliased constant String := "standard/OSL-3.0";
   K_352           : aliased constant String := "standard/OpenJDK-assembly-exception-1.0";
   K_353           : aliased constant String := "standard/OpenSSL-standalone";
   K_354           : aliased constant String := "standard/OpenVision";
   K_355           : aliased constant String := "standard/PADL";
   K_356           : aliased constant String := "standard/PHP-3.0";
   K_357           : aliased constant String := "standard/PHP-3.01";
   K_358           : aliased constant String := "standard/PS-or-PDF-font-exception-20170817";
   K_359           : aliased constant String := "standard/Parity-6.0.0";
   K_360           : aliased constant String := "standard/Pixar";
   K_361           : aliased constant String := "standard/Plexus";
   K_362           : aliased constant String := "standard/PostgreSQL";
   K_363           : aliased constant String := "standard/QPL-1.0-INRIA-2004-exception";
   K_364           : aliased constant String := "standard/Qhull";
   K_365           : aliased constant String := "standard/Qt-GPL-exception-1.0";
   K_366           : aliased constant String := "standard/Qt-LGPL-exception-1.1";
   K_367           : aliased constant String := "standard/Qwt-exception-1.0";
   K_368           : aliased constant String := "standard/RPSL-1.0";
   K_369           : aliased constant String := "standard/RSA-MD";
   K_370           : aliased constant String := "standard/Rdisc";
   K_371           : aliased constant String := "standard/Ruby";
   K_372           : aliased constant String := "standard/SANE-exception";
   K_373           : aliased constant String := "standard/SAX-PD";
   K_374           : aliased constant String := "standard/SAX-PD-2.0";
   K_375           : aliased constant String := "standard/SCEA";
   K_376           : aliased constant String := "standard/SGI-B-1.0";
   K_377           : aliased constant String := "standard/SGI-B-1.1";
   K_378           : aliased constant String := "standard/SGI-B-2.0";
   K_379           : aliased constant String := "standard/SGI-OpenGL";
   K_380           : aliased constant String := "standard/SGP4";
   K_381           : aliased constant String := "standard/SHL-0.5";
   K_382           : aliased constant String := "standard/SHL-0.51";
   K_383           : aliased constant String := "standard/SHL-2.0";
   K_384           : aliased constant String := "standard/SHL-2.1";
   K_385           : aliased constant String := "standard/SISSL";
   K_386           : aliased constant String := "standard/SISSL-1.2";
   K_387           : aliased constant String := "standard/SL";
   K_388           : aliased constant String := "standard/SMLNJ";
   K_389           : aliased constant String := "standard/SMPPL";
   K_390           : aliased constant String := "standard/SPL-1.0";
   K_391           : aliased constant String := "standard/SSH-OpenSSH";
   K_392           : aliased constant String := "standard/SSH-short";
   K_393           : aliased constant String := "standard/SSLeay-standalone";
   K_394           : aliased constant String := "standard/SSPL-1.0";
   K_395           : aliased constant String := "standard/SWI-exception";
   K_396           : aliased constant String := "standard/SWL";
   K_397           : aliased constant String := "standard/Saxpath";
   K_398           : aliased constant String := "standard/SchemeReport";
   K_399           : aliased constant String := "standard/SimPL-2.0";
   K_400           : aliased constant String := "standard/Soundex";
   K_401           : aliased constant String := "standard/Spencer-86";
   K_402           : aliased constant String := "standard/Spencer-94";
   K_403           : aliased constant String := "standard/Spencer-99";
   K_404           : aliased constant String := "standard/StandardML-NJ";
   K_405           : aliased constant String := "standard/Sun-PPP";
   K_406           : aliased constant String := "standard/Sun-PPP-2000";
   K_407           : aliased constant String := "standard/SunPro";
   K_408           : aliased constant String := "standard/Swift-exception";
   K_409           : aliased constant String := "standard/Symlinks";
   K_410           : aliased constant String := "standard/TCL";
   K_411           : aliased constant String := "standard/TCP-wrappers";
   K_412           : aliased constant String := "standard/TGPPL-1.0";
   K_413           : aliased constant String := "standard/TMate";
   K_414           : aliased constant String := "standard/TOSL";
   K_415           : aliased constant String := "standard/TPDL";
   K_416           : aliased constant String := "standard/TPL-1.0";
   K_417           : aliased constant String := "standard/TTWL";
   K_418           : aliased constant String := "standard/TTYP0";
   K_419           : aliased constant String := "standard/TU-Berlin-1.0";
   K_420           : aliased constant String := "standard/TU-Berlin-2.0";
   K_421           : aliased constant String := "standard/TermReadKey";
   K_422           : aliased constant String := "standard/Texinfo-exception";
   K_423           : aliased constant String := "standard/UBDL-exception";
   K_424           : aliased constant String := "standard/UCAR";
   K_425           : aliased constant String := "standard/UCL-1.0";
   K_426           : aliased constant String := "standard/UMich-Merit";
   K_427           : aliased constant String := "standard/UPL-1.0";
   K_428           : aliased constant String := "standard/URT-RLE";
   K_429           : aliased constant String := "standard/Unicode-3.0";
   K_430           : aliased constant String := "standard/Unicode-DFS-2015";
   K_431           : aliased constant String := "standard/Unicode-DFS-2016";
   K_432           : aliased constant String := "standard/Universal-FOSS-exception-1.0";
   K_433           : aliased constant String := "standard/UnixCrypt";
   K_434           : aliased constant String := "standard/Unlicense";
   K_435           : aliased constant String := "standard/VOSTROM";
   K_436           : aliased constant String := "standard/VSL-1.0";
   K_437           : aliased constant String := "standard/W3C";
   K_438           : aliased constant String := "standard/W3C-19980720";
   K_439           : aliased constant String := "standard/W3C-20150513";
   K_440           : aliased constant String := "standard/WTFPL";
   K_441           : aliased constant String := "standard/Widget-Workshop";
   K_442           : aliased constant String := "standard/Wsuipa";
   K_443           : aliased constant String := "standard/WxWindows-exception-3.1";
   K_444           : aliased constant String := "standard/X11";
   K_445           : aliased constant String := "standard/X11-distribute-modifications-variant";
   K_446           : aliased constant String := "standard/XFree86-1.1";
   K_447           : aliased constant String := "standard/XSkat";
   K_448           : aliased constant String := "standard/Xdebug-1.03";
   K_449           : aliased constant String := "standard/Xerox";
   K_450           : aliased constant String := "standard/Xfig";
   K_451           : aliased constant String := "standard/Xnet";
   K_452           : aliased constant String := "standard/ZPL-1.1";
   K_453           : aliased constant String := "standard/ZPL-2.0";
   K_454           : aliased constant String := "standard/ZPL-2.1";
   K_455           : aliased constant String := "standard/Zed";
   K_456           : aliased constant String := "standard/Zeeff";
   K_457           : aliased constant String := "standard/Zend-2.0";
   K_458           : aliased constant String := "standard/Zlib";
   K_459           : aliased constant String := "standard/bcrypt-Solar-Designer";
   K_460           : aliased constant String := "standard/blessing";
   K_461           : aliased constant String := "standard/bzip2-1.0.5";
   K_462           : aliased constant String := "standard/bzip2-1.0.6";
   K_463           : aliased constant String := "standard/check-cvs";
   K_464           : aliased constant String := "standard/checkmk";
   K_465           : aliased constant String := "standard/cryptsetup-OpenSSL-exception";
   K_466           : aliased constant String := "standard/curl";
   K_467           : aliased constant String := "standard/diffmark";
   K_468           : aliased constant String := "standard/dtoa";
   K_469           : aliased constant String := "standard/dvipdfm";
   K_470           : aliased constant String := "standard/eCos-2.0";
   K_471           : aliased constant String := "standard/eCos-exception-2.0";
   K_472           : aliased constant String := "standard/fmt-exception";
   K_473           : aliased constant String := "standard/freertos-exception-2.0";
   K_474           : aliased constant String := "standard/fwlw";
   K_475           : aliased constant String := "standard/gnu-javamail-exception";
   K_476           : aliased constant String := "standard/gnuplot";
   K_477           : aliased constant String := "standard/gtkbook";
   K_478           : aliased constant String := "standard/hdparm";
   K_479           : aliased constant String := "standard/i2p-gpl-java-exception";
   K_480           : aliased constant String := "standard/iMatix";
   K_481           : aliased constant String := "standard/libpng-2.0";
   K_482           : aliased constant String := "standard/libpri-OpenH323-exception";
   K_483           : aliased constant String := "standard/libselinux-1.0";
   K_484           : aliased constant String := "standard/libtiff";
   K_485           : aliased constant String := "standard/libutil-David-Nugent";
   K_486           : aliased constant String := "standard/lsof";
   K_487           : aliased constant String := "standard/magaz";
   K_488           : aliased constant String := "standard/mailprio";
   K_489           : aliased constant String := "standard/metamail";
   K_490           : aliased constant String := "standard/mif-exception";
   K_491           : aliased constant String := "standard/mpi-permissive";
   K_492           : aliased constant String := "standard/mpich2";
   K_493           : aliased constant String := "standard/mplus";
   K_494           : aliased constant String := "standard/openvpn-openssl-exception";
   K_495           : aliased constant String := "standard/pkgconf";
   K_496           : aliased constant String := "standard/pnmstitch";
   K_497           : aliased constant String := "standard/psfrag";
   K_498           : aliased constant String := "standard/psutils";
   K_499           : aliased constant String := "standard/python-ldap";
   K_500           : aliased constant String := "standard/radvd";
   K_501           : aliased constant String := "standard/snprintf";
   K_502           : aliased constant String := "standard/softSurfer";
   K_503           : aliased constant String := "standard/ssh-keyscan";
   K_504           : aliased constant String := "standard/stunnel-exception";
   K_505           : aliased constant String := "standard/swrule";
   K_506           : aliased constant String := "standard/threeparttable";
   K_507           : aliased constant String := "standard/u-boot-exception-2.0";
   K_508           : aliased constant String := "standard/ulem";
   K_509           : aliased constant String := "standard/vsftpd-openssl-exception";
   K_510           : aliased constant String := "standard/w3m";
   K_511           : aliased constant String := "standard/wxWindows";
   K_512           : aliased constant String := "standard/x11vnc-openssl-exception";
   K_513           : aliased constant String := "standard/xinetd";
   K_514           : aliased constant String := "standard/xkeyboard-config-Zinoviev";
   K_515           : aliased constant String := "standard/xlock";
   K_516           : aliased constant String := "standard/xpp";
   K_517           : aliased constant String := "standard/xzoom";
   K_518           : aliased constant String := "standard/zlib-acknowledgement";

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
      K_516'Access, K_517'Access, K_518'Access);
end SPDX_Tool.Licenses.Files;
