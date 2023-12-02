--  Advanced Resource Embedder 1.3.0
--  SPDX-License-Identifier: Apache-2.0
--  Extensions mapping generated from extensions.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Files.Extensions is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 8) of Natural :=
     (1, 2, 3, 4, 5, 6, 9, 11, 12);

   T1 : constant array (0 .. 8) of Unsigned_16 :=
     (1708, 1749, 723, 644, 447, 485, 602, 1676, 784);

   T2 : constant array (0 .. 8) of Unsigned_16 :=
     (557, 885, 1228, 1520, 913, 261, 60, 1766, 859);

   G : constant array (0 .. 1806) of Unsigned_16 :=
     (425, 0, 0, 0, 775, 552, 886, 0, 814, 0, 523, 0, 633, 0, 108, 818, 0,
      0, 0, 0, 194, 354, 578, 0, 659, 0, 0, 0, 0, 0, 251, 470, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 475, 0, 780, 0, 0, 0, 0, 0, 455, 0, 72, 0, 0, 529, 306,
      0, 0, 417, 0, 0, 0, 277, 606, 0, 0, 0, 734, 0, 0, 643, 249, 0, 192, 0,
      11, 0, 651, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 367, 0, 0, 0, 651, 0, 0, 0,
      0, 0, 473, 0, 680, 0, 408, 0, 636, 901, 795, 0, 0, 340, 0, 0, 0, 0,
      473, 723, 0, 0, 0, 0, 363, 148, 0, 0, 0, 0, 694, 883, 0, 0, 0, 0, 280,
      0, 0, 0, 0, 0, 447, 0, 70, 600, 0, 605, 812, 0, 0, 0, 0, 401, 0, 0,
      758, 0, 0, 0, 294, 0, 0, 0, 0, 0, 700, 60, 146, 0, 0, 96, 0, 0, 0, 0,
      745, 0, 844, 0, 663, 344, 0, 0, 0, 405, 0, 166, 0, 0, 0, 0, 0, 0, 0,
      0, 854, 0, 0, 0, 530, 0, 290, 0, 0, 745, 0, 0, 0, 566, 0, 0, 129, 0,
      610, 161, 0, 574, 702, 0, 329, 474, 0, 0, 0, 0, 0, 0, 0, 639, 0, 0, 0,
      0, 597, 0, 876, 806, 0, 0, 0, 819, 490, 333, 0, 0, 59, 0, 0, 0, 0, 0,
      2, 89, 0, 233, 175, 645, 829, 0, 517, 240, 805, 0, 0, 0, 0, 478, 714,
      0, 0, 644, 18, 0, 344, 57, 0, 40, 0, 0, 0, 0, 517, 0, 0, 0, 0, 0, 0,
      0, 0, 136, 0, 326, 0, 902, 0, 846, 0, 239, 409, 596, 0, 376, 30, 0, 0,
      0, 766, 0, 154, 0, 0, 823, 855, 0, 897, 0, 0, 0, 0, 0, 0, 0, 100, 0,
      374, 0, 0, 17, 337, 0, 770, 440, 0, 0, 287, 270, 0, 0, 734, 0, 0, 294,
      849, 0, 0, 240, 0, 696, 92, 0, 0, 0, 0, 0, 0, 434, 0, 0, 473, 0, 0,
      376, 0, 0, 0, 568, 655, 0, 0, 0, 311, 299, 295, 0, 322, 0, 0, 0, 792,
      863, 198, 0, 0, 142, 0, 760, 0, 0, 658, 0, 0, 14, 0, 681, 0, 0, 362,
      0, 816, 41, 586, 0, 755, 628, 804, 873, 258, 0, 0, 0, 0, 0, 40, 812,
      831, 0, 0, 478, 0, 0, 505, 0, 0, 0, 339, 0, 227, 0, 0, 503, 717, 850,
      452, 283, 0, 0, 0, 715, 0, 0, 319, 0, 808, 604, 0, 0, 348, 0, 235,
      768, 20, 412, 331, 392, 0, 469, 0, 185, 0, 299, 387, 321, 0, 0, 0, 0,
      0, 622, 0, 0, 0, 0, 0, 0, 0, 0, 775, 356, 0, 0, 0, 356, 0, 290, 802,
      0, 0, 0, 20, 39, 0, 0, 0, 0, 262, 0, 0, 0, 0, 0, 0, 0, 506, 401, 0, 0,
      490, 704, 0, 80, 0, 0, 0, 0, 175, 0, 434, 478, 169, 473, 0, 0, 337,
      703, 95, 510, 0, 91, 561, 0, 0, 0, 605, 368, 175, 368, 0, 0, 0, 0,
      821, 0, 0, 0, 0, 13, 820, 205, 354, 662, 0, 0, 0, 0, 0, 743, 0, 0, 0,
      184, 430, 0, 504, 508, 845, 0, 469, 61, 890, 278, 453, 0, 34, 669, 0,
      0, 187, 0, 488, 79, 308, 669, 0, 670, 0, 76, 602, 0, 0, 404, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 551, 0, 0, 381, 0, 351, 348, 0, 0, 0, 669, 0, 100,
      0, 0, 523, 229, 0, 0, 0, 8, 602, 201, 33, 0, 1, 0, 160, 0, 0, 0, 895,
      0, 476, 856, 821, 0, 0, 0, 697, 225, 0, 648, 0, 632, 0, 690, 0, 0, 0,
      732, 869, 607, 755, 215, 0, 0, 0, 0, 200, 0, 0, 371, 166, 0, 231, 0,
      615, 0, 0, 735, 134, 0, 189, 434, 75, 0, 466, 647, 509, 484, 0, 0, 0,
      570, 0, 0, 742, 0, 422, 426, 0, 618, 778, 0, 0, 199, 0, 50, 0, 0, 340,
      268, 681, 323, 761, 0, 520, 0, 0, 677, 698, 0, 304, 779, 0, 691, 0,
      318, 0, 0, 557, 0, 286, 0, 110, 599, 455, 0, 0, 468, 0, 128, 0, 146,
      361, 58, 223, 526, 0, 0, 0, 0, 0, 839, 554, 130, 0, 37, 173, 508, 178,
      0, 782, 265, 224, 111, 807, 30, 0, 0, 167, 615, 571, 452, 725, 568,
      521, 0, 0, 594, 0, 95, 0, 775, 745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 585,
      696, 0, 0, 0, 0, 294, 413, 0, 0, 0, 882, 409, 0, 85, 460, 649, 0, 0,
      546, 0, 0, 0, 120, 0, 0, 0, 627, 0, 666, 0, 0, 0, 390, 0, 0, 667, 0,
      0, 0, 657, 162, 0, 254, 484, 850, 533, 0, 193, 0, 0, 241, 0, 146, 841,
      0, 0, 420, 0, 0, 81, 0, 0, 0, 0, 425, 0, 0, 15, 1, 360, 0, 0, 0, 591,
      0, 0, 655, 0, 0, 0, 83, 289, 427, 0, 128, 0, 0, 96, 606, 19, 0, 474,
      0, 113, 0, 0, 0, 0, 0, 285, 759, 185, 0, 0, 0, 308, 0, 693, 0, 279,
      361, 599, 32, 0, 0, 0, 486, 45, 0, 55, 271, 447, 248, 644, 0, 0, 9, 0,
      0, 0, 0, 66, 9, 407, 0, 499, 106, 0, 0, 0, 24, 5, 0, 831, 601, 554,
      96, 338, 0, 0, 435, 0, 767, 0, 0, 776, 0, 0, 548, 0, 0, 0, 287, 0, 0,
      324, 51, 894, 227, 787, 0, 0, 0, 418, 882, 769, 0, 0, 0, 0, 869, 0, 0,
      540, 0, 796, 0, 0, 0, 0, 821, 0, 0, 264, 703, 882, 117, 0, 0, 18, 0,
      0, 517, 479, 0, 0, 162, 0, 0, 0, 325, 0, 186, 529, 0, 0, 0, 347, 835,
      652, 899, 0, 0, 0, 0, 0, 288, 0, 462, 0, 0, 333, 676, 0, 0, 506, 206,
      0, 36, 0, 0, 497, 395, 816, 0, 214, 0, 0, 0, 75, 42, 604, 0, 209, 0,
      0, 257, 78, 0, 0, 0, 0, 0, 0, 390, 0, 75, 251, 0, 0, 890, 569, 68,
      127, 888, 0, 346, 0, 0, 0, 0, 23, 73, 0, 0, 824, 309, 0, 0, 138, 0,
      183, 112, 499, 0, 311, 0, 0, 22, 0, 0, 899, 631, 0, 0, 0, 166, 776,
      45, 0, 410, 115, 864, 742, 255, 796, 607, 0, 20, 733, 56, 0, 874, 0,
      728, 0, 119, 890, 0, 415, 521, 66, 416, 0, 0, 777, 0, 662, 0, 62, 359,
      0, 0, 0, 803, 0, 265, 0, 422, 250, 293, 229, 837, 347, 0, 240, 188,
      595, 0, 0, 0, 0, 0, 586, 0, 475, 738, 0, 222, 0, 0, 405, 0, 313, 0,
      474, 27, 114, 638, 588, 0, 0, 33, 0, 766, 424, 0, 0, 0, 0, 527, 190,
      426, 0, 0, 0, 0, 0, 526, 723, 74, 0, 0, 722, 0, 0, 543, 0, 222, 0, 0,
      0, 587, 656, 0, 216, 222, 0, 301, 12, 0, 712, 0, 483, 818, 839, 895,
      0, 0, 0, 685, 298, 878, 45, 89, 776, 423, 304, 0, 0, 0, 0, 135, 34,
      862, 660, 0, 879, 109, 630, 0, 0, 0, 840, 0, 0, 0, 274, 0, 868, 0, 0,
      0, 0, 305, 278, 0, 0, 97, 0, 0, 0, 0, 0, 0, 498, 859, 100, 840, 0,
      377, 0, 0, 526, 78, 463, 0, 0, 0, 0, 4, 315, 72, 630, 301, 0, 592, 0,
      0, 0, 337, 0, 89, 447, 0, 0, 43, 0, 0, 0, 0, 0, 0, 242, 579, 0, 825,
      392, 620, 173, 0, 477, 599, 497, 708, 745, 868, 0, 591, 79, 176, 0,
      661, 0, 106, 0, 0, 0, 0, 462, 875, 651, 811, 218, 0, 0, 318, 0, 0,
      822, 470, 0, 596, 20, 0, 0, 191, 0, 370, 11, 0, 0, 81, 207, 0, 0, 0,
      820, 0, 0, 86, 0, 0, 0, 751, 549, 457, 0, 0, 357, 13, 471, 223, 102,
      422, 341, 0, 716, 0, 0, 0, 138, 664, 11, 0, 0, 741, 0, 0, 852, 0, 0,
      0, 744, 804, 0, 67, 0, 859, 293, 448, 62, 0, 0, 0, 0, 0, 231, 180, 0,
      553, 859, 154, 443, 0, 0, 0, 0, 0, 0, 0, 0, 16, 437, 405, 0, 468, 116,
      258, 0, 49, 593, 0, 164, 0, 272, 0, 853, 715, 110, 100, 10, 82, 273,
      667, 0, 0, 0, 754, 686, 318, 463, 59, 0, 542, 0, 0, 65, 0, 486, 0, 6,
      449, 0, 867, 0, 141, 199, 0, 569, 726, 714, 42, 716, 846, 79, 0, 475,
      650, 0, 538, 629, 280, 857, 234, 114, 633, 0, 0, 740, 868, 711, 0, 69,
      377, 0, 435, 0, 3, 661, 440, 14, 0, 228, 486, 0, 0, 0, 778, 0, 886, 0,
      0, 412, 131, 0, 0, 669, 416, 897, 0, 0, 63, 521, 411, 827, 0, 763, 0,
      0, 0, 428, 848, 142, 36, 599, 428, 591, 0, 0, 511, 414, 0, 0, 520,
      267, 852, 852, 0, 0, 869, 192, 0, 582, 483, 854, 729, 269, 0, 785, 0,
      181, 0, 202, 218, 874, 480, 714, 425, 0, 0, 61, 830, 348, 0, 383, 326,
      0, 791, 495, 413, 0, 78, 351, 617, 0, 0, 0, 287, 877, 153, 53, 728,
      828, 149, 382, 23, 0, 0, 625, 238, 0, 0, 633, 95, 788, 0, 297, 362,
      672, 513, 281, 465, 756, 0, 712, 312, 590, 0, 48, 855, 0, 799, 0, 776,
      0, 21, 355, 0, 487, 746, 385, 0, 390, 132, 0, 0, 314, 88, 541, 2, 0,
      0, 350, 0, 0, 422, 0, 0, 0, 0, 190, 315, 0, 211, 316, 599, 396, 126,
      111, 263, 0, 433, 896, 356, 0, 0, 0, 0, 140, 326, 29, 385, 20, 0, 439,
      0, 459, 747, 0, 0, 35, 0, 0, 776, 0, 387, 331, 233, 0, 50, 0, 9, 0, 0,
      196, 0, 0, 192, 823, 0, 28, 27, 0, 0, 0, 0, 0, 0, 72, 0, 151, 900, 0,
      514, 374, 487, 0, 0, 0, 471, 43, 323, 231, 764, 0, 0, 0, 0, 40, 31, 0,
      0, 0, 0, 879, 25, 0, 492, 472, 0, 0, 355, 63, 832, 125, 0, 862, 366,
      31, 648, 0, 509, 493, 505, 446, 244, 0, 0, 0, 539, 538, 875, 389, 0,
      97, 196, 100, 43, 175, 210, 0, 38, 357, 625, 0, 0, 192, 726, 713, 0,
      628, 609, 247, 322, 596, 0, 0, 0, 7, 0, 887, 0, 482, 10, 642, 343,
      570, 467, 739, 113, 724, 160, 26, 0, 0, 700, 259, 0, 0, 0, 877, 167);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 1807;
         F2 := (F2 + Natural (T2 (K)) * J) mod 1807;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 903;
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
   K_61            : aliased constant String := "E";
   M_61            : aliased constant String := "E";
   K_62            : aliased constant String := "sublime-commands";
   M_62            : aliased constant String := "JavaScript";
   K_63            : aliased constant String := "mkd";
   M_63            : aliased constant String := "Markdown";
   K_64            : aliased constant String := "reek";
   M_64            : aliased constant String := "YAML";
   K_65            : aliased constant String := "jsfl";
   M_65            : aliased constant String := "JavaScript";
   K_66            : aliased constant String := "cljs";
   M_66            : aliased constant String := "Clojure";
   K_67            : aliased constant String := "m4";
   M_67            : aliased constant String := "M4Sugar, M4";
   K_68            : aliased constant String := "cljx";
   M_68            : aliased constant String := "Clojure";
   K_69            : aliased constant String := "axs.erb";
   M_69            : aliased constant String := "NetLinx+ERB";
   K_70            : aliased constant String := "mumps";
   M_70            : aliased constant String := "M";
   K_71            : aliased constant String := "opencl";
   M_71            : aliased constant String := "OpenCL";
   K_72            : aliased constant String := "purs";
   M_72            : aliased constant String := "PureScript";
   K_73            : aliased constant String := "a51";
   M_73            : aliased constant String := "Assembly";
   K_74            : aliased constant String := "rest.txt";
   M_74            : aliased constant String := "reStructuredText";
   K_75            : aliased constant String := "php";
   M_75            : aliased constant String := "PHP, Hack";
   K_76            : aliased constant String := "uno";
   M_76            : aliased constant String := "Uno";
   K_77            : aliased constant String := "b";
   M_77            : aliased constant String := "Limbo, Brainfuck";
   K_78            : aliased constant String := "c";
   M_78            : aliased constant String := "C";
   K_79            : aliased constant String := "spin";
   M_79            : aliased constant String := "Propeller Spin";
   K_80            : aliased constant String := "d";
   M_80            : aliased constant String := "Makefile, DTrace, D";
   K_81            : aliased constant String := "e";
   M_81            : aliased constant String := "Eiffel";
   K_82            : aliased constant String := "kt";
   M_82            : aliased constant String := "Kotlin";
   K_83            : aliased constant String := "gsp";
   M_83            : aliased constant String := "Groovy Server Pages";
   K_84            : aliased constant String := "ashx";
   M_84            : aliased constant String := "ASP";
   K_85            : aliased constant String := "f";
   M_85            : aliased constant String := "Forth, FORTRAN";
   K_86            : aliased constant String := "g";
   M_86            : aliased constant String := "GAP, G-code";
   K_87            : aliased constant String := "h";
   M_87            : aliased constant String := "Objective-C, C++, C";
   K_88            : aliased constant String := "gst";
   M_88            : aliased constant String := "Gosu";
   K_89            : aliased constant String := "j";
   M_89            : aliased constant String := "Objective-J, Jasmin";
   K_90            : aliased constant String := "ampl";
   M_90            : aliased constant String := "AMPL";
   K_91            : aliased constant String := "l";
   M_91            : aliased constant String := "PicoLisp, Lex, Groff, Common Lisp";
   K_92            : aliased constant String := "bmx";
   M_92            : aliased constant String := "BlitzMax";
   K_93            : aliased constant String := "topojson";
   M_93            : aliased constant String := "JSON";
   K_94            : aliased constant String := "m";
   M_94            : aliased constant String := "Objective-C, Mercury, Matlab, Mathematica, MUF, M, Limbo";
   K_95            : aliased constant String := "vba";
   M_95            : aliased constant String := "Visual Basic";
   K_96            : aliased constant String := "gsx";
   M_96            : aliased constant String := "Gosu";
   K_97            : aliased constant String := "n";
   M_97            : aliased constant String := "Nemerle, Groff";
   K_98            : aliased constant String := "p";
   M_98            : aliased constant String := "OpenEdge ABL";
   K_99            : aliased constant String := "r";
   M_99            : aliased constant String := "Rebol, R";
   K_100           : aliased constant String := "darcspatch";
   M_100           : aliased constant String := "Darcs Patch";
   K_101           : aliased constant String := "s";
   M_101           : aliased constant String := "GAS";
   K_102           : aliased constant String := "t";
   M_102           : aliased constant String := "Turing, Terra, Perl6, Perl";
   K_103           : aliased constant String := "v";
   M_103           : aliased constant String := "Verilog, Coq";
   K_104           : aliased constant String := "w";
   M_104           : aliased constant String := "C";
   K_105           : aliased constant String := "x";
   M_105           : aliased constant String := "Logos";
   K_106           : aliased constant String := "rsh";
   M_106           : aliased constant String := "RenderScript";
   K_107           : aliased constant String := "y";
   M_107           : aliased constant String := "Yacc";
   K_108           : aliased constant String := "mmk";
   M_108           : aliased constant String := "Module Management System";
   K_109           : aliased constant String := "psm1";
   M_109           : aliased constant String := "PowerShell";
   K_110           : aliased constant String := "dpatch";
   M_110           : aliased constant String := "Darcs Patch";
   K_111           : aliased constant String := "ma";
   M_111           : aliased constant String := "Mathematica";
   K_112           : aliased constant String := "pl6";
   M_112           : aliased constant String := "Perl6";
   K_113           : aliased constant String := "vbs";
   M_113           : aliased constant String := "Visual Basic";
   K_114           : aliased constant String := "md";
   M_114           : aliased constant String := "Markdown";
   K_115           : aliased constant String := "upc";
   M_115           : aliased constant String := "Unified Parallel C";
   K_116           : aliased constant String := "me";
   M_116           : aliased constant String := "Groff";
   K_117           : aliased constant String := "mms";
   M_117           : aliased constant String := "Module Management System";
   K_118           : aliased constant String := "sublime-menu";
   M_118           : aliased constant String := "JavaScript";
   K_119           : aliased constant String := "rss";
   M_119           : aliased constant String := "XML";
   K_120           : aliased constant String := "rst";
   M_120           : aliased constant String := "reStructuredText";
   K_121           : aliased constant String := "mk";
   M_121           : aliased constant String := "Makefile";
   K_122           : aliased constant String := "rsx";
   M_122           : aliased constant String := "R";
   K_123           : aliased constant String := "ml";
   M_123           : aliased constant String := "OCaml";
   K_124           : aliased constant String := "mm";
   M_124           : aliased constant String := "XML, Objective-C++";
   K_125           : aliased constant String := "mo";
   M_125           : aliased constant String := "Modelica";
   K_126           : aliased constant String := "eclass";
   M_126           : aliased constant String := "Gentoo Eclass";
   K_127           : aliased constant String := "jelly";
   M_127           : aliased constant String := "XML";
   K_128           : aliased constant String := "boo";
   M_128           : aliased constant String := "Boo";
   K_129           : aliased constant String := "ms";
   M_129           : aliased constant String := "MAXScript, Groff, GAS";
   K_130           : aliased constant String := "mt";
   M_130           : aliased constant String := "Mathematica";
   K_131           : aliased constant String := "opal";
   M_131           : aliased constant String := "Opal";
   K_132           : aliased constant String := "mu";
   M_132           : aliased constant String := "mupad";
   K_133           : aliased constant String := "xmi";
   M_133           : aliased constant String := "XML";
   K_134           : aliased constant String := "xml";
   M_134           : aliased constant String := "XML";
   K_135           : aliased constant String := "oxh";
   M_135           : aliased constant String := "Ox";
   K_136           : aliased constant String := "oxygene";
   M_136           : aliased constant String := "Oxygene";
   K_137           : aliased constant String := "elm";
   M_137           : aliased constant String := "Elm";
   K_138           : aliased constant String := "hic";
   M_138           : aliased constant String := "Clojure";
   K_139           : aliased constant String := "oxo";
   M_139           : aliased constant String := "Ox";
   K_140           : aliased constant String := "mod";
   M_140           : aliased constant String := "XML, Modula-2, Linux Kernel Module, AMPL";
   K_141           : aliased constant String := "mkdn";
   M_141           : aliased constant String := "Markdown";
   K_142           : aliased constant String := "ccp";
   M_142           : aliased constant String := "COBOL";
   K_143           : aliased constant String := "moo";
   M_143           : aliased constant String := "Moocode, Mercury";
   K_144           : aliased constant String := "plb";
   M_144           : aliased constant String := "PLSQL";
   K_145           : aliased constant String := "bones";
   M_145           : aliased constant String := "JavaScript";
   K_146           : aliased constant String := "numpyw";
   M_146           : aliased constant String := "NumPy";
   K_147           : aliased constant String := "yap";
   M_147           : aliased constant String := "Prolog";
   K_148           : aliased constant String := "mxml";
   M_148           : aliased constant String := "XML";
   K_149           : aliased constant String := "perl";
   M_149           : aliased constant String := "Perl";
   K_150           : aliased constant String := "pls";
   M_150           : aliased constant String := "PLSQL";
   K_151           : aliased constant String := "urs";
   M_151           : aliased constant String := "UrWeb";
   K_152           : aliased constant String := "sig";
   M_152           : aliased constant String := "Standard ML";
   K_153           : aliased constant String := "tcsh";
   M_153           : aliased constant String := "Tcsh";
   K_154           : aliased constant String := "plt";
   M_154           : aliased constant String := "Gnuplot";
   K_155           : aliased constant String := "ox";
   M_155           : aliased constant String := "Ox";
   K_156           : aliased constant String := "plx";
   M_156           : aliased constant String := "Perl";
   K_157           : aliased constant String := "ncl";
   M_157           : aliased constant String := "Text, NCL";
   K_158           : aliased constant String := "oz";
   M_158           : aliased constant String := "Oz";
   K_159           : aliased constant String := "smt2";
   M_159           : aliased constant String := "SMT";
   K_160           : aliased constant String := "mkdown";
   M_160           : aliased constant String := "Markdown";
   K_161           : aliased constant String := "ssjs";
   M_161           : aliased constant String := "JavaScript";
   K_162           : aliased constant String := "sublime-completions";
   M_162           : aliased constant String := "JavaScript";
   K_163           : aliased constant String := "scaml";
   M_163           : aliased constant String := "Scaml";
   K_164           : aliased constant String := "d-objdump";
   M_164           : aliased constant String := "D-ObjDump";
   K_165           : aliased constant String := "wisp";
   M_165           : aliased constant String := "wisp";
   K_166           : aliased constant String := "cobol";
   M_166           : aliased constant String := "COBOL";
   K_167           : aliased constant String := "textile";
   M_167           : aliased constant String := "Textile";
   K_168           : aliased constant String := "befunge";
   M_168           : aliased constant String := "Befunge";
   K_169           : aliased constant String := "gyp";
   M_169           : aliased constant String := "Python";
   K_170           : aliased constant String := "axi.erb";
   M_170           : aliased constant String := "NetLinx+ERB";
   K_171           : aliased constant String := "_coffee";
   M_171           : aliased constant String := "CoffeeScript";
   K_172           : aliased constant String := "asset";
   M_172           : aliased constant String := "Unity3D Asset";
   K_173           : aliased constant String := "bsv";
   M_173           : aliased constant String := "Bluespec";
   K_174           : aliased constant String := "jsproj";
   M_174           : aliased constant String := "XML";
   K_175           : aliased constant String := "epj";
   M_175           : aliased constant String := "Ecere Projects";
   K_176           : aliased constant String := "xql";
   M_176           : aliased constant String := "XQuery";
   K_177           : aliased constant String := "xqm";
   M_177           : aliased constant String := "XQuery";
   K_178           : aliased constant String := "matlab";
   M_178           : aliased constant String := "Matlab";
   K_179           : aliased constant String := "vhd";
   M_179           : aliased constant String := "VHDL";
   K_180           : aliased constant String := "vhf";
   M_180           : aliased constant String := "VHDL";
   K_181           : aliased constant String := "xojo_menu";
   M_181           : aliased constant String := "Xojo";
   K_182           : aliased constant String := "vhi";
   M_182           : aliased constant String := "VHDL";
   K_183           : aliased constant String := "webidl";
   M_183           : aliased constant String := "WebIDL";
   K_184           : aliased constant String := "eps";
   M_184           : aliased constant String := "PostScript";
   K_185           : aliased constant String := "cirru";
   M_185           : aliased constant String := "Cirru";
   K_186           : aliased constant String := "eam.fs";
   M_186           : aliased constant String := "Formatted";
   K_187           : aliased constant String := "cgi";
   M_187           : aliased constant String := "Shell, Python, Perl";
   K_188           : aliased constant String := "numpy";
   M_188           : aliased constant String := "NumPy";
   K_189           : aliased constant String := "xliff";
   M_189           : aliased constant String := "XML";
   K_190           : aliased constant String := "xqy";
   M_190           : aliased constant String := "XQuery";
   K_191           : aliased constant String := "vho";
   M_191           : aliased constant String := "VHDL";
   K_192           : aliased constant String := "qbs";
   M_192           : aliased constant String := "QML";
   K_193           : aliased constant String := "vhs";
   M_193           : aliased constant String := "VHDL";
   K_194           : aliased constant String := "gnuplot";
   M_194           : aliased constant String := "Gnuplot";
   K_195           : aliased constant String := "vht";
   M_195           : aliased constant String := "VHDL";
   K_196           : aliased constant String := "sc";
   M_196           : aliased constant String := "SuperCollider, Scala";
   K_197           : aliased constant String := "vhw";
   M_197           : aliased constant String := "VHDL";
   K_198           : aliased constant String := "mss";
   M_198           : aliased constant String := "CartoCSS";
   K_199           : aliased constant String := "sh";
   M_199           : aliased constant String := "Shell";
   K_200           : aliased constant String := "sj";
   M_200           : aliased constant String := "Objective-J";
   K_201           : aliased constant String := "sl";
   M_201           : aliased constant String := "Slash";
   K_202           : aliased constant String := "sma";
   M_202           : aliased constant String := "SourcePawn";
   K_203           : aliased constant String := "graphql";
   M_203           : aliased constant String := "GraphQL";
   K_204           : aliased constant String := "cats";
   M_204           : aliased constant String := "C";
   K_205           : aliased constant String := "sp";
   M_205           : aliased constant String := "SourcePawn";
   K_206           : aliased constant String := "erb";
   M_206           : aliased constant String := "HTML+ERB";
   K_207           : aliased constant String := "xsd";
   M_207           : aliased constant String := "XML";
   K_208           : aliased constant String := "ss";
   M_208           : aliased constant String := "Scheme";
   K_209           : aliased constant String := "aspx";
   M_209           : aliased constant String := "ASP";
   K_210           : aliased constant String := "st";
   M_210           : aliased constant String := "Smalltalk, HTML";
   K_211           : aliased constant String := "sv";
   M_211           : aliased constant String := "SystemVerilog";
   K_212           : aliased constant String := "ceylon";
   M_212           : aliased constant String := "Ceylon";
   K_213           : aliased constant String := "sml";
   M_213           : aliased constant String := "Standard ML";
   K_214           : aliased constant String := "xsl";
   M_214           : aliased constant String := "XSLT";
   K_215           : aliased constant String := "erl";
   M_215           : aliased constant String := "Erlang";
   K_216           : aliased constant String := "smt";
   M_216           : aliased constant String := "SMT";
   K_217           : aliased constant String := "muf";
   M_217           : aliased constant String := "MUF";
   K_218           : aliased constant String := "tab";
   M_218           : aliased constant String := "SQL";
   K_219           : aliased constant String := "tac";
   M_219           : aliased constant String := "Python";
   K_220           : aliased constant String := "robot";
   M_220           : aliased constant String := "RobotFramework";
   K_221           : aliased constant String := "prc";
   M_221           : aliased constant String := "SQL";
   K_222           : aliased constant String := "erb.deface";
   M_222           : aliased constant String := "HTML+ERB";
   K_223           : aliased constant String := "uc";
   M_223           : aliased constant String := "UnrealScript";
   K_224           : aliased constant String := "prg";
   M_224           : aliased constant String := "xBase";
   K_225           : aliased constant String := "pri";
   M_225           : aliased constant String := "QMake";
   K_226           : aliased constant String := "ui";
   M_226           : aliased constant String := "XML";
   K_227           : aliased constant String := "csproj";
   M_227           : aliased constant String := "XML";
   K_228           : aliased constant String := "decls";
   M_228           : aliased constant String := "BlitzBasic";
   K_229           : aliased constant String := "h++";
   M_229           : aliased constant String := "C++";
   K_230           : aliased constant String := "pro";
   M_230           : aliased constant String := "QMake, Prolog, INI, IDL";
   K_231           : aliased constant String := "geojson";
   M_231           : aliased constant String := "JSON";
   K_232           : aliased constant String := "asciidoc";
   M_232           : aliased constant String := "AsciiDoc";
   K_233           : aliased constant String := "ur";
   M_233           : aliased constant String := "UrWeb";
   K_234           : aliased constant String := "prw";
   M_234           : aliased constant String := "xBase";
   K_235           : aliased constant String := "icl";
   M_235           : aliased constant String := "Clean";
   K_236           : aliased constant String := "ux";
   M_236           : aliased constant String := "XML";
   K_237           : aliased constant String := "nim";
   M_237           : aliased constant String := "Nimrod";
   K_238           : aliased constant String := "xul";
   M_238           : aliased constant String := "XML";
   K_239           : aliased constant String := "nit";
   M_239           : aliased constant String := "Nit";
   K_240           : aliased constant String := "dylan";
   M_240           : aliased constant String := "Dylan";
   K_241           : aliased constant String := "ccxml";
   M_241           : aliased constant String := "XML";
   K_242           : aliased constant String := "hqf";
   M_242           : aliased constant String := "SQF";
   K_243           : aliased constant String := "nix";
   M_243           : aliased constant String := "Nix";
   K_244           : aliased constant String := "cgpr";
   M_244           : aliased constant String := "GNAT Project";
   K_245           : aliased constant String := "tcc";
   M_245           : aliased constant String := "C++";
   K_246           : aliased constant String := "rbfrm";
   M_246           : aliased constant String := "REALbasic";
   K_247           : aliased constant String := "zone";
   M_247           : aliased constant String := "DNS Zone";
   K_248           : aliased constant String := "html";
   M_248           : aliased constant String := "HTML";
   K_249           : aliased constant String := "4th";
   M_249           : aliased constant String := "Forth";
   K_250           : aliased constant String := "eclxml";
   M_250           : aliased constant String := "ECL";
   K_251           : aliased constant String := "sublime-project";
   M_251           : aliased constant String := "JavaScript";
   K_252           : aliased constant String := "meta";
   M_252           : aliased constant String := "Unity3D Asset";
   K_253           : aliased constant String := "x10";
   M_253           : aliased constant String := "X10";
   K_254           : aliased constant String := "nimrod";
   M_254           : aliased constant String := "Nimrod";
   K_255           : aliased constant String := "handlebars";
   M_255           : aliased constant String := "Handlebars";
   K_256           : aliased constant String := "tcl";
   M_256           : aliased constant String := "Tcl";
   K_257           : aliased constant String := "wl";
   M_257           : aliased constant String := "Mathematica";
   K_258           : aliased constant String := "objdump";
   M_258           : aliased constant String := "ObjDump";
   K_259           : aliased constant String := "gshader";
   M_259           : aliased constant String := "GLSL";
   K_260           : aliased constant String := "sqf";
   M_260           : aliased constant String := "SQF";
   K_261           : aliased constant String := "nginxconf";
   M_261           : aliased constant String := "Nginx";
   K_262           : aliased constant String := "rviz";
   M_262           : aliased constant String := "YAML";
   K_263           : aliased constant String := "bats";
   M_263           : aliased constant String := "Shell";
   K_264           : aliased constant String := "podspec";
   M_264           : aliased constant String := "Ruby";
   K_265           : aliased constant String := "sql";
   M_265           : aliased constant String := "SQLPL, SQL, PLpgSQL, PLSQL";
   K_266           : aliased constant String := "mako";
   M_266           : aliased constant String := "Mako";
   K_267           : aliased constant String := "properties";
   M_267           : aliased constant String := "INI";
   K_268           : aliased constant String := "hsc";
   M_268           : aliased constant String := "Haskell";
   K_269           : aliased constant String := "cmd";
   M_269           : aliased constant String := "Batchfile";
   K_270           : aliased constant String := "toml";
   M_270           : aliased constant String := "TOML";
   K_271           : aliased constant String := "cmake.in";
   M_271           : aliased constant String := "CMake";
   K_272           : aliased constant String := "tea";
   M_272           : aliased constant String := "Tea";
   K_273           : aliased constant String := "ada";
   M_273           : aliased constant String := "Ada";
   K_274           : aliased constant String := "adb";
   M_274           : aliased constant String := "Ada";
   K_275           : aliased constant String := "rest";
   M_275           : aliased constant String := "reStructuredText";
   K_276           : aliased constant String := "pike";
   M_276           : aliased constant String := "Pike";
   K_277           : aliased constant String := "lbx";
   M_277           : aliased constant String := "TeX";
   K_278           : aliased constant String := "myt";
   M_278           : aliased constant String := "Myghty";
   K_279           : aliased constant String := "xtend";
   M_279           : aliased constant String := "Xtend";
   K_280           : aliased constant String := "1m";
   M_280           : aliased constant String := "Groff";
   K_281           : aliased constant String := "ado";
   M_281           : aliased constant String := "Stata";
   K_282           : aliased constant String := "adp";
   M_282           : aliased constant String := "Tcl";
   K_283           : aliased constant String := "tmSnippet";
   M_283           : aliased constant String := "XML";
   K_284           : aliased constant String := "sublime-syntax";
   M_284           : aliased constant String := "YAML";
   K_285           : aliased constant String := "ads";
   M_285           : aliased constant String := "Ada";
   K_286           : aliased constant String := "tex";
   M_286           : aliased constant String := "TeX";
   K_287           : aliased constant String := "1x";
   M_287           : aliased constant String := "Groff";
   K_288           : aliased constant String := "yy";
   M_288           : aliased constant String := "Yacc";
   K_289           : aliased constant String := "cob";
   M_289           : aliased constant String := "COBOL";
   K_290           : aliased constant String := "wsdl";
   M_290           : aliased constant String := "XML";
   K_291           : aliased constant String := "rbxs";
   M_291           : aliased constant String := "Lua";
   K_292           : aliased constant String := "tool";
   M_292           : aliased constant String := "Shell";
   K_293           : aliased constant String := "exs";
   M_293           : aliased constant String := "Elixir";
   K_294           : aliased constant String := "jinja";
   M_294           : aliased constant String := "HTML+Django";
   K_295           : aliased constant String := "parrot";
   M_295           : aliased constant String := "Parrot";
   K_296           : aliased constant String := "com";
   M_296           : aliased constant String := "DIGITAL Command Language";
   K_297           : aliased constant String := "lds";
   M_297           : aliased constant String := "Linker Script";
   K_298           : aliased constant String := "coq";
   M_298           : aliased constant String := "Coq";
   K_299           : aliased constant String := "pxd";
   M_299           : aliased constant String := "Cython";
   K_300           : aliased constant String := "sage";
   M_300           : aliased constant String := "Sage";
   K_301           : aliased constant String := "3m";
   M_301           : aliased constant String := "Groff";
   K_302           : aliased constant String := "yml";
   M_302           : aliased constant String := "YAML";
   K_303           : aliased constant String := "pxi";
   M_303           : aliased constant String := "Cython";
   K_304           : aliased constant String := "scpt";
   M_304           : aliased constant String := "AppleScript";
   K_305           : aliased constant String := "krl";
   M_305           : aliased constant String := "KRL";
   K_306           : aliased constant String := "c++";
   M_306           : aliased constant String := "C++";
   K_307           : aliased constant String := "x3d";
   M_307           : aliased constant String := "XML";
   K_308           : aliased constant String := "3x";
   M_308           : aliased constant String := "Groff";
   K_309           : aliased constant String := "nasm";
   M_309           : aliased constant String := "Assembly";
   K_310           : aliased constant String := "markdown";
   M_310           : aliased constant String := "Markdown";
   K_311           : aliased constant String := "dcl";
   M_311           : aliased constant String := "Clean";
   K_312           : aliased constant String := "cmake";
   M_312           : aliased constant String := "CMake";
   K_313           : aliased constant String := "iced";
   M_313           : aliased constant String := "CoffeeScript";
   K_314           : aliased constant String := "nuspec";
   M_314           : aliased constant String := "XML";
   K_315           : aliased constant String := "xproc";
   M_315           : aliased constant String := "XProc";
   K_316           : aliased constant String := "lfe";
   M_316           : aliased constant String := "LFE";
   K_317           : aliased constant String := "xsjs";
   M_317           : aliased constant String := "JavaScript";
   K_318           : aliased constant String := "cljs.hl";
   M_318           : aliased constant String := "Clojure";
   K_319           : aliased constant String := "xproj";
   M_319           : aliased constant String := "XML";
   K_320           : aliased constant String := "cql";
   M_320           : aliased constant String := "SQL";
   K_321           : aliased constant String := "pogo";
   M_321           : aliased constant String := "PogoScript";
   K_322           : aliased constant String := "vshader";
   M_322           : aliased constant String := "GLSL";
   K_323           : aliased constant String := "ninja";
   M_323           : aliased constant String := "Ninja";
   K_324           : aliased constant String := "vrx";
   M_324           : aliased constant String := "GLSL";
   K_325           : aliased constant String := "ahk";
   M_325           : aliased constant String := "AutoHotkey";
   K_326           : aliased constant String := "ktm";
   M_326           : aliased constant String := "Kotlin";
   K_327           : aliased constant String := "cjsx";
   M_327           : aliased constant String := "CoffeeScript";
   K_328           : aliased constant String := "jake";
   M_328           : aliased constant String := "JavaScript";
   K_329           : aliased constant String := "kts";
   M_329           : aliased constant String := "Kotlin";
   K_330           : aliased constant String := "apacheconf";
   M_330           : aliased constant String := "ApacheConf";
   K_331           : aliased constant String := "rst.txt";
   M_331           : aliased constant String := "reStructuredText";
   K_332           : aliased constant String := "mirah";
   M_332           : aliased constant String := "Mirah";
   K_333           : aliased constant String := "ditamap";
   M_333           : aliased constant String := "XML";
   K_334           : aliased constant String := "c++objdump";
   M_334           : aliased constant String := "Cpp-ObjDump";
   K_335           : aliased constant String := "zimpl";
   M_335           : aliased constant String := "Zimpl";
   K_336           : aliased constant String := "nqp";
   M_336           : aliased constant String := "Perl6";
   K_337           : aliased constant String := "xslt";
   M_337           : aliased constant String := "XSLT";
   K_338           : aliased constant String := "csh";
   M_338           : aliased constant String := "Tcsh";
   K_339           : aliased constant String := "csl";
   M_339           : aliased constant String := "XML";
   K_340           : aliased constant String := "slim";
   M_340           : aliased constant String := "Slim";
   K_341           : aliased constant String := "lhs";
   M_341           : aliased constant String := "Literate Haskell";
   K_342           : aliased constant String := "mspec";
   M_342           : aliased constant String := "Ruby";
   K_343           : aliased constant String := "css";
   M_343           : aliased constant String := "CSS";
   K_344           : aliased constant String := "csv";
   M_344           : aliased constant String := "CSV";
   K_345           : aliased constant String := "csx";
   M_345           : aliased constant String := "C#";
   K_346           : aliased constant String := "hats";
   M_346           : aliased constant String := "ATS";
   K_347           : aliased constant String := "fpp";
   M_347           : aliased constant String := "FORTRAN";
   K_348           : aliased constant String := "nse";
   M_348           : aliased constant String := "Lua";
   K_349           : aliased constant String := "nawk";
   M_349           : aliased constant String := "Awk";
   K_350           : aliased constant String := "nsh";
   M_350           : aliased constant String := "NSIS";
   K_351           : aliased constant String := "click";
   M_351           : aliased constant String := "Click";
   K_352           : aliased constant String := "volt";
   M_352           : aliased constant String := "Volt";
   K_353           : aliased constant String := "nsi";
   M_353           : aliased constant String := "NSIS";
   K_354           : aliased constant String := "abap";
   M_354           : aliased constant String := "ABAP";
   K_355           : aliased constant String := "iml";
   M_355           : aliased constant String := "XML";
   K_356           : aliased constant String := "mask";
   M_356           : aliased constant String := "Mask";
   K_357           : aliased constant String := "yang";
   M_357           : aliased constant String := "YANG";
   K_358           : aliased constant String := "rbw";
   M_358           : aliased constant String := "Ruby";
   K_359           : aliased constant String := "rbx";
   M_359           : aliased constant String := "Ruby";
   K_360           : aliased constant String := "sublime-macro";
   M_360           : aliased constant String := "JavaScript";
   K_361           : aliased constant String := "cuh";
   M_361           : aliased constant String := "Cuda";
   K_362           : aliased constant String := "zep";
   M_362           : aliased constant String := "Zephir";
   K_363           : aliased constant String := "mkvi";
   M_363           : aliased constant String := "TeX";
   K_364           : aliased constant String := "scxml";
   M_364           : aliased constant String := "XML";
   K_365           : aliased constant String := "mediawiki";
   M_365           : aliased constant String := "MediaWiki";
   K_366           : aliased constant String := "frg";
   M_366           : aliased constant String := "GLSL";
   K_367           : aliased constant String := "p6l";
   M_367           : aliased constant String := "Perl6";
   K_368           : aliased constant String := "tmLanguage";
   M_368           : aliased constant String := "XML";
   K_369           : aliased constant String := "tml";
   M_369           : aliased constant String := "XML";
   K_370           : aliased constant String := "p6m";
   M_370           : aliased constant String := "Perl6";
   K_371           : aliased constant String := "frm";
   M_371           : aliased constant String := "Visual Basic";
   K_372           : aliased constant String := "rdf";
   M_372           : aliased constant String := "XML";
   K_373           : aliased constant String := "xsp.metadata";
   M_373           : aliased constant String := "XPages";
   K_374           : aliased constant String := "als";
   M_374           : aliased constant String := "Alloy";
   K_375           : aliased constant String := "creole";
   M_375           : aliased constant String := "Creole";
   K_376           : aliased constant String := "frt";
   M_376           : aliased constant String := "Forth";
   K_377           : aliased constant String := "frx";
   M_377           : aliased constant String := "Visual Basic";
   K_378           : aliased constant String := "sublime-build";
   M_378           : aliased constant String := "JavaScript";
   K_379           : aliased constant String := "grace";
   M_379           : aliased constant String := "Grace";
   K_380           : aliased constant String := "nut";
   M_380           : aliased constant String := "Squirrel";
   K_381           : aliased constant String := "mtml";
   M_381           : aliased constant String := "MTML";
   K_382           : aliased constant String := "launch";
   M_382           : aliased constant String := "XML";
   K_383           : aliased constant String := "toc";
   M_383           : aliased constant String := "TeX";
   K_384           : aliased constant String := "lock";
   M_384           : aliased constant String := "JSON";
   K_385           : aliased constant String := "3in";
   M_385           : aliased constant String := "Groff";
   K_386           : aliased constant String := "emacs";
   M_386           : aliased constant String := "Emacs Lisp";
   K_387           : aliased constant String := "fth";
   M_387           : aliased constant String := "Forth";
   K_388           : aliased constant String := "nproj";
   M_388           : aliased constant String := "XML";
   K_389           : aliased constant String := "gradle";
   M_389           : aliased constant String := "Gradle";
   K_390           : aliased constant String := "ftl";
   M_390           : aliased constant String := "FreeMarker";
   K_391           : aliased constant String := "roff";
   M_391           : aliased constant String := "Groff";
   K_392           : aliased constant String := "dotsettings";
   M_392           : aliased constant String := "XML";
   K_393           : aliased constant String := "rake";
   M_393           : aliased constant String := "Ruby";
   K_394           : aliased constant String := "chpl";
   M_394           : aliased constant String := "Chapel";
   K_395           : aliased constant String := "ant";
   M_395           : aliased constant String := "XML";
   K_396           : aliased constant String := "flex";
   M_396           : aliased constant String := "JFlex";
   K_397           : aliased constant String := "mawk";
   M_397           : aliased constant String := "Awk";
   K_398           : aliased constant String := "wlt";
   M_398           : aliased constant String := "Mathematica";
   K_399           : aliased constant String := "f03";
   M_399           : aliased constant String := "FORTRAN";
   K_400           : aliased constant String := "podsl";
   M_400           : aliased constant String := "Common Lisp";
   K_401           : aliased constant String := "f08";
   M_401           : aliased constant String := "FORTRAN";
   K_402           : aliased constant String := "bbx";
   M_402           : aliased constant String := "TeX";
   K_403           : aliased constant String := "apl";
   M_403           : aliased constant String := "APL";
   K_404           : aliased constant String := "glade";
   M_404           : aliased constant String := "XML";
   K_405           : aliased constant String := "rs.in";
   M_405           : aliased constant String := "Rust";
   K_406           : aliased constant String := "raml";
   M_406           : aliased constant String := "RAML";
   K_407           : aliased constant String := "sublime_session";
   M_407           : aliased constant String := "JavaScript";
   K_408           : aliased constant String := "bb";
   M_408           : aliased constant String := "BlitzBasic, BitBake";
   K_409           : aliased constant String := "bf";
   M_409           : aliased constant String := "HyPhy, Brainfuck";
   K_410           : aliased constant String := "builder";
   M_410           : aliased constant String := "Ruby";
   K_411           : aliased constant String := "iss";
   M_411           : aliased constant String := "Inno Setup";
   K_412           : aliased constant String := "frag";
   M_412           : aliased constant String := "JavaScript, GLSL";
   K_413           : aliased constant String := "rbtbar";
   M_413           : aliased constant String := "REALbasic";
   K_414           : aliased constant String := "haml.deface";
   M_414           : aliased constant String := "Haml";
   K_415           : aliased constant String := "lpr";
   M_415           : aliased constant String := "Pascal";
   K_416           : aliased constant String := "arc";
   M_416           : aliased constant String := "Arc";
   K_417           : aliased constant String := "fxh";
   M_417           : aliased constant String := "HLSL";
   K_418           : aliased constant String := "xojo_script";
   M_418           : aliased constant String := "Xojo";
   K_419           : aliased constant String := "lookml";
   M_419           : aliased constant String := "LookML";
   K_420           : aliased constant String := "ruby";
   M_420           : aliased constant String := "Ruby";
   K_421           : aliased constant String := "tst";
   M_421           : aliased constant String := "Scilab, GAP";
   K_422           : aliased constant String := "dart";
   M_422           : aliased constant String := "Dart";
   K_423           : aliased constant String := "rbmnu";
   M_423           : aliased constant String := "REALbasic";
   K_424           : aliased constant String := "psd1";
   M_424           : aliased constant String := "PowerShell";
   K_425           : aliased constant String := "doh";
   M_425           : aliased constant String := "Stata";
   K_426           : aliased constant String := "aru";
   M_426           : aliased constant String := "AdaControl rules";
   K_427           : aliased constant String := "tsx";
   M_427           : aliased constant String := "XML, TypeScript";
   K_428           : aliased constant String := "fancypack";
   M_428           : aliased constant String := "Fancy";
   K_429           : aliased constant String := "sass";
   M_429           : aliased constant String := "Sass";
   K_430           : aliased constant String := "pac";
   M_430           : aliased constant String := "JavaScript";
   K_431           : aliased constant String := "cshtml";
   M_431           : aliased constant String := "C#";
   K_432           : aliased constant String := "di";
   M_432           : aliased constant String := "D";
   K_433           : aliased constant String := "glf";
   M_433           : aliased constant String := "Glyph";
   K_434           : aliased constant String := "dot";
   M_434           : aliased constant String := "Graphviz (DOT)";
   K_435           : aliased constant String := "dm";
   M_435           : aliased constant String := "DM";
   K_436           : aliased constant String := "tmTheme";
   M_436           : aliased constant String := "XML";
   K_437           : aliased constant String := "pan";
   M_437           : aliased constant String := "Pan";
   K_438           : aliased constant String := "do";
   M_438           : aliased constant String := "Stata";
   K_439           : aliased constant String := "dll.config";
   M_439           : aliased constant String := "XML";
   K_440           : aliased constant String := "pas";
   M_440           : aliased constant String := "Pascal";
   K_441           : aliased constant String := "pat";
   M_441           : aliased constant String := "Max";
   K_442           : aliased constant String := "urdf";
   M_442           : aliased constant String := "XML";
   K_443           : aliased constant String := "asax";
   M_443           : aliased constant String := "ASP";
   K_444           : aliased constant String := "ooc";
   M_444           : aliased constant String := "ooc";
   K_445           : aliased constant String := "irbrc";
   M_445           : aliased constant String := "Ruby";
   K_446           : aliased constant String := "logtalk";
   M_446           : aliased constant String := "Logtalk";
   K_447           : aliased constant String := "ecl";
   M_447           : aliased constant String := "ECLiPSe, ECL";
   K_448           : aliased constant String := "filters";
   M_448           : aliased constant String := "XML";
   K_449           : aliased constant String := "dats";
   M_449           : aliased constant String := "ATS";
   K_450           : aliased constant String := "cfml";
   M_450           : aliased constant String := "ColdFusion";
   K_451           : aliased constant String := "pck";
   M_451           : aliased constant String := "PLSQL";
   K_452           : aliased constant String := "watchr";
   M_452           : aliased constant String := "Ruby";
   K_453           : aliased constant String := "prolog";
   M_453           : aliased constant String := "Prolog";
   K_454           : aliased constant String := "coffee";
   M_454           : aliased constant String := "CoffeeScript";
   K_455           : aliased constant String := "fp";
   M_455           : aliased constant String := "GLSL";
   K_456           : aliased constant String := "desktop";
   M_456           : aliased constant String := "desktop";
   K_457           : aliased constant String := "fr";
   M_457           : aliased constant String := "Text, Frege, Forth";
   K_458           : aliased constant String := "fs";
   M_458           : aliased constant String := "GLSL, Forth, Filterscript, F#";
   K_459           : aliased constant String := "moon";
   M_459           : aliased constant String := "MoonScript";
   K_460           : aliased constant String := "ascx";
   M_460           : aliased constant String := "ASP";
   K_461           : aliased constant String := "maxproj";
   M_461           : aliased constant String := "Max";
   K_462           : aliased constant String := "fx";
   M_462           : aliased constant String := "HLSL, FLUX";
   K_463           : aliased constant String := "fy";
   M_463           : aliased constant String := "Fancy";
   K_464           : aliased constant String := "gnu";
   M_464           : aliased constant String := "Gnuplot";
   K_465           : aliased constant String := "feature";
   M_465           : aliased constant String := "Cucumber";
   K_466           : aliased constant String := "ltx";
   M_466           : aliased constant String := "TeX";
   K_467           : aliased constant String := "3qt";
   M_467           : aliased constant String := "Groff";
   K_468           : aliased constant String := "vxml";
   M_468           : aliased constant String := "XML";
   K_469           : aliased constant String := "ldml";
   M_469           : aliased constant String := "Lasso";
   K_470           : aliased constant String := "eex";
   M_470           : aliased constant String := "HTML+EEX";
   K_471           : aliased constant String := "zcml";
   M_471           : aliased constant String := "XML";
   K_472           : aliased constant String := "nlogo";
   M_472           : aliased constant String := "NetLogo";
   K_473           : aliased constant String := "hb";
   M_473           : aliased constant String := "Harbour";
   K_474           : aliased constant String := "lisp";
   M_474           : aliased constant String := "NewLisp, Common Lisp";
   K_475           : aliased constant String := "rno";
   M_475           : aliased constant String := "Groff";
   K_476           : aliased constant String := "hbs";
   M_476           : aliased constant String := "Handlebars";
   K_477           : aliased constant String := "xojo_code";
   M_477           : aliased constant String := "Xojo";
   K_478           : aliased constant String := "monkey";
   M_478           : aliased constant String := "Monkey";
   K_479           : aliased constant String := "hh";
   M_479           : aliased constant String := "Hack, C++";
   K_480           : aliased constant String := "pluginspec";
   M_480           : aliased constant String := "XML, Ruby";
   K_481           : aliased constant String := "targets";
   M_481           : aliased constant String := "XML";
   K_482           : aliased constant String := "hs";
   M_482           : aliased constant String := "Haskell";
   K_483           : aliased constant String := "escript";
   M_483           : aliased constant String := "Erlang";
   K_484           : aliased constant String := "gpr";
   M_484           : aliased constant String := "GNAT Project";
   K_485           : aliased constant String := "clixml";
   M_485           : aliased constant String := "XML";
   K_486           : aliased constant String := "hx";
   M_486           : aliased constant String := "Haxe";
   K_487           : aliased constant String := "lean";
   M_487           : aliased constant String := "Lean";
   K_488           : aliased constant String := "hy";
   M_488           : aliased constant String := "Hy";
   K_489           : aliased constant String := "axd";
   M_489           : aliased constant String := "ASP";
   K_490           : aliased constant String := "ml4";
   M_490           : aliased constant String := "OCaml";
   K_491           : aliased constant String := "axi";
   M_491           : aliased constant String := "NetLinx";
   K_492           : aliased constant String := "osm";
   M_492           : aliased constant String := "XML";
   K_493           : aliased constant String := "sbt";
   M_493           : aliased constant String := "Scala";
   K_494           : aliased constant String := "xht";
   M_494           : aliased constant String := "HTML";
   K_495           : aliased constant String := "6pl";
   M_495           : aliased constant String := "Perl6";
   K_496           : aliased constant String := "6pm";
   M_496           : aliased constant String := "Perl6";
   K_497           : aliased constant String := "axs";
   M_497           : aliased constant String := "NetLinx";
   K_498           : aliased constant String := "cake";
   M_498           : aliased constant String := "CoffeeScript, C#";
   K_499           : aliased constant String := "reds";
   M_499           : aliased constant String := "Red";
   K_500           : aliased constant String := "shen";
   M_500           : aliased constant String := "Shen";
   K_501           : aliased constant String := "axml";
   M_501           : aliased constant String := "XML";
   K_502           : aliased constant String := "mathematica";
   M_502           : aliased constant String := "Mathematica";
   K_503           : aliased constant String := "zsh";
   M_503           : aliased constant String := "Shell";
   K_504           : aliased constant String := "jl";
   M_504           : aliased constant String := "Julia";
   K_505           : aliased constant String := "rpy";
   M_505           : aliased constant String := "Ren'Py, Python";
   K_506           : aliased constant String := "jq";
   M_506           : aliased constant String := "JSONiq";
   K_507           : aliased constant String := "js";
   M_507           : aliased constant String := "JavaScript";
   K_508           : aliased constant String := "grt";
   M_508           : aliased constant String := "Groovy";
   K_509           : aliased constant String := "geom";
   M_509           : aliased constant String := "GLSL";
   K_510           : aliased constant String := "scad";
   M_510           : aliased constant String := "OpenSCAD";
   K_511           : aliased constant String := "mli";
   M_511           : aliased constant String := "OCaml";
   K_512           : aliased constant String := "wxi";
   M_512           : aliased constant String := "XML";
   K_513           : aliased constant String := "mll";
   M_513           : aliased constant String := "OCaml";
   K_514           : aliased constant String := "jsonld";
   M_514           : aliased constant String := "JSONLD";
   K_515           : aliased constant String := "wxl";
   M_515           : aliased constant String := "XML";
   K_516           : aliased constant String := "ld";
   M_516           : aliased constant String := "Linker Script";
   K_517           : aliased constant String := "xml.dist";
   M_517           : aliased constant String := "XML";
   K_518           : aliased constant String := "pig";
   M_518           : aliased constant String := "PigLatin";
   K_519           : aliased constant String := "wxs";
   M_519           : aliased constant String := "XML";
   K_520           : aliased constant String := "mly";
   M_520           : aliased constant String := "OCaml";
   K_521           : aliased constant String := "ll";
   M_521           : aliased constant String := "LLVM";
   K_522           : aliased constant String := "pir";
   M_522           : aliased constant String := "Parrot Internal Representation";
   K_523           : aliased constant String := "ls";
   M_523           : aliased constant String := "LoomScript, LiveScript";
   K_524           : aliased constant String := "xlf";
   M_524           : aliased constant String := "XML";
   K_525           : aliased constant String := "cppobjdump";
   M_525           : aliased constant String := "Cpp-ObjDump";
   K_526           : aliased constant String := "plsql";
   M_526           : aliased constant String := "PLSQL";
   K_527           : aliased constant String := "ahkl";
   M_527           : aliased constant String := "AutoHotkey";
   K_528           : aliased constant String := "forth";
   M_528           : aliased constant String := "Forth";
   K_529           : aliased constant String := "ly";
   M_529           : aliased constant String := "LilyPond";
   K_530           : aliased constant String := "self";
   M_530           : aliased constant String := "Self";
   K_531           : aliased constant String := "sublime-mousemap";
   M_531           : aliased constant String := "JavaScript";
   K_532           : aliased constant String := "owl";
   M_532           : aliased constant String := "Web Ontology Language";
   K_533           : aliased constant String := "pyde";
   M_533           : aliased constant String := "Python";
   K_534           : aliased constant String := "emacs.desktop";
   M_534           : aliased constant String := "Emacs Lisp";
   K_535           : aliased constant String := "vcl";
   M_535           : aliased constant String := "VCL";
   K_536           : aliased constant String := "cbl";
   M_536           : aliased constant String := "COBOL";
   K_537           : aliased constant String := "vert";
   M_537           : aliased constant String := "GLSL";
   K_538           : aliased constant String := "pm6";
   M_538           : aliased constant String := "Perl6";
   K_539           : aliased constant String := "p6";
   M_539           : aliased constant String := "Perl6";
   K_540           : aliased constant String := "pkb";
   M_540           : aliased constant String := "PLSQL";
   K_541           : aliased constant String := "nb";
   M_541           : aliased constant String := "Text, Mathematica";
   K_542           : aliased constant String := "dyl";
   M_542           : aliased constant String := "Dylan";
   K_543           : aliased constant String := "nc";
   M_543           : aliased constant String := "nesC";
   K_544           : aliased constant String := "irclog";
   M_544           : aliased constant String := "IRC log";
   K_545           : aliased constant String := "xsp-config";
   M_545           : aliased constant String := "XPages";
   K_546           : aliased constant String := "cbx";
   M_546           : aliased constant String := "TeX";
   K_547           : aliased constant String := "ni";
   M_547           : aliased constant String := "Inform 7";
   K_548           : aliased constant String := "i7x";
   M_548           : aliased constant String := "Inform 7";
   K_549           : aliased constant String := "xacro";
   M_549           : aliased constant String := "XML";
   K_550           : aliased constant String := "pkl";
   M_550           : aliased constant String := "Pickle";
   K_551           : aliased constant String := "nl";
   M_551           : aliased constant String := "NewLisp, NL";
   K_552           : aliased constant String := "vbproj";
   M_552           : aliased constant String := "XML";
   K_553           : aliased constant String := "scrbl";
   M_553           : aliased constant String := "Racket";
   K_554           : aliased constant String := "no";
   M_554           : aliased constant String := "Text";
   K_555           : aliased constant String := "php3";
   M_555           : aliased constant String := "PHP";
   K_556           : aliased constant String := "php4";
   M_556           : aliased constant String := "PHP";
   K_557           : aliased constant String := "php5";
   M_557           : aliased constant String := "PHP";
   K_558           : aliased constant String := "pks";
   M_558           : aliased constant String := "PLSQL";
   K_559           : aliased constant String := "jsb";
   M_559           : aliased constant String := "JavaScript";
   K_560           : aliased constant String := "nu";
   M_560           : aliased constant String := "Nu";
   K_561           : aliased constant String := "fshader";
   M_561           : aliased constant String := "GLSL";
   K_562           : aliased constant String := "druby";
   M_562           : aliased constant String := "Mirah";
   K_563           : aliased constant String := "ny";
   M_563           : aliased constant String := "Common Lisp";
   K_564           : aliased constant String := "nbp";
   M_564           : aliased constant String := "Mathematica";
   K_565           : aliased constant String := "gvy";
   M_565           : aliased constant String := "Groovy";
   K_566           : aliased constant String := "jsm";
   M_566           : aliased constant String := "JavaScript";
   K_567           : aliased constant String := "rbuistate";
   M_567           : aliased constant String := "REALbasic";
   K_568           : aliased constant String := "jsp";
   M_568           : aliased constant String := "Java Server Pages";
   K_569           : aliased constant String := "cdf";
   M_569           : aliased constant String := "Mathematica";
   K_570           : aliased constant String := "command";
   M_570           : aliased constant String := "Shell";
   K_571           : aliased constant String := "scala";
   M_571           : aliased constant String := "Scala";
   K_572           : aliased constant String := "jss";
   M_572           : aliased constant String := "JavaScript";
   K_573           : aliased constant String := "r2";
   M_573           : aliased constant String := "Rebol";
   K_574           : aliased constant String := "r3";
   M_574           : aliased constant String := "Rebol";
   K_575           : aliased constant String := "jsx";
   M_575           : aliased constant String := "JSX";
   K_576           : aliased constant String := "fsproj";
   M_576           : aliased constant String := "XML";
   K_577           : aliased constant String := "veo";
   M_577           : aliased constant String := "Verilog";
   K_578           : aliased constant String := "ML";
   M_578           : aliased constant String := "Standard ML";
   K_579           : aliased constant String := "pb";
   M_579           : aliased constant String := "PureBasic";
   K_580           : aliased constant String := "cxx-objdump";
   M_580           : aliased constant String := "Cpp-ObjDump";
   K_581           : aliased constant String := "pd";
   M_581           : aliased constant String := "Pure Data";
   K_582           : aliased constant String := "flux";
   M_582           : aliased constant String := "FLUX";
   K_583           : aliased constant String := "brd";
   M_583           : aliased constant String := "KiCad, Eagle";
   K_584           : aliased constant String := "ph";
   M_584           : aliased constant String := "Perl";
   K_585           : aliased constant String := "omgrofl";
   M_585           : aliased constant String := "Omgrofl";
   K_586           : aliased constant String := "fan";
   M_586           : aliased constant String := "Fantom";
   K_587           : aliased constant String := "pl";
   M_587           : aliased constant String := "Prolog, Perl6, Perl";
   K_588           : aliased constant String := "pm";
   M_588           : aliased constant String := "Perl6, Perl";
   K_589           : aliased constant String := "po";
   M_589           : aliased constant String := "Gettext Catalog";
   K_590           : aliased constant String := "pp";
   M_590           : aliased constant String := "Puppet, Pascal";
   K_591           : aliased constant String := "bro";
   M_591           : aliased constant String := "Bro";
   K_592           : aliased constant String := "latte";
   M_592           : aliased constant String := "Latte";
   K_593           : aliased constant String := "ps";
   M_593           : aliased constant String := "PostScript";
   K_594           : aliased constant String := "asmx";
   M_594           : aliased constant String := "ASP";
   K_595           : aliased constant String := "pt";
   M_595           : aliased constant String := "XML";
   K_596           : aliased constant String := "brs";
   M_596           : aliased constant String := "Brightscript";
   K_597           : aliased constant String := "py";
   M_597           : aliased constant String := "Python";
   K_598           : aliased constant String := "xpl";
   M_598           : aliased constant String := "XProc";
   K_599           : aliased constant String := "cfc";
   M_599           : aliased constant String := "ColdFusion CFC";
   K_600           : aliased constant String := "sjs";
   M_600           : aliased constant String := "JavaScript";
   K_601           : aliased constant String := "cfg";
   M_601           : aliased constant String := "INI";
   K_602           : aliased constant String := "phps";
   M_602           : aliased constant String := "PHP";
   K_603           : aliased constant String := "phpt";
   M_603           : aliased constant String := "PHP";
   K_604           : aliased constant String := "xpy";
   M_604           : aliased constant String := "Python";
   K_605           : aliased constant String := "cfm";
   M_605           : aliased constant String := "ColdFusion";
   K_606           : aliased constant String := "twig";
   M_606           : aliased constant String := "Twig";
   K_607           : aliased constant String := "rb";
   M_607           : aliased constant String := "Ruby";
   K_608           : aliased constant String := "capnp";
   M_608           : aliased constant String := "Cap'n Proto";
   K_609           : aliased constant String := "kid";
   M_609           : aliased constant String := "Genshi";
   K_610           : aliased constant String := "rd";
   M_610           : aliased constant String := "R";
   K_611           : aliased constant String := "pod";
   M_611           : aliased constant String := "Pod, Perl";
   K_612           : aliased constant String := "rg";
   M_612           : aliased constant String := "Rouge";
   K_613           : aliased constant String := "anim";
   M_613           : aliased constant String := "Unity3D Asset";
   K_614           : aliased constant String := "rl";
   M_614           : aliased constant String := "Ragel in Ruby Host";
   K_615           : aliased constant String := "sparql";
   M_615           : aliased constant String := "SPARQL";
   K_616           : aliased constant String := "rq";
   M_616           : aliased constant String := "SPARQL";
   K_617           : aliased constant String := "sld";
   M_617           : aliased constant String := "Scheme";
   K_618           : aliased constant String := "es6";
   M_618           : aliased constant String := "JavaScript";
   K_619           : aliased constant String := "rs";
   M_619           : aliased constant String := "Rust, RenderScript";
   K_620           : aliased constant String := "kit";
   M_620           : aliased constant String := "Kit";
   K_621           : aliased constant String := "sublime-settings";
   M_621           : aliased constant String := "JavaScript";
   K_622           : aliased constant String := "pot";
   M_622           : aliased constant String := "Gettext Catalog";
   K_623           : aliased constant String := "ru";
   M_623           : aliased constant String := "Ruby";
   K_624           : aliased constant String := "pov";
   M_624           : aliased constant String := "POV-Ray SDL";
   K_625           : aliased constant String := "xrl";
   M_625           : aliased constant String := "Erlang";
   K_626           : aliased constant String := "swift";
   M_626           : aliased constant String := "Swift";
   K_627           : aliased constant String := "sls";
   M_627           : aliased constant String := "Scheme, SaltStack";
   K_628           : aliased constant String := "rbuild";
   M_628           : aliased constant String := "Ruby";
   K_629           : aliased constant String := "xsjslib";
   M_629           : aliased constant String := "JavaScript";
   K_630           : aliased constant String := "mkii";
   M_630           : aliased constant String := "TeX";
   K_631           : aliased constant String := "vim";
   M_631           : aliased constant String := "VimL";
   K_632           : aliased constant String := "ps1";
   M_632           : aliased constant String := "PowerShell";
   K_633           : aliased constant String := "json";
   M_633           : aliased constant String := "JSON";
   K_634           : aliased constant String := "unity";
   M_634           : aliased constant String := "Unity3D Asset";
   K_635           : aliased constant String := "chs";
   M_635           : aliased constant String := "C2hs Haskell";
   K_636           : aliased constant String := "tf";
   M_636           : aliased constant String := "HCL";
   K_637           : aliased constant String := "viw";
   M_637           : aliased constant String := "SQL";
   K_638           : aliased constant String := "mkiv";
   M_638           : aliased constant String := "TeX";
   K_639           : aliased constant String := "yaml-tmlanguage";
   M_639           : aliased constant String := "YAML";
   K_640           : aliased constant String := "tm";
   M_640           : aliased constant String := "Tcl";
   K_641           : aliased constant String := "rhtml";
   M_641           : aliased constant String := "RHTML";
   K_642           : aliased constant String := "stan";
   M_642           : aliased constant String := "Stan";
   K_643           : aliased constant String := "numsc";
   M_643           : aliased constant String := "NumPy";
   K_644           : aliased constant String := "xojo_report";
   M_644           : aliased constant String := "Xojo";
   K_645           : aliased constant String := "ts";
   M_645           : aliased constant String := "XML, TypeScript";
   K_646           : aliased constant String := "gemspec";
   M_646           : aliased constant String := "Ruby";
   K_647           : aliased constant String := "yacc";
   M_647           : aliased constant String := "Yacc";
   K_648           : aliased constant String := "tu";
   M_648           : aliased constant String := "Turing";
   K_649           : aliased constant String := "cl2";
   M_649           : aliased constant String := "Clojure";
   K_650           : aliased constant String := "minid";
   M_650           : aliased constant String := "MiniD";
   K_651           : aliased constant String := "bison";
   M_651           : aliased constant String := "Bison";
   K_652           : aliased constant String := "dockerfile";
   M_652           : aliased constant String := "Dockerfile";
   K_653           : aliased constant String := "hpp";
   M_653           : aliased constant String := "C++";
   K_654           : aliased constant String := "vb";
   M_654           : aliased constant String := "Visual Basic";
   K_655           : aliased constant String := "psc";
   M_655           : aliased constant String := "Papyrus";
   K_656           : aliased constant String := "fxml";
   M_656           : aliased constant String := "XML";
   K_657           : aliased constant String := "vh";
   M_657           : aliased constant String := "SystemVerilog";
   K_658           : aliased constant String := "kml";
   M_658           : aliased constant String := "XML";
   K_659           : aliased constant String := "bash";
   M_659           : aliased constant String := "Shell";
   K_660           : aliased constant String := "wlua";
   M_660           : aliased constant String := "Lua";
   K_661           : aliased constant String := "eliom";
   M_661           : aliased constant String := "OCaml";
   K_662           : aliased constant String := "idc";
   M_662           : aliased constant String := "C";
   K_663           : aliased constant String := "jade";
   M_663           : aliased constant String := "Jade";
   K_664           : aliased constant String := "hlean";
   M_664           : aliased constant String := "Lean";
   K_665           : aliased constant String := "idr";
   M_665           : aliased constant String := "Idris";
   K_666           : aliased constant String := "njs";
   M_666           : aliased constant String := "JavaScript";
   K_667           : aliased constant String := "sps";
   M_667           : aliased constant String := "Scheme";
   K_668           : aliased constant String := "clj";
   M_668           : aliased constant String := "Clojure";
   K_669           : aliased constant String := "html.hl";
   M_669           : aliased constant String := "HTML";
   K_670           : aliased constant String := "hrl";
   M_670           : aliased constant String := "Erlang";
   K_671           : aliased constant String := "las";
   M_671           : aliased constant String := "Lasso";
   K_672           : aliased constant String := "clp";
   M_672           : aliased constant String := "CLIPS";
   K_673           : aliased constant String := "pub";
   M_673           : aliased constant String := "Public Key";
   K_674           : aliased constant String := "haml";
   M_674           : aliased constant String := "Haml";
   K_675           : aliased constant String := "xc";
   M_675           : aliased constant String := "XC";
   K_676           : aliased constant String := "cls";
   M_676           : aliased constant String := "Visual Basic, TeX, OpenEdge ABL, Apex";
   K_677           : aliased constant String := "db2";
   M_677           : aliased constant String := "SQLPL";
   K_678           : aliased constant String := "mxt";
   M_678           : aliased constant String := "Max";
   K_679           : aliased constant String := "clw";
   M_679           : aliased constant String := "Clarion";
   K_680           : aliased constant String := "xi";
   M_680           : aliased constant String := "Logos";
   K_681           : aliased constant String := "grxml";
   M_681           : aliased constant String := "XML";
   K_682           : aliased constant String := "xm";
   M_682           : aliased constant String := "Logos";
   K_683           : aliased constant String := "bzl";
   M_683           : aliased constant String := "Python";
   K_684           : aliased constant String := "diff";
   M_684           : aliased constant String := "Diff";
   K_685           : aliased constant String := "rbres";
   M_685           : aliased constant String := "REALbasic";
   K_686           : aliased constant String := "xq";
   M_686           : aliased constant String := "XQuery";
   K_687           : aliased constant String := "xs";
   M_687           : aliased constant String := "XS";
   K_688           : aliased constant String := "groovy";
   M_688           : aliased constant String := "Groovy";
   K_689           : aliased constant String := "lslp";
   M_689           : aliased constant String := "LSL";
   K_690           : aliased constant String := "rbbas";
   M_690           : aliased constant String := "REALbasic";
   K_691           : aliased constant String := "sexp";
   M_691           : aliased constant String := "Common Lisp";
   K_692           : aliased constant String := "maxpat";
   M_692           : aliased constant String := "Max";
   K_693           : aliased constant String := "htm";
   M_693           : aliased constant String := "HTML";
   K_694           : aliased constant String := "vala";
   M_694           : aliased constant String := "Vala";
   K_695           : aliased constant String := "fcgi";
   M_695           : aliased constant String := "Shell, Ruby, Python, Perl, PHP, Lua";
   K_696           : aliased constant String := "pwn";
   M_696           : aliased constant String := "PAWN";
   K_697           : aliased constant String := "factor";
   M_697           : aliased constant String := "Factor";
   K_698           : aliased constant String := "rabl";
   M_698           : aliased constant String := "Ruby";
   K_699           : aliased constant String := "cljscm";
   M_699           : aliased constant String := "Clojure";
   K_700           : aliased constant String := "vssettings";
   M_700           : aliased constant String := "XML";
   K_701           : aliased constant String := "less";
   M_701           : aliased constant String := "Less";
   K_702           : aliased constant String := "plist";
   M_702           : aliased constant String := "XML";
   K_703           : aliased constant String := "litcoffee";
   M_703           : aliased constant String := "Literate CoffeeScript";
   K_704           : aliased constant String := "vcxproj";
   M_704           : aliased constant String := "XML";
   K_705           : aliased constant String := "sty";
   M_705           : aliased constant String := "TeX";
   K_706           : aliased constant String := "cpp";
   M_706           : aliased constant String := "C++";
   K_707           : aliased constant String := "sagews";
   M_707           : aliased constant String := "Sage";
   K_708           : aliased constant String := "cps";
   M_708           : aliased constant String := "Component Pascal";
   K_709           : aliased constant String := "lex";
   M_709           : aliased constant String := "Lex";
   K_710           : aliased constant String := "agda";
   M_710           : aliased constant String := "Agda";
   K_711           : aliased constant String := "ksh";
   M_711           : aliased constant String := "Shell";
   K_712           : aliased constant String := "stTheme";
   M_712           : aliased constant String := "XML";
   K_713           : aliased constant String := "cpy";
   M_713           : aliased constant String := "COBOL";
   K_714           : aliased constant String := "jflex";
   M_714           : aliased constant String := "JFlex";
   K_715           : aliased constant String := "pyp";
   M_715           : aliased constant String := "Python";
   K_716           : aliased constant String := "emberscript";
   M_716           : aliased constant String := "EmberScript";
   K_717           : aliased constant String := "svg";
   M_717           : aliased constant String := "SVG";
   K_718           : aliased constant String := "thy";
   M_718           : aliased constant String := "Isabelle";
   K_719           : aliased constant String := "pyt";
   M_719           : aliased constant String := "Python";
   K_720           : aliased constant String := "svh";
   M_720           : aliased constant String := "SystemVerilog";
   K_721           : aliased constant String := "ddl";
   M_721           : aliased constant String := "SQL";
   K_722           : aliased constant String := "lidr";
   M_722           : aliased constant String := "Idris";
   K_723           : aliased constant String := "pyw";
   M_723           : aliased constant String := "Python";
   K_724           : aliased constant String := "pyx";
   M_724           : aliased constant String := "Cython";
   K_725           : aliased constant String := "wsgi";
   M_725           : aliased constant String := "Python";
   K_726           : aliased constant String := "props";
   M_726           : aliased constant String := "XML";
   K_727           : aliased constant String := "storyboard";
   M_727           : aliased constant String := "XML";
   K_728           : aliased constant String := "tmPreferences";
   M_728           : aliased constant String := "XML";
   K_729           : aliased constant String := "ijs";
   M_729           : aliased constant String := "J";
   K_730           : aliased constant String := "pytb";
   M_730           : aliased constant String := "Python traceback";
   K_731           : aliased constant String := "json5";
   M_731           : aliased constant String := "JSON5";
   K_732           : aliased constant String := "vsh";
   M_732           : aliased constant String := "GLSL";
   K_733           : aliased constant String := "qml";
   M_733           : aliased constant String := "QML";
   K_734           : aliased constant String := "ihlp";
   M_734           : aliased constant String := "Stata";
   K_735           : aliased constant String := "gap";
   M_735           : aliased constant String := "GAP";
   K_736           : aliased constant String := "odd";
   M_736           : aliased constant String := "XML";
   K_737           : aliased constant String := "lgt";
   M_737           : aliased constant String := "Logtalk";
   K_738           : aliased constant String := "http";
   M_738           : aliased constant String := "HTTP";
   K_739           : aliased constant String := "eliomi";
   M_739           : aliased constant String := "OCaml";
   K_740           : aliased constant String := "gtpl";
   M_740           : aliased constant String := "Groovy";
   K_741           : aliased constant String := "scss";
   M_741           : aliased constant String := "SCSS";
   K_742           : aliased constant String := "hxx";
   M_742           : aliased constant String := "C++";
   K_743           : aliased constant String := "vapi";
   M_743           : aliased constant String := "Vala";
   K_744           : aliased constant String := "lasso8";
   M_744           : aliased constant String := "Lasso";
   K_745           : aliased constant String := "lasso9";
   M_745           : aliased constant String := "Lasso";
   K_746           : aliased constant String := "cpp-objdump";
   M_746           : aliased constant String := "Cpp-ObjDump";
   K_747           : aliased constant String := "for";
   M_747           : aliased constant String := "Forth, Formatted, FORTRAN";
   K_748           : aliased constant String := "ps1xml";
   M_748           : aliased constant String := "XML";
   K_749           : aliased constant String := "metal";
   M_749           : aliased constant String := "Metal";
   K_750           : aliased constant String := "pd_lua";
   M_750           : aliased constant String := "Lua";
   K_751           : aliased constant String := "dfm";
   M_751           : aliased constant String := "Pascal";
   K_752           : aliased constant String := "prefs";
   M_752           : aliased constant String := "INI";
   K_753           : aliased constant String := "lid";
   M_753           : aliased constant String := "Dylan";
   K_754           : aliased constant String := "hlsl";
   M_754           : aliased constant String := "HLSL";
   K_755           : aliased constant String := "yaml";
   M_755           : aliased constant String := "YAML";
   K_756           : aliased constant String := "raw";
   M_756           : aliased constant String := "Raw token data";
   K_757           : aliased constant String := "vue";
   M_757           : aliased constant String := "Vue";
   K_758           : aliased constant String := "sublime-snippet";
   M_758           : aliased constant String := "XML";
   K_759           : aliased constant String := "ily";
   M_759           : aliased constant String := "LilyPond";
   K_760           : aliased constant String := "gco";
   M_760           : aliased constant String := "G-code";
   K_761           : aliased constant String := "ctp";
   M_761           : aliased constant String := "PHP";
   K_762           : aliased constant String := "glslv";
   M_762           : aliased constant String := "GLSL";
   K_763           : aliased constant String := "yrl";
   M_763           : aliased constant String := "Erlang";
   K_764           : aliased constant String := "golo";
   M_764           : aliased constant String := "Golo";
   K_765           : aliased constant String := "phtml";
   M_765           : aliased constant String := "HTML+PHP";
   K_766           : aliased constant String := "vark";
   M_766           : aliased constant String := "Gosu";
   K_767           : aliased constant String := "inc";
   M_767           : aliased constant String := "SourcePawn, SQL, Pascal, POV-Ray SDL, PHP, PAWN, HTML, C++, Assembly";
   K_768           : aliased constant String := "rktd";
   M_768           : aliased constant String := "Racket";
   K_769           : aliased constant String := "mata";
   M_769           : aliased constant String := "Stata";
   K_770           : aliased constant String := "sh-session";
   M_770           : aliased constant String := "ShellSession";
   K_771           : aliased constant String := "srdf";
   M_771           : aliased constant String := "XML";
   K_772           : aliased constant String := "shader";
   M_772           : aliased constant String := "GLSL";
   K_773           : aliased constant String := "ini";
   M_773           : aliased constant String := "INI";
   K_774           : aliased constant String := "rktl";
   M_774           : aliased constant String := "Racket";
   K_775           : aliased constant String := "maxhelp";
   M_775           : aliased constant String := "Max";
   K_776           : aliased constant String := "inl";
   M_776           : aliased constant String := "C++";
   K_777           : aliased constant String := "proto";
   M_777           : aliased constant String := "Protocol Buffer";
   K_778           : aliased constant String := "syntax";
   M_778           : aliased constant String := "YAML";
   K_779           : aliased constant String := "rebol";
   M_779           : aliased constant String := "Rebol";
   K_780           : aliased constant String := "vbhtml";
   M_780           : aliased constant String := "Visual Basic";
   K_781           : aliased constant String := "ino";
   M_781           : aliased constant String := "Arduino";
   K_782           : aliased constant String := "prefab";
   M_782           : aliased constant String := "Unity3D Asset";
   K_783           : aliased constant String := "ins";
   M_783           : aliased constant String := "TeX";
   K_784           : aliased constant String := "thrift";
   M_784           : aliased constant String := "Thrift";
   K_785           : aliased constant String := "plot";
   M_785           : aliased constant String := "Gnuplot";
   K_786           : aliased constant String := "boot";
   M_786           : aliased constant String := "Clojure";
   K_787           : aliased constant String := "geo";
   M_787           : aliased constant String := "GLSL";
   K_788           : aliased constant String := "ebuild";
   M_788           : aliased constant String := "Gentoo Ebuild";
   K_789           : aliased constant String := "sublime-workspace";
   M_789           : aliased constant String := "JavaScript";
   K_790           : aliased constant String := "fsh";
   M_790           : aliased constant String := "GLSL";
   K_791           : aliased constant String := "fsi";
   M_791           : aliased constant String := "F#";
   K_792           : aliased constant String := "reb";
   M_792           : aliased constant String := "Rebol";
   K_793           : aliased constant String := "red";
   M_793           : aliased constant String := "Red";
   K_794           : aliased constant String := "ston";
   M_794           : aliased constant String := "STON";
   K_795           : aliased constant String := "c++-objdump";
   M_795           : aliased constant String := "Cpp-ObjDump";
   K_796           : aliased constant String := "ipf";
   M_796           : aliased constant String := "IGOR Pro";
   K_797           : aliased constant String := "zmpl";
   M_797           : aliased constant String := "Zimpl";
   K_798           : aliased constant String := "fsx";
   M_798           : aliased constant String := "F#";
   K_799           : aliased constant String := "desktop.in";
   M_799           : aliased constant String := "desktop";
   K_800           : aliased constant String := "sublime-theme";
   M_800           : aliased constant String := "JavaScript";
   K_801           : aliased constant String := "ipp";
   M_801           : aliased constant String := "C++";
   K_802           : aliased constant String := "djs";
   M_802           : aliased constant String := "Dogescript";
   K_803           : aliased constant String := "sh.in";
   M_803           : aliased constant String := "Shell";
   K_804           : aliased constant String := "vhost";
   M_804           : aliased constant String := "Nginx, ApacheConf";
   K_805           : aliased constant String := "lmi";
   M_805           : aliased constant String := "Python";
   K_806           : aliased constant String := "glsl";
   M_806           : aliased constant String := "GLSL";
   K_807           : aliased constant String := "xaml";
   M_807           : aliased constant String := "XML";
   K_808           : aliased constant String := "adoc";
   M_808           : aliased constant String := "AsciiDoc";
   K_809           : aliased constant String := "bas";
   M_809           : aliased constant String := "Visual Basic";
   K_810           : aliased constant String := "bat";
   M_810           : aliased constant String := "Batchfile";
   K_811           : aliased constant String := "pasm";
   M_811           : aliased constant String := "Parrot Assembly";
   K_812           : aliased constant String := "duby";
   M_812           : aliased constant String := "Mirah";
   K_813           : aliased constant String := "cson";
   M_813           : aliased constant String := "CoffeeScript";
   K_814           : aliased constant String := "tpl";
   M_814           : aliased constant String := "Smarty";
   K_815           : aliased constant String := "pony";
   M_815           : aliased constant String := "Pony";
   K_816           : aliased constant String := "cxx";
   M_816           : aliased constant String := "C++";
   K_817           : aliased constant String := "tpp";
   M_817           : aliased constant String := "C++";
   K_818           : aliased constant String := "fun";
   M_818           : aliased constant String := "Standard ML";
   K_819           : aliased constant String := "mak";
   M_819           : aliased constant String := "Makefile";
   K_820           : aliased constant String := "man";
   M_820           : aliased constant String := "Groff";
   K_821           : aliased constant String := "mao";
   M_821           : aliased constant String := "Mako";
   K_822           : aliased constant String := "dlm";
   M_822           : aliased constant String := "IDL";
   K_823           : aliased constant String := "mat";
   M_823           : aliased constant String := "Unity3D Asset";
   K_824           : aliased constant String := "udf";
   M_824           : aliased constant String := "SQL";
   K_825           : aliased constant String := "aj";
   M_825           : aliased constant String := "AspectJ";
   K_826           : aliased constant String := "al";
   M_826           : aliased constant String := "Perl";
   K_827           : aliased constant String := "xhtml";
   M_827           : aliased constant String := "HTML";
   K_828           : aliased constant String := "xquery";
   M_828           : aliased constant String := "XQuery";
   K_829           : aliased constant String := "lol";
   M_829           : aliased constant String := "LOLCODE";
   K_830           : aliased constant String := "as";
   M_830           : aliased constant String := "ActionScript";
   K_831           : aliased constant String := "aw";
   M_831           : aliased constant String := "PHP";
   K_832           : aliased constant String := "xojo_window";
   M_832           : aliased constant String := "Xojo";
   K_833           : aliased constant String := "gawk";
   M_833           : aliased constant String := "Awk";
   K_834           : aliased constant String := "patch";
   M_834           : aliased constant String := "Diff";
   K_835           : aliased constant String := "dita";
   M_835           : aliased constant String := "XML";
   K_836           : aliased constant String := "hlsli";
   M_836           : aliased constant String := "HLSL";
   K_837           : aliased constant String := "psc1";
   M_837           : aliased constant String := "XML";
   K_838           : aliased constant String := "cc";
   M_838           : aliased constant String := "C++";
   K_839           : aliased constant String := "lasso";
   M_839           : aliased constant String := "Lasso";
   K_840           : aliased constant String := "vhdl";
   M_840           : aliased constant String := "VHDL";
   K_841           : aliased constant String := "mcr";
   M_841           : aliased constant String := "MAXScript";
   K_842           : aliased constant String := "ch";
   M_842           : aliased constant String := "xBase, Charity";
   K_843           : aliased constant String := "ck";
   M_843           : aliased constant String := "ChucK";
   K_844           : aliased constant String := "cl";
   M_844           : aliased constant String := "OpenCL, Cool, Common Lisp";
   K_845           : aliased constant String := "smali";
   M_845           : aliased constant String := "Smali";
   K_846           : aliased constant String := "dyalog";
   M_846           : aliased constant String := "APL";
   K_847           : aliased constant String := "cp";
   M_847           : aliased constant String := "Component Pascal, C++";
   K_848           : aliased constant String := "c-objdump";
   M_848           : aliased constant String := "C-ObjDump";
   K_849           : aliased constant String := "cr";
   M_849           : aliased constant String := "Crystal";
   K_850           : aliased constant String := "au3";
   M_850           : aliased constant String := "AutoIt";
   K_851           : aliased constant String := "cs";
   M_851           : aliased constant String := "Smalltalk, C#";
   K_852           : aliased constant String := "ct";
   M_852           : aliased constant String := "XML";
   K_853           : aliased constant String := "mdpolicy";
   M_853           : aliased constant String := "XML";
   K_854           : aliased constant String := "cu";
   M_854           : aliased constant String := "Cuda";
   K_855           : aliased constant String := "sublime_metrics";
   M_855           : aliased constant String := "JavaScript";
   K_856           : aliased constant String := "cw";
   M_856           : aliased constant String := "Redcode";
   K_857           : aliased constant String := "asc";
   M_857           : aliased constant String := "Public Key, AsciiDoc, AGS Script";
   K_858           : aliased constant String := "jscad";
   M_858           : aliased constant String := "JavaScript";
   K_859           : aliased constant String := "cy";
   M_859           : aliased constant String := "Cycript";
   K_860           : aliased constant String := "asd";
   M_860           : aliased constant String := "Common Lisp";
   K_861           : aliased constant String := "ash";
   M_861           : aliased constant String := "AGS Script";
   K_862           : aliased constant String := "ttl";
   M_862           : aliased constant String := "Turtle";
   K_863           : aliased constant String := "applescript";
   M_863           : aliased constant String := "AppleScript";
   K_864           : aliased constant String := "asm";
   M_864           : aliased constant String := "Assembly";
   K_865           : aliased constant String := "liquid";
   M_865           : aliased constant String := "Liquid";
   K_866           : aliased constant String := "java";
   M_866           : aliased constant String := "Java";
   K_867           : aliased constant String := "asp";
   M_867           : aliased constant String := "ASP";
   K_868           : aliased constant String := "g4";
   M_868           : aliased constant String := "ANTLR";
   K_869           : aliased constant String := "ditaval";
   M_869           : aliased constant String := "XML";
   K_870           : aliased constant String := "sats";
   M_870           : aliased constant String := "ATS";
   K_871           : aliased constant String := "gcode";
   M_871           : aliased constant String := "G-code";
   K_872           : aliased constant String := "ec";
   M_872           : aliased constant String := "eC";
   K_873           : aliased constant String := "matah";
   M_873           : aliased constant String := "Stata";
   K_874           : aliased constant String := "xojo_toolbar";
   M_874           : aliased constant String := "Xojo";
   K_875           : aliased constant String := "rkt";
   M_875           : aliased constant String := "Racket";
   K_876           : aliased constant String := "eh";
   M_876           : aliased constant String := "eC";
   K_877           : aliased constant String := "pbi";
   M_877           : aliased constant String := "PureBasic";
   K_878           : aliased constant String := "dpr";
   M_878           : aliased constant String := "Pascal";
   K_879           : aliased constant String := "_js";
   M_879           : aliased constant String := "JavaScript";
   K_880           : aliased constant String := "el";
   M_880           : aliased constant String := "Emacs Lisp";
   K_881           : aliased constant String := "em";
   M_881           : aliased constant String := "EmberScript";
   K_882           : aliased constant String := "arpa";
   M_882           : aliased constant String := "DNS Zone";
   K_883           : aliased constant String := "gml";
   M_883           : aliased constant String := "XML, Graph Modeling Language, Game Maker Language";
   K_884           : aliased constant String := "lsl";
   M_884           : aliased constant String := "LSL";
   K_885           : aliased constant String := "ivy";
   M_885           : aliased constant String := "XML";
   K_886           : aliased constant String := "kicad_pcb";
   M_886           : aliased constant String := "KiCad";
   K_887           : aliased constant String := "opa";
   M_887           : aliased constant String := "Opa";
   K_888           : aliased constant String := "es";
   M_888           : aliased constant String := "JavaScript, Erlang";
   K_889           : aliased constant String := "mkfile";
   M_889           : aliased constant String := "Makefile";
   K_890           : aliased constant String := "lsp";
   M_890           : aliased constant String := "NewLisp, Common Lisp";
   K_891           : aliased constant String := "gms";
   M_891           : aliased constant String := "GAMS";
   K_892           : aliased constant String := "ex";
   M_892           : aliased constant String := "Elixir";
   K_893           : aliased constant String := "aug";
   M_893           : aliased constant String := "Augeas";
   K_894           : aliased constant String := "edn";
   M_894           : aliased constant String := "edn";
   K_895           : aliased constant String := "thor";
   M_895           : aliased constant String := "Ruby";
   K_896           : aliased constant String := "auk";
   M_896           : aliased constant String := "Awk";
   K_897           : aliased constant String := "jbuilder";
   M_897           : aliased constant String := "Ruby";
   K_898           : aliased constant String := "rmd";
   M_898           : aliased constant String := "RMarkdown";
   K_899           : aliased constant String := "wsf";
   M_899           : aliased constant String := "XML";
   K_900           : aliased constant String := "tmux";
   M_900           : aliased constant String := "Shell";
   K_901           : aliased constant String := "sublime-keymap";
   M_901           : aliased constant String := "JavaScript";
   K_902           : aliased constant String := "aux";
   M_902           : aliased constant String := "TeX";

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
      K_900'Access, K_901'Access, K_902'Access);

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
      M_900'Access, M_901'Access, M_902'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Files.Extensions;
