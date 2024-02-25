--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Extensions mapping generated from extensions.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Files.Extensions is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 8) of Natural :=
     (1, 2, 3, 4, 5, 6, 9, 11, 12);

   T1 : constant array (0 .. 8) of Unsigned_16 :=
     (136, 246, 151, 824, 1296, 709, 2, 1455, 1440);

   T2 : constant array (0 .. 8) of Unsigned_16 :=
     (573, 36, 1399, 1288, 4, 610, 15, 319, 490);

   G : constant array (0 .. 1810) of Unsigned_16 :=
     (0, 11, 0, 0, 0, 592, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 566, 0,
      587, 216, 39, 0, 0, 0, 438, 0, 194, 768, 0, 616, 0, 330, 0, 0, 849,
      28, 103, 0, 0, 850, 0, 0, 0, 0, 0, 417, 0, 88, 0, 0, 0, 0, 0, 0, 14,
      339, 0, 825, 0, 411, 0, 77, 0, 0, 620, 0, 0, 0, 0, 295, 522, 0, 0, 0,
      0, 37, 0, 0, 303, 0, 763, 344, 74, 700, 0, 673, 517, 0, 0, 0, 0, 0, 0,
      0, 725, 0, 675, 0, 140, 0, 612, 108, 0, 0, 0, 821, 340, 227, 0, 497,
      0, 575, 410, 369, 0, 511, 0, 0, 206, 792, 0, 0, 0, 484, 0, 0, 0, 532,
      0, 0, 0, 0, 36, 0, 0, 0, 0, 434, 114, 0, 0, 0, 0, 213, 642, 197, 0, 0,
      0, 0, 0, 274, 253, 627, 801, 0, 0, 0, 493, 187, 0, 0, 212, 337, 225,
      0, 0, 0, 0, 127, 0, 7, 0, 0, 615, 0, 0, 649, 0, 0, 0, 0, 0, 885, 0, 0,
      150, 0, 459, 722, 0, 142, 134, 726, 0, 677, 0, 817, 576, 0, 423, 0, 0,
      0, 0, 0, 598, 333, 134, 649, 0, 0, 235, 0, 0, 0, 289, 113, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 229, 0, 338, 492, 663, 495, 0, 670, 0, 256, 0, 797, 0,
      0, 0, 0, 0, 0, 627, 0, 0, 0, 0, 0, 0, 0, 86, 0, 0, 0, 0, 0, 614, 370,
      0, 0, 78, 0, 0, 11, 561, 0, 6, 140, 90, 0, 0, 804, 145, 0, 0, 0, 586,
      388, 0, 0, 466, 518, 0, 119, 796, 0, 0, 0, 217, 642, 257, 0, 0, 0, 0,
      808, 102, 231, 732, 0, 0, 489, 495, 92, 0, 63, 0, 740, 0, 0, 0, 377,
      588, 0, 764, 0, 0, 785, 346, 0, 216, 768, 778, 119, 348, 0, 537, 0, 0,
      0, 0, 7, 0, 123, 847, 493, 890, 526, 190, 563, 759, 235, 0, 0, 0, 0,
      0, 0, 689, 0, 745, 391, 473, 61, 622, 843, 277, 585, 0, 0, 65, 0, 0,
      0, 0, 542, 247, 222, 0, 862, 0, 687, 565, 0, 0, 0, 0, 18, 0, 5, 0,
      451, 0, 0, 0, 0, 889, 0, 0, 0, 0, 25, 0, 0, 132, 0, 0, 0, 0, 0, 62,
      375, 600, 757, 670, 665, 855, 637, 522, 0, 199, 0, 616, 0, 0, 135,
      409, 0, 0, 813, 0, 0, 0, 0, 0, 0, 373, 0, 194, 0, 0, 761, 643, 645,
      192, 34, 0, 0, 0, 785, 362, 99, 0, 0, 0, 117, 460, 482, 388, 817, 599,
      719, 733, 64, 440, 902, 0, 0, 728, 0, 580, 720, 420, 436, 0, 0, 96,
      308, 0, 0, 126, 0, 326, 0, 0, 260, 0, 561, 67, 187, 209, 0, 0, 0, 190,
      0, 0, 0, 0, 524, 7, 0, 0, 0, 0, 308, 0, 0, 0, 0, 0, 547, 841, 0, 0,
      823, 821, 435, 386, 234, 0, 0, 380, 0, 0, 0, 451, 0, 0, 0, 488, 0, 0,
      0, 0, 0, 0, 0, 263, 344, 0, 859, 0, 0, 642, 0, 0, 272, 0, 550, 0, 0,
      831, 27, 0, 654, 610, 0, 0, 0, 0, 0, 0, 0, 119, 0, 610, 486, 64, 0, 0,
      0, 892, 0, 0, 549, 0, 863, 0, 748, 0, 0, 0, 0, 0, 0, 0, 277, 0, 566,
      0, 0, 0, 0, 0, 0, 348, 0, 0, 0, 0, 129, 0, 0, 0, 0, 326, 250, 514, 0,
      748, 219, 722, 0, 0, 138, 556, 0, 0, 399, 771, 0, 390, 0, 0, 138, 0,
      453, 0, 413, 244, 0, 126, 0, 0, 0, 701, 781, 0, 0, 0, 680, 0, 0, 197,
      734, 280, 502, 0, 666, 409, 0, 738, 0, 78, 0, 87, 237, 112, 717, 0,
      278, 0, 626, 0, 90, 740, 0, 798, 0, 0, 24, 0, 0, 0, 0, 499, 528, 0, 0,
      0, 305, 692, 748, 0, 0, 0, 0, 800, 0, 0, 0, 9, 39, 0, 0, 0, 0, 275,
      11, 0, 0, 631, 348, 185, 710, 0, 0, 0, 0, 0, 883, 0, 0, 338, 8, 0, 0,
      0, 188, 161, 99, 0, 0, 264, 0, 0, 0, 0, 837, 119, 457, 12, 0, 0, 515,
      0, 0, 0, 0, 0, 701, 728, 400, 0, 0, 0, 0, 742, 0, 0, 0, 246, 847, 0,
      308, 0, 0, 0, 338, 592, 0, 0, 35, 823, 0, 0, 391, 119, 0, 0, 0, 0, 0,
      0, 282, 0, 0, 104, 0, 0, 5, 371, 0, 630, 0, 0, 400, 686, 0, 418, 531,
      0, 287, 99, 885, 108, 653, 0, 0, 0, 195, 0, 0, 358, 481, 0, 0, 3, 0,
      99, 184, 114, 2, 523, 0, 693, 178, 16, 91, 0, 220, 0, 0, 0, 437, 740,
      0, 228, 0, 0, 313, 0, 0, 0, 0, 0, 739, 0, 770, 0, 0, 552, 0, 239, 0,
      0, 290, 555, 661, 899, 0, 458, 0, 0, 696, 0, 0, 18, 677, 211, 853, 0,
      681, 115, 480, 735, 679, 716, 0, 0, 0, 0, 0, 713, 0, 707, 0, 680, 877,
      225, 0, 1, 38, 0, 536, 95, 0, 576, 0, 632, 261, 157, 127, 0, 703, 695,
      0, 0, 0, 77, 0, 0, 835, 163, 0, 0, 336, 0, 0, 0, 240, 274, 0, 279, 0,
      581, 0, 51, 685, 0, 292, 0, 0, 652, 131, 81, 16, 94, 765, 0, 0, 0, 0,
      0, 89, 0, 0, 286, 0, 873, 731, 144, 721, 0, 0, 843, 68, 719, 371, 754,
      237, 0, 366, 428, 0, 171, 0, 0, 300, 0, 0, 0, 202, 0, 821, 0, 264,
      202, 844, 441, 0, 0, 721, 558, 0, 0, 5, 0, 750, 0, 0, 0, 0, 0, 860, 0,
      0, 0, 104, 0, 855, 885, 0, 0, 0, 212, 665, 0, 277, 235, 306, 0, 480,
      0, 885, 712, 0, 0, 0, 0, 901, 0, 334, 0, 524, 0, 0, 0, 100, 866, 0, 0,
      0, 0, 503, 0, 0, 25, 0, 0, 0, 858, 149, 0, 0, 326, 0, 0, 0, 35, 0,
      646, 0, 0, 890, 615, 531, 0, 764, 0, 357, 837, 0, 118, 806, 322, 707,
      0, 0, 376, 895, 874, 0, 0, 823, 211, 0, 0, 0, 644, 734, 728, 0, 244,
      0, 0, 5, 230, 0, 0, 854, 0, 0, 74, 0, 464, 423, 0, 0, 0, 798, 649,
      400, 0, 0, 606, 562, 0, 0, 467, 0, 885, 884, 0, 218, 191, 853, 0, 0,
      11, 238, 0, 0, 300, 0, 413, 0, 409, 0, 181, 123, 0, 447, 0, 0, 98, 0,
      0, 0, 0, 592, 602, 0, 401, 633, 0, 0, 0, 0, 0, 727, 0, 95, 687, 0,
      381, 128, 594, 625, 0, 396, 0, 357, 0, 376, 289, 889, 0, 168, 0, 0, 0,
      0, 0, 0, 0, 129, 15, 590, 342, 0, 854, 42, 0, 0, 0, 572, 873, 508,
      640, 716, 226, 0, 843, 180, 0, 0, 172, 0, 753, 239, 832, 0, 0, 374, 0,
      687, 86, 885, 0, 0, 85, 246, 191, 398, 353, 0, 0, 0, 0, 619, 0, 713,
      0, 206, 151, 243, 0, 716, 209, 247, 0, 0, 898, 508, 376, 572, 0, 556,
      867, 465, 0, 0, 34, 0, 837, 0, 0, 415, 0, 382, 215, 0, 506, 63, 0,
      175, 664, 0, 291, 858, 440, 0, 0, 0, 203, 445, 829, 678, 0, 801, 0,
      650, 691, 0, 0, 549, 0, 0, 0, 0, 69, 0, 538, 0, 0, 0, 212, 0, 900,
      508, 0, 0, 0, 0, 491, 502, 336, 0, 478, 103, 28, 709, 0, 158, 21, 0,
      309, 0, 0, 556, 0, 0, 413, 0, 540, 614, 0, 0, 396, 0, 581, 0, 335,
      174, 0, 0, 414, 855, 87, 0, 5, 423, 0, 638, 0, 0, 212, 0, 404, 550,
      470, 0, 348, 0, 0, 0, 715, 0, 80, 661, 397, 291, 818, 0, 869, 878,
      366, 183, 0, 487, 0, 313, 525, 551, 513, 166, 480, 668, 693, 0, 18, 0,
      0, 508, 561, 155, 0, 0, 485, 56, 0, 0, 0, 0, 477, 40, 313, 461, 852,
      0, 0, 114, 0, 200, 0, 0, 0, 0, 0, 0, 0, 84, 108, 0, 0, 725, 639, 120,
      0, 54, 347, 811, 242, 0, 707, 150, 0, 828, 850, 185, 0, 0, 0, 0, 861,
      680, 0, 172, 574, 277, 0, 0, 389, 0, 0, 0, 161, 398, 267, 0, 321, 0,
      29, 0, 797, 433, 192, 0, 0, 0, 0, 187, 0, 0, 0, 0, 827, 278, 0, 1, 0,
      0, 533, 396, 262, 0, 0, 98, 638, 507, 520, 0, 793, 0, 831, 0, 714,
      786, 205, 547, 0, 143, 186, 10, 19, 0, 325, 774, 0, 0, 0, 367, 684,
      235, 570, 174, 457, 753, 0, 49, 426, 135, 0, 0, 187, 0, 91, 342, 0, 0,
      0, 891, 497, 417, 39, 554, 318, 189, 371, 0, 0, 746, 372, 0, 0, 579,
      0, 0, 671, 0, 407, 0, 0, 0, 0, 419, 374, 13, 421, 741, 0, 0, 0, 136,
      440, 225, 0, 0, 0, 772, 206, 0, 0, 0, 0, 771, 0, 362, 0, 0, 0, 124, 0,
      333, 644, 0, 0, 0, 0, 152, 146, 261, 0, 580, 0, 507, 160, 861, 550,
      71, 511, 0, 0, 0, 400, 674, 0, 753, 438, 0, 0, 828, 609, 121, 1, 430,
      12, 0, 76, 0, 0, 214, 360, 711, 0, 0, 49, 0, 552, 840, 772, 0, 0, 0,
      504, 630, 128, 0, 886, 0, 285, 247, 0, 0, 0, 312, 0, 510, 0, 613, 0,
      345, 629, 33, 0, 0, 182, 303, 302, 0, 0, 0, 780, 0, 0, 319, 308, 0, 0,
      0, 40, 788, 0, 0, 653, 209, 468, 0, 809, 519, 69, 566, 0, 450, 0, 45,
      664, 0, 0, 0, 483, 0, 0, 0, 0, 389, 497, 117, 608, 402, 476, 408, 491,
      0, 0, 535, 0, 71, 0, 0, 77, 207, 318, 0, 780, 816, 0, 124, 243, 761,
      137, 0, 0, 164, 14, 564, 677, 105, 661, 0, 0, 0, 552, 654, 369, 431,
      0, 0, 131, 168, 0, 397, 522, 172, 0, 0, 795, 0, 0, 11, 483, 252, 32,
      429, 0, 0, 792, 0, 32, 15, 157, 599, 263, 113, 0, 129, 813, 0, 361, 0,
      90, 0, 589, 0, 312, 43, 0, 212, 753, 747, 121, 0, 587, 36, 106, 823,
      754, 0, 142, 532, 841, 40, 0, 725, 0, 667, 0, 23, 232, 0, 44, 408,
      230, 0, 0, 0, 41, 765, 336, 0, 0, 212, 77, 0, 0, 0, 0, 0, 224, 0, 60,
      647, 0, 637, 0, 674, 146, 858, 0, 469, 0, 520, 583, 0, 0, 190, 380,
      883, 7, 291, 630, 751);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 1811;
         F2 := (F2 + Natural (T2 (K)) * J) mod 1811;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 905;
   end Hash;


   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "gd";
   M_0             : aliased constant String := "GDScript, GAP";
   K_1             : aliased constant String := "bib";
   M_1             : aliased constant String := "TeX";
   K_2             : aliased constant String := "pde";
   M_2             : aliased constant String := "Processing";
   K_3             : aliased constant String := "rdoc";
   M_3             : aliased constant String := "RDoc";
   K_4             : aliased constant String := "gf";
   M_4             : aliased constant String := "Grammatical Framework";
   K_5             : aliased constant String := "lua";
   M_5             : aliased constant String := "Lua";
   K_6             : aliased constant String := "god";
   M_6             : aliased constant String := "Ruby";
   K_7             : aliased constant String := "gi";
   M_7             : aliased constant String := "GAP";
   K_8             : aliased constant String := "_ls";
   M_8             : aliased constant String := "LiveScript";
   K_9             : aliased constant String := "zpl";
   M_9             : aliased constant String := "Zimpl";
   K_10            : aliased constant String := "go";
   M_10            : aliased constant String := "Go";
   K_11            : aliased constant String := "gp";
   M_11            : aliased constant String := "Gnuplot";
   K_12            : aliased constant String := "gs";
   M_12            : aliased constant String := "JavaScript, Gosu";
   K_13            : aliased constant String := "f77";
   M_13            : aliased constant String := "FORTRAN";
   K_14            : aliased constant String := "gv";
   M_14            : aliased constant String := "Graphviz (DOT)";
   K_15            : aliased constant String := "org";
   M_15            : aliased constant String := "Org";
   K_16            : aliased constant String := "sthlp";
   M_16            : aliased constant String := "Stata";
   K_17            : aliased constant String := "tmCommand";
   M_17            : aliased constant String := "XML";
   K_18            : aliased constant String := "apib";
   M_18            : aliased constant String := "API Blueprint";
   K_19            : aliased constant String := "cproject";
   M_19            : aliased constant String := "XML";
   K_20            : aliased constant String := "txl";
   M_20            : aliased constant String := "TXL";
   K_21            : aliased constant String := "awk";
   M_21            : aliased constant String := "Awk";
   K_22            : aliased constant String := "sas";
   M_22            : aliased constant String := "SAS";
   K_23            : aliased constant String := "styl";
   M_23            : aliased constant String := "Stylus";
   K_24            : aliased constant String := "ipynb";
   M_24            : aliased constant String := "Jupyter Notebook";
   K_25            : aliased constant String := "1in";
   M_25            : aliased constant String := "Groff";
   K_26            : aliased constant String := "txt";
   M_26            : aliased constant String := "Text";
   K_27            : aliased constant String := "hcl";
   M_27            : aliased constant String := "HCL";
   K_28            : aliased constant String := "mustache";
   M_28            : aliased constant String := "HTML+Django";
   K_29            : aliased constant String := "lagda";
   M_29            : aliased constant String := "Literate Agda";
   K_30            : aliased constant String := "ron";
   M_30            : aliased constant String := "Markdown";
   K_31            : aliased constant String := "intr";
   M_31            : aliased constant String := "Dylan";
   K_32            : aliased constant String := "mir";
   M_32            : aliased constant String := "Mirah";
   K_33            : aliased constant String := "wiki";
   M_33            : aliased constant String := "MediaWiki";
   K_34            : aliased constant String := "1";
   M_34            : aliased constant String := "Groff";
   K_35            : aliased constant String := "ik";
   M_35            : aliased constant String := "Ioke";
   K_36            : aliased constant String := "psgi";
   M_36            : aliased constant String := "Perl";
   K_37            : aliased constant String := "2";
   M_37            : aliased constant String := "Groff";
   K_38            : aliased constant String := "f90";
   M_38            : aliased constant String := "FORTRAN";
   K_39            : aliased constant String := "3";
   M_39            : aliased constant String := "Groff";
   K_40            : aliased constant String := "4";
   M_40            : aliased constant String := "Groff";
   K_41            : aliased constant String := "5";
   M_41            : aliased constant String := "Groff";
   K_42            : aliased constant String := "dtx";
   M_42            : aliased constant String := "TeX";
   K_43            : aliased constant String := "io";
   M_43            : aliased constant String := "Io";
   K_44            : aliased constant String := "6";
   M_44            : aliased constant String := "Groff";
   K_45            : aliased constant String := "weechatlog";
   M_45            : aliased constant String := "IRC log";
   K_46            : aliased constant String := "xib";
   M_46            : aliased constant String := "XML";
   K_47            : aliased constant String := "7";
   M_47            : aliased constant String := "Groff";
   K_48            : aliased constant String := "scd";
   M_48            : aliased constant String := "SuperCollider";
   K_49            : aliased constant String := "f95";
   M_49            : aliased constant String := "FORTRAN";
   K_50            : aliased constant String := "8";
   M_50            : aliased constant String := "Groff";
   K_51            : aliased constant String := "sce";
   M_51            : aliased constant String := "Scilab";
   K_52            : aliased constant String := "lvproj";
   M_52            : aliased constant String := "LabVIEW";
   K_53            : aliased constant String := "9";
   M_53            : aliased constant String := "Groff";
   K_54            : aliased constant String := "hxsl";
   M_54            : aliased constant String := "Haxe";
   K_55            : aliased constant String := "fish";
   M_55            : aliased constant String := "fish";
   K_56            : aliased constant String := "sch";
   M_56            : aliased constant String := "KiCad, Eagle";
   K_57            : aliased constant String := "sci";
   M_57            : aliased constant String := "Scilab";
   K_58            : aliased constant String := "pmod";
   M_58            : aliased constant String := "Pike";
   K_59            : aliased constant String := "scm";
   M_59            : aliased constant String := "Scheme";
   K_60            : aliased constant String := "cljc";
   M_60            : aliased constant String := "Clojure";
   K_61            : aliased constant String := "C";
   M_61            : aliased constant String := "C++";
   K_62            : aliased constant String := "E";
   M_62            : aliased constant String := "E";
   K_63            : aliased constant String := "sublime-commands";
   M_63            : aliased constant String := "JavaScript";
   K_64            : aliased constant String := "mkd";
   M_64            : aliased constant String := "Markdown";
   K_65            : aliased constant String := "reek";
   M_65            : aliased constant String := "YAML";
   K_66            : aliased constant String := "jsfl";
   M_66            : aliased constant String := "JavaScript";
   K_67            : aliased constant String := "cljs";
   M_67            : aliased constant String := "Clojure";
   K_68            : aliased constant String := "m4";
   M_68            : aliased constant String := "M4Sugar, M4";
   K_69            : aliased constant String := "cljx";
   M_69            : aliased constant String := "Clojure";
   K_70            : aliased constant String := "axs.erb";
   M_70            : aliased constant String := "NetLinx+ERB";
   K_71            : aliased constant String := "mumps";
   M_71            : aliased constant String := "M";
   K_72            : aliased constant String := "opencl";
   M_72            : aliased constant String := "OpenCL";
   K_73            : aliased constant String := "purs";
   M_73            : aliased constant String := "PureScript";
   K_74            : aliased constant String := "a51";
   M_74            : aliased constant String := "Assembly";
   K_75            : aliased constant String := "rest.txt";
   M_75            : aliased constant String := "reStructuredText";
   K_76            : aliased constant String := "php";
   M_76            : aliased constant String := "PHP, Hack";
   K_77            : aliased constant String := "uno";
   M_77            : aliased constant String := "Uno";
   K_78            : aliased constant String := "b";
   M_78            : aliased constant String := "Limbo, Brainfuck";
   K_79            : aliased constant String := "c";
   M_79            : aliased constant String := "C";
   K_80            : aliased constant String := "spin";
   M_80            : aliased constant String := "Propeller Spin";
   K_81            : aliased constant String := "d";
   M_81            : aliased constant String := "Makefile, DTrace, D";
   K_82            : aliased constant String := "e";
   M_82            : aliased constant String := "Eiffel";
   K_83            : aliased constant String := "kt";
   M_83            : aliased constant String := "Kotlin";
   K_84            : aliased constant String := "gsp";
   M_84            : aliased constant String := "Groovy Server Pages";
   K_85            : aliased constant String := "ashx";
   M_85            : aliased constant String := "ASP";
   K_86            : aliased constant String := "f";
   M_86            : aliased constant String := "Forth, FORTRAN";
   K_87            : aliased constant String := "g";
   M_87            : aliased constant String := "GAP, G-code";
   K_88            : aliased constant String := "h";
   M_88            : aliased constant String := "Objective-C, C++, C";
   K_89            : aliased constant String := "gst";
   M_89            : aliased constant String := "Gosu";
   K_90            : aliased constant String := "j";
   M_90            : aliased constant String := "Objective-J, Jasmin";
   K_91            : aliased constant String := "ampl";
   M_91            : aliased constant String := "AMPL";
   K_92            : aliased constant String := "l";
   M_92            : aliased constant String := "PicoLisp, Lex, Groff, Common Lisp";
   K_93            : aliased constant String := "bmx";
   M_93            : aliased constant String := "BlitzMax";
   K_94            : aliased constant String := "topojson";
   M_94            : aliased constant String := "JSON";
   K_95            : aliased constant String := "m";
   M_95            : aliased constant String := "Objective-C, Mercury, Matlab, Mathematica, MUF, M, Limbo";
   K_96            : aliased constant String := "vba";
   M_96            : aliased constant String := "Visual Basic";
   K_97            : aliased constant String := "gsx";
   M_97            : aliased constant String := "Gosu";
   K_98            : aliased constant String := "n";
   M_98            : aliased constant String := "Nemerle, Groff";
   K_99            : aliased constant String := "p";
   M_99            : aliased constant String := "OpenEdge ABL";
   K_100           : aliased constant String := "r";
   M_100           : aliased constant String := "Rebol, R";
   K_101           : aliased constant String := "darcspatch";
   M_101           : aliased constant String := "Darcs Patch";
   K_102           : aliased constant String := "s";
   M_102           : aliased constant String := "GAS";
   K_103           : aliased constant String := "t";
   M_103           : aliased constant String := "Turing, Terra, Perl6, Perl";
   K_104           : aliased constant String := "v";
   M_104           : aliased constant String := "Verilog, Coq";
   K_105           : aliased constant String := "w";
   M_105           : aliased constant String := "C";
   K_106           : aliased constant String := "x";
   M_106           : aliased constant String := "Logos";
   K_107           : aliased constant String := "rsh";
   M_107           : aliased constant String := "RenderScript";
   K_108           : aliased constant String := "y";
   M_108           : aliased constant String := "Yacc";
   K_109           : aliased constant String := "mmk";
   M_109           : aliased constant String := "Module Management System";
   K_110           : aliased constant String := "psm1";
   M_110           : aliased constant String := "PowerShell";
   K_111           : aliased constant String := "dpatch";
   M_111           : aliased constant String := "Darcs Patch";
   K_112           : aliased constant String := "ma";
   M_112           : aliased constant String := "Mathematica";
   K_113           : aliased constant String := "pl6";
   M_113           : aliased constant String := "Perl6";
   K_114           : aliased constant String := "vbs";
   M_114           : aliased constant String := "Visual Basic";
   K_115           : aliased constant String := "md";
   M_115           : aliased constant String := "Markdown";
   K_116           : aliased constant String := "upc";
   M_116           : aliased constant String := "Unified Parallel C";
   K_117           : aliased constant String := "me";
   M_117           : aliased constant String := "Groff";
   K_118           : aliased constant String := "mms";
   M_118           : aliased constant String := "Module Management System";
   K_119           : aliased constant String := "sublime-menu";
   M_119           : aliased constant String := "JavaScript";
   K_120           : aliased constant String := "rss";
   M_120           : aliased constant String := "XML";
   K_121           : aliased constant String := "rst";
   M_121           : aliased constant String := "reStructuredText";
   K_122           : aliased constant String := "mk";
   M_122           : aliased constant String := "Makefile";
   K_123           : aliased constant String := "rsx";
   M_123           : aliased constant String := "R";
   K_124           : aliased constant String := "ml";
   M_124           : aliased constant String := "OCaml";
   K_125           : aliased constant String := "mm";
   M_125           : aliased constant String := "XML, Objective-C++";
   K_126           : aliased constant String := "mo";
   M_126           : aliased constant String := "Modelica";
   K_127           : aliased constant String := "eclass";
   M_127           : aliased constant String := "Gentoo Eclass";
   K_128           : aliased constant String := "jelly";
   M_128           : aliased constant String := "XML";
   K_129           : aliased constant String := "boo";
   M_129           : aliased constant String := "Boo";
   K_130           : aliased constant String := "ms";
   M_130           : aliased constant String := "MAXScript, Groff, GAS";
   K_131           : aliased constant String := "mt";
   M_131           : aliased constant String := "Mathematica";
   K_132           : aliased constant String := "opal";
   M_132           : aliased constant String := "Opal";
   K_133           : aliased constant String := "mu";
   M_133           : aliased constant String := "mupad";
   K_134           : aliased constant String := "xmi";
   M_134           : aliased constant String := "XML";
   K_135           : aliased constant String := "xml";
   M_135           : aliased constant String := "XML";
   K_136           : aliased constant String := "oxh";
   M_136           : aliased constant String := "Ox";
   K_137           : aliased constant String := "oxygene";
   M_137           : aliased constant String := "Oxygene";
   K_138           : aliased constant String := "elm";
   M_138           : aliased constant String := "Elm";
   K_139           : aliased constant String := "hic";
   M_139           : aliased constant String := "Clojure";
   K_140           : aliased constant String := "oxo";
   M_140           : aliased constant String := "Ox";
   K_141           : aliased constant String := "mod";
   M_141           : aliased constant String := "XML, Modula-2, Linux Kernel Module, AMPL";
   K_142           : aliased constant String := "mkdn";
   M_142           : aliased constant String := "Markdown";
   K_143           : aliased constant String := "ccp";
   M_143           : aliased constant String := "COBOL";
   K_144           : aliased constant String := "moo";
   M_144           : aliased constant String := "Moocode, Mercury";
   K_145           : aliased constant String := "plb";
   M_145           : aliased constant String := "PLSQL";
   K_146           : aliased constant String := "bones";
   M_146           : aliased constant String := "JavaScript";
   K_147           : aliased constant String := "numpyw";
   M_147           : aliased constant String := "NumPy";
   K_148           : aliased constant String := "yap";
   M_148           : aliased constant String := "Prolog";
   K_149           : aliased constant String := "mxml";
   M_149           : aliased constant String := "XML";
   K_150           : aliased constant String := "perl";
   M_150           : aliased constant String := "Perl";
   K_151           : aliased constant String := "pls";
   M_151           : aliased constant String := "PLSQL";
   K_152           : aliased constant String := "urs";
   M_152           : aliased constant String := "UrWeb";
   K_153           : aliased constant String := "sig";
   M_153           : aliased constant String := "Standard ML";
   K_154           : aliased constant String := "tcsh";
   M_154           : aliased constant String := "Tcsh";
   K_155           : aliased constant String := "plt";
   M_155           : aliased constant String := "Gnuplot";
   K_156           : aliased constant String := "ox";
   M_156           : aliased constant String := "Ox";
   K_157           : aliased constant String := "plx";
   M_157           : aliased constant String := "Perl";
   K_158           : aliased constant String := "ncl";
   M_158           : aliased constant String := "Text, NCL";
   K_159           : aliased constant String := "oz";
   M_159           : aliased constant String := "Oz";
   K_160           : aliased constant String := "smt2";
   M_160           : aliased constant String := "SMT";
   K_161           : aliased constant String := "mkdown";
   M_161           : aliased constant String := "Markdown";
   K_162           : aliased constant String := "ssjs";
   M_162           : aliased constant String := "JavaScript";
   K_163           : aliased constant String := "sublime-completions";
   M_163           : aliased constant String := "JavaScript";
   K_164           : aliased constant String := "scaml";
   M_164           : aliased constant String := "Scaml";
   K_165           : aliased constant String := "d-objdump";
   M_165           : aliased constant String := "D-ObjDump";
   K_166           : aliased constant String := "wisp";
   M_166           : aliased constant String := "wisp";
   K_167           : aliased constant String := "cobol";
   M_167           : aliased constant String := "COBOL";
   K_168           : aliased constant String := "textile";
   M_168           : aliased constant String := "Textile";
   K_169           : aliased constant String := "befunge";
   M_169           : aliased constant String := "Befunge";
   K_170           : aliased constant String := "gyp";
   M_170           : aliased constant String := "Python";
   K_171           : aliased constant String := "axi.erb";
   M_171           : aliased constant String := "NetLinx+ERB";
   K_172           : aliased constant String := "_coffee";
   M_172           : aliased constant String := "CoffeeScript";
   K_173           : aliased constant String := "asset";
   M_173           : aliased constant String := "Unity3D Asset";
   K_174           : aliased constant String := "bsv";
   M_174           : aliased constant String := "Bluespec";
   K_175           : aliased constant String := "jsproj";
   M_175           : aliased constant String := "XML";
   K_176           : aliased constant String := "epj";
   M_176           : aliased constant String := "Ecere Projects";
   K_177           : aliased constant String := "xql";
   M_177           : aliased constant String := "XQuery";
   K_178           : aliased constant String := "xqm";
   M_178           : aliased constant String := "XQuery";
   K_179           : aliased constant String := "matlab";
   M_179           : aliased constant String := "Matlab";
   K_180           : aliased constant String := "vhd";
   M_180           : aliased constant String := "VHDL";
   K_181           : aliased constant String := "vhf";
   M_181           : aliased constant String := "VHDL";
   K_182           : aliased constant String := "xojo_menu";
   M_182           : aliased constant String := "Xojo";
   K_183           : aliased constant String := "vhi";
   M_183           : aliased constant String := "VHDL";
   K_184           : aliased constant String := "webidl";
   M_184           : aliased constant String := "WebIDL";
   K_185           : aliased constant String := "eps";
   M_185           : aliased constant String := "PostScript";
   K_186           : aliased constant String := "cirru";
   M_186           : aliased constant String := "Cirru";
   K_187           : aliased constant String := "eam.fs";
   M_187           : aliased constant String := "Formatted";
   K_188           : aliased constant String := "cgi";
   M_188           : aliased constant String := "Shell, Python, Perl";
   K_189           : aliased constant String := "numpy";
   M_189           : aliased constant String := "NumPy";
   K_190           : aliased constant String := "xliff";
   M_190           : aliased constant String := "XML";
   K_191           : aliased constant String := "xqy";
   M_191           : aliased constant String := "XQuery";
   K_192           : aliased constant String := "vho";
   M_192           : aliased constant String := "VHDL";
   K_193           : aliased constant String := "qbs";
   M_193           : aliased constant String := "QML";
   K_194           : aliased constant String := "vhs";
   M_194           : aliased constant String := "VHDL";
   K_195           : aliased constant String := "gnuplot";
   M_195           : aliased constant String := "Gnuplot";
   K_196           : aliased constant String := "vht";
   M_196           : aliased constant String := "VHDL";
   K_197           : aliased constant String := "sc";
   M_197           : aliased constant String := "SuperCollider, Scala";
   K_198           : aliased constant String := "vhw";
   M_198           : aliased constant String := "VHDL";
   K_199           : aliased constant String := "mss";
   M_199           : aliased constant String := "CartoCSS";
   K_200           : aliased constant String := "sh";
   M_200           : aliased constant String := "Shell";
   K_201           : aliased constant String := "sj";
   M_201           : aliased constant String := "Objective-J";
   K_202           : aliased constant String := "sl";
   M_202           : aliased constant String := "Slash";
   K_203           : aliased constant String := "sma";
   M_203           : aliased constant String := "SourcePawn";
   K_204           : aliased constant String := "graphql";
   M_204           : aliased constant String := "GraphQL";
   K_205           : aliased constant String := "cats";
   M_205           : aliased constant String := "C";
   K_206           : aliased constant String := "sp";
   M_206           : aliased constant String := "SourcePawn";
   K_207           : aliased constant String := "erb";
   M_207           : aliased constant String := "HTML+ERB";
   K_208           : aliased constant String := "xsd";
   M_208           : aliased constant String := "XML";
   K_209           : aliased constant String := "ss";
   M_209           : aliased constant String := "Scheme";
   K_210           : aliased constant String := "aspx";
   M_210           : aliased constant String := "ASP";
   K_211           : aliased constant String := "st";
   M_211           : aliased constant String := "Smalltalk, HTML";
   K_212           : aliased constant String := "sv";
   M_212           : aliased constant String := "SystemVerilog";
   K_213           : aliased constant String := "ceylon";
   M_213           : aliased constant String := "Ceylon";
   K_214           : aliased constant String := "sml";
   M_214           : aliased constant String := "Standard ML";
   K_215           : aliased constant String := "xsl";
   M_215           : aliased constant String := "XSLT";
   K_216           : aliased constant String := "erl";
   M_216           : aliased constant String := "Erlang";
   K_217           : aliased constant String := "smt";
   M_217           : aliased constant String := "SMT";
   K_218           : aliased constant String := "muf";
   M_218           : aliased constant String := "MUF";
   K_219           : aliased constant String := "tab";
   M_219           : aliased constant String := "SQL";
   K_220           : aliased constant String := "tac";
   M_220           : aliased constant String := "Python";
   K_221           : aliased constant String := "robot";
   M_221           : aliased constant String := "RobotFramework";
   K_222           : aliased constant String := "prc";
   M_222           : aliased constant String := "SQL";
   K_223           : aliased constant String := "erb.deface";
   M_223           : aliased constant String := "HTML+ERB";
   K_224           : aliased constant String := "uc";
   M_224           : aliased constant String := "UnrealScript";
   K_225           : aliased constant String := "prg";
   M_225           : aliased constant String := "xBase";
   K_226           : aliased constant String := "pri";
   M_226           : aliased constant String := "QMake";
   K_227           : aliased constant String := "ui";
   M_227           : aliased constant String := "XML";
   K_228           : aliased constant String := "csproj";
   M_228           : aliased constant String := "XML";
   K_229           : aliased constant String := "decls";
   M_229           : aliased constant String := "BlitzBasic";
   K_230           : aliased constant String := "h++";
   M_230           : aliased constant String := "C++";
   K_231           : aliased constant String := "pro";
   M_231           : aliased constant String := "QMake, Prolog, INI, IDL";
   K_232           : aliased constant String := "geojson";
   M_232           : aliased constant String := "JSON";
   K_233           : aliased constant String := "asciidoc";
   M_233           : aliased constant String := "AsciiDoc";
   K_234           : aliased constant String := "ur";
   M_234           : aliased constant String := "UrWeb";
   K_235           : aliased constant String := "prw";
   M_235           : aliased constant String := "xBase";
   K_236           : aliased constant String := "icl";
   M_236           : aliased constant String := "Clean";
   K_237           : aliased constant String := "ux";
   M_237           : aliased constant String := "XML";
   K_238           : aliased constant String := "nim";
   M_238           : aliased constant String := "Nimrod";
   K_239           : aliased constant String := "xul";
   M_239           : aliased constant String := "XML";
   K_240           : aliased constant String := "nit";
   M_240           : aliased constant String := "Nit";
   K_241           : aliased constant String := "dylan";
   M_241           : aliased constant String := "Dylan";
   K_242           : aliased constant String := "ccxml";
   M_242           : aliased constant String := "XML";
   K_243           : aliased constant String := "hqf";
   M_243           : aliased constant String := "SQF";
   K_244           : aliased constant String := "nix";
   M_244           : aliased constant String := "Nix";
   K_245           : aliased constant String := "cgpr";
   M_245           : aliased constant String := "GNAT Project";
   K_246           : aliased constant String := "tcc";
   M_246           : aliased constant String := "C++";
   K_247           : aliased constant String := "rbfrm";
   M_247           : aliased constant String := "REALbasic";
   K_248           : aliased constant String := "zone";
   M_248           : aliased constant String := "DNS Zone";
   K_249           : aliased constant String := "html";
   M_249           : aliased constant String := "HTML";
   K_250           : aliased constant String := "4th";
   M_250           : aliased constant String := "Forth";
   K_251           : aliased constant String := "eclxml";
   M_251           : aliased constant String := "ECL";
   K_252           : aliased constant String := "sublime-project";
   M_252           : aliased constant String := "JavaScript";
   K_253           : aliased constant String := "meta";
   M_253           : aliased constant String := "Unity3D Asset";
   K_254           : aliased constant String := "x10";
   M_254           : aliased constant String := "X10";
   K_255           : aliased constant String := "nimrod";
   M_255           : aliased constant String := "Nimrod";
   K_256           : aliased constant String := "handlebars";
   M_256           : aliased constant String := "Handlebars";
   K_257           : aliased constant String := "tcl";
   M_257           : aliased constant String := "Tcl";
   K_258           : aliased constant String := "wl";
   M_258           : aliased constant String := "Mathematica";
   K_259           : aliased constant String := "objdump";
   M_259           : aliased constant String := "ObjDump";
   K_260           : aliased constant String := "gshader";
   M_260           : aliased constant String := "GLSL";
   K_261           : aliased constant String := "sqf";
   M_261           : aliased constant String := "SQF";
   K_262           : aliased constant String := "nginxconf";
   M_262           : aliased constant String := "Nginx";
   K_263           : aliased constant String := "rviz";
   M_263           : aliased constant String := "YAML";
   K_264           : aliased constant String := "bats";
   M_264           : aliased constant String := "Shell";
   K_265           : aliased constant String := "podspec";
   M_265           : aliased constant String := "Ruby";
   K_266           : aliased constant String := "sql";
   M_266           : aliased constant String := "SQLPL, SQL, PLpgSQL, PLSQL";
   K_267           : aliased constant String := "mako";
   M_267           : aliased constant String := "Mako";
   K_268           : aliased constant String := "properties";
   M_268           : aliased constant String := "INI";
   K_269           : aliased constant String := "hsc";
   M_269           : aliased constant String := "Haskell";
   K_270           : aliased constant String := "cmd";
   M_270           : aliased constant String := "Batchfile";
   K_271           : aliased constant String := "toml";
   M_271           : aliased constant String := "TOML";
   K_272           : aliased constant String := "cmake.in";
   M_272           : aliased constant String := "CMake";
   K_273           : aliased constant String := "tea";
   M_273           : aliased constant String := "Tea";
   K_274           : aliased constant String := "ada";
   M_274           : aliased constant String := "Ada";
   K_275           : aliased constant String := "adb";
   M_275           : aliased constant String := "Ada";
   K_276           : aliased constant String := "rest";
   M_276           : aliased constant String := "reStructuredText";
   K_277           : aliased constant String := "pike";
   M_277           : aliased constant String := "Pike";
   K_278           : aliased constant String := "lbx";
   M_278           : aliased constant String := "TeX";
   K_279           : aliased constant String := "myt";
   M_279           : aliased constant String := "Myghty";
   K_280           : aliased constant String := "xtend";
   M_280           : aliased constant String := "Xtend";
   K_281           : aliased constant String := "1m";
   M_281           : aliased constant String := "Groff";
   K_282           : aliased constant String := "ado";
   M_282           : aliased constant String := "Stata";
   K_283           : aliased constant String := "adp";
   M_283           : aliased constant String := "Tcl";
   K_284           : aliased constant String := "tmSnippet";
   M_284           : aliased constant String := "XML";
   K_285           : aliased constant String := "sublime-syntax";
   M_285           : aliased constant String := "YAML";
   K_286           : aliased constant String := "ads";
   M_286           : aliased constant String := "Ada";
   K_287           : aliased constant String := "tex";
   M_287           : aliased constant String := "TeX";
   K_288           : aliased constant String := "1x";
   M_288           : aliased constant String := "Groff";
   K_289           : aliased constant String := "yy";
   M_289           : aliased constant String := "Yacc";
   K_290           : aliased constant String := "cob";
   M_290           : aliased constant String := "COBOL";
   K_291           : aliased constant String := "wsdl";
   M_291           : aliased constant String := "XML";
   K_292           : aliased constant String := "rbxs";
   M_292           : aliased constant String := "Lua";
   K_293           : aliased constant String := "tool";
   M_293           : aliased constant String := "Shell";
   K_294           : aliased constant String := "exs";
   M_294           : aliased constant String := "Elixir";
   K_295           : aliased constant String := "jinja";
   M_295           : aliased constant String := "HTML+Django";
   K_296           : aliased constant String := "parrot";
   M_296           : aliased constant String := "Parrot";
   K_297           : aliased constant String := "com";
   M_297           : aliased constant String := "DIGITAL Command Language";
   K_298           : aliased constant String := "lds";
   M_298           : aliased constant String := "Linker Script";
   K_299           : aliased constant String := "coq";
   M_299           : aliased constant String := "Coq";
   K_300           : aliased constant String := "pxd";
   M_300           : aliased constant String := "Cython";
   K_301           : aliased constant String := "sage";
   M_301           : aliased constant String := "Sage";
   K_302           : aliased constant String := "3m";
   M_302           : aliased constant String := "Groff";
   K_303           : aliased constant String := "yml";
   M_303           : aliased constant String := "YAML";
   K_304           : aliased constant String := "pxi";
   M_304           : aliased constant String := "Cython";
   K_305           : aliased constant String := "scpt";
   M_305           : aliased constant String := "AppleScript";
   K_306           : aliased constant String := "krl";
   M_306           : aliased constant String := "KRL";
   K_307           : aliased constant String := "c++";
   M_307           : aliased constant String := "C++";
   K_308           : aliased constant String := "x3d";
   M_308           : aliased constant String := "XML";
   K_309           : aliased constant String := "3x";
   M_309           : aliased constant String := "Groff";
   K_310           : aliased constant String := "nasm";
   M_310           : aliased constant String := "Assembly";
   K_311           : aliased constant String := "markdown";
   M_311           : aliased constant String := "Markdown";
   K_312           : aliased constant String := "dcl";
   M_312           : aliased constant String := "Clean";
   K_313           : aliased constant String := "cmake";
   M_313           : aliased constant String := "CMake";
   K_314           : aliased constant String := "iced";
   M_314           : aliased constant String := "CoffeeScript";
   K_315           : aliased constant String := "nuspec";
   M_315           : aliased constant String := "XML";
   K_316           : aliased constant String := "xproc";
   M_316           : aliased constant String := "XProc";
   K_317           : aliased constant String := "lfe";
   M_317           : aliased constant String := "LFE";
   K_318           : aliased constant String := "xsjs";
   M_318           : aliased constant String := "JavaScript";
   K_319           : aliased constant String := "cljs.hl";
   M_319           : aliased constant String := "Clojure";
   K_320           : aliased constant String := "xproj";
   M_320           : aliased constant String := "XML";
   K_321           : aliased constant String := "cql";
   M_321           : aliased constant String := "SQL";
   K_322           : aliased constant String := "pogo";
   M_322           : aliased constant String := "PogoScript";
   K_323           : aliased constant String := "vshader";
   M_323           : aliased constant String := "GLSL";
   K_324           : aliased constant String := "ninja";
   M_324           : aliased constant String := "Ninja";
   K_325           : aliased constant String := "vrx";
   M_325           : aliased constant String := "GLSL";
   K_326           : aliased constant String := "ahk";
   M_326           : aliased constant String := "AutoHotkey";
   K_327           : aliased constant String := "ktm";
   M_327           : aliased constant String := "Kotlin";
   K_328           : aliased constant String := "cjsx";
   M_328           : aliased constant String := "CoffeeScript";
   K_329           : aliased constant String := "jake";
   M_329           : aliased constant String := "JavaScript";
   K_330           : aliased constant String := "kts";
   M_330           : aliased constant String := "Kotlin";
   K_331           : aliased constant String := "apacheconf";
   M_331           : aliased constant String := "ApacheConf";
   K_332           : aliased constant String := "rst.txt";
   M_332           : aliased constant String := "reStructuredText";
   K_333           : aliased constant String := "mirah";
   M_333           : aliased constant String := "Mirah";
   K_334           : aliased constant String := "ditamap";
   M_334           : aliased constant String := "XML";
   K_335           : aliased constant String := "c++objdump";
   M_335           : aliased constant String := "Cpp-ObjDump";
   K_336           : aliased constant String := "zimpl";
   M_336           : aliased constant String := "Zimpl";
   K_337           : aliased constant String := "nqp";
   M_337           : aliased constant String := "Perl6";
   K_338           : aliased constant String := "xslt";
   M_338           : aliased constant String := "XSLT";
   K_339           : aliased constant String := "csh";
   M_339           : aliased constant String := "Tcsh";
   K_340           : aliased constant String := "csl";
   M_340           : aliased constant String := "XML";
   K_341           : aliased constant String := "slim";
   M_341           : aliased constant String := "Slim";
   K_342           : aliased constant String := "lhs";
   M_342           : aliased constant String := "Literate Haskell";
   K_343           : aliased constant String := "mspec";
   M_343           : aliased constant String := "Ruby";
   K_344           : aliased constant String := "css";
   M_344           : aliased constant String := "CSS";
   K_345           : aliased constant String := "csv";
   M_345           : aliased constant String := "CSV";
   K_346           : aliased constant String := "csx";
   M_346           : aliased constant String := "C#";
   K_347           : aliased constant String := "hats";
   M_347           : aliased constant String := "ATS";
   K_348           : aliased constant String := "fpp";
   M_348           : aliased constant String := "FORTRAN";
   K_349           : aliased constant String := "nse";
   M_349           : aliased constant String := "Lua";
   K_350           : aliased constant String := "nawk";
   M_350           : aliased constant String := "Awk";
   K_351           : aliased constant String := "nsh";
   M_351           : aliased constant String := "NSIS";
   K_352           : aliased constant String := "click";
   M_352           : aliased constant String := "Click";
   K_353           : aliased constant String := "volt";
   M_353           : aliased constant String := "Volt";
   K_354           : aliased constant String := "nsi";
   M_354           : aliased constant String := "NSIS";
   K_355           : aliased constant String := "abap";
   M_355           : aliased constant String := "ABAP";
   K_356           : aliased constant String := "iml";
   M_356           : aliased constant String := "XML";
   K_357           : aliased constant String := "mask";
   M_357           : aliased constant String := "Mask";
   K_358           : aliased constant String := "yang";
   M_358           : aliased constant String := "YANG";
   K_359           : aliased constant String := "rbw";
   M_359           : aliased constant String := "Ruby";
   K_360           : aliased constant String := "rbx";
   M_360           : aliased constant String := "Ruby";
   K_361           : aliased constant String := "sublime-macro";
   M_361           : aliased constant String := "JavaScript";
   K_362           : aliased constant String := "cuh";
   M_362           : aliased constant String := "Cuda";
   K_363           : aliased constant String := "zep";
   M_363           : aliased constant String := "Zephir";
   K_364           : aliased constant String := "mkvi";
   M_364           : aliased constant String := "TeX";
   K_365           : aliased constant String := "scxml";
   M_365           : aliased constant String := "XML";
   K_366           : aliased constant String := "mediawiki";
   M_366           : aliased constant String := "MediaWiki";
   K_367           : aliased constant String := "frg";
   M_367           : aliased constant String := "GLSL";
   K_368           : aliased constant String := "ali";
   M_368           : aliased constant String := "ALI file";
   K_369           : aliased constant String := "p6l";
   M_369           : aliased constant String := "Perl6";
   K_370           : aliased constant String := "tmLanguage";
   M_370           : aliased constant String := "XML";
   K_371           : aliased constant String := "tml";
   M_371           : aliased constant String := "XML";
   K_372           : aliased constant String := "p6m";
   M_372           : aliased constant String := "Perl6";
   K_373           : aliased constant String := "frm";
   M_373           : aliased constant String := "Visual Basic";
   K_374           : aliased constant String := "rdf";
   M_374           : aliased constant String := "XML";
   K_375           : aliased constant String := "xsp.metadata";
   M_375           : aliased constant String := "XPages";
   K_376           : aliased constant String := "als";
   M_376           : aliased constant String := "Alloy";
   K_377           : aliased constant String := "creole";
   M_377           : aliased constant String := "Creole";
   K_378           : aliased constant String := "frt";
   M_378           : aliased constant String := "Forth";
   K_379           : aliased constant String := "frx";
   M_379           : aliased constant String := "Visual Basic";
   K_380           : aliased constant String := "sublime-build";
   M_380           : aliased constant String := "JavaScript";
   K_381           : aliased constant String := "grace";
   M_381           : aliased constant String := "Grace";
   K_382           : aliased constant String := "nut";
   M_382           : aliased constant String := "Squirrel";
   K_383           : aliased constant String := "mtml";
   M_383           : aliased constant String := "MTML";
   K_384           : aliased constant String := "launch";
   M_384           : aliased constant String := "XML";
   K_385           : aliased constant String := "toc";
   M_385           : aliased constant String := "TeX";
   K_386           : aliased constant String := "lock";
   M_386           : aliased constant String := "JSON";
   K_387           : aliased constant String := "3in";
   M_387           : aliased constant String := "Groff";
   K_388           : aliased constant String := "emacs";
   M_388           : aliased constant String := "Emacs Lisp";
   K_389           : aliased constant String := "fth";
   M_389           : aliased constant String := "Forth";
   K_390           : aliased constant String := "nproj";
   M_390           : aliased constant String := "XML";
   K_391           : aliased constant String := "gradle";
   M_391           : aliased constant String := "Gradle";
   K_392           : aliased constant String := "ftl";
   M_392           : aliased constant String := "FreeMarker";
   K_393           : aliased constant String := "roff";
   M_393           : aliased constant String := "Groff";
   K_394           : aliased constant String := "dotsettings";
   M_394           : aliased constant String := "XML";
   K_395           : aliased constant String := "rake";
   M_395           : aliased constant String := "Ruby";
   K_396           : aliased constant String := "chpl";
   M_396           : aliased constant String := "Chapel";
   K_397           : aliased constant String := "ant";
   M_397           : aliased constant String := "XML";
   K_398           : aliased constant String := "flex";
   M_398           : aliased constant String := "JFlex";
   K_399           : aliased constant String := "mawk";
   M_399           : aliased constant String := "Awk";
   K_400           : aliased constant String := "wlt";
   M_400           : aliased constant String := "Mathematica";
   K_401           : aliased constant String := "f03";
   M_401           : aliased constant String := "FORTRAN";
   K_402           : aliased constant String := "podsl";
   M_402           : aliased constant String := "Common Lisp";
   K_403           : aliased constant String := "f08";
   M_403           : aliased constant String := "FORTRAN";
   K_404           : aliased constant String := "bbx";
   M_404           : aliased constant String := "TeX";
   K_405           : aliased constant String := "apl";
   M_405           : aliased constant String := "APL";
   K_406           : aliased constant String := "glade";
   M_406           : aliased constant String := "XML";
   K_407           : aliased constant String := "rs.in";
   M_407           : aliased constant String := "Rust";
   K_408           : aliased constant String := "raml";
   M_408           : aliased constant String := "RAML";
   K_409           : aliased constant String := "sublime_session";
   M_409           : aliased constant String := "JavaScript";
   K_410           : aliased constant String := "bb";
   M_410           : aliased constant String := "BlitzBasic, BitBake";
   K_411           : aliased constant String := "bf";
   M_411           : aliased constant String := "HyPhy, Brainfuck";
   K_412           : aliased constant String := "builder";
   M_412           : aliased constant String := "Ruby";
   K_413           : aliased constant String := "iss";
   M_413           : aliased constant String := "Inno Setup";
   K_414           : aliased constant String := "frag";
   M_414           : aliased constant String := "JavaScript, GLSL";
   K_415           : aliased constant String := "rbtbar";
   M_415           : aliased constant String := "REALbasic";
   K_416           : aliased constant String := "haml.deface";
   M_416           : aliased constant String := "Haml";
   K_417           : aliased constant String := "lpr";
   M_417           : aliased constant String := "Pascal";
   K_418           : aliased constant String := "arc";
   M_418           : aliased constant String := "Arc";
   K_419           : aliased constant String := "fxh";
   M_419           : aliased constant String := "HLSL";
   K_420           : aliased constant String := "xojo_script";
   M_420           : aliased constant String := "Xojo";
   K_421           : aliased constant String := "lookml";
   M_421           : aliased constant String := "LookML";
   K_422           : aliased constant String := "ruby";
   M_422           : aliased constant String := "Ruby";
   K_423           : aliased constant String := "tst";
   M_423           : aliased constant String := "Scilab, GAP";
   K_424           : aliased constant String := "dart";
   M_424           : aliased constant String := "Dart";
   K_425           : aliased constant String := "rbmnu";
   M_425           : aliased constant String := "REALbasic";
   K_426           : aliased constant String := "psd1";
   M_426           : aliased constant String := "PowerShell";
   K_427           : aliased constant String := "doh";
   M_427           : aliased constant String := "Stata";
   K_428           : aliased constant String := "aru";
   M_428           : aliased constant String := "AdaControl rules";
   K_429           : aliased constant String := "tsx";
   M_429           : aliased constant String := "XML, TypeScript";
   K_430           : aliased constant String := "fancypack";
   M_430           : aliased constant String := "Fancy";
   K_431           : aliased constant String := "sass";
   M_431           : aliased constant String := "Sass";
   K_432           : aliased constant String := "pac";
   M_432           : aliased constant String := "JavaScript";
   K_433           : aliased constant String := "cshtml";
   M_433           : aliased constant String := "C#";
   K_434           : aliased constant String := "di";
   M_434           : aliased constant String := "D";
   K_435           : aliased constant String := "glf";
   M_435           : aliased constant String := "Glyph";
   K_436           : aliased constant String := "dot";
   M_436           : aliased constant String := "Graphviz (DOT)";
   K_437           : aliased constant String := "dm";
   M_437           : aliased constant String := "DM";
   K_438           : aliased constant String := "tmTheme";
   M_438           : aliased constant String := "XML";
   K_439           : aliased constant String := "pan";
   M_439           : aliased constant String := "Pan";
   K_440           : aliased constant String := "do";
   M_440           : aliased constant String := "Stata";
   K_441           : aliased constant String := "dll.config";
   M_441           : aliased constant String := "XML";
   K_442           : aliased constant String := "pas";
   M_442           : aliased constant String := "Pascal";
   K_443           : aliased constant String := "pat";
   M_443           : aliased constant String := "Max";
   K_444           : aliased constant String := "urdf";
   M_444           : aliased constant String := "XML";
   K_445           : aliased constant String := "asax";
   M_445           : aliased constant String := "ASP";
   K_446           : aliased constant String := "ooc";
   M_446           : aliased constant String := "ooc";
   K_447           : aliased constant String := "irbrc";
   M_447           : aliased constant String := "Ruby";
   K_448           : aliased constant String := "logtalk";
   M_448           : aliased constant String := "Logtalk";
   K_449           : aliased constant String := "ecl";
   M_449           : aliased constant String := "ECLiPSe, ECL";
   K_450           : aliased constant String := "filters";
   M_450           : aliased constant String := "XML";
   K_451           : aliased constant String := "dats";
   M_451           : aliased constant String := "ATS";
   K_452           : aliased constant String := "cfml";
   M_452           : aliased constant String := "ColdFusion";
   K_453           : aliased constant String := "pck";
   M_453           : aliased constant String := "PLSQL";
   K_454           : aliased constant String := "watchr";
   M_454           : aliased constant String := "Ruby";
   K_455           : aliased constant String := "prolog";
   M_455           : aliased constant String := "Prolog";
   K_456           : aliased constant String := "coffee";
   M_456           : aliased constant String := "CoffeeScript";
   K_457           : aliased constant String := "fp";
   M_457           : aliased constant String := "GLSL";
   K_458           : aliased constant String := "desktop";
   M_458           : aliased constant String := "desktop";
   K_459           : aliased constant String := "fr";
   M_459           : aliased constant String := "Text, Frege, Forth";
   K_460           : aliased constant String := "fs";
   M_460           : aliased constant String := "GLSL, Forth, Filterscript, F#";
   K_461           : aliased constant String := "moon";
   M_461           : aliased constant String := "MoonScript";
   K_462           : aliased constant String := "ascx";
   M_462           : aliased constant String := "ASP";
   K_463           : aliased constant String := "maxproj";
   M_463           : aliased constant String := "Max";
   K_464           : aliased constant String := "fx";
   M_464           : aliased constant String := "HLSL, FLUX";
   K_465           : aliased constant String := "fy";
   M_465           : aliased constant String := "Fancy";
   K_466           : aliased constant String := "gnu";
   M_466           : aliased constant String := "Gnuplot";
   K_467           : aliased constant String := "feature";
   M_467           : aliased constant String := "Cucumber";
   K_468           : aliased constant String := "ltx";
   M_468           : aliased constant String := "TeX";
   K_469           : aliased constant String := "3qt";
   M_469           : aliased constant String := "Groff";
   K_470           : aliased constant String := "vxml";
   M_470           : aliased constant String := "XML";
   K_471           : aliased constant String := "ldml";
   M_471           : aliased constant String := "Lasso";
   K_472           : aliased constant String := "eex";
   M_472           : aliased constant String := "HTML+EEX";
   K_473           : aliased constant String := "zcml";
   M_473           : aliased constant String := "XML";
   K_474           : aliased constant String := "nlogo";
   M_474           : aliased constant String := "NetLogo";
   K_475           : aliased constant String := "hb";
   M_475           : aliased constant String := "Harbour";
   K_476           : aliased constant String := "lisp";
   M_476           : aliased constant String := "NewLisp, Common Lisp";
   K_477           : aliased constant String := "rno";
   M_477           : aliased constant String := "Groff";
   K_478           : aliased constant String := "hbs";
   M_478           : aliased constant String := "Handlebars";
   K_479           : aliased constant String := "xojo_code";
   M_479           : aliased constant String := "Xojo";
   K_480           : aliased constant String := "monkey";
   M_480           : aliased constant String := "Monkey";
   K_481           : aliased constant String := "hh";
   M_481           : aliased constant String := "Hack, C++";
   K_482           : aliased constant String := "pluginspec";
   M_482           : aliased constant String := "XML, Ruby";
   K_483           : aliased constant String := "targets";
   M_483           : aliased constant String := "XML";
   K_484           : aliased constant String := "hs";
   M_484           : aliased constant String := "Haskell";
   K_485           : aliased constant String := "escript";
   M_485           : aliased constant String := "Erlang";
   K_486           : aliased constant String := "gpr";
   M_486           : aliased constant String := "GNAT Project";
   K_487           : aliased constant String := "clixml";
   M_487           : aliased constant String := "XML";
   K_488           : aliased constant String := "hx";
   M_488           : aliased constant String := "Haxe";
   K_489           : aliased constant String := "lean";
   M_489           : aliased constant String := "Lean";
   K_490           : aliased constant String := "hy";
   M_490           : aliased constant String := "Hy";
   K_491           : aliased constant String := "axd";
   M_491           : aliased constant String := "ASP";
   K_492           : aliased constant String := "ml4";
   M_492           : aliased constant String := "OCaml";
   K_493           : aliased constant String := "axi";
   M_493           : aliased constant String := "NetLinx";
   K_494           : aliased constant String := "osm";
   M_494           : aliased constant String := "XML";
   K_495           : aliased constant String := "sbt";
   M_495           : aliased constant String := "Scala";
   K_496           : aliased constant String := "xht";
   M_496           : aliased constant String := "HTML";
   K_497           : aliased constant String := "6pl";
   M_497           : aliased constant String := "Perl6";
   K_498           : aliased constant String := "6pm";
   M_498           : aliased constant String := "Perl6";
   K_499           : aliased constant String := "axs";
   M_499           : aliased constant String := "NetLinx";
   K_500           : aliased constant String := "cake";
   M_500           : aliased constant String := "CoffeeScript, C#";
   K_501           : aliased constant String := "reds";
   M_501           : aliased constant String := "Red";
   K_502           : aliased constant String := "shen";
   M_502           : aliased constant String := "Shen";
   K_503           : aliased constant String := "axml";
   M_503           : aliased constant String := "XML";
   K_504           : aliased constant String := "mathematica";
   M_504           : aliased constant String := "Mathematica";
   K_505           : aliased constant String := "zsh";
   M_505           : aliased constant String := "Shell";
   K_506           : aliased constant String := "jl";
   M_506           : aliased constant String := "Julia";
   K_507           : aliased constant String := "rpy";
   M_507           : aliased constant String := "Ren'Py, Python";
   K_508           : aliased constant String := "jq";
   M_508           : aliased constant String := "JSONiq";
   K_509           : aliased constant String := "js";
   M_509           : aliased constant String := "JavaScript";
   K_510           : aliased constant String := "grt";
   M_510           : aliased constant String := "Groovy";
   K_511           : aliased constant String := "geom";
   M_511           : aliased constant String := "GLSL";
   K_512           : aliased constant String := "scad";
   M_512           : aliased constant String := "OpenSCAD";
   K_513           : aliased constant String := "mli";
   M_513           : aliased constant String := "OCaml";
   K_514           : aliased constant String := "wxi";
   M_514           : aliased constant String := "XML";
   K_515           : aliased constant String := "mll";
   M_515           : aliased constant String := "OCaml";
   K_516           : aliased constant String := "jsonld";
   M_516           : aliased constant String := "JSONLD";
   K_517           : aliased constant String := "wxl";
   M_517           : aliased constant String := "XML";
   K_518           : aliased constant String := "ld";
   M_518           : aliased constant String := "Linker Script";
   K_519           : aliased constant String := "xml.dist";
   M_519           : aliased constant String := "XML";
   K_520           : aliased constant String := "pig";
   M_520           : aliased constant String := "PigLatin";
   K_521           : aliased constant String := "wxs";
   M_521           : aliased constant String := "XML";
   K_522           : aliased constant String := "mly";
   M_522           : aliased constant String := "OCaml";
   K_523           : aliased constant String := "ll";
   M_523           : aliased constant String := "LLVM";
   K_524           : aliased constant String := "pir";
   M_524           : aliased constant String := "Parrot Internal Representation";
   K_525           : aliased constant String := "ls";
   M_525           : aliased constant String := "LoomScript, LiveScript";
   K_526           : aliased constant String := "xlf";
   M_526           : aliased constant String := "XML";
   K_527           : aliased constant String := "cppobjdump";
   M_527           : aliased constant String := "Cpp-ObjDump";
   K_528           : aliased constant String := "plsql";
   M_528           : aliased constant String := "PLSQL";
   K_529           : aliased constant String := "ahkl";
   M_529           : aliased constant String := "AutoHotkey";
   K_530           : aliased constant String := "forth";
   M_530           : aliased constant String := "Forth";
   K_531           : aliased constant String := "ly";
   M_531           : aliased constant String := "LilyPond";
   K_532           : aliased constant String := "self";
   M_532           : aliased constant String := "Self";
   K_533           : aliased constant String := "sublime-mousemap";
   M_533           : aliased constant String := "JavaScript";
   K_534           : aliased constant String := "owl";
   M_534           : aliased constant String := "Web Ontology Language";
   K_535           : aliased constant String := "pyde";
   M_535           : aliased constant String := "Python";
   K_536           : aliased constant String := "emacs.desktop";
   M_536           : aliased constant String := "Emacs Lisp";
   K_537           : aliased constant String := "vcl";
   M_537           : aliased constant String := "VCL";
   K_538           : aliased constant String := "cbl";
   M_538           : aliased constant String := "COBOL";
   K_539           : aliased constant String := "vert";
   M_539           : aliased constant String := "GLSL";
   K_540           : aliased constant String := "pm6";
   M_540           : aliased constant String := "Perl6";
   K_541           : aliased constant String := "p6";
   M_541           : aliased constant String := "Perl6";
   K_542           : aliased constant String := "pkb";
   M_542           : aliased constant String := "PLSQL";
   K_543           : aliased constant String := "nb";
   M_543           : aliased constant String := "Text, Mathematica";
   K_544           : aliased constant String := "dyl";
   M_544           : aliased constant String := "Dylan";
   K_545           : aliased constant String := "nc";
   M_545           : aliased constant String := "nesC";
   K_546           : aliased constant String := "irclog";
   M_546           : aliased constant String := "IRC log";
   K_547           : aliased constant String := "xsp-config";
   M_547           : aliased constant String := "XPages";
   K_548           : aliased constant String := "cbx";
   M_548           : aliased constant String := "TeX";
   K_549           : aliased constant String := "ni";
   M_549           : aliased constant String := "Inform 7";
   K_550           : aliased constant String := "i7x";
   M_550           : aliased constant String := "Inform 7";
   K_551           : aliased constant String := "xacro";
   M_551           : aliased constant String := "XML";
   K_552           : aliased constant String := "pkl";
   M_552           : aliased constant String := "Pickle";
   K_553           : aliased constant String := "nl";
   M_553           : aliased constant String := "NewLisp, NL";
   K_554           : aliased constant String := "vbproj";
   M_554           : aliased constant String := "XML";
   K_555           : aliased constant String := "scrbl";
   M_555           : aliased constant String := "Racket";
   K_556           : aliased constant String := "no";
   M_556           : aliased constant String := "Text";
   K_557           : aliased constant String := "php3";
   M_557           : aliased constant String := "PHP";
   K_558           : aliased constant String := "php4";
   M_558           : aliased constant String := "PHP";
   K_559           : aliased constant String := "php5";
   M_559           : aliased constant String := "PHP";
   K_560           : aliased constant String := "pks";
   M_560           : aliased constant String := "PLSQL";
   K_561           : aliased constant String := "jsb";
   M_561           : aliased constant String := "JavaScript";
   K_562           : aliased constant String := "nu";
   M_562           : aliased constant String := "Nu";
   K_563           : aliased constant String := "fshader";
   M_563           : aliased constant String := "GLSL";
   K_564           : aliased constant String := "druby";
   M_564           : aliased constant String := "Mirah";
   K_565           : aliased constant String := "ny";
   M_565           : aliased constant String := "Common Lisp";
   K_566           : aliased constant String := "nbp";
   M_566           : aliased constant String := "Mathematica";
   K_567           : aliased constant String := "gvy";
   M_567           : aliased constant String := "Groovy";
   K_568           : aliased constant String := "jsm";
   M_568           : aliased constant String := "JavaScript";
   K_569           : aliased constant String := "rbuistate";
   M_569           : aliased constant String := "REALbasic";
   K_570           : aliased constant String := "jsp";
   M_570           : aliased constant String := "Java Server Pages";
   K_571           : aliased constant String := "cdf";
   M_571           : aliased constant String := "Mathematica";
   K_572           : aliased constant String := "command";
   M_572           : aliased constant String := "Shell";
   K_573           : aliased constant String := "scala";
   M_573           : aliased constant String := "Scala";
   K_574           : aliased constant String := "jss";
   M_574           : aliased constant String := "JavaScript";
   K_575           : aliased constant String := "r2";
   M_575           : aliased constant String := "Rebol";
   K_576           : aliased constant String := "r3";
   M_576           : aliased constant String := "Rebol";
   K_577           : aliased constant String := "jsx";
   M_577           : aliased constant String := "JSX";
   K_578           : aliased constant String := "fsproj";
   M_578           : aliased constant String := "XML";
   K_579           : aliased constant String := "veo";
   M_579           : aliased constant String := "Verilog";
   K_580           : aliased constant String := "ML";
   M_580           : aliased constant String := "Standard ML";
   K_581           : aliased constant String := "pb";
   M_581           : aliased constant String := "PureBasic";
   K_582           : aliased constant String := "cxx-objdump";
   M_582           : aliased constant String := "Cpp-ObjDump";
   K_583           : aliased constant String := "pd";
   M_583           : aliased constant String := "Pure Data";
   K_584           : aliased constant String := "flux";
   M_584           : aliased constant String := "FLUX";
   K_585           : aliased constant String := "brd";
   M_585           : aliased constant String := "KiCad, Eagle";
   K_586           : aliased constant String := "ph";
   M_586           : aliased constant String := "Perl";
   K_587           : aliased constant String := "omgrofl";
   M_587           : aliased constant String := "Omgrofl";
   K_588           : aliased constant String := "fan";
   M_588           : aliased constant String := "Fantom";
   K_589           : aliased constant String := "pl";
   M_589           : aliased constant String := "Prolog, Perl6, Perl";
   K_590           : aliased constant String := "pm";
   M_590           : aliased constant String := "Perl6, Perl";
   K_591           : aliased constant String := "po";
   M_591           : aliased constant String := "Gettext Catalog";
   K_592           : aliased constant String := "pp";
   M_592           : aliased constant String := "Puppet, Pascal";
   K_593           : aliased constant String := "bro";
   M_593           : aliased constant String := "Bro";
   K_594           : aliased constant String := "latte";
   M_594           : aliased constant String := "Latte";
   K_595           : aliased constant String := "ps";
   M_595           : aliased constant String := "PostScript";
   K_596           : aliased constant String := "asmx";
   M_596           : aliased constant String := "ASP";
   K_597           : aliased constant String := "pt";
   M_597           : aliased constant String := "XML";
   K_598           : aliased constant String := "brs";
   M_598           : aliased constant String := "Brightscript";
   K_599           : aliased constant String := "py";
   M_599           : aliased constant String := "Python";
   K_600           : aliased constant String := "xpl";
   M_600           : aliased constant String := "XProc";
   K_601           : aliased constant String := "cfc";
   M_601           : aliased constant String := "ColdFusion CFC";
   K_602           : aliased constant String := "sjs";
   M_602           : aliased constant String := "JavaScript";
   K_603           : aliased constant String := "cfg";
   M_603           : aliased constant String := "INI";
   K_604           : aliased constant String := "phps";
   M_604           : aliased constant String := "PHP";
   K_605           : aliased constant String := "phpt";
   M_605           : aliased constant String := "PHP";
   K_606           : aliased constant String := "xpy";
   M_606           : aliased constant String := "Python";
   K_607           : aliased constant String := "cfm";
   M_607           : aliased constant String := "ColdFusion";
   K_608           : aliased constant String := "twig";
   M_608           : aliased constant String := "Twig";
   K_609           : aliased constant String := "rb";
   M_609           : aliased constant String := "Ruby";
   K_610           : aliased constant String := "capnp";
   M_610           : aliased constant String := "Cap'n Proto";
   K_611           : aliased constant String := "kid";
   M_611           : aliased constant String := "Genshi";
   K_612           : aliased constant String := "rd";
   M_612           : aliased constant String := "R";
   K_613           : aliased constant String := "pod";
   M_613           : aliased constant String := "Pod, Perl";
   K_614           : aliased constant String := "rg";
   M_614           : aliased constant String := "Rouge";
   K_615           : aliased constant String := "anim";
   M_615           : aliased constant String := "Unity3D Asset";
   K_616           : aliased constant String := "rl";
   M_616           : aliased constant String := "Ragel in Ruby Host";
   K_617           : aliased constant String := "sparql";
   M_617           : aliased constant String := "SPARQL";
   K_618           : aliased constant String := "rq";
   M_618           : aliased constant String := "SPARQL";
   K_619           : aliased constant String := "sld";
   M_619           : aliased constant String := "Scheme";
   K_620           : aliased constant String := "es6";
   M_620           : aliased constant String := "JavaScript";
   K_621           : aliased constant String := "rs";
   M_621           : aliased constant String := "Rust, RenderScript";
   K_622           : aliased constant String := "kit";
   M_622           : aliased constant String := "Kit";
   K_623           : aliased constant String := "sublime-settings";
   M_623           : aliased constant String := "JavaScript";
   K_624           : aliased constant String := "pot";
   M_624           : aliased constant String := "Gettext Catalog";
   K_625           : aliased constant String := "ru";
   M_625           : aliased constant String := "Ruby";
   K_626           : aliased constant String := "pov";
   M_626           : aliased constant String := "POV-Ray SDL";
   K_627           : aliased constant String := "xrl";
   M_627           : aliased constant String := "Erlang";
   K_628           : aliased constant String := "swift";
   M_628           : aliased constant String := "Swift";
   K_629           : aliased constant String := "sls";
   M_629           : aliased constant String := "Scheme, SaltStack";
   K_630           : aliased constant String := "rbuild";
   M_630           : aliased constant String := "Ruby";
   K_631           : aliased constant String := "xsjslib";
   M_631           : aliased constant String := "JavaScript";
   K_632           : aliased constant String := "mkii";
   M_632           : aliased constant String := "TeX";
   K_633           : aliased constant String := "vim";
   M_633           : aliased constant String := "VimL";
   K_634           : aliased constant String := "ps1";
   M_634           : aliased constant String := "PowerShell";
   K_635           : aliased constant String := "json";
   M_635           : aliased constant String := "JSON";
   K_636           : aliased constant String := "unity";
   M_636           : aliased constant String := "Unity3D Asset";
   K_637           : aliased constant String := "chs";
   M_637           : aliased constant String := "C2hs Haskell";
   K_638           : aliased constant String := "tf";
   M_638           : aliased constant String := "HCL";
   K_639           : aliased constant String := "viw";
   M_639           : aliased constant String := "SQL";
   K_640           : aliased constant String := "mkiv";
   M_640           : aliased constant String := "TeX";
   K_641           : aliased constant String := "yaml-tmlanguage";
   M_641           : aliased constant String := "YAML";
   K_642           : aliased constant String := "tm";
   M_642           : aliased constant String := "Tcl";
   K_643           : aliased constant String := "rhtml";
   M_643           : aliased constant String := "RHTML";
   K_644           : aliased constant String := "stan";
   M_644           : aliased constant String := "Stan";
   K_645           : aliased constant String := "numsc";
   M_645           : aliased constant String := "NumPy";
   K_646           : aliased constant String := "xojo_report";
   M_646           : aliased constant String := "Xojo";
   K_647           : aliased constant String := "ts";
   M_647           : aliased constant String := "XML, TypeScript";
   K_648           : aliased constant String := "gemspec";
   M_648           : aliased constant String := "Ruby";
   K_649           : aliased constant String := "yacc";
   M_649           : aliased constant String := "Yacc";
   K_650           : aliased constant String := "tu";
   M_650           : aliased constant String := "Turing";
   K_651           : aliased constant String := "cl2";
   M_651           : aliased constant String := "Clojure";
   K_652           : aliased constant String := "minid";
   M_652           : aliased constant String := "MiniD";
   K_653           : aliased constant String := "bison";
   M_653           : aliased constant String := "Bison";
   K_654           : aliased constant String := "dockerfile";
   M_654           : aliased constant String := "Dockerfile";
   K_655           : aliased constant String := "hpp";
   M_655           : aliased constant String := "C++";
   K_656           : aliased constant String := "vb";
   M_656           : aliased constant String := "Visual Basic";
   K_657           : aliased constant String := "psc";
   M_657           : aliased constant String := "Papyrus";
   K_658           : aliased constant String := "fxml";
   M_658           : aliased constant String := "XML";
   K_659           : aliased constant String := "vh";
   M_659           : aliased constant String := "SystemVerilog";
   K_660           : aliased constant String := "kml";
   M_660           : aliased constant String := "XML";
   K_661           : aliased constant String := "bash";
   M_661           : aliased constant String := "Shell";
   K_662           : aliased constant String := "wlua";
   M_662           : aliased constant String := "Lua";
   K_663           : aliased constant String := "eliom";
   M_663           : aliased constant String := "OCaml";
   K_664           : aliased constant String := "idc";
   M_664           : aliased constant String := "C";
   K_665           : aliased constant String := "jade";
   M_665           : aliased constant String := "Jade";
   K_666           : aliased constant String := "hlean";
   M_666           : aliased constant String := "Lean";
   K_667           : aliased constant String := "idr";
   M_667           : aliased constant String := "Idris";
   K_668           : aliased constant String := "njs";
   M_668           : aliased constant String := "JavaScript";
   K_669           : aliased constant String := "sps";
   M_669           : aliased constant String := "Scheme";
   K_670           : aliased constant String := "clj";
   M_670           : aliased constant String := "Clojure";
   K_671           : aliased constant String := "html.hl";
   M_671           : aliased constant String := "HTML";
   K_672           : aliased constant String := "hrl";
   M_672           : aliased constant String := "Erlang";
   K_673           : aliased constant String := "las";
   M_673           : aliased constant String := "Lasso";
   K_674           : aliased constant String := "clp";
   M_674           : aliased constant String := "CLIPS";
   K_675           : aliased constant String := "pub";
   M_675           : aliased constant String := "Public Key";
   K_676           : aliased constant String := "haml";
   M_676           : aliased constant String := "Haml";
   K_677           : aliased constant String := "xc";
   M_677           : aliased constant String := "XC";
   K_678           : aliased constant String := "cls";
   M_678           : aliased constant String := "Visual Basic, TeX, OpenEdge ABL, Apex";
   K_679           : aliased constant String := "db2";
   M_679           : aliased constant String := "SQLPL";
   K_680           : aliased constant String := "mxt";
   M_680           : aliased constant String := "Max";
   K_681           : aliased constant String := "clw";
   M_681           : aliased constant String := "Clarion";
   K_682           : aliased constant String := "xi";
   M_682           : aliased constant String := "Logos";
   K_683           : aliased constant String := "grxml";
   M_683           : aliased constant String := "XML";
   K_684           : aliased constant String := "xm";
   M_684           : aliased constant String := "Logos";
   K_685           : aliased constant String := "bzl";
   M_685           : aliased constant String := "Python";
   K_686           : aliased constant String := "diff";
   M_686           : aliased constant String := "Diff";
   K_687           : aliased constant String := "rbres";
   M_687           : aliased constant String := "REALbasic";
   K_688           : aliased constant String := "xq";
   M_688           : aliased constant String := "XQuery";
   K_689           : aliased constant String := "xs";
   M_689           : aliased constant String := "XS";
   K_690           : aliased constant String := "groovy";
   M_690           : aliased constant String := "Groovy";
   K_691           : aliased constant String := "lslp";
   M_691           : aliased constant String := "LSL";
   K_692           : aliased constant String := "rbbas";
   M_692           : aliased constant String := "REALbasic";
   K_693           : aliased constant String := "sexp";
   M_693           : aliased constant String := "Common Lisp";
   K_694           : aliased constant String := "maxpat";
   M_694           : aliased constant String := "Max";
   K_695           : aliased constant String := "htm";
   M_695           : aliased constant String := "HTML";
   K_696           : aliased constant String := "vala";
   M_696           : aliased constant String := "Vala";
   K_697           : aliased constant String := "fcgi";
   M_697           : aliased constant String := "Shell, Ruby, Python, Perl, PHP, Lua";
   K_698           : aliased constant String := "pwn";
   M_698           : aliased constant String := "PAWN";
   K_699           : aliased constant String := "factor";
   M_699           : aliased constant String := "Factor";
   K_700           : aliased constant String := "rabl";
   M_700           : aliased constant String := "Ruby";
   K_701           : aliased constant String := "cljscm";
   M_701           : aliased constant String := "Clojure";
   K_702           : aliased constant String := "vssettings";
   M_702           : aliased constant String := "XML";
   K_703           : aliased constant String := "less";
   M_703           : aliased constant String := "Less";
   K_704           : aliased constant String := "plist";
   M_704           : aliased constant String := "XML";
   K_705           : aliased constant String := "litcoffee";
   M_705           : aliased constant String := "Literate CoffeeScript";
   K_706           : aliased constant String := "vcxproj";
   M_706           : aliased constant String := "XML";
   K_707           : aliased constant String := "sty";
   M_707           : aliased constant String := "TeX";
   K_708           : aliased constant String := "cpp";
   M_708           : aliased constant String := "C++";
   K_709           : aliased constant String := "sagews";
   M_709           : aliased constant String := "Sage";
   K_710           : aliased constant String := "cps";
   M_710           : aliased constant String := "Component Pascal";
   K_711           : aliased constant String := "lex";
   M_711           : aliased constant String := "Lex";
   K_712           : aliased constant String := "agda";
   M_712           : aliased constant String := "Agda";
   K_713           : aliased constant String := "ksh";
   M_713           : aliased constant String := "Shell";
   K_714           : aliased constant String := "stTheme";
   M_714           : aliased constant String := "XML";
   K_715           : aliased constant String := "cpy";
   M_715           : aliased constant String := "COBOL";
   K_716           : aliased constant String := "jflex";
   M_716           : aliased constant String := "JFlex";
   K_717           : aliased constant String := "pyp";
   M_717           : aliased constant String := "Python";
   K_718           : aliased constant String := "emberscript";
   M_718           : aliased constant String := "EmberScript";
   K_719           : aliased constant String := "svg";
   M_719           : aliased constant String := "SVG";
   K_720           : aliased constant String := "thy";
   M_720           : aliased constant String := "Isabelle";
   K_721           : aliased constant String := "pyt";
   M_721           : aliased constant String := "Python";
   K_722           : aliased constant String := "svh";
   M_722           : aliased constant String := "SystemVerilog";
   K_723           : aliased constant String := "ddl";
   M_723           : aliased constant String := "SQL";
   K_724           : aliased constant String := "lidr";
   M_724           : aliased constant String := "Idris";
   K_725           : aliased constant String := "pyw";
   M_725           : aliased constant String := "Python";
   K_726           : aliased constant String := "pyx";
   M_726           : aliased constant String := "Cython";
   K_727           : aliased constant String := "wsgi";
   M_727           : aliased constant String := "Python";
   K_728           : aliased constant String := "props";
   M_728           : aliased constant String := "XML";
   K_729           : aliased constant String := "storyboard";
   M_729           : aliased constant String := "XML";
   K_730           : aliased constant String := "tmPreferences";
   M_730           : aliased constant String := "XML";
   K_731           : aliased constant String := "ijs";
   M_731           : aliased constant String := "J";
   K_732           : aliased constant String := "pytb";
   M_732           : aliased constant String := "Python traceback";
   K_733           : aliased constant String := "json5";
   M_733           : aliased constant String := "JSON5";
   K_734           : aliased constant String := "vsh";
   M_734           : aliased constant String := "GLSL";
   K_735           : aliased constant String := "qml";
   M_735           : aliased constant String := "QML";
   K_736           : aliased constant String := "ihlp";
   M_736           : aliased constant String := "Stata";
   K_737           : aliased constant String := "gap";
   M_737           : aliased constant String := "GAP";
   K_738           : aliased constant String := "odd";
   M_738           : aliased constant String := "XML";
   K_739           : aliased constant String := "lgt";
   M_739           : aliased constant String := "Logtalk";
   K_740           : aliased constant String := "http";
   M_740           : aliased constant String := "HTTP";
   K_741           : aliased constant String := "eliomi";
   M_741           : aliased constant String := "OCaml";
   K_742           : aliased constant String := "gtpl";
   M_742           : aliased constant String := "Groovy";
   K_743           : aliased constant String := "scss";
   M_743           : aliased constant String := "SCSS";
   K_744           : aliased constant String := "hxx";
   M_744           : aliased constant String := "C++";
   K_745           : aliased constant String := "vapi";
   M_745           : aliased constant String := "Vala";
   K_746           : aliased constant String := "lasso8";
   M_746           : aliased constant String := "Lasso";
   K_747           : aliased constant String := "lasso9";
   M_747           : aliased constant String := "Lasso";
   K_748           : aliased constant String := "cpp-objdump";
   M_748           : aliased constant String := "Cpp-ObjDump";
   K_749           : aliased constant String := "for";
   M_749           : aliased constant String := "Forth, Formatted, FORTRAN";
   K_750           : aliased constant String := "ps1xml";
   M_750           : aliased constant String := "XML";
   K_751           : aliased constant String := "metal";
   M_751           : aliased constant String := "Metal";
   K_752           : aliased constant String := "pd_lua";
   M_752           : aliased constant String := "Lua";
   K_753           : aliased constant String := "dfm";
   M_753           : aliased constant String := "Pascal";
   K_754           : aliased constant String := "prefs";
   M_754           : aliased constant String := "INI";
   K_755           : aliased constant String := "lid";
   M_755           : aliased constant String := "Dylan";
   K_756           : aliased constant String := "hlsl";
   M_756           : aliased constant String := "HLSL";
   K_757           : aliased constant String := "yaml";
   M_757           : aliased constant String := "YAML";
   K_758           : aliased constant String := "raw";
   M_758           : aliased constant String := "Raw token data";
   K_759           : aliased constant String := "vue";
   M_759           : aliased constant String := "Vue";
   K_760           : aliased constant String := "sublime-snippet";
   M_760           : aliased constant String := "XML";
   K_761           : aliased constant String := "ily";
   M_761           : aliased constant String := "LilyPond";
   K_762           : aliased constant String := "gco";
   M_762           : aliased constant String := "G-code";
   K_763           : aliased constant String := "ctp";
   M_763           : aliased constant String := "PHP";
   K_764           : aliased constant String := "glslv";
   M_764           : aliased constant String := "GLSL";
   K_765           : aliased constant String := "yrl";
   M_765           : aliased constant String := "Erlang";
   K_766           : aliased constant String := "golo";
   M_766           : aliased constant String := "Golo";
   K_767           : aliased constant String := "phtml";
   M_767           : aliased constant String := "HTML+PHP";
   K_768           : aliased constant String := "rktd";
   M_768           : aliased constant String := "Racket";
   K_769           : aliased constant String := "vark";
   M_769           : aliased constant String := "Gosu";
   K_770           : aliased constant String := "inc";
   M_770           : aliased constant String := "SourcePawn, SQL, Pascal, POV-Ray SDL, PHP, PAWN, HTML, C++, Assembly";
   K_771           : aliased constant String := "mata";
   M_771           : aliased constant String := "Stata";
   K_772           : aliased constant String := "sh-session";
   M_772           : aliased constant String := "ShellSession";
   K_773           : aliased constant String := "srdf";
   M_773           : aliased constant String := "XML";
   K_774           : aliased constant String := "shader";
   M_774           : aliased constant String := "GLSL";
   K_775           : aliased constant String := "ini";
   M_775           : aliased constant String := "INI";
   K_776           : aliased constant String := "rktl";
   M_776           : aliased constant String := "Racket";
   K_777           : aliased constant String := "maxhelp";
   M_777           : aliased constant String := "Max";
   K_778           : aliased constant String := "inl";
   M_778           : aliased constant String := "C++";
   K_779           : aliased constant String := "proto";
   M_779           : aliased constant String := "Protocol Buffer";
   K_780           : aliased constant String := "syntax";
   M_780           : aliased constant String := "YAML";
   K_781           : aliased constant String := "rebol";
   M_781           : aliased constant String := "Rebol";
   K_782           : aliased constant String := "vbhtml";
   M_782           : aliased constant String := "Visual Basic";
   K_783           : aliased constant String := "ino";
   M_783           : aliased constant String := "Arduino";
   K_784           : aliased constant String := "prefab";
   M_784           : aliased constant String := "Unity3D Asset";
   K_785           : aliased constant String := "ins";
   M_785           : aliased constant String := "TeX";
   K_786           : aliased constant String := "thrift";
   M_786           : aliased constant String := "Thrift";
   K_787           : aliased constant String := "plot";
   M_787           : aliased constant String := "Gnuplot";
   K_788           : aliased constant String := "boot";
   M_788           : aliased constant String := "Clojure";
   K_789           : aliased constant String := "geo";
   M_789           : aliased constant String := "GLSL";
   K_790           : aliased constant String := "ebuild";
   M_790           : aliased constant String := "Gentoo Ebuild";
   K_791           : aliased constant String := "sublime-workspace";
   M_791           : aliased constant String := "JavaScript";
   K_792           : aliased constant String := "fsh";
   M_792           : aliased constant String := "GLSL";
   K_793           : aliased constant String := "fsi";
   M_793           : aliased constant String := "F#";
   K_794           : aliased constant String := "reb";
   M_794           : aliased constant String := "Rebol";
   K_795           : aliased constant String := "red";
   M_795           : aliased constant String := "Red";
   K_796           : aliased constant String := "ston";
   M_796           : aliased constant String := "STON";
   K_797           : aliased constant String := "c++-objdump";
   M_797           : aliased constant String := "Cpp-ObjDump";
   K_798           : aliased constant String := "ipf";
   M_798           : aliased constant String := "IGOR Pro";
   K_799           : aliased constant String := "zmpl";
   M_799           : aliased constant String := "Zimpl";
   K_800           : aliased constant String := "fsx";
   M_800           : aliased constant String := "F#";
   K_801           : aliased constant String := "desktop.in";
   M_801           : aliased constant String := "desktop";
   K_802           : aliased constant String := "sublime-theme";
   M_802           : aliased constant String := "JavaScript";
   K_803           : aliased constant String := "ipp";
   M_803           : aliased constant String := "C++";
   K_804           : aliased constant String := "djs";
   M_804           : aliased constant String := "Dogescript";
   K_805           : aliased constant String := "sh.in";
   M_805           : aliased constant String := "Shell";
   K_806           : aliased constant String := "vhost";
   M_806           : aliased constant String := "Nginx, ApacheConf";
   K_807           : aliased constant String := "lmi";
   M_807           : aliased constant String := "Python";
   K_808           : aliased constant String := "glsl";
   M_808           : aliased constant String := "GLSL";
   K_809           : aliased constant String := "xaml";
   M_809           : aliased constant String := "XML";
   K_810           : aliased constant String := "adoc";
   M_810           : aliased constant String := "AsciiDoc";
   K_811           : aliased constant String := "bas";
   M_811           : aliased constant String := "Visual Basic";
   K_812           : aliased constant String := "bat";
   M_812           : aliased constant String := "Batchfile";
   K_813           : aliased constant String := "pasm";
   M_813           : aliased constant String := "Parrot Assembly";
   K_814           : aliased constant String := "duby";
   M_814           : aliased constant String := "Mirah";
   K_815           : aliased constant String := "cson";
   M_815           : aliased constant String := "CoffeeScript";
   K_816           : aliased constant String := "tpl";
   M_816           : aliased constant String := "Smarty";
   K_817           : aliased constant String := "pony";
   M_817           : aliased constant String := "Pony";
   K_818           : aliased constant String := "cxx";
   M_818           : aliased constant String := "C++";
   K_819           : aliased constant String := "tpp";
   M_819           : aliased constant String := "C++";
   K_820           : aliased constant String := "fun";
   M_820           : aliased constant String := "Standard ML";
   K_821           : aliased constant String := "mak";
   M_821           : aliased constant String := "Makefile";
   K_822           : aliased constant String := "man";
   M_822           : aliased constant String := "Groff";
   K_823           : aliased constant String := "mao";
   M_823           : aliased constant String := "Mako";
   K_824           : aliased constant String := "dlm";
   M_824           : aliased constant String := "IDL";
   K_825           : aliased constant String := "mat";
   M_825           : aliased constant String := "Unity3D Asset";
   K_826           : aliased constant String := "udf";
   M_826           : aliased constant String := "SQL";
   K_827           : aliased constant String := "aj";
   M_827           : aliased constant String := "AspectJ";
   K_828           : aliased constant String := "al";
   M_828           : aliased constant String := "Perl";
   K_829           : aliased constant String := "xhtml";
   M_829           : aliased constant String := "HTML";
   K_830           : aliased constant String := "xquery";
   M_830           : aliased constant String := "XQuery";
   K_831           : aliased constant String := "lol";
   M_831           : aliased constant String := "LOLCODE";
   K_832           : aliased constant String := "as";
   M_832           : aliased constant String := "ActionScript";
   K_833           : aliased constant String := "aw";
   M_833           : aliased constant String := "PHP";
   K_834           : aliased constant String := "xojo_window";
   M_834           : aliased constant String := "Xojo";
   K_835           : aliased constant String := "gawk";
   M_835           : aliased constant String := "Awk";
   K_836           : aliased constant String := "patch";
   M_836           : aliased constant String := "Diff";
   K_837           : aliased constant String := "dita";
   M_837           : aliased constant String := "XML";
   K_838           : aliased constant String := "hlsli";
   M_838           : aliased constant String := "HLSL";
   K_839           : aliased constant String := "psc1";
   M_839           : aliased constant String := "XML";
   K_840           : aliased constant String := "cc";
   M_840           : aliased constant String := "C++";
   K_841           : aliased constant String := "lasso";
   M_841           : aliased constant String := "Lasso";
   K_842           : aliased constant String := "vhdl";
   M_842           : aliased constant String := "VHDL";
   K_843           : aliased constant String := "mcr";
   M_843           : aliased constant String := "MAXScript";
   K_844           : aliased constant String := "ch";
   M_844           : aliased constant String := "xBase, Charity";
   K_845           : aliased constant String := "ck";
   M_845           : aliased constant String := "ChucK";
   K_846           : aliased constant String := "cl";
   M_846           : aliased constant String := "OpenCL, Cool, Common Lisp";
   K_847           : aliased constant String := "smali";
   M_847           : aliased constant String := "Smali";
   K_848           : aliased constant String := "dyalog";
   M_848           : aliased constant String := "APL";
   K_849           : aliased constant String := "cp";
   M_849           : aliased constant String := "Component Pascal, C++";
   K_850           : aliased constant String := "c-objdump";
   M_850           : aliased constant String := "C-ObjDump";
   K_851           : aliased constant String := "cr";
   M_851           : aliased constant String := "Crystal";
   K_852           : aliased constant String := "au3";
   M_852           : aliased constant String := "AutoIt";
   K_853           : aliased constant String := "cs";
   M_853           : aliased constant String := "Smalltalk, C#";
   K_854           : aliased constant String := "ct";
   M_854           : aliased constant String := "XML";
   K_855           : aliased constant String := "mdpolicy";
   M_855           : aliased constant String := "XML";
   K_856           : aliased constant String := "cu";
   M_856           : aliased constant String := "Cuda";
   K_857           : aliased constant String := "sublime_metrics";
   M_857           : aliased constant String := "JavaScript";
   K_858           : aliased constant String := "cw";
   M_858           : aliased constant String := "Redcode";
   K_859           : aliased constant String := "asc";
   M_859           : aliased constant String := "Public Key, AsciiDoc, AGS Script";
   K_860           : aliased constant String := "jscad";
   M_860           : aliased constant String := "JavaScript";
   K_861           : aliased constant String := "cy";
   M_861           : aliased constant String := "Cycript";
   K_862           : aliased constant String := "asd";
   M_862           : aliased constant String := "Common Lisp";
   K_863           : aliased constant String := "ash";
   M_863           : aliased constant String := "AGS Script";
   K_864           : aliased constant String := "ttl";
   M_864           : aliased constant String := "Turtle";
   K_865           : aliased constant String := "applescript";
   M_865           : aliased constant String := "AppleScript";
   K_866           : aliased constant String := "asm";
   M_866           : aliased constant String := "Assembly";
   K_867           : aliased constant String := "liquid";
   M_867           : aliased constant String := "Liquid";
   K_868           : aliased constant String := "java";
   M_868           : aliased constant String := "Java";
   K_869           : aliased constant String := "asp";
   M_869           : aliased constant String := "ASP";
   K_870           : aliased constant String := "g4";
   M_870           : aliased constant String := "ANTLR";
   K_871           : aliased constant String := "ditaval";
   M_871           : aliased constant String := "XML";
   K_872           : aliased constant String := "sats";
   M_872           : aliased constant String := "ATS";
   K_873           : aliased constant String := "gcode";
   M_873           : aliased constant String := "G-code";
   K_874           : aliased constant String := "ec";
   M_874           : aliased constant String := "eC";
   K_875           : aliased constant String := "matah";
   M_875           : aliased constant String := "Stata";
   K_876           : aliased constant String := "xojo_toolbar";
   M_876           : aliased constant String := "Xojo";
   K_877           : aliased constant String := "rkt";
   M_877           : aliased constant String := "Racket";
   K_878           : aliased constant String := "eh";
   M_878           : aliased constant String := "eC";
   K_879           : aliased constant String := "pbi";
   M_879           : aliased constant String := "PureBasic";
   K_880           : aliased constant String := "dpr";
   M_880           : aliased constant String := "Pascal";
   K_881           : aliased constant String := "_js";
   M_881           : aliased constant String := "JavaScript";
   K_882           : aliased constant String := "el";
   M_882           : aliased constant String := "Emacs Lisp";
   K_883           : aliased constant String := "em";
   M_883           : aliased constant String := "EmberScript";
   K_884           : aliased constant String := "arpa";
   M_884           : aliased constant String := "DNS Zone";
   K_885           : aliased constant String := "gml";
   M_885           : aliased constant String := "XML, Graph Modeling Language, Game Maker Language";
   K_886           : aliased constant String := "lsl";
   M_886           : aliased constant String := "LSL";
   K_887           : aliased constant String := "ivy";
   M_887           : aliased constant String := "XML";
   K_888           : aliased constant String := "kicad_pcb";
   M_888           : aliased constant String := "KiCad";
   K_889           : aliased constant String := "opa";
   M_889           : aliased constant String := "Opa";
   K_890           : aliased constant String := "es";
   M_890           : aliased constant String := "JavaScript, Erlang";
   K_891           : aliased constant String := "mkfile";
   M_891           : aliased constant String := "Makefile";
   K_892           : aliased constant String := "lsp";
   M_892           : aliased constant String := "NewLisp, Common Lisp";
   K_893           : aliased constant String := "gms";
   M_893           : aliased constant String := "GAMS";
   K_894           : aliased constant String := "ex";
   M_894           : aliased constant String := "Elixir";
   K_895           : aliased constant String := "aug";
   M_895           : aliased constant String := "Augeas";
   K_896           : aliased constant String := "edn";
   M_896           : aliased constant String := "edn";
   K_897           : aliased constant String := "thor";
   M_897           : aliased constant String := "Ruby";
   K_898           : aliased constant String := "auk";
   M_898           : aliased constant String := "Awk";
   K_899           : aliased constant String := "jbuilder";
   M_899           : aliased constant String := "Ruby";
   K_900           : aliased constant String := "rmd";
   M_900           : aliased constant String := "RMarkdown";
   K_901           : aliased constant String := "wsf";
   M_901           : aliased constant String := "XML";
   K_902           : aliased constant String := "tmux";
   M_902           : aliased constant String := "Shell";
   K_903           : aliased constant String := "sublime-keymap";
   M_903           : aliased constant String := "JavaScript";
   K_904           : aliased constant String := "aux";
   M_904           : aliased constant String := "TeX";

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
      K_904'Access);

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
      M_904'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Files.Extensions;
