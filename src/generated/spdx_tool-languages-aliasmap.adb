--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Alias mapping generated from aliases.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.AliasMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 15) of Natural :=
     (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 16, 17, 24);

   T1 : constant array (0 .. 15) of Unsigned_16 :=
     (2008, 1715, 1172, 379, 2083, 1035, 615, 1047, 932, 1620, 738, 1237,
      383, 1005, 930, 1084);

   T2 : constant array (0 .. 15) of Unsigned_16 :=
     (1397, 981, 553, 1623, 37, 125, 929, 775, 1735, 249, 586, 69, 889, 349,
      63, 1940);

   G : constant array (0 .. 2146) of Unsigned_16 :=
     (0, 464, 0, 0, 303, 669, 0, 757, 436, 136, 0, 987, 0, 550, 33, 0, 96,
      0, 0, 0, 0, 0, 652, 127, 0, 0, 790, 0, 0, 0, 0, 0, 0, 218, 0, 0, 0,
      1058, 0, 1034, 1018, 201, 948, 0, 0, 0, 0, 0, 624, 0, 976, 170, 0, 0,
      0, 384, 0, 0, 0, 0, 318, 0, 954, 0, 0, 0, 923, 50, 0, 0, 306, 0, 551,
      0, 0, 267, 0, 0, 0, 0, 884, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 135,
      127, 0, 0, 846, 0, 0, 0, 0, 0, 0, 586, 0, 0, 0, 0, 343, 0, 0, 0, 870,
      1044, 1022, 0, 719, 0, 0, 595, 0, 0, 0, 516, 0, 0, 109, 0, 505, 967,
      714, 0, 914, 0, 296, 0, 0, 0, 0, 0, 636, 0, 146, 942, 0, 0, 0, 994,
      342, 63, 0, 142, 0, 0, 1026, 0, 0, 754, 395, 784, 0, 0, 414, 0, 474,
      0, 661, 729, 0, 0, 0, 0, 0, 0, 207, 498, 0, 518, 0, 813, 860, 275,
      910, 857, 600, 0, 0, 0, 965, 0, 0, 0, 0, 138, 0, 788, 0, 0, 0, 1032,
      617, 0, 0, 0, 286, 47, 951, 0, 0, 341, 0, 0, 0, 0, 607, 0, 294, 0,
      839, 289, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 395, 764, 0, 0, 738, 782, 0,
      0, 727, 0, 0, 142, 0, 0, 0, 284, 834, 0, 0, 0, 10, 0, 0, 0, 0, 397, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 559, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 365, 474, 0, 0, 0, 0, 508, 0, 0, 732, 756, 348, 0, 0,
      795, 0, 117, 0, 0, 939, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 166, 0, 881, 0,
      3, 0, 0, 0, 0, 0, 0, 430, 811, 351, 0, 0, 0, 0, 0, 0, 830, 1051, 0, 0,
      40, 0, 0, 0, 0, 179, 0, 0, 0, 1021, 0, 0, 178, 0, 0, 0, 0, 767, 943,
      464, 0, 690, 464, 0, 55, 0, 290, 0, 0, 0, 0, 281, 0, 0, 323, 889, 622,
      0, 293, 0, 0, 0, 0, 0, 0, 384, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0,
      22, 0, 0, 0, 0, 0, 0, 806, 327, 687, 0, 0, 0, 607, 175, 0, 0, 55, 0,
      198, 117, 819, 0, 0, 151, 0, 0, 0, 0, 0, 78, 0, 200, 0, 0, 1067, 332,
      477, 0, 605, 0, 379, 0, 0, 181, 0, 0, 0, 1003, 0, 0, 953, 0, 0, 0,
      263, 0, 0, 0, 0, 0, 0, 183, 918, 0, 0, 700, 0, 0, 0, 0, 300, 986, 0,
      0, 423, 0, 0, 0, 0, 0, 0, 637, 0, 78, 909, 668, 0, 0, 0, 0, 428, 0,
      335, 876, 899, 0, 0, 504, 0, 117, 844, 856, 451, 0, 0, 68, 0, 0, 0, 0,
      0, 0, 0, 0, 430, 624, 0, 0, 0, 0, 0, 0, 908, 802, 827, 0, 899, 764,
      69, 0, 147, 174, 728, 0, 0, 369, 71, 657, 0, 0, 746, 993, 0, 161, 0,
      0, 829, 289, 0, 370, 0, 752, 0, 0, 0, 0, 57, 0, 0, 0, 0, 762, 0, 0,
      11, 0, 0, 73, 0, 0, 0, 0, 578, 809, 0, 0, 38, 0, 0, 0, 487, 0, 0, 0,
      478, 737, 104, 654, 0, 0, 393, 0, 308, 0, 0, 0, 991, 0, 0, 426, 0,
      225, 0, 0, 8, 0, 0, 594, 0, 498, 0, 569, 0, 1003, 0, 943, 0, 0, 724,
      0, 0, 197, 0, 137, 54, 0, 0, 0, 918, 69, 0, 110, 257, 0, 0, 1007, 213,
      0, 0, 0, 0, 0, 0, 0, 792, 21, 290, 286, 481, 444, 0, 0, 0, 802, 61, 0,
      1018, 0, 0, 924, 0, 0, 728, 0, 0, 577, 0, 119, 0, 0, 888, 0, 914, 18,
      0, 0, 214, 0, 0, 0, 995, 0, 0, 298, 252, 723, 553, 0, 876, 0, 709, 0,
      0, 357, 0, 569, 0, 0, 660, 338, 137, 0, 0, 0, 761, 522, 0, 0, 0, 52,
      261, 0, 584, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 140, 408, 480, 236,
      0, 0, 99, 37, 0, 0, 0, 0, 0, 105, 1029, 429, 0, 5, 804, 392, 0, 284,
      916, 235, 0, 878, 596, 0, 191, 80, 605, 374, 0, 0, 0, 707, 0, 1053, 0,
      0, 43, 0, 0, 178, 0, 695, 0, 0, 5, 549, 0, 0, 527, 687, 0, 0, 958,
      879, 273, 0, 701, 0, 0, 865, 519, 0, 0, 241, 0, 469, 0, 289, 84, 0,
      319, 167, 218, 0, 0, 0, 0, 0, 0, 0, 475, 394, 691, 7, 0, 133, 0, 0,
      873, 293, 383, 24, 0, 293, 392, 0, 0, 729, 0, 499, 0, 0, 115, 0, 0, 0,
      630, 0, 960, 484, 312, 0, 0, 0, 861, 0, 0, 0, 222, 339, 602, 232, 425,
      0, 0, 0, 0, 0, 0, 754, 0, 0, 574, 412, 305, 247, 0, 180, 311, 0, 0, 0,
      0, 0, 823, 0, 0, 163, 420, 0, 577, 0, 413, 0, 56, 372, 326, 635, 826,
      566, 0, 0, 0, 0, 0, 624, 0, 0, 726, 0, 0, 1033, 0, 0, 0, 0, 597, 1023,
      1030, 0, 0, 609, 892, 0, 328, 34, 417, 0, 602, 0, 0, 248, 0, 568, 299,
      0, 114, 0, 837, 381, 748, 961, 0, 861, 0, 168, 482, 893, 0, 132, 0,
      398, 0, 0, 0, 0, 867, 0, 0, 299, 352, 0, 0, 0, 301, 0, 210, 19, 612,
      0, 0, 534, 0, 0, 0, 348, 0, 152, 549, 1052, 71, 531, 564, 56, 0, 0, 0,
      0, 0, 0, 1014, 0, 865, 0, 0, 0, 1035, 0, 254, 0, 972, 482, 0, 18, 992,
      0, 622, 0, 451, 0, 0, 0, 92, 204, 51, 286, 540, 907, 612, 0, 924, 0,
      360, 249, 795, 298, 76, 707, 0, 0, 0, 0, 0, 371, 678, 0, 718, 60, 0,
      0, 0, 0, 173, 0, 723, 0, 324, 0, 915, 9, 0, 0, 598, 0, 0, 0, 0, 35,
      680, 239, 736, 572, 0, 568, 0, 192, 1018, 164, 0, 371, 949, 0, 0, 0,
      0, 509, 0, 0, 38, 706, 831, 0, 515, 507, 0, 829, 437, 1038, 0, 0, 769,
      0, 471, 29, 188, 276, 0, 806, 989, 431, 585, 0, 0, 89, 0, 0, 243, 0,
      735, 244, 0, 746, 0, 648, 671, 44, 340, 23, 614, 0, 0, 0, 0, 325, 442,
      0, 0, 0, 0, 38, 0, 0, 0, 0, 659, 0, 985, 6, 472, 423, 65, 0, 75, 0,
      218, 448, 0, 323, 0, 104, 0, 0, 197, 0, 0, 0, 0, 0, 0, 0, 665, 331,
      198, 1046, 0, 0, 0, 562, 491, 0, 0, 615, 240, 0, 0, 845, 223, 0, 368,
      643, 0, 0, 0, 397, 0, 424, 930, 233, 0, 0, 991, 0, 531, 610, 0, 102,
      314, 260, 130, 0, 46, 924, 0, 170, 2, 0, 0, 518, 0, 0, 157, 0, 0, 595,
      879, 386, 0, 337, 236, 50, 0, 62, 477, 0, 714, 734, 474, 0, 0, 1002,
      1, 771, 402, 0, 342, 0, 236, 49, 0, 0, 111, 1035, 0, 0, 60, 0, 679, 0,
      0, 0, 0, 0, 291, 57, 0, 0, 725, 453, 364, 1038, 489, 0, 540, 0, 1028,
      189, 0, 0, 0, 0, 0, 33, 522, 0, 244, 0, 0, 118, 775, 0, 418, 421, 230,
      0, 933, 0, 0, 739, 318, 0, 0, 601, 557, 0, 481, 0, 187, 0, 110, 0,
      168, 973, 520, 0, 0, 729, 40, 781, 0, 0, 81, 869, 114, 0, 745, 0, 156,
      445, 360, 708, 575, 0, 1047, 0, 0, 283, 36, 103, 0, 12, 0, 911, 0, 16,
      0, 314, 620, 1057, 227, 774, 133, 0, 0, 89, 0, 966, 945, 242, 0, 808,
      0, 331, 414, 60, 891, 0, 84, 0, 821, 0, 0, 681, 983, 352, 493, 0, 0,
      0, 0, 0, 0, 1044, 0, 0, 640, 0, 0, 676, 304, 0, 0, 0, 0, 0, 0, 662, 0,
      38, 6, 374, 852, 113, 1050, 17, 526, 0, 0, 172, 387, 343, 350, 494,
      818, 798, 0, 375, 41, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 232, 13, 721,
      0, 0, 777, 0, 312, 0, 0, 339, 20, 382, 0, 0, 0, 661, 0, 417, 355, 267,
      0, 0, 389, 148, 0, 0, 0, 647, 0, 143, 427, 0, 766, 596, 129, 0, 0,
      242, 956, 103, 211, 0, 844, 0, 0, 0, 97, 407, 1015, 389, 0, 0, 256,
      202, 0, 0, 0, 322, 472, 69, 0, 416, 662, 217, 0, 0, 819, 960, 0, 1036,
      0, 359, 0, 0, 0, 207, 0, 0, 0, 0, 481, 0, 416, 0, 0, 0, 417, 0, 242,
      0, 94, 1026, 666, 0, 100, 0, 0, 983, 747, 0, 725, 523, 898, 570, 842,
      98, 0, 707, 0, 0, 871, 194, 14, 808, 475, 0, 894, 963, 0, 420, 0, 591,
      816, 927, 93, 244, 1049, 0, 0, 1005, 514, 0, 5, 648, 0, 738, 58, 718,
      1052, 0, 0, 0, 237, 139, 0, 32, 642, 0, 0, 872, 90, 0, 0, 999, 925, 0,
      946, 0, 0, 716, 628, 0, 218, 317, 268, 0, 0, 1021, 163, 689, 458, 0,
      782, 0, 551, 459, 961, 0, 505, 552, 588, 597, 0, 404, 231, 537, 158,
      629, 0, 0, 0, 0, 0, 384, 700, 0, 0, 0, 130, 0, 0, 0, 0, 214, 290, 266,
      0, 0, 637, 60, 0, 0, 0, 112, 215, 0, 0, 0, 0, 0, 803, 744, 155, 0, 0,
      665, 0, 0, 0, 424, 651, 0, 65, 788, 96, 865, 112, 0, 845, 798, 0, 118,
      0, 0, 558, 0, 0, 169, 505, 0, 625, 19, 298, 354, 85, 276, 424, 741,
      576, 0, 0, 827, 0, 863, 1033, 0, 189, 0, 94, 0, 0, 0, 0, 0, 0, 28, 0,
      0, 0, 541, 0, 57, 513, 0, 462, 0, 0, 0, 926, 0, 849, 0, 0, 826, 0,
      226, 0, 340, 152, 0, 315, 0, 760, 118, 910, 411, 0, 553, 255, 118, 36,
      635, 426, 254, 0, 1046, 659, 515, 312, 908, 0, 526, 870, 0, 280, 0,
      881, 52, 11, 3, 124, 306, 1035, 0, 581, 0, 0, 0, 481, 0, 24, 0, 114,
      0, 0, 0, 0, 1032, 0, 0, 60, 3, 772, 95, 0, 0, 394, 560, 0, 101, 534,
      0, 758, 737, 0, 0, 768, 133, 62, 0, 0, 0, 0, 0, 885, 0, 797, 0, 303,
      0, 250, 0, 959, 259, 0, 0, 0, 0, 469, 366, 314, 931, 667, 742, 186, 0,
      832, 229, 0, 31, 0, 0, 23, 423, 15, 699, 0, 556, 90, 199, 888, 157, 0,
      131, 0, 0, 796, 390, 646, 428, 244, 605, 107, 652, 84, 863, 509, 0,
      1068, 0, 540, 0, 967, 349, 429, 361, 885, 0, 183, 160, 944, 842, 0, 0,
      960, 0, 0, 410, 0, 229, 812, 342, 1045, 301, 0, 221, 0, 42, 0, 651, 0,
      0, 0, 0, 0, 211, 836, 308, 0, 150, 0, 115, 0, 653, 193, 750, 0, 884,
      750, 1059, 0, 0, 0, 287, 651, 403, 87, 0, 0, 64, 0, 0, 1072, 733, 450,
      0, 0, 558, 916, 544, 0, 270, 0, 660, 1016, 0, 412, 0, 0, 0, 469, 211,
      0, 0, 980, 0, 55, 117, 0, 0, 0, 285, 159, 89, 1004, 609, 0, 684, 0,
      732, 0, 206, 928, 0, 0, 171, 0, 0, 0, 0, 1032, 822, 986, 0, 0, 73,
      680, 0, 0, 0, 849, 0, 0, 43, 201, 398, 1014, 0, 495, 0, 575, 758, 175,
      1042, 0, 0, 0, 122, 867, 145, 282, 1010, 876, 411, 0, 347, 0, 261,
      540, 138, 30, 654, 277, 392, 0, 688, 633, 0, 63, 474, 543, 313, 235,
      648, 271, 627, 4, 0, 228, 508, 649, 0, 0, 407, 0, 0, 53, 0, 0, 0, 281,
      333, 476, 315, 0, 734, 907, 49, 0, 894, 823, 678, 216, 0, 704, 67, 0,
      0, 496, 728, 649, 0, 994, 754, 139, 625, 507, 467, 0, 91, 212, 14, 0,
      231, 747, 0, 377, 263, 34, 314, 0, 860, 0, 25, 594, 368, 0, 481, 343,
      0, 485, 0, 0, 4, 590, 0, 16, 808, 145, 405, 0, 771, 155, 540, 411, 0,
      887, 874, 0, 171, 396, 587, 0, 847, 308, 0, 279, 205, 1008, 824, 0, 0,
      0, 833, 29, 243, 526, 76, 413, 63, 0, 158, 737, 167, 790, 138, 0, 103,
      886, 0, 904, 636, 467, 0, 0, 0, 688, 0, 378, 502, 1061, 965, 576, 0,
      0, 1038, 812, 0, 0, 0, 0, 409, 889, 1027, 534, 10, 5, 301, 0, 58, 45);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 2147;
         F2 := (F2 + Natural (T2 (K)) * J) mod 2147;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 1073;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "janet";
   M_0             : aliased constant String := "Janet";
   K_1             : aliased constant String := "rdoc";
   M_1             : aliased constant String := "RDoc";
   K_2             : aliased constant String := "isabelle";
   M_2             : aliased constant String := "Isabelle";
   K_3             : aliased constant String := "gf";
   M_3             : aliased constant String := "Grammatical Framework";
   K_4             : aliased constant String := "nvim";
   M_4             : aliased constant String := "Vim Script";
   K_5             : aliased constant String := "lua";
   M_5             : aliased constant String := "Lua";
   K_6             : aliased constant String := "classic asp";
   M_6             : aliased constant String := "Classic ASP";
   K_7             : aliased constant String := "vim snippet";
   M_7             : aliased constant String := "Vim Snippet";
   K_8             : aliased constant String := "gn";
   M_8             : aliased constant String := "GN";
   K_9             : aliased constant String := "odin";
   M_9             : aliased constant String := "Odin";
   K_10            : aliased constant String := "go";
   M_10            : aliased constant String := "Go";
   K_11            : aliased constant String := "cucumber";
   M_11            : aliased constant String := "Gherkin";
   K_12            : aliased constant String := "shellcheckrc";
   M_12            : aliased constant String := "ShellCheck Config";
   K_13            : aliased constant String := "git blame ignore revs";
   M_13            : aliased constant String := "Git Revision List";
   K_14            : aliased constant String := "npmrc";
   M_14            : aliased constant String := "NPM Config";
   K_15            : aliased constant String := "org";
   M_15            : aliased constant String := "Org";
   K_16            : aliased constant String := "html+django";
   M_16            : aliased constant String := "Jinja";
   K_17            : aliased constant String := "astro";
   M_17            : aliased constant String := "Astro";
   K_18            : aliased constant String := "nesc";
   M_18            : aliased constant String := "nesC";
   K_19            : aliased constant String := "git config";
   M_19            : aliased constant String := "Git Config";
   K_20            : aliased constant String := "piglatin";
   M_20            : aliased constant String := "PigLatin";
   K_21            : aliased constant String := "txl";
   M_21            : aliased constant String := "TXL";
   K_22            : aliased constant String := "awk";
   M_22            : aliased constant String := "Awk";
   K_23            : aliased constant String := "unix assembly";
   M_23            : aliased constant String := "Unix Assembly";
   K_24            : aliased constant String := "sas";
   M_24            : aliased constant String := "SAS";
   K_25            : aliased constant String := "perl6";
   M_25            : aliased constant String := "Raku";
   K_26            : aliased constant String := "go work";
   M_26            : aliased constant String := "Go Workspace";
   K_27            : aliased constant String := "roc";
   M_27            : aliased constant String := "Roc";
   K_28            : aliased constant String := "openedge";
   M_28            : aliased constant String := "OpenEdge ABL";
   K_29            : aliased constant String := "pickle";
   M_29            : aliased constant String := "Pickle";
   K_30            : aliased constant String := "abnf";
   M_30            : aliased constant String := "ABNF";
   K_31            : aliased constant String := "dosini";
   M_31            : aliased constant String := "INI";
   K_32            : aliased constant String := "hcl";
   M_32            : aliased constant String := "HCL";
   K_33            : aliased constant String := "mustache";
   M_33            : aliased constant String := "Mustache";
   K_34            : aliased constant String := "terraform template";
   M_34            : aliased constant String := "Terraform Template";
   K_35            : aliased constant String := "microsoft developer studio project";
   M_35            : aliased constant String := "Microsoft Developer Studio Project";
   K_36            : aliased constant String := "digital command language";
   M_36            : aliased constant String := "DIGITAL Command Language";
   K_37            : aliased constant String := "wiki";
   M_37            : aliased constant String := "Wikitext";
   K_38            : aliased constant String := "clips";
   M_38            : aliased constant String := "CLIPS";
   K_39            : aliased constant String := "tsql";
   M_39            : aliased constant String := "TSQL";
   K_40            : aliased constant String := "ecmarkup";
   M_40            : aliased constant String := "Ecmarkup";
   K_41            : aliased constant String := "jsoniq";
   M_41            : aliased constant String := "JSONiq";
   K_42            : aliased constant String := "io";
   M_42            : aliased constant String := "Io";
   K_43            : aliased constant String := "conll-u";
   M_43            : aliased constant String := "CoNLL-U";
   K_44            : aliased constant String := "conll-x";
   M_44            : aliased constant String := "CoNLL-U";
   K_45            : aliased constant String := "brightscript";
   M_45            : aliased constant String := "Brightscript";
   K_46            : aliased constant String := "nginx configuration file";
   M_46            : aliased constant String := "Nginx";
   K_47            : aliased constant String := "postcss";
   M_47            : aliased constant String := "PostCSS";
   K_48            : aliased constant String := "sums";
   M_48            : aliased constant String := "Checksums";
   K_49            : aliased constant String := "redirects";
   M_49            : aliased constant String := "Redirect Rules";
   K_50            : aliased constant String := "visual basic 6.0";
   M_50            : aliased constant String := "Visual Basic 6.0";
   K_51            : aliased constant String := "vb6";
   M_51            : aliased constant String := "Visual Basic 6.0";
   K_52            : aliased constant String := "ecmarkdown";
   M_52            : aliased constant String := "Ecmarkup";
   K_53            : aliased constant String := "darcs patch";
   M_53            : aliased constant String := "Darcs Patch";
   K_54            : aliased constant String := "openstep property list";
   M_54            : aliased constant String := "OpenStep Property List";
   K_55            : aliased constant String := "razor";
   M_55            : aliased constant String := "HTML+Razor";
   K_56            : aliased constant String := "vbnet";
   M_56            : aliased constant String := "Visual Basic .NET";
   K_57            : aliased constant String := "less-css";
   M_57            : aliased constant String := "Less";
   K_58            : aliased constant String := "arexx";
   M_58            : aliased constant String := "REXX";
   K_59            : aliased constant String := "wavefront material";
   M_59            : aliased constant String := "Wavefront Material";
   K_60            : aliased constant String := "xbase";
   M_60            : aliased constant String := "xBase";
   K_61            : aliased constant String := "fstar";
   M_61            : aliased constant String := "F*";
   K_62            : aliased constant String := "sugarss";
   M_62            : aliased constant String := "SugarSS";
   K_63            : aliased constant String := "regular expression";
   M_63            : aliased constant String := "Regular Expression";
   K_64            : aliased constant String := "m2";
   M_64            : aliased constant String := "Macaulay2";
   K_65            : aliased constant String := "vbscript";
   M_65            : aliased constant String := "VBScript";
   K_66            : aliased constant String := "m4";
   M_66            : aliased constant String := "M4";
   K_67            : aliased constant String := "autoconf";
   M_67            : aliased constant String := "M4Sugar";
   K_68            : aliased constant String := "gsc";
   M_68            : aliased constant String := "GSC";
   K_69            : aliased constant String := "mumps";
   M_69            : aliased constant String := "M";
   K_70            : aliased constant String := "opencl";
   M_70            : aliased constant String := "OpenCL";
   K_71            : aliased constant String := "pep8";
   M_71            : aliased constant String := "Pep8";
   K_72            : aliased constant String := "php";
   M_72            : aliased constant String := "PHP";
   K_73            : aliased constant String := "uno";
   M_73            : aliased constant String := "Uno";
   K_74            : aliased constant String := "c";
   M_74            : aliased constant String := "C";
   K_75            : aliased constant String := "d";
   M_75            : aliased constant String := "D";
   K_76            : aliased constant String := "e";
   M_76            : aliased constant String := "E";
   K_77            : aliased constant String := "gsp";
   M_77            : aliased constant String := "Groovy Server Pages";
   K_78            : aliased constant String := "text";
   M_78            : aliased constant String := "Text";
   K_79            : aliased constant String := "j";
   M_79            : aliased constant String := "J";
   K_80            : aliased constant String := "ampl";
   M_80            : aliased constant String := "AMPL";
   K_81            : aliased constant String := "topojson";
   M_81            : aliased constant String := "JSON";
   K_82            : aliased constant String := "m";
   M_82            : aliased constant String := "M";
   K_83            : aliased constant String := "vba";
   M_83            : aliased constant String := "VBA";
   K_84            : aliased constant String := "gemini";
   M_84            : aliased constant String := "Gemini";
   K_85            : aliased constant String := "inform 7";
   M_85            : aliased constant String := "Inform 7";
   K_86            : aliased constant String := "mma";
   M_86            : aliased constant String := "Mathematica";
   K_87            : aliased constant String := "objc++";
   M_87            : aliased constant String := "Objective-C++";
   K_88            : aliased constant String := "wikitext";
   M_88            : aliased constant String := "Wikitext";
   K_89            : aliased constant String := "r";
   M_89            : aliased constant String := "R";
   K_90            : aliased constant String := "record jar";
   M_90            : aliased constant String := "Record Jar";
   K_91            : aliased constant String := "macruby";
   M_91            : aliased constant String := "Ruby";
   K_92            : aliased constant String := "ejs";
   M_92            : aliased constant String := "EJS";
   K_93            : aliased constant String := "html+erb";
   M_93            : aliased constant String := "HTML+ERB";
   K_94            : aliased constant String := "v";
   M_94            : aliased constant String := "V";
   K_95            : aliased constant String := "powerbuilder";
   M_95            : aliased constant String := "PowerBuilder";
   K_96            : aliased constant String := "bluespec classic";
   M_96            : aliased constant String := "Bluespec BH";
   K_97            : aliased constant String := "dpatch";
   M_97            : aliased constant String := "Darcs Patch";
   K_98            : aliased constant String := "curlrc";
   M_98            : aliased constant String := "cURL Config";
   K_99            : aliased constant String := "ascii stl";
   M_99            : aliased constant String := "STL";
   K_100           : aliased constant String := "classic visual basic";
   M_100           : aliased constant String := "Visual Basic 6.0";
   K_101           : aliased constant String := "md";
   M_101           : aliased constant String := "Markdown";
   K_102           : aliased constant String := "openedge abl";
   M_102           : aliased constant String := "OpenEdge ABL";
   K_103           : aliased constant String := "nette object notation";
   M_103           : aliased constant String := "NEON";
   K_104           : aliased constant String := "mf";
   M_104           : aliased constant String := "Makefile";
   K_105           : aliased constant String := "rss";
   M_105           : aliased constant String := "XML";
   K_106           : aliased constant String := "rst";
   M_106           : aliased constant String := "reStructuredText";
   K_107           : aliased constant String := "move";
   M_107           : aliased constant String := "Move";
   K_108           : aliased constant String := "saltstack";
   M_108           : aliased constant String := "SaltStack";
   K_109           : aliased constant String := "boo";
   M_109           : aliased constant String := "Boo";
   K_110           : aliased constant String := "opal";
   M_110           : aliased constant String := "Opal";
   K_111           : aliased constant String := "rescript";
   M_111           : aliased constant String := "ReScript";
   K_112           : aliased constant String := "acfm";
   M_112           : aliased constant String := "Adobe Font Metrics";
   K_113           : aliased constant String := "q#";
   M_113           : aliased constant String := "Q#";
   K_114           : aliased constant String := "xml";
   M_114           : aliased constant String := "XML";
   K_115           : aliased constant String := "oasv2-yaml";
   M_115           : aliased constant String := "OASv2-yaml";
   K_116           : aliased constant String := "oxygene";
   M_116           : aliased constant String := "Oxygene";
   K_117           : aliased constant String := "elm";
   M_117           : aliased constant String := "Elm";
   K_118           : aliased constant String := "curry";
   M_118           : aliased constant String := "Curry";
   K_119           : aliased constant String := "gedcom";
   M_119           : aliased constant String := "GEDCOM";
   K_120           : aliased constant String := "cypher";
   M_120           : aliased constant String := "Cypher";
   K_121           : aliased constant String := "redirect rules";
   M_121           : aliased constant String := "Redirect Rules";
   K_122           : aliased constant String := "vdf";
   M_122           : aliased constant String := "Valve Data Format";
   K_123           : aliased constant String := "carto";
   M_123           : aliased constant String := "CartoCSS";
   K_124           : aliased constant String := "jison lex";
   M_124           : aliased constant String := "Jison Lex";
   K_125           : aliased constant String := "freebasic";
   M_125           : aliased constant String := "FreeBasic";
   K_126           : aliased constant String := "ocaml";
   M_126           : aliased constant String := "OCaml";
   K_127           : aliased constant String := "just";
   M_127           : aliased constant String := "Just";
   K_128           : aliased constant String := "figlet font";
   M_128           : aliased constant String := "FIGlet Font";
   K_129           : aliased constant String := "wrenlang";
   M_129           : aliased constant String := "Wren";
   K_130           : aliased constant String := "igorpro";
   M_130           : aliased constant String := "IGOR Pro";
   K_131           : aliased constant String := "wolfram";
   M_131           : aliased constant String := "Mathematica";
   K_132           : aliased constant String := "ne-on";
   M_132           : aliased constant String := "NEON";
   K_133           : aliased constant String := "smpl";
   M_133           : aliased constant String := "SmPL";
   K_134           : aliased constant String := "ultisnip";
   M_134           : aliased constant String := "Vim Snippet";
   K_135           : aliased constant String := "robots txt";
   M_135           : aliased constant String := "robots.txt";
   K_136           : aliased constant String := "mbox";
   M_136           : aliased constant String := "E-mail";
   K_137           : aliased constant String := "yas";
   M_137           : aliased constant String := "YASnippet";
   K_138           : aliased constant String := "wgetrc";
   M_138           : aliased constant String := "Wget Config";
   K_139           : aliased constant String := "perl";
   M_139           : aliased constant String := "Perl";
   K_140           : aliased constant String := "jest snapshot";
   M_140           : aliased constant String := "Jest Snapshot";
   K_141           : aliased constant String := "tcsh";
   M_141           : aliased constant String := "Tcsh";
   K_142           : aliased constant String := "checksums";
   M_142           : aliased constant String := "Checksums";
   K_143           : aliased constant String := "ox";
   M_143           : aliased constant String := "Ox";
   K_144           : aliased constant String := "bazel";
   M_144           : aliased constant String := "Starlark";
   K_145           : aliased constant String := "filterscript";
   M_145           : aliased constant String := "Filterscript";
   K_146           : aliased constant String := "ncl";
   M_146           : aliased constant String := "NCL";
   K_147           : aliased constant String := "oz";
   M_147           : aliased constant String := "Oz";
   K_148           : aliased constant String := "adblock";
   M_148           : aliased constant String := "Adblock Filter List";
   K_149           : aliased constant String := "gentoo ebuild";
   M_149           : aliased constant String := "Gentoo Ebuild";
   K_150           : aliased constant String := "genshi";
   M_150           : aliased constant String := "Genshi";
   K_151           : aliased constant String := "ssh config";
   M_151           : aliased constant String := "SSH Config";
   K_152           : aliased constant String := "groovy server pages";
   M_152           : aliased constant String := "Groovy Server Pages";
   K_153           : aliased constant String := "objectivec++";
   M_153           : aliased constant String := "Objective-C++";
   K_154           : aliased constant String := "adobe composite font metrics";
   M_154           : aliased constant String := "Adobe Font Metrics";
   K_155           : aliased constant String := "dns zone";
   M_155           : aliased constant String := "DNS Zone";
   K_156           : aliased constant String := "scaml";
   M_156           : aliased constant String := "Scaml";
   K_157           : aliased constant String := "m68k";
   M_157           : aliased constant String := "Motorola 68K Assembly";
   K_158           : aliased constant String := "zenscript";
   M_158           : aliased constant String := "ZenScript";
   K_159           : aliased constant String := "progress";
   M_159           : aliased constant String := "OpenEdge ABL";
   K_160           : aliased constant String := "csound-orc";
   M_160           : aliased constant String := "Csound";
   K_161           : aliased constant String := "d-objdump";
   M_161           : aliased constant String := "D-ObjDump";
   K_162           : aliased constant String := "node";
   M_162           : aliased constant String := "JavaScript";
   K_163           : aliased constant String := "formatted";
   M_163           : aliased constant String := "Formatted";
   K_164           : aliased constant String := "ql";
   M_164           : aliased constant String := "CodeQL";
   K_165           : aliased constant String := "udiff";
   M_165           : aliased constant String := "Diff";
   K_166           : aliased constant String := "cobol";
   M_166           : aliased constant String := "COBOL";
   K_167           : aliased constant String := "slint";
   M_167           : aliased constant String := "Slint";
   K_168           : aliased constant String := "objc";
   M_168           : aliased constant String := "Objective-C";
   K_169           : aliased constant String := "coffee-script";
   M_169           : aliased constant String := "CoffeeScript";
   K_170           : aliased constant String := "textile";
   M_170           : aliased constant String := "Textile";
   K_171           : aliased constant String := "befunge";
   M_171           : aliased constant String := "Befunge";
   K_172           : aliased constant String := "max/msp";
   M_172           : aliased constant String := "Max";
   K_173           : aliased constant String := "objectpascal";
   M_173           : aliased constant String := "Pascal";
   K_174           : aliased constant String := "splus";
   M_174           : aliased constant String := "R";
   K_175           : aliased constant String := "objj";
   M_175           : aliased constant String := "Objective-J";
   K_176           : aliased constant String := "jsonnet";
   M_176           : aliased constant String := "Jsonnet";
   K_177           : aliased constant String := "bsv";
   M_177           : aliased constant String := "Bluespec";
   K_178           : aliased constant String := "matlab";
   M_178           : aliased constant String := "MATLAB";
   K_179           : aliased constant String := "soong";
   M_179           : aliased constant String := "Soong";
   K_180           : aliased constant String := "haskell";
   M_180           : aliased constant String := "Haskell";
   K_181           : aliased constant String := "webidl";
   M_181           : aliased constant String := "WebIDL";
   K_182           : aliased constant String := "cirru";
   M_182           : aliased constant String := "Cirru";
   K_183           : aliased constant String := "numpy";
   M_183           : aliased constant String := "NumPy";
   K_184           : aliased constant String := "ren'py";
   M_184           : aliased constant String := "Ren'Py";
   K_185           : aliased constant String := "xcompose";
   M_185           : aliased constant String := "XCompose";
   K_186           : aliased constant String := "terra";
   M_186           : aliased constant String := "Terra";
   K_187           : aliased constant String := "gnuplot";
   M_187           : aliased constant String := "Gnuplot";
   K_188           : aliased constant String := "htmldjango";
   M_188           : aliased constant String := "Jinja";
   K_189           : aliased constant String := "eagle";
   M_189           : aliased constant String := "Eagle";
   K_190           : aliased constant String := "cool";
   M_190           : aliased constant String := "Cool";
   K_191           : aliased constant String := "python3";
   M_191           : aliased constant String := "Python";
   K_192           : aliased constant String := "aidl";
   M_192           : aliased constant String := "AIDL";
   K_193           : aliased constant String := "django";
   M_193           : aliased constant String := "Jinja";
   K_194           : aliased constant String := "odinlang";
   M_194           : aliased constant String := "Odin";
   K_195           : aliased constant String := "sh";
   M_195           : aliased constant String := "Shell";
   K_196           : aliased constant String := "myghty";
   M_196           : aliased constant String := "Myghty";
   K_197           : aliased constant String := "csound-sco";
   M_197           : aliased constant String := "Csound Score";
   K_198           : aliased constant String := "igor";
   M_198           : aliased constant String := "IGOR Pro";
   K_199           : aliased constant String := "graphql";
   M_199           : aliased constant String := "GraphQL";
   K_200           : aliased constant String := "windows registry entries";
   M_200           : aliased constant String := "Windows Registry Entries";
   K_201           : aliased constant String := "erb";
   M_201           : aliased constant String := "HTML+ERB";
   K_202           : aliased constant String := "xsd";
   M_202           : aliased constant String := "XML";
   K_203           : aliased constant String := "routeros script";
   M_203           : aliased constant String := "RouterOS Script";
   K_204           : aliased constant String := "hashes";
   M_204           : aliased constant String := "Checksums";
   K_205           : aliased constant String := "snipmate";
   M_205           : aliased constant String := "Vim Snippet";
   K_206           : aliased constant String := "aspx";
   M_206           : aliased constant String := "ASP.NET";
   K_207           : aliased constant String := "ceylon";
   M_207           : aliased constant String := "Ceylon";
   K_208           : aliased constant String := "bsdmake";
   M_208           : aliased constant String := "Makefile";
   K_209           : aliased constant String := "sml";
   M_209           : aliased constant String := "Standard ML";
   K_210           : aliased constant String := "xsl";
   M_210           : aliased constant String := "XSLT";
   K_211           : aliased constant String := "modula-2";
   M_211           : aliased constant String := "Modula-2";
   K_212           : aliased constant String := "clarity";
   M_212           : aliased constant String := "Clarity";
   K_213           : aliased constant String := "modula-3";
   M_213           : aliased constant String := "Modula-3";
   K_214           : aliased constant String := "x bitmap";
   M_214           : aliased constant String := "X BitMap";
   K_215           : aliased constant String := "rust";
   M_215           : aliased constant String := "Rust";
   K_216           : aliased constant String := "smt";
   M_216           : aliased constant String := "SMT";
   K_217           : aliased constant String := "rmarkdown";
   M_217           : aliased constant String := "RMarkdown";
   K_218           : aliased constant String := "limbo";
   M_218           : aliased constant String := "Limbo";
   K_219           : aliased constant String := "ur/web";
   M_219           : aliased constant String := "UrWeb";
   K_220           : aliased constant String := "muf";
   M_220           : aliased constant String := "MUF";
   K_221           : aliased constant String := "cadence";
   M_221           : aliased constant String := "Cadence";
   K_222           : aliased constant String := "smithy";
   M_222           : aliased constant String := "Smithy";
   K_223           : aliased constant String := "cil";
   M_223           : aliased constant String := "CIL";
   K_224           : aliased constant String := "toit";
   M_224           : aliased constant String := "Toit";
   K_225           : aliased constant String := "svelte";
   M_225           : aliased constant String := "Svelte";
   K_226           : aliased constant String := "plantuml";
   M_226           : aliased constant String := "PlantUML";
   K_227           : aliased constant String := "webassembly";
   M_227           : aliased constant String := "WebAssembly";
   K_228           : aliased constant String := "supercollider";
   M_228           : aliased constant String := "SuperCollider";
   K_229           : aliased constant String := "workflow description language";
   M_229           : aliased constant String := "WDL";
   K_230           : aliased constant String := "fennel";
   M_230           : aliased constant String := "Fennel";
   K_231           : aliased constant String := "standard ml";
   M_231           : aliased constant String := "Standard ML";
   K_232           : aliased constant String := "futhark";
   M_232           : aliased constant String := "Futhark";
   K_233           : aliased constant String := "visual basic classic";
   M_233           : aliased constant String := "Visual Basic 6.0";
   K_234           : aliased constant String := "geojson";
   M_234           : aliased constant String := "JSON";
   K_235           : aliased constant String := "asciidoc";
   M_235           : aliased constant String := "AsciiDoc";
   K_236           : aliased constant String := "clojure";
   M_236           : aliased constant String := "Clojure";
   K_237           : aliased constant String := "golang";
   M_237           : aliased constant String := "Go";
   K_238           : aliased constant String := "coldfusion";
   M_238           : aliased constant String := "ColdFusion";
   K_239           : aliased constant String := "ur";
   M_239           : aliased constant String := "UrWeb";
   K_240           : aliased constant String := "berry";
   M_240           : aliased constant String := "Berry";
   K_241           : aliased constant String := "scilab";
   M_241           : aliased constant String := "Scilab";
   K_242           : aliased constant String := "g-code";
   M_242           : aliased constant String := "G-code";
   K_243           : aliased constant String := "bluespec bh";
   M_243           : aliased constant String := "Bluespec BH";
   K_244           : aliased constant String := "shell-script";
   M_244           : aliased constant String := "Shell";
   K_245           : aliased constant String := "nim";
   M_245           : aliased constant String := "Nim";
   K_246           : aliased constant String := "mail";
   M_246           : aliased constant String := "E-mail";
   K_247           : aliased constant String := "eiffel";
   M_247           : aliased constant String := "Eiffel";
   K_248           : aliased constant String := "clipper";
   M_248           : aliased constant String := "xBase";
   K_249           : aliased constant String := "nit";
   M_249           : aliased constant String := "Nit";
   K_250           : aliased constant String := "coldfusion html";
   M_250           : aliased constant String := "ColdFusion";
   K_251           : aliased constant String := "dylan";
   M_251           : aliased constant String := "Dylan";
   K_252           : aliased constant String := "openqasm";
   M_252           : aliased constant String := "OpenQASM";
   K_253           : aliased constant String := "1c enterprise";
   M_253           : aliased constant String := "1C Enterprise";
   K_254           : aliased constant String := "nix";
   M_254           : aliased constant String := "Nix";
   K_255           : aliased constant String := "soy";
   M_255           : aliased constant String := "Closure Templates";
   K_256           : aliased constant String := "pikchr";
   M_256           : aliased constant String := "Pic";
   K_257           : aliased constant String := "gnu asm";
   M_257           : aliased constant String := "Unix Assembly";
   K_258           : aliased constant String := "html";
   M_258           : aliased constant String := "HTML";
   K_259           : aliased constant String := "x10";
   M_259           : aliased constant String := "X10";
   K_260           : aliased constant String := "handlebars";
   M_260           : aliased constant String := "Handlebars";
   K_261           : aliased constant String := "gitattributes";
   M_261           : aliased constant String := "Git Attributes";
   K_262           : aliased constant String := "tcl";
   M_262           : aliased constant String := "Tcl";
   K_263           : aliased constant String := "abl";
   M_263           : aliased constant String := "OpenEdge ABL";
   K_264           : aliased constant String := "wl";
   M_264           : aliased constant String := "Mathematica";
   K_265           : aliased constant String := "vb .net";
   M_265           : aliased constant String := "Visual Basic .NET";
   K_266           : aliased constant String := "objdump";
   M_266           : aliased constant String := "ObjDump";
   K_267           : aliased constant String := "make";
   M_267           : aliased constant String := "Makefile";
   K_268           : aliased constant String := "sqf";
   M_268           : aliased constant String := "SQF";
   K_269           : aliased constant String := "cabal config";
   M_269           : aliased constant String := "Cabal Config";
   K_270           : aliased constant String := "nushell-script";
   M_270           : aliased constant String := "Nushell";
   K_271           : aliased constant String := "alloy";
   M_271           : aliased constant String := "Alloy";
   K_272           : aliased constant String := "sql";
   M_272           : aliased constant String := "SQL";
   K_273           : aliased constant String := "afdko";
   M_273           : aliased constant String := "OpenType Feature File";
   K_274           : aliased constant String := "byond";
   M_274           : aliased constant String := "DM";
   K_275           : aliased constant String := "mako";
   M_275           : aliased constant String := "Mako";
   K_276           : aliased constant String := "aconf";
   M_276           : aliased constant String := "ApacheConf";
   K_277           : aliased constant String := "idris";
   M_277           : aliased constant String := "Idris";
   K_278           : aliased constant String := "slash";
   M_278           : aliased constant String := "Slash";
   K_279           : aliased constant String := "ti program";
   M_279           : aliased constant String := "TI Program";
   K_280           : aliased constant String := "toml";
   M_280           : aliased constant String := "TOML";
   K_281           : aliased constant String := "gitconfig";
   M_281           : aliased constant String := "Git Config";
   K_282           : aliased constant String := "sway";
   M_282           : aliased constant String := "Sway";
   K_283           : aliased constant String := "tea";
   M_283           : aliased constant String := "Tea";
   K_284           : aliased constant String := "ada";
   M_284           : aliased constant String := "Ada";
   K_285           : aliased constant String := "pov-ray sdl";
   M_285           : aliased constant String := "POV-Ray SDL";
   K_286           : aliased constant String := "adb";
   M_286           : aliased constant String := "Adblock Filter List";
   K_287           : aliased constant String := "povray";
   M_287           : aliased constant String := "POV-Ray SDL";
   K_288           : aliased constant String := "coldfusion cfc";
   M_288           : aliased constant String := "ColdFusion CFC";
   K_289           : aliased constant String := "dosbatch";
   M_289           : aliased constant String := "Batchfile";
   K_290           : aliased constant String := "perl-6";
   M_290           : aliased constant String := "Raku";
   K_291           : aliased constant String := "b3d";
   M_291           : aliased constant String := "BlitzBasic";
   K_292           : aliased constant String := "cakescript";
   M_292           : aliased constant String := "C#";
   K_293           : aliased constant String := "holyc";
   M_293           : aliased constant String := "HolyC";
   K_294           : aliased constant String := "curl config";
   M_294           : aliased constant String := "cURL Config";
   K_295           : aliased constant String := "pike";
   M_295           : aliased constant String := "Pike";
   K_296           : aliased constant String := "open policy agent";
   M_296           : aliased constant String := "Open Policy Agent";
   K_297           : aliased constant String := "xtend";
   M_297           : aliased constant String := "Xtend";
   K_298           : aliased constant String := "opentype feature file";
   M_298           : aliased constant String := "OpenType Feature File";
   K_299           : aliased constant String := "velocity template language";
   M_299           : aliased constant String := "Velocity Template Language";
   K_300           : aliased constant String := "kicad schematic";
   M_300           : aliased constant String := "KiCad Schematic";
   K_301           : aliased constant String := "tex";
   M_301           : aliased constant String := "TeX";
   K_302           : aliased constant String := "valve data format";
   M_302           : aliased constant String := "Valve Data Format";
   K_303           : aliased constant String := "go.work.sum";
   M_303           : aliased constant String := "Go Checksums";
   K_304           : aliased constant String := "webassembly interface type";
   M_304           : aliased constant String := "WebAssembly Interface Type";
   K_305           : aliased constant String := "kotlin";
   M_305           : aliased constant String := "Kotlin";
   K_306           : aliased constant String := "wsdl";
   M_306           : aliased constant String := "XML";
   K_307           : aliased constant String := "snakefile";
   M_307           : aliased constant String := "Snakemake";
   K_308           : aliased constant String := "public key";
   M_308           : aliased constant String := "Public Key";
   K_309           : aliased constant String := "jinja";
   M_309           : aliased constant String := "Jinja";
   K_310           : aliased constant String := "prisma";
   M_310           : aliased constant String := "Prisma";
   K_311           : aliased constant String := "parrot";
   M_311           : aliased constant String := "Parrot";
   K_312           : aliased constant String := "bplus";
   M_312           : aliased constant String := "BlitzBasic";
   K_313           : aliased constant String := "visual basic .net";
   M_313           : aliased constant String := "Visual Basic .NET";
   K_314           : aliased constant String := "smarty";
   M_314           : aliased constant String := "Smarty";
   K_315           : aliased constant String := "coq";
   M_315           : aliased constant String := "Coq";
   K_316           : aliased constant String := "boogie";
   M_316           : aliased constant String := "Boogie";
   K_317           : aliased constant String := "bash session";
   M_317           : aliased constant String := "ShellSession";
   K_318           : aliased constant String := "sage";
   M_318           : aliased constant String := "Sage";
   K_319           : aliased constant String := "cloud firestore security rules";
   M_319           : aliased constant String := "Cloud Firestore Security Rules";
   K_320           : aliased constant String := "edje data collection";
   M_320           : aliased constant String := "Edje Data Collection";
   K_321           : aliased constant String := "yml";
   M_321           : aliased constant String := "YAML";
   K_322           : aliased constant String := "mql4";
   M_322           : aliased constant String := "MQL4";
   K_323           : aliased constant String := "krl";
   M_323           : aliased constant String := "KRL";
   K_324           : aliased constant String := "objectscript";
   M_324           : aliased constant String := "ObjectScript";
   K_325           : aliased constant String := "mql5";
   M_325           : aliased constant String := "MQL5";
   K_326           : aliased constant String := "c++";
   M_326           : aliased constant String := "C++";
   K_327           : aliased constant String := "charity";
   M_327           : aliased constant String := "Charity";
   K_328           : aliased constant String := "browserslist";
   M_328           : aliased constant String := "Browserslist";
   K_329           : aliased constant String := "nearley";
   M_329           : aliased constant String := "Nearley";
   K_330           : aliased constant String := "alpine abuild";
   M_330           : aliased constant String := "Alpine Abuild";
   K_331           : aliased constant String := "denizenscript";
   M_331           : aliased constant String := "DenizenScript";
   K_332           : aliased constant String := "nasl";
   M_332           : aliased constant String := "NASL";
   K_333           : aliased constant String := "wdl";
   M_333           : aliased constant String := "WDL";
   K_334           : aliased constant String := "nasm";
   M_334           : aliased constant String := "Assembly";
   K_335           : aliased constant String := "modelica";
   M_335           : aliased constant String := "Modelica";
   K_336           : aliased constant String := "markdown";
   M_336           : aliased constant String := "Markdown";
   K_337           : aliased constant String := "dcl";
   M_337           : aliased constant String := "DIGITAL Command Language";
   K_338           : aliased constant String := "cmake";
   M_338           : aliased constant String := "CMake";
   K_339           : aliased constant String := "euphoria";
   M_339           : aliased constant String := "Euphoria";
   K_340           : aliased constant String := "sum";
   M_340           : aliased constant String := "Checksums";
   K_341           : aliased constant String := "gitignore";
   M_341           : aliased constant String := "Ignore List";
   K_342           : aliased constant String := "xproc";
   M_342           : aliased constant String := "XProc";
   K_343           : aliased constant String := "procfile";
   M_343           : aliased constant String := "Procfile";
   K_344           : aliased constant String := "lfe";
   M_344           : aliased constant String := "LFE";
   K_345           : aliased constant String := "raw token data";
   M_345           : aliased constant String := "Raw token data";
   K_346           : aliased constant String := "zap";
   M_346           : aliased constant String := "ZAP";
   K_347           : aliased constant String := "gemfile.lock";
   M_347           : aliased constant String := "Gemfile.lock";
   K_348           : aliased constant String := "lean 4";
   M_348           : aliased constant String := "Lean 4";
   K_349           : aliased constant String := "bmax";
   M_349           : aliased constant String := "BlitzMax";
   K_350           : aliased constant String := "ninja";
   M_350           : aliased constant String := "Ninja";
   K_351           : aliased constant String := "ahk";
   M_351           : aliased constant String := "AutoHotkey";
   K_352           : aliased constant String := "racket";
   M_352           : aliased constant String := "Racket";
   K_353           : aliased constant String := "pogoscript";
   M_353           : aliased constant String := "PogoScript";
   K_354           : aliased constant String := "fundamental";
   M_354           : aliased constant String := "Text";
   K_355           : aliased constant String := "vim help file";
   M_355           : aliased constant String := "Vim Help File";
   K_356           : aliased constant String := "bitbake";
   M_356           : aliased constant String := "BitBake";
   K_357           : aliased constant String := "xonsh";
   M_357           : aliased constant String := "Xonsh";
   K_358           : aliased constant String := "quake";
   M_358           : aliased constant String := "Quake";
   K_359           : aliased constant String := "go workspace";
   M_359           : aliased constant String := "Go Workspace";
   K_360           : aliased constant String := "ignore";
   M_360           : aliased constant String := "Ignore List";
   K_361           : aliased constant String := "apacheconf";
   M_361           : aliased constant String := "ApacheConf";
   K_362           : aliased constant String := "godot resource";
   M_362           : aliased constant String := "Godot Resource";
   K_363           : aliased constant String := "x pixmap";
   M_363           : aliased constant String := "X PixMap";
   K_364           : aliased constant String := "adobe font metrics";
   M_364           : aliased constant String := "Adobe Font Metrics";
   K_365           : aliased constant String := "go checksums";
   M_365           : aliased constant String := "Go Checksums";
   K_366           : aliased constant String := "mirah";
   M_366           : aliased constant String := "Mirah";
   K_367           : aliased constant String := "batchfile";
   M_367           : aliased constant String := "Batchfile";
   K_368           : aliased constant String := "zimpl";
   M_368           : aliased constant String := "Zimpl";
   K_369           : aliased constant String := "literate agda";
   M_369           : aliased constant String := "Literate Agda";
   K_370           : aliased constant String := "man page";
   M_370           : aliased constant String := "Roff";
   K_371           : aliased constant String := "xslt";
   M_371           : aliased constant String := "XSLT";
   K_372           : aliased constant String := "go.work";
   M_372           : aliased constant String := "Go Workspace";
   K_373           : aliased constant String := "vtl";
   M_373           : aliased constant String := "Velocity Template Language";
   K_374           : aliased constant String := "julia";
   M_374           : aliased constant String := "Julia";
   K_375           : aliased constant String := "kerboscript";
   M_375           : aliased constant String := "KerboScript";
   K_376           : aliased constant String := "slim";
   M_376           : aliased constant String := "Slim";
   K_377           : aliased constant String := "stla";
   M_377           : aliased constant String := "STL";
   K_378           : aliased constant String := "lhs";
   M_378           : aliased constant String := "Literate Haskell";
   K_379           : aliased constant String := "go work sum";
   M_379           : aliased constant String := "Go Checksums";
   K_380           : aliased constant String := "jetbrains mps";
   M_380           : aliased constant String := "JetBrains MPS";
   K_381           : aliased constant String := "actionscript 3";
   M_381           : aliased constant String := "ActionScript";
   K_382           : aliased constant String := "vtt";
   M_382           : aliased constant String := "WebVTT";
   K_383           : aliased constant String := "css";
   M_383           : aliased constant String := "CSS";
   K_384           : aliased constant String := "puppet";
   M_384           : aliased constant String := "Puppet";
   K_385           : aliased constant String := "csv";
   M_385           : aliased constant String := "CSV";
   K_386           : aliased constant String := "reason";
   M_386           : aliased constant String := "Reason";
   K_387           : aliased constant String := "glimmer js";
   M_387           : aliased constant String := "Glimmer JS";
   K_388           : aliased constant String := "abuild";
   M_388           : aliased constant String := "Alpine Abuild";
   K_389           : aliased constant String := "earthfile";
   M_389           : aliased constant String := "Earthly";
   K_390           : aliased constant String := "ada95";
   M_390           : aliased constant String := "Ada";
   K_391           : aliased constant String := "html+razor";
   M_391           : aliased constant String := "HTML+Razor";
   K_392           : aliased constant String := "linker script";
   M_392           : aliased constant String := "Linker Script";
   K_393           : aliased constant String := "go.mod";
   M_393           : aliased constant String := "Go Module";
   K_394           : aliased constant String := "squirrel";
   M_394           : aliased constant String := "Squirrel";
   K_395           : aliased constant String := "swig";
   M_395           : aliased constant String := "SWIG";
   K_396           : aliased constant String := "click";
   M_396           : aliased constant String := "Click";
   K_397           : aliased constant String := "typst";
   M_397           : aliased constant String := "Typst";
   K_398           : aliased constant String := "volt";
   M_398           : aliased constant String := "Volt";
   K_399           : aliased constant String := "readline config";
   M_399           : aliased constant String := "Readline Config";
   K_400           : aliased constant String := "abap";
   M_400           : aliased constant String := "ABAP";
   K_401           : aliased constant String := "lassoscript";
   M_401           : aliased constant String := "Lasso";
   K_402           : aliased constant String := "gentoo eclass";
   M_402           : aliased constant String := "Gentoo Eclass";
   K_403           : aliased constant String := "bluespec bsv";
   M_403           : aliased constant String := "Bluespec";
   K_404           : aliased constant String := "mask";
   M_404           : aliased constant String := "Mask";
   K_405           : aliased constant String := "yang";
   M_405           : aliased constant String := "YANG";
   K_406           : aliased constant String := "gdb";
   M_406           : aliased constant String := "GDB";
   K_407           : aliased constant String := "rbs";
   M_407           : aliased constant String := "RBS";
   K_408           : aliased constant String := "markojs";
   M_408           : aliased constant String := "Marko";
   K_409           : aliased constant String := "wolfram lang";
   M_409           : aliased constant String := "Mathematica";
   K_410           : aliased constant String := "rbx";
   M_410           : aliased constant String := "Ruby";
   K_411           : aliased constant String := "rscript";
   M_411           : aliased constant String := "R";
   K_412           : aliased constant String := "cue";
   M_412           : aliased constant String := "CUE";
   K_413           : aliased constant String := "microsoft visual studio solution";
   M_413           : aliased constant String := "Microsoft Visual Studio Solution";
   K_414           : aliased constant String := "assembly";
   M_414           : aliased constant String := "Assembly";
   K_415           : aliased constant String := "texinfo";
   M_415           : aliased constant String := "Texinfo";
   K_416           : aliased constant String := "grammatical framework";
   M_416           : aliased constant String := "Grammatical Framework";
   K_417           : aliased constant String := "macaulay2";
   M_417           : aliased constant String := "Macaulay2";
   K_418           : aliased constant String := "option list";
   M_418           : aliased constant String := "Option List";
   K_419           : aliased constant String := "manpage";
   M_419           : aliased constant String := "Roff";
   K_420           : aliased constant String := "mediawiki";
   M_420           : aliased constant String := "Wikitext";
   K_421           : aliased constant String := "xml property list";
   M_421           : aliased constant String := "XML Property List";
   K_422           : aliased constant String := "antlers";
   M_422           : aliased constant String := "Antlers";
   K_423           : aliased constant String := "edgeql";
   M_423           : aliased constant String := "EdgeQL";
   K_424           : aliased constant String := "heex";
   M_424           : aliased constant String := "HTML+EEX";
   K_425           : aliased constant String := "rich text format";
   M_425           : aliased constant String := "Rich Text Format";
   K_426           : aliased constant String := "isabelle root";
   M_426           : aliased constant String := "Isabelle ROOT";
   K_427           : aliased constant String := "kicad legacy layout";
   M_427           : aliased constant String := "KiCad Legacy Layout";
   K_428           : aliased constant String := "creole";
   M_428           : aliased constant String := "Creole";
   K_429           : aliased constant String := "neosnippet";
   M_429           : aliased constant String := "Vim Snippet";
   K_430           : aliased constant String := "visual basic for applications";
   M_430           : aliased constant String := "VBA";
   K_431           : aliased constant String := "terraform";
   M_431           : aliased constant String := "HCL";
   K_432           : aliased constant String := "kusto";
   M_432           : aliased constant String := "Kusto";
   K_433           : aliased constant String := "html+ecr";
   M_433           : aliased constant String := "HTML+ECR";
   K_434           : aliased constant String := "maven pom";
   M_434           : aliased constant String := "Maven POM";
   K_435           : aliased constant String := "grace";
   M_435           : aliased constant String := "Grace";
   K_436           : aliased constant String := "pure data";
   M_436           : aliased constant String := "Pure Data";
   K_437           : aliased constant String := "coffeescript";
   M_437           : aliased constant String := "CoffeeScript";
   K_438           : aliased constant String := "oasv2";
   M_438           : aliased constant String := "OpenAPI Specification v2";
   K_439           : aliased constant String := "mercury";
   M_439           : aliased constant String := "Mercury";
   K_440           : aliased constant String := "oasv3";
   M_440           : aliased constant String := "OpenAPI Specification v3";
   K_441           : aliased constant String := "mtml";
   M_441           : aliased constant String := "MTML";
   K_442           : aliased constant String := "justfile";
   M_442           : aliased constant String := "Just";
   K_443           : aliased constant String := "text proto";
   M_443           : aliased constant String := "Protocol Buffer Text Format";
   K_444           : aliased constant String := "haxe";
   M_444           : aliased constant String := "Haxe";
   K_445           : aliased constant String := "cwl";
   M_445           : aliased constant String := "Common Workflow Language";
   K_446           : aliased constant String := "c2hs";
   M_446           : aliased constant String := "C2hs Haskell";
   K_447           : aliased constant String := "robots";
   M_447           : aliased constant String := "robots.txt";
   K_448           : aliased constant String := "emacs";
   M_448           : aliased constant String := "Emacs Lisp";
   K_449           : aliased constant String := "gemtext";
   M_449           : aliased constant String := "Gemini";
   K_450           : aliased constant String := "ad block filters";
   M_450           : aliased constant String := "Adblock Filter List";
   K_451           : aliased constant String := "jcl";
   M_451           : aliased constant String := "JCL";
   K_452           : aliased constant String := "gradle";
   M_452           : aliased constant String := "Gradle";
   K_453           : aliased constant String := "yul";
   M_453           : aliased constant String := "Yul";
   K_454           : aliased constant String := "ftl";
   M_454           : aliased constant String := "FreeMarker";
   K_455           : aliased constant String := "roff";
   M_455           : aliased constant String := "Roff";
   K_456           : aliased constant String := "portugol";
   M_456           : aliased constant String := "Portugol";
   K_457           : aliased constant String := "rake";
   M_457           : aliased constant String := "Ruby";
   K_458           : aliased constant String := "emacs muse";
   M_458           : aliased constant String := "Muse";
   K_459           : aliased constant String := "chpl";
   M_459           : aliased constant String := "Chapel";
   K_460           : aliased constant String := "blitzmax";
   M_460           : aliased constant String := "BlitzMax";
   K_461           : aliased constant String := "yara";
   M_461           : aliased constant String := "YARA";
   K_462           : aliased constant String := "csound score";
   M_462           : aliased constant String := "Csound Score";
   K_463           : aliased constant String := "fantom";
   M_463           : aliased constant String := "Fantom";
   K_464           : aliased constant String := "cabal";
   M_464           : aliased constant String := "Cabal Config";
   K_465           : aliased constant String := "mermaid";
   M_465           : aliased constant String := "Mermaid";
   K_466           : aliased constant String := "graph modeling language";
   M_466           : aliased constant String := "Graph Modeling Language";
   K_467           : aliased constant String := "wolfram language";
   M_467           : aliased constant String := "Mathematica";
   K_468           : aliased constant String := "flex";
   M_468           : aliased constant String := "Lex";
   K_469           : aliased constant String := "java server page";
   M_469           : aliased constant String := "Groovy Server Pages";
   K_470           : aliased constant String := "zig";
   M_470           : aliased constant String := "Zig";
   K_471           : aliased constant String := "raku";
   M_471           : aliased constant String := "Raku";
   K_472           : aliased constant String := "ring";
   M_472           : aliased constant String := "Ring";
   K_473           : aliased constant String := "unix asm";
   M_473           : aliased constant String := "Unix Assembly";
   K_474           : aliased constant String := "zil";
   M_474           : aliased constant String := "ZIL";
   K_475           : aliased constant String := "pip requirements";
   M_475           : aliased constant String := "Pip Requirements";
   K_476           : aliased constant String := "promela";
   M_476           : aliased constant String := "Promela";
   K_477           : aliased constant String := "html+eex";
   M_477           : aliased constant String := "HTML+EEX";
   K_478           : aliased constant String := "aspx-vb";
   M_478           : aliased constant String := "ASP.NET";
   K_479           : aliased constant String := "hiveql";
   M_479           : aliased constant String := "HiveQL";
   K_480           : aliased constant String := "oasv3-json";
   M_480           : aliased constant String := "OASv3-json";
   K_481           : aliased constant String := "object data instance notation";
   M_481           : aliased constant String := "Object Data Instance Notation";
   K_482           : aliased constant String := "api blueprint";
   M_482           : aliased constant String := "API Blueprint";
   K_483           : aliased constant String := "ragel";
   M_483           : aliased constant String := "Ragel";
   K_484           : aliased constant String := "ltspice symbol";
   M_484           : aliased constant String := "LTspice Symbol";
   K_485           : aliased constant String := "simple file verification";
   M_485           : aliased constant String := "Simple File Verification";
   K_486           : aliased constant String := "apl";
   M_486           : aliased constant String := "APL";
   K_487           : aliased constant String := "elixir";
   M_487           : aliased constant String := "Elixir";
   K_488           : aliased constant String := "mirc script";
   M_488           : aliased constant String := "mIRC Script";
   K_489           : aliased constant String := "cairo";
   M_489           : aliased constant String := "Cairo";
   K_490           : aliased constant String := "d2";
   M_490           : aliased constant String := "D2";
   K_491           : aliased constant String := "crystal";
   M_491           : aliased constant String := "Crystal";
   K_492           : aliased constant String := "raml";
   M_492           : aliased constant String := "RAML";
   K_493           : aliased constant String := "go module";
   M_493           : aliased constant String := "Go Module";
   K_494           : aliased constant String := "ragel-ruby";
   M_494           : aliased constant String := "Ragel";
   K_495           : aliased constant String := "be";
   M_495           : aliased constant String := "Berry";
   K_496           : aliased constant String := "javascript";
   M_496           : aliased constant String := "JavaScript";
   K_497           : aliased constant String := "osascript";
   M_497           : aliased constant String := "AppleScript";
   K_498           : aliased constant String := "bh";
   M_498           : aliased constant String := "Bluespec BH";
   K_499           : aliased constant String := "frege";
   M_499           : aliased constant String := "Frege";
   K_500           : aliased constant String := "jupyter notebook";
   M_500           : aliased constant String := "Jupyter Notebook";
   K_501           : aliased constant String := "proguard";
   M_501           : aliased constant String := "Proguard";
   K_502           : aliased constant String := "altium designer";
   M_502           : aliased constant String := "Altium Designer";
   K_503           : aliased constant String := "collada";
   M_503           : aliased constant String := "COLLADA";
   K_504           : aliased constant String := "systemverilog";
   M_504           : aliased constant String := "SystemVerilog";
   K_505           : aliased constant String := "faust";
   M_505           : aliased constant String := "Faust";
   K_506           : aliased constant String := "arc";
   M_506           : aliased constant String := "Arc";
   K_507           : aliased constant String := "f#";
   M_507           : aliased constant String := "F#";
   K_508           : aliased constant String := "xbm";
   M_508           : aliased constant String := "X BitMap";
   K_509           : aliased constant String := "containerfile";
   M_509           : aliased constant String := "Dockerfile";
   K_510           : aliased constant String := "f*";
   M_510           : aliased constant String := "F*";
   K_511           : aliased constant String := "lookml";
   M_511           : aliased constant String := "LookML";
   K_512           : aliased constant String := "ruby";
   M_512           : aliased constant String := "Ruby";
   K_513           : aliased constant String := "keyvalues";
   M_513           : aliased constant String := "Valve Data Format";
   K_514           : aliased constant String := "dart";
   M_514           : aliased constant String := "Dart";
   K_515           : aliased constant String := "gosu";
   M_515           : aliased constant String := "Gosu";
   K_516           : aliased constant String := "cap cds";
   M_516           : aliased constant String := "CAP CDS";
   K_517           : aliased constant String := "c2hs haskell";
   M_517           : aliased constant String := "C2hs Haskell";
   K_518           : aliased constant String := "tsv";
   M_518           : aliased constant String := "TSV";
   K_519           : aliased constant String := "nsis";
   M_519           : aliased constant String := "NSIS";
   K_520           : aliased constant String := "csound-csd";
   M_520           : aliased constant String := "Csound Document";
   K_521           : aliased constant String := "tsx";
   M_521           : aliased constant String := "TSX";
   K_522           : aliased constant String := "maxmsp";
   M_522           : aliased constant String := "Max";
   K_523           : aliased constant String := "sass";
   M_523           : aliased constant String := "Sass";
   K_524           : aliased constant String := "javascript+erb";
   M_524           : aliased constant String := "JavaScript+ERB";
   K_525           : aliased constant String := "nroff";
   M_525           : aliased constant String := "Roff";
   K_526           : aliased constant String := "cython";
   M_526           : aliased constant String := "Cython";
   K_527           : aliased constant String := "inform7";
   M_527           : aliased constant String := "Inform 7";
   K_528           : aliased constant String := "mdx";
   M_528           : aliased constant String := "MDX";
   K_529           : aliased constant String := "dm";
   M_529           : aliased constant String := "DM";
   K_530           : aliased constant String := "pan";
   M_530           : aliased constant String := "Pan";
   K_531           : aliased constant String := "posh";
   M_531           : aliased constant String := "PowerShell";
   K_532           : aliased constant String := "nushell";
   M_532           : aliased constant String := "Nushell";
   K_533           : aliased constant String := "netlogo";
   M_533           : aliased constant String := "NetLogo";
   K_534           : aliased constant String := "xdc";
   M_534           : aliased constant String := "Tcl";
   K_535           : aliased constant String := "hocon";
   M_535           : aliased constant String := "HOCON";
   K_536           : aliased constant String := "type language";
   M_536           : aliased constant String := "Type Language";
   K_537           : aliased constant String := "email";
   M_537           : aliased constant String := "E-mail";
   K_538           : aliased constant String := "newlisp";
   M_538           : aliased constant String := "NewLisp";
   K_539           : aliased constant String := "mdoc";
   M_539           : aliased constant String := "Roff";
   K_540           : aliased constant String := "logtalk";
   M_540           : aliased constant String := "Logtalk";
   K_541           : aliased constant String := "apache";
   M_541           : aliased constant String := "ApacheConf";
   K_542           : aliased constant String := "amusewiki";
   M_542           : aliased constant String := "Muse";
   K_543           : aliased constant String := "ecl";
   M_543           : aliased constant String := "ECL";
   K_544           : aliased constant String := "cap'n proto";
   M_544           : aliased constant String := "Cap'n Proto";
   K_545           : aliased constant String := "xdr";
   M_545           : aliased constant String := "RPC";
   K_546           : aliased constant String := "world of warcraft addon data";
   M_546           : aliased constant String := "World of Warcraft Addon Data";
   K_547           : aliased constant String := "ecr";
   M_547           : aliased constant String := "HTML+ECR";
   K_548           : aliased constant String := "glimmer ts";
   M_548           : aliased constant String := "Glimmer TS";
   K_549           : aliased constant String := "foxpro";
   M_549           : aliased constant String := "xBase";
   K_550           : aliased constant String := "jruby";
   M_550           : aliased constant String := "Ruby";
   K_551           : aliased constant String := "pyret";
   M_551           : aliased constant String := "Pyret";
   K_552           : aliased constant String := "ats";
   M_552           : aliased constant String := "ATS";
   K_553           : aliased constant String := "slice";
   M_553           : aliased constant String := "Slice";
   K_554           : aliased constant String := "pyrex";
   M_554           : aliased constant String := "Cython";
   K_555           : aliased constant String := "fb";
   M_555           : aliased constant String := "FreeBasic";
   K_556           : aliased constant String := "autohotkey";
   M_556           : aliased constant String := "AutoHotkey";
   K_557           : aliased constant String := "groff";
   M_557           : aliased constant String := "Roff";
   K_558           : aliased constant String := "cweb";
   M_558           : aliased constant String := "CWeb";
   K_559           : aliased constant String := "cfml";
   M_559           : aliased constant String := "ColdFusion";
   K_560           : aliased constant String := "augeas";
   M_560           : aliased constant String := "Augeas";
   K_561           : aliased constant String := "yasnippet";
   M_561           : aliased constant String := "YASnippet";
   K_562           : aliased constant String := "prolog";
   M_562           : aliased constant String := "Prolog";
   K_563           : aliased constant String := "coffee";
   M_563           : aliased constant String := "CoffeeScript";
   K_564           : aliased constant String := "parrot internal representation";
   M_564           : aliased constant String := "Parrot Internal Representation";
   K_565           : aliased constant String := "openapi specification v2";
   M_565           : aliased constant String := "OpenAPI Specification v2";
   K_566           : aliased constant String := "advpl";
   M_566           : aliased constant String := "xBase";
   K_567           : aliased constant String := "openapi specification v3";
   M_567           : aliased constant String := "OpenAPI Specification v3";
   K_568           : aliased constant String := "java properties";
   M_568           : aliased constant String := "Java Properties";
   K_569           : aliased constant String := "hashicorp configuration language";
   M_569           : aliased constant String := "HCL";
   K_570           : aliased constant String := "gdscript";
   M_570           : aliased constant String := "GDScript";
   K_571           : aliased constant String := "realbasic";
   M_571           : aliased constant String := "REALbasic";
   K_572           : aliased constant String := "harbour";
   M_572           : aliased constant String := "Harbour";
   K_573           : aliased constant String := "protocol buffer text format";
   M_573           : aliased constant String := "Protocol Buffer Text Format";
   K_574           : aliased constant String := "bibtex";
   M_574           : aliased constant String := "BibTeX";
   K_575           : aliased constant String := "abap cds";
   M_575           : aliased constant String := "ABAP CDS";
   K_576           : aliased constant String := "eex";
   M_576           : aliased constant String := "HTML+EEX";
   K_577           : aliased constant String := "kakscript";
   M_577           : aliased constant String := "KakouneScript";
   K_578           : aliased constant String := "ada2005";
   M_578           : aliased constant String := "Ada";
   K_579           : aliased constant String := "lisp";
   M_579           : aliased constant String := "Common Lisp";
   K_580           : aliased constant String := "editor-config";
   M_580           : aliased constant String := "EditorConfig";
   K_581           : aliased constant String := "hbs";
   M_581           : aliased constant String := "Handlebars";
   K_582           : aliased constant String := "monkey";
   M_582           : aliased constant String := "Monkey";
   K_583           : aliased constant String := "htmlbars";
   M_583           : aliased constant String := "Handlebars";
   K_584           : aliased constant String := "gitmodules";
   M_584           : aliased constant String := "Git Config";
   K_585           : aliased constant String := "moocode";
   M_585           : aliased constant String := "Moocode";
   K_586           : aliased constant String := "purebasic";
   M_586           : aliased constant String := "PureBasic";
   K_587           : aliased constant String := "pov-ray";
   M_587           : aliased constant String := "POV-Ray SDL";
   K_588           : aliased constant String := "spline font database";
   M_588           : aliased constant String := "Spline Font Database";
   K_589           : aliased constant String := "shell";
   M_589           : aliased constant String := "Shell";
   K_590           : aliased constant String := "zephir";
   M_590           : aliased constant String := "Zephir";
   K_591           : aliased constant String := "miniyaml";
   M_591           : aliased constant String := "MiniYAML";
   K_592           : aliased constant String := "xml+genshi";
   M_592           : aliased constant String := "Genshi";
   K_593           : aliased constant String := "dataweave";
   M_593           : aliased constant String := "DataWeave";
   K_594           : aliased constant String := "nasal";
   M_594           : aliased constant String := "Nasal";
   K_595           : aliased constant String := "lean";
   M_595           : aliased constant String := "Lean";
   K_596           : aliased constant String := "hy";
   M_596           : aliased constant String := "Hy";
   K_597           : aliased constant String := "jar manifest";
   M_597           : aliased constant String := "JAR Manifest";
   K_598           : aliased constant String := "lark";
   M_598           : aliased constant String := "Lark";
   K_599           : aliased constant String := "sourcepawn";
   M_599           : aliased constant String := "SourcePawn";
   K_600           : aliased constant String := "git-ignore";
   M_600           : aliased constant String := "Ignore List";
   K_601           : aliased constant String := "man-page";
   M_601           : aliased constant String := "Roff";
   K_602           : aliased constant String := "praat";
   M_602           : aliased constant String := "Praat";
   K_603           : aliased constant String := "ipython notebook";
   M_603           : aliased constant String := "Jupyter Notebook";
   K_604           : aliased constant String := "stylus";
   M_604           : aliased constant String := "Stylus";
   K_605           : aliased constant String := "rpc";
   M_605           : aliased constant String := "RPC";
   K_606           : aliased constant String := "typ";
   M_606           : aliased constant String := "Typst";
   K_607           : aliased constant String := "go.sum";
   M_607           : aliased constant String := "Go Checksums";
   K_608           : aliased constant String := "gcc machine description";
   M_608           : aliased constant String := "GCC Machine Description";
   K_609           : aliased constant String := "blitzbasic";
   M_609           : aliased constant String := "BlitzBasic";
   K_610           : aliased constant String := "module management system";
   M_610           : aliased constant String := "Module Management System";
   K_611           : aliased constant String := "wget config";
   M_611           : aliased constant String := "Wget Config";
   K_612           : aliased constant String := "ballerina";
   M_612           : aliased constant String := "Ballerina";
   K_613           : aliased constant String := "cake";
   M_613           : aliased constant String := "C#";
   K_614           : aliased constant String := "shen";
   M_614           : aliased constant String := "Shen";
   K_615           : aliased constant String := "delphi";
   M_615           : aliased constant String := "Pascal";
   K_616           : aliased constant String := "lilypond";
   M_616           : aliased constant String := "LilyPond";
   K_617           : aliased constant String := "cperl";
   M_617           : aliased constant String := "Perl";
   K_618           : aliased constant String := "csharp";
   M_618           : aliased constant String := "C#";
   K_619           : aliased constant String := "kak";
   M_619           : aliased constant String := "KakouneScript";
   K_620           : aliased constant String := "mathematica";
   M_620           : aliased constant String := "Mathematica";
   K_621           : aliased constant String := "zsh";
   M_621           : aliased constant String := "Shell";
   K_622           : aliased constant String := "labview";
   M_622           : aliased constant String := "LabVIEW";
   K_623           : aliased constant String := "sdc";
   M_623           : aliased constant String := "Tcl";
   K_624           : aliased constant String := "adblock filter list";
   M_624           : aliased constant String := "Adblock Filter List";
   K_625           : aliased constant String := "obj-c";
   M_625           : aliased constant String := "Objective-C";
   K_626           : aliased constant String := "js";
   M_626           : aliased constant String := "JavaScript";
   K_627           : aliased constant String := "json with comments";
   M_627           : aliased constant String := "JSON with Comments";
   K_628           : aliased constant String := "erlang";
   M_628           : aliased constant String := "Erlang";
   K_629           : aliased constant String := "obj-j";
   M_629           : aliased constant String := "Objective-J";
   K_630           : aliased constant String := "graphviz (dot)";
   M_630           : aliased constant String := "Graphviz (DOT)";
   K_631           : aliased constant String := "rouge";
   M_631           : aliased constant String := "Rouge";
   K_632           : aliased constant String := "xojo";
   M_632           : aliased constant String := "Xojo";
   K_633           : aliased constant String := "ackrc";
   M_633           : aliased constant String := "Option List";
   K_634           : aliased constant String := "propeller spin";
   M_634           : aliased constant String := "Propeller Spin";
   K_635           : aliased constant String := "objective-c++";
   M_635           : aliased constant String := "Objective-C++";
   K_636           : aliased constant String := "csound document";
   M_636           : aliased constant String := "Csound Document";
   K_637           : aliased constant String := "codeowners";
   M_637           : aliased constant String := "CODEOWNERS";
   K_638           : aliased constant String := "python traceback";
   M_638           : aliased constant String := "Python traceback";
   K_639           : aliased constant String := "jsonld";
   M_639           : aliased constant String := "JSONLD";
   K_640           : aliased constant String := "stringtemplate";
   M_640           : aliased constant String := "StringTemplate";
   K_641           : aliased constant String := "pic";
   M_641           : aliased constant String := "Pic";
   K_642           : aliased constant String := "html+jinja";
   M_642           : aliased constant String := "Jinja";
   K_643           : aliased constant String := "smalltalk";
   M_643           : aliased constant String := "Smalltalk";
   K_644           : aliased constant String := "hosts file";
   M_644           : aliased constant String := "Hosts File";
   K_645           : aliased constant String := "altium";
   M_645           : aliased constant String := "Altium Designer";
   K_646           : aliased constant String := "oasv3-yaml";
   M_646           : aliased constant String := "OASv3-yaml";
   K_647           : aliased constant String := "blitz3d";
   M_647           : aliased constant String := "BlitzBasic";
   K_648           : aliased constant String := "sqlrpgle";
   M_648           : aliased constant String := "RPGLE";
   K_649           : aliased constant String := "ioke";
   M_649           : aliased constant String := "Ioke";
   K_650           : aliased constant String := "rascal";
   M_650           : aliased constant String := "Rascal";
   K_651           : aliased constant String := "aspectj";
   M_651           : aliased constant String := "AspectJ";
   K_652           : aliased constant String := "pir";
   M_652           : aliased constant String := "Parrot Internal Representation";
   K_653           : aliased constant String := "brainfuck";
   M_653           : aliased constant String := "Brainfuck";
   K_654           : aliased constant String := "ls";
   M_654           : aliased constant String := "LiveScript";
   K_655           : aliased constant String := "nwscript";
   M_655           : aliased constant String := "NWScript";
   K_656           : aliased constant String := "protocol buffer";
   M_656           : aliased constant String := "Protocol Buffer";
   K_657           : aliased constant String := "xml+kid";
   M_657           : aliased constant String := "Genshi";
   K_658           : aliased constant String := "kakounescript";
   M_658           : aliased constant String := "KakouneScript";
   K_659           : aliased constant String := "plsql";
   M_659           : aliased constant String := "PLSQL";
   K_660           : aliased constant String := "imba";
   M_660           : aliased constant String := "Imba";
   K_661           : aliased constant String := "asymptote";
   M_661           : aliased constant String := "Asymptote";
   K_662           : aliased constant String := "forth";
   M_662           : aliased constant String := "Forth";
   K_663           : aliased constant String := "roff manpage";
   M_663           : aliased constant String := "Roff Manpage";
   K_664           : aliased constant String := "self";
   M_664           : aliased constant String := "Self";
   K_665           : aliased constant String := "apollo guidance computer";
   M_665           : aliased constant String := "Apollo Guidance Computer";
   K_666           : aliased constant String := "renpy";
   M_666           : aliased constant String := "Ren'Py";
   K_667           : aliased constant String := "clean";
   M_667           : aliased constant String := "Clean";
   K_668           : aliased constant String := "sarif";
   M_668           : aliased constant String := "JSON";
   K_669           : aliased constant String := "red/system";
   M_669           : aliased constant String := "Red";
   K_670           : aliased constant String := "hyphy";
   M_670           : aliased constant String := "HyPhy";
   K_671           : aliased constant String := "subrip text";
   M_671           : aliased constant String := "SubRip Text";
   K_672           : aliased constant String := "leex";
   M_672           : aliased constant String := "HTML+EEX";
   K_673           : aliased constant String := "easybuild";
   M_673           : aliased constant String := "Easybuild";
   K_674           : aliased constant String := "sfv";
   M_674           : aliased constant String := "Simple File Verification";
   K_675           : aliased constant String := "vcl";
   M_675           : aliased constant String := "VCL";
   K_676           : aliased constant String := "p4";
   M_676           : aliased constant String := "P4";
   K_677           : aliased constant String := "hack";
   M_677           : aliased constant String := "Hack";
   K_678           : aliased constant String := "selinux policy";
   M_678           : aliased constant String := "SELinux Policy";
   K_679           : aliased constant String := "qmake";
   M_679           : aliased constant String := "QMake";
   K_680           : aliased constant String := "wren";
   M_680           : aliased constant String := "Wren";
   K_681           : aliased constant String := "freemarker";
   M_681           : aliased constant String := "FreeMarker";
   K_682           : aliased constant String := "game maker language";
   M_682           : aliased constant String := "Game Maker Language";
   K_683           : aliased constant String := "llvm";
   M_683           : aliased constant String := "LLVM";
   K_684           : aliased constant String := "nl";
   M_684           : aliased constant String := "NL";
   K_685           : aliased constant String := "dotenv";
   M_685           : aliased constant String := "Dotenv";
   K_686           : aliased constant String := "clarion";
   M_686           : aliased constant String := "Clarion";
   K_687           : aliased constant String := "coccinelle";
   M_687           : aliased constant String := "SmPL";
   K_688           : aliased constant String := "vlang";
   M_688           : aliased constant String := "V";
   K_689           : aliased constant String := "singularity";
   M_689           : aliased constant String := "Singularity";
   K_690           : aliased constant String := "cuda";
   M_690           : aliased constant String := "Cuda";
   K_691           : aliased constant String := "nu";
   M_691           : aliased constant String := "Nu";
   K_692           : aliased constant String := "ad block";
   M_692           : aliased constant String := "Adblock Filter List";
   K_693           : aliased constant String := "fortran free form";
   M_693           : aliased constant String := "Fortran Free Form";
   K_694           : aliased constant String := "glyph bitmap distribution format";
   M_694           : aliased constant String := "Glyph Bitmap Distribution Format";
   K_695           : aliased constant String := "redcode";
   M_695           : aliased constant String := "Redcode";
   K_696           : aliased constant String := "vim script";
   M_696           : aliased constant String := "Vim Script";
   K_697           : aliased constant String := "eml";
   M_697           : aliased constant String := "E-mail";
   K_698           : aliased constant String := "protocol buffers";
   M_698           : aliased constant String := "Protocol Buffer";
   K_699           : aliased constant String := "rpcgen";
   M_699           : aliased constant String := "RPC";
   K_700           : aliased constant String := "kaitai struct";
   M_700           : aliased constant String := "Kaitai Struct";
   K_701           : aliased constant String := "jsp";
   M_701           : aliased constant String := "Java Server Pages";
   K_702           : aliased constant String := "objectivec";
   M_702           : aliased constant String := "Objective-C";
   K_703           : aliased constant String := "linux kernel module";
   M_703           : aliased constant String := "Linux Kernel Module";
   K_704           : aliased constant String := "scala";
   M_704           : aliased constant String := "Scala";
   K_705           : aliased constant String := "verilog";
   M_705           : aliased constant String := "Verilog";
   K_706           : aliased constant String := "win32 message file";
   M_706           : aliased constant String := "Win32 Message File";
   K_707           : aliased constant String := "rpm spec";
   M_707           : aliased constant String := "RPM Spec";
   K_708           : aliased constant String := "gleam";
   M_708           : aliased constant String := "Gleam";
   K_709           : aliased constant String := "vimhelp";
   M_709           : aliased constant String := "Vim Help File";
   K_710           : aliased constant String := "nextflow";
   M_710           : aliased constant String := "Nextflow";
   K_711           : aliased constant String := "ultisnips";
   M_711           : aliased constant String := "Vim Snippet";
   K_712           : aliased constant String := "npm config";
   M_712           : aliased constant String := "NPM Config";
   K_713           : aliased constant String := "objectivej";
   M_713           : aliased constant String := "Objective-J";
   K_714           : aliased constant String := "bicep";
   M_714           : aliased constant String := "Bicep";
   K_715           : aliased constant String := "filebench wml";
   M_715           : aliased constant String := "Filebench WML";
   K_716           : aliased constant String := "cds";
   M_716           : aliased constant String := "CAP CDS";
   K_717           : aliased constant String := "directx 3d file";
   M_717           : aliased constant String := "DirectX 3D File";
   K_718           : aliased constant String := "mps";
   M_718           : aliased constant String := "JetBrains MPS";
   K_719           : aliased constant String := "flux";
   M_719           : aliased constant String := "FLUX";
   K_720           : aliased constant String := "dlang";
   M_720           : aliased constant String := "D";
   K_721           : aliased constant String := "pascal";
   M_721           : aliased constant String := "Pascal";
   K_722           : aliased constant String := "gradle kotlin dsl";
   M_722           : aliased constant String := "Gradle Kotlin DSL";
   K_723           : aliased constant String := "omgrofl";
   M_723           : aliased constant String := "Omgrofl";
   K_724           : aliased constant String := "typescript";
   M_724           : aliased constant String := "TypeScript";
   K_725           : aliased constant String := "polar";
   M_725           : aliased constant String := "Polar";
   K_726           : aliased constant String := "postscript";
   M_726           : aliased constant String := "PostScript";
   K_727           : aliased constant String := "specfile";
   M_727           : aliased constant String := "RPM Spec";
   K_728           : aliased constant String := "monkey c";
   M_728           : aliased constant String := "Monkey C";
   K_729           : aliased constant String := "cue sheet";
   M_729           : aliased constant String := "Cue Sheet";
   K_730           : aliased constant String := "protobuf text format";
   M_730           : aliased constant String := "Protocol Buffer Text Format";
   K_731           : aliased constant String := "bro";
   M_731           : aliased constant String := "Zeek";
   K_732           : aliased constant String := "latte";
   M_732           : aliased constant String := "Latte";
   K_733           : aliased constant String := "peg.js";
   M_733           : aliased constant String := "PEG.js";
   K_734           : aliased constant String := "textmate properties";
   M_734           : aliased constant String := "TextMate Properties";
   K_735           : aliased constant String := "xpm";
   M_735           : aliased constant String := "X PixMap";
   K_736           : aliased constant String := "velocity";
   M_736           : aliased constant String := "Velocity Template Language";
   K_737           : aliased constant String := "haproxy";
   M_737           : aliased constant String := "HAProxy";
   K_738           : aliased constant String := "cfc";
   M_738           : aliased constant String := "ColdFusion CFC";
   K_739           : aliased constant String := "edge";
   M_739           : aliased constant String := "Edge";
   K_740           : aliased constant String := "muse";
   M_740           : aliased constant String := "Muse";
   K_741           : aliased constant String := "regex";
   M_741           : aliased constant String := "Regular Expression";
   K_742           : aliased constant String := "unity3d asset";
   M_742           : aliased constant String := "Unity3D Asset";
   K_743           : aliased constant String := "cfm";
   M_743           : aliased constant String := "ColdFusion";
   K_744           : aliased constant String := "twig";
   M_744           : aliased constant String := "Twig";
   K_745           : aliased constant String := "actionscript3";
   M_745           : aliased constant String := "ActionScript";
   K_746           : aliased constant String := "oberon";
   M_746           : aliased constant String := "Oberon";
   K_747           : aliased constant String := "rb";
   M_747           : aliased constant String := "Ruby";
   K_748           : aliased constant String := "blade";
   M_748           : aliased constant String := "Blade";
   K_749           : aliased constant String := "pod";
   M_749           : aliased constant String := "Pod";
   K_750           : aliased constant String := "oncrpc";
   M_750           : aliased constant String := "RPC";
   K_751           : aliased constant String := "ragel-rb";
   M_751           : aliased constant String := "Ragel";
   K_752           : aliased constant String := "nu-script";
   M_752           : aliased constant String := "Nushell";
   K_753           : aliased constant String := "dogescript";
   M_753           : aliased constant String := "Dogescript";
   K_754           : aliased constant String := "sparql";
   M_754           : aliased constant String := "SPARQL";
   K_755           : aliased constant String := "rs";
   M_755           : aliased constant String := "Rust";
   K_756           : aliased constant String := "kit";
   M_756           : aliased constant String := "Kit";
   K_757           : aliased constant String := "pot";
   M_757           : aliased constant String := "Gettext Catalog";
   K_758           : aliased constant String := "swift";
   M_758           : aliased constant String := "Swift";
   K_759           : aliased constant String := "talon";
   M_759           : aliased constant String := "Talon";
   K_760           : aliased constant String := "wasm";
   M_760           : aliased constant String := "WebAssembly";
   K_761           : aliased constant String := "vim";
   M_761           : aliased constant String := "Vim Script";
   K_762           : aliased constant String := "json";
   M_762           : aliased constant String := "JSON";
   K_763           : aliased constant String := "autoit";
   M_763           : aliased constant String := "AutoIt";
   K_764           : aliased constant String := "wast";
   M_764           : aliased constant String := "WebAssembly";
   K_765           : aliased constant String := "pact";
   M_765           : aliased constant String := "Pact";
   K_766           : aliased constant String := "elvish";
   M_766           : aliased constant String := "Elvish";
   K_767           : aliased constant String := "dtrace-script";
   M_767           : aliased constant String := "DTrace";
   K_768           : aliased constant String := "tl";
   M_768           : aliased constant String := "Type Language";
   K_769           : aliased constant String := "irc logs";
   M_769           : aliased constant String := "IRC log";
   K_770           : aliased constant String := "rhtml";
   M_770           : aliased constant String := "HTML+ERB";
   K_771           : aliased constant String := "stan";
   M_771           : aliased constant String := "Stan";
   K_772           : aliased constant String := "chuck";
   M_772           : aliased constant String := "ChucK";
   K_773           : aliased constant String := "star";
   M_773           : aliased constant String := "STAR";
   K_774           : aliased constant String := "igor pro";
   M_774           : aliased constant String := "IGOR Pro";
   K_775           : aliased constant String := "ts";
   M_775           : aliased constant String := "TypeScript";
   K_776           : aliased constant String := "yacc";
   M_776           : aliased constant String := "Yacc";
   K_777           : aliased constant String := "ags script";
   M_777           : aliased constant String := "AGS Script";
   K_778           : aliased constant String := "minid";
   M_778           : aliased constant String := "MiniD";
   K_779           : aliased constant String := "bison";
   M_779           : aliased constant String := "Bison";
   K_780           : aliased constant String := "cameligo";
   M_780           : aliased constant String := "CameLIGO";
   K_781           : aliased constant String := "snakemake";
   M_781           : aliased constant String := "Snakemake";
   K_782           : aliased constant String := "troff";
   M_782           : aliased constant String := "Roff";
   K_783           : aliased constant String := "kickstart";
   M_783           : aliased constant String := "Kickstart";
   K_784           : aliased constant String := "literate coffeescript";
   M_784           : aliased constant String := "Literate CoffeeScript";
   K_785           : aliased constant String := "dockerfile";
   M_785           : aliased constant String := "Dockerfile";
   K_786           : aliased constant String := "netlinx+erb";
   M_786           : aliased constant String := "NetLinx+ERB";
   K_787           : aliased constant String := "plpgsql";
   M_787           : aliased constant String := "PLpgSQL";
   K_788           : aliased constant String := "odin-lang";
   M_788           : aliased constant String := "Odin";
   K_789           : aliased constant String := "reasonligo";
   M_789           : aliased constant String := "ReasonLIGO";
   K_790           : aliased constant String := "solidity";
   M_790           : aliased constant String := "Solidity";
   K_791           : aliased constant String := "bash";
   M_791           : aliased constant String := "Shell";
   K_792           : aliased constant String := "octave";
   M_792           : aliased constant String := "MATLAB";
   K_793           : aliased constant String := "maxscript";
   M_793           : aliased constant String := "MAXScript";
   K_794           : aliased constant String := "visual basic";
   M_794           : aliased constant String := "Visual Basic .NET";
   K_795           : aliased constant String := "pod 6";
   M_795           : aliased constant String := "Pod 6";
   K_796           : aliased constant String := "njk";
   M_796           : aliased constant String := "Nunjucks";
   K_797           : aliased constant String := "idl";
   M_797           : aliased constant String := "IDL";
   K_798           : aliased constant String := "starlark";
   M_798           : aliased constant String := "Starlark";
   K_799           : aliased constant String := "unrealscript";
   M_799           : aliased constant String := "UnrealScript";
   K_800           : aliased constant String := "nixos";
   M_800           : aliased constant String := "Nix";
   K_801           : aliased constant String := "tm-properties";
   M_801           : aliased constant String := "TextMate Properties";
   K_802           : aliased constant String := "console";
   M_802           : aliased constant String := "ShellSession";
   K_803           : aliased constant String := "jasmin";
   M_803           : aliased constant String := "Jasmin";
   K_804           : aliased constant String := "dtrace";
   M_804           : aliased constant String := "DTrace";
   K_805           : aliased constant String := "cartocss";
   M_805           : aliased constant String := "CartoCSS";
   K_806           : aliased constant String := "asp.net";
   M_806           : aliased constant String := "ASP.NET";
   K_807           : aliased constant String := "html+ruby";
   M_807           : aliased constant String := "HTML+ERB";
   K_808           : aliased constant String := "haml";
   M_808           : aliased constant String := "Haml";
   K_809           : aliased constant String := "ecere projects";
   M_809           : aliased constant String := "Ecere Projects";
   K_810           : aliased constant String := "xc";
   M_810           : aliased constant String := "XC";
   K_811           : aliased constant String := "web ontology language";
   M_811           : aliased constant String := "Web Ontology Language";
   K_812           : aliased constant String := "pug";
   M_812           : aliased constant String := "Pug";
   K_813           : aliased constant String := "robotframework";
   M_813           : aliased constant String := "RobotFramework";
   K_814           : aliased constant String := "emacs-lisp";
   M_814           : aliased constant String := "Common Lisp";
   K_815           : aliased constant String := "apkbuild";
   M_815           : aliased constant String := "Alpine Abuild";
   K_816           : aliased constant String := "pddl";
   M_816           : aliased constant String := "PDDL";
   K_817           : aliased constant String := "diff";
   M_817           : aliased constant String := "Diff";
   K_818           : aliased constant String := "bzl";
   M_818           : aliased constant String := "Starlark";
   K_819           : aliased constant String := "groovy";
   M_819           : aliased constant String := "Groovy";
   K_820           : aliased constant String := "dhall";
   M_820           : aliased constant String := "Dhall";
   K_821           : aliased constant String := "xs";
   M_821           : aliased constant String := "XS";
   K_822           : aliased constant String := "urweb";
   M_822           : aliased constant String := "UrWeb";
   K_823           : aliased constant String := "marko";
   M_823           : aliased constant String := "Marko";
   K_824           : aliased constant String := "postscr";
   M_824           : aliased constant String := "PostScript";
   K_825           : aliased constant String := "viml";
   M_825           : aliased constant String := "Vim Script";
   K_826           : aliased constant String := "x font directory index";
   M_826           : aliased constant String := "X Font Directory Index";
   K_827           : aliased constant String := "avro idl";
   M_827           : aliased constant String := "Avro IDL";
   K_828           : aliased constant String := "adobe multiple font metrics";
   M_828           : aliased constant String := "Adobe Font Metrics";
   K_829           : aliased constant String := "cycript";
   M_829           : aliased constant String := "Cycript";
   K_830           : aliased constant String := "openrc";
   M_830           : aliased constant String := "OpenRC runscript";
   K_831           : aliased constant String := "srecode template";
   M_831           : aliased constant String := "SRecode Template";
   K_832           : aliased constant String := "live-script";
   M_832           : aliased constant String := "LiveScript";
   K_833           : aliased constant String := "editorconfig";
   M_833           : aliased constant String := "EditorConfig";
   K_834           : aliased constant String := "winbatch";
   M_834           : aliased constant String := "Batchfile";
   K_835           : aliased constant String := "angelscript";
   M_835           : aliased constant String := "AngelScript";
   K_836           : aliased constant String := "vala";
   M_836           : aliased constant String := "Vala";
   K_837           : aliased constant String := "zeek";
   M_837           : aliased constant String := "Zeek";
   K_838           : aliased constant String := "elvish transcript";
   M_838           : aliased constant String := "Elvish Transcript";
   K_839           : aliased constant String := "jison";
   M_839           : aliased constant String := "Jison";
   K_840           : aliased constant String := "autoitscript";
   M_840           : aliased constant String := "AutoIt";
   K_841           : aliased constant String := "earthly";
   M_841           : aliased constant String := "Earthly";
   K_842           : aliased constant String := "antlr";
   M_842           : aliased constant String := "ANTLR";
   K_843           : aliased constant String := "objective-c";
   M_843           : aliased constant String := "Objective-C";
   K_844           : aliased constant String := "papyrus";
   M_844           : aliased constant String := "Papyrus";
   K_845           : aliased constant String := "gerber image";
   M_845           : aliased constant String := "Gerber Image";
   K_846           : aliased constant String := "factor";
   M_846           : aliased constant String := "Factor";
   K_847           : aliased constant String := "elisp";
   M_847           : aliased constant String := "Emacs Lisp";
   K_848           : aliased constant String := "webvtt";
   M_848           : aliased constant String := "WebVTT";
   K_849           : aliased constant String := "objective-j";
   M_849           : aliased constant String := "Objective-J";
   K_850           : aliased constant String := "wgsl";
   M_850           : aliased constant String := "WGSL";
   K_851           : aliased constant String := "sourcemod";
   M_851           : aliased constant String := "SourcePawn";
   K_852           : aliased constant String := "genero per";
   M_852           : aliased constant String := "Genero per";
   K_853           : aliased constant String := "stl";
   M_853           : aliased constant String := "STL";
   K_854           : aliased constant String := "moonscript";
   M_854           : aliased constant String := "MoonScript";
   K_855           : aliased constant String := "common workflow language";
   M_855           : aliased constant String := "Common Workflow Language";
   K_856           : aliased constant String := "less";
   M_856           : aliased constant String := "Less";
   K_857           : aliased constant String := "mermaid example";
   M_857           : aliased constant String := "Mermaid";
   K_858           : aliased constant String := "litcoffee";
   M_858           : aliased constant String := "Literate CoffeeScript";
   K_859           : aliased constant String := "motorola 68k assembly";
   M_859           : aliased constant String := "Motorola 68K Assembly";
   K_860           : aliased constant String := "scheme";
   M_860           : aliased constant String := "Scheme";
   K_861           : aliased constant String := "gnat project";
   M_861           : aliased constant String := "GNAT Project";
   K_862           : aliased constant String := "bikeshed";
   M_862           : aliased constant String := "Bikeshed";
   K_863           : aliased constant String := "circom";
   M_863           : aliased constant String := "Circom";
   K_864           : aliased constant String := "git attributes";
   M_864           : aliased constant String := "Git Attributes";
   K_865           : aliased constant String := "wavefront object";
   M_865           : aliased constant String := "Wavefront Object";
   K_866           : aliased constant String := "4d";
   M_866           : aliased constant String := "4D";
   K_867           : aliased constant String := "cpp";
   M_867           : aliased constant String := "C++";
   K_868           : aliased constant String := "lex";
   M_868           : aliased constant String := "Lex";
   K_869           : aliased constant String := "go mod";
   M_869           : aliased constant String := "Go Module";
   K_870           : aliased constant String := "2-dimensional array";
   M_870           : aliased constant String := "2-Dimensional Array";
   K_871           : aliased constant String := "agda";
   M_871           : aliased constant String := "Agda";
   K_872           : aliased constant String := "motoko";
   M_872           : aliased constant String := "Motoko";
   K_873           : aliased constant String := "gaml";
   M_873           : aliased constant String := "GAML";
   K_874           : aliased constant String := "genero 4gl";
   M_874           : aliased constant String := "Genero 4gl";
   K_875           : aliased constant String := "jflex";
   M_875           : aliased constant String := "JFlex";
   K_876           : aliased constant String := "turtle";
   M_876           : aliased constant String := "Turtle";
   K_877           : aliased constant String := "m4sugar";
   M_877           : aliased constant String := "M4Sugar";
   K_878           : aliased constant String := "gams";
   M_878           : aliased constant String := "GAMS";
   K_879           : aliased constant String := "literate haskell";
   M_879           : aliased constant String := "Literate Haskell";
   K_880           : aliased constant String := "ags";
   M_880           : aliased constant String := "AGS Script";
   K_881           : aliased constant String := "emberscript";
   M_881           : aliased constant String := "EmberScript";
   K_882           : aliased constant String := "obj-c++";
   M_882           : aliased constant String := "Objective-C++";
   K_883           : aliased constant String := "inputrc";
   M_883           : aliased constant String := "Readline Config";
   K_884           : aliased constant String := "svg";
   M_884           : aliased constant String := "SVG";
   K_885           : aliased constant String := "ijm";
   M_885           : aliased constant String := "ImageJ Macro";
   K_886           : aliased constant String := "ksy";
   M_886           : aliased constant String := "Kaitai Struct";
   K_887           : aliased constant String := "conll";
   M_887           : aliased constant String := "CoNLL-U";
   K_888           : aliased constant String := "squeak";
   M_888           : aliased constant String := "Smalltalk";
   K_889           : aliased constant String := "pcbnew";
   M_889           : aliased constant String := "KiCad Layout";
   K_890           : aliased constant String := "ant build system";
   M_890           : aliased constant String := "Ant Build System";
   K_891           : aliased constant String := "json5";
   M_891           : aliased constant String := "JSON5";
   K_892           : aliased constant String := "picolisp";
   M_892           : aliased constant String := "PicoLisp";
   K_893           : aliased constant String := "lhaskell";
   M_893           : aliased constant String := "Literate Haskell";
   K_894           : aliased constant String := "turing";
   M_894           : aliased constant String := "Turing";
   K_895           : aliased constant String := "qml";
   M_895           : aliased constant String := "QML";
   K_896           : aliased constant String := "nunjucks";
   M_896           : aliased constant String := "Nunjucks";
   K_897           : aliased constant String := "gap";
   M_897           : aliased constant String := "GAP";
   K_898           : aliased constant String := "hash";
   M_898           : aliased constant String := "Checksums";
   K_899           : aliased constant String := "gas";
   M_899           : aliased constant String := "Unix Assembly";
   K_900           : aliased constant String := "tl-verilog";
   M_900           : aliased constant String := "TL-Verilog";
   K_901           : aliased constant String := "http";
   M_901           : aliased constant String := "HTTP";
   K_902           : aliased constant String := "qsharp";
   M_902           : aliased constant String := "Q#";
   K_903           : aliased constant String := "saltstate";
   M_903           : aliased constant String := "SaltStack";
   K_904           : aliased constant String := "rexx";
   M_904           : aliased constant String := "REXX";
   K_905           : aliased constant String := "scss";
   M_905           : aliased constant String := "SCSS";
   K_906           : aliased constant String := "processing";
   M_906           : aliased constant String := "Processing";
   K_907           : aliased constant String := "ignore list";
   M_907           : aliased constant String := "Ignore List";
   K_908           : aliased constant String := "scenic";
   M_908           : aliased constant String := "Scenic";
   K_909           : aliased constant String := "purescript";
   M_909           : aliased constant String := "PureScript";
   K_910           : aliased constant String := "cpp-objdump";
   M_910           : aliased constant String := "Cpp-ObjDump";
   K_911           : aliased constant String := "chapel";
   M_911           : aliased constant String := "Chapel";
   K_912           : aliased constant String := "stata";
   M_912           : aliased constant String := "Stata";
   K_913           : aliased constant String := "metal";
   M_913           : aliased constant String := "Metal";
   K_914           : aliased constant String := "plain text";
   M_914           : aliased constant String := "Text";
   K_915           : aliased constant String := "nemerle";
   M_915           : aliased constant String := "Nemerle";
   K_916           : aliased constant String := "hlsl";
   M_916           : aliased constant String := "HLSL";
   K_917           : aliased constant String := "raw";
   M_917           : aliased constant String := "Raw token data";
   K_918           : aliased constant String := "yaml";
   M_918           : aliased constant String := "YAML";
   K_919           : aliased constant String := "pandoc";
   M_919           : aliased constant String := "Markdown";
   K_920           : aliased constant String := "vue";
   M_920           : aliased constant String := "Vue";
   K_921           : aliased constant String := "jsonc";
   M_921           : aliased constant String := "JSON with Comments";
   K_922           : aliased constant String := "fortran";
   M_922           : aliased constant String := "Fortran";
   K_923           : aliased constant String := "ligolang";
   M_923           : aliased constant String := "LigoLANG";
   K_924           : aliased constant String := "git revision list";
   M_924           : aliased constant String := "Git Revision List";
   K_925           : aliased constant String := "tla";
   M_925           : aliased constant String := "TLA";
   K_926           : aliased constant String := "jsonl";
   M_926           : aliased constant String := "JSON";
   K_927           : aliased constant String := "meson";
   M_927           : aliased constant String := "Meson";
   K_928           : aliased constant String := "nginx";
   M_928           : aliased constant String := "Nginx";
   K_929           : aliased constant String := "textgrid";
   M_929           : aliased constant String := "TextGrid";
   K_930           : aliased constant String := "golo";
   M_930           : aliased constant String := "Golo";
   K_931           : aliased constant String := "closure templates";
   M_931           : aliased constant String := "Closure Templates";
   K_932           : aliased constant String := "xpages";
   M_932           : aliased constant String := "XPages";
   K_933           : aliased constant String := "shellsession";
   M_933           : aliased constant String := "ShellSession";
   K_934           : aliased constant String := "inc";
   M_934           : aliased constant String := "PHP";
   K_935           : aliased constant String := "ats2";
   M_935           : aliased constant String := "ATS";
   K_936           : aliased constant String := "ini";
   M_936           : aliased constant String := "INI";
   K_937           : aliased constant String := "salt";
   M_937           : aliased constant String := "SaltStack";
   K_938           : aliased constant String := "snippet";
   M_938           : aliased constant String := "YASnippet";
   K_939           : aliased constant String := "ink";
   M_939           : aliased constant String := "Ink";
   K_940           : aliased constant String := "esdl";
   M_940           : aliased constant String := "EdgeQL";
   K_941           : aliased constant String := "proto";
   M_941           : aliased constant String := "Protocol Buffer";
   K_942           : aliased constant String := "shaderlab";
   M_942           : aliased constant String := "ShaderLab";
   K_943           : aliased constant String := "vb 6";
   M_943           : aliased constant String := "Visual Basic 6.0";
   K_944           : aliased constant String := "rebol";
   M_944           : aliased constant String := "Rebol";
   K_945           : aliased constant String := "jolie";
   M_945           : aliased constant String := "Jolie";
   K_946           : aliased constant String := "sepolicy";
   M_946           : aliased constant String := "SELinux Policy";
   K_947           : aliased constant String := "opts";
   M_947           : aliased constant String := "Option List";
   K_948           : aliased constant String := "wit";
   M_948           : aliased constant String := "WebAssembly Interface Type";
   K_949           : aliased constant String := "mlir";
   M_949           : aliased constant String := "MLIR";
   K_950           : aliased constant String := "regexp";
   M_950           : aliased constant String := "Regular Expression";
   K_951           : aliased constant String := "pycon";
   M_951           : aliased constant String := "Python console";
   K_952           : aliased constant String := "rpgle";
   M_952           : aliased constant String := "RPGLE";
   K_953           : aliased constant String := "thrift";
   M_953           : aliased constant String := "Thrift";
   K_954           : aliased constant String := "bluespec";
   M_954           : aliased constant String := "Bluespec";
   K_955           : aliased constant String := "java server pages";
   M_955           : aliased constant String := "Java Server Pages";
   K_956           : aliased constant String := "rs-274x";
   M_956           : aliased constant String := "Gerber Image";
   K_957           : aliased constant String := "gettext catalog";
   M_957           : aliased constant String := "Gettext Catalog";
   K_958           : aliased constant String := "witcher script";
   M_958           : aliased constant String := "Witcher Script";
   K_959           : aliased constant String := "codeql";
   M_959           : aliased constant String := "CodeQL";
   K_960           : aliased constant String := "restructuredtext";
   M_960           : aliased constant String := "reStructuredText";
   K_961           : aliased constant String := "livescript";
   M_961           : aliased constant String := "LiveScript";
   K_962           : aliased constant String := "logos";
   M_962           : aliased constant String := "Logos";
   K_963           : aliased constant String := "d2lang";
   M_963           : aliased constant String := "D2";
   K_964           : aliased constant String := "ebnf";
   M_964           : aliased constant String := "EBNF";
   K_965           : aliased constant String := "inno setup";
   M_965           : aliased constant String := "Inno Setup";
   K_966           : aliased constant String := "shellcheck config";
   M_966           : aliased constant String := "ShellCheck Config";
   K_967           : aliased constant String := "checksum";
   M_967           : aliased constant String := "Checksums";
   K_968           : aliased constant String := "red";
   M_968           : aliased constant String := "Red";
   K_969           : aliased constant String := "ston";
   M_969           : aliased constant String := "STON";
   K_970           : aliased constant String := "c++-objdump";
   M_970           : aliased constant String := "Cpp-ObjDump";
   K_971           : aliased constant String := "readline";
   M_971           : aliased constant String := "Readline Config";
   K_972           : aliased constant String := "sqlpl";
   M_972           : aliased constant String := "SQLPL";
   K_973           : aliased constant String := "gherkin";
   M_973           : aliased constant String := "Gherkin";
   K_974           : aliased constant String := "beef";
   M_974           : aliased constant String := "Beef";
   K_975           : aliased constant String := "mint";
   M_975           : aliased constant String := "Mint";
   K_976           : aliased constant String := "debian package control file";
   M_976           : aliased constant String := "Debian Package Control File";
   K_977           : aliased constant String := "basic";
   M_977           : aliased constant String := "BASIC";
   K_978           : aliased constant String := "visual basic 6";
   M_978           : aliased constant String := "Visual Basic 6.0";
   K_979           : aliased constant String := "eeschema schematic";
   M_979           : aliased constant String := "KiCad Schematic";
   K_980           : aliased constant String := "rez";
   M_980           : aliased constant String := "Rez";
   K_981           : aliased constant String := "python";
   M_981           : aliased constant String := "Python";
   K_982           : aliased constant String := "selinux kernel policy language";
   M_982           : aliased constant String := "SELinux Policy";
   K_983           : aliased constant String := "glsl";
   M_983           : aliased constant String := "GLSL";
   K_984           : aliased constant String := "qt script";
   M_984           : aliased constant String := "Qt Script";
   K_985           : aliased constant String := "emacs lisp";
   M_985           : aliased constant String := "Emacs Lisp";
   K_986           : aliased constant String := "blitzplus";
   M_986           : aliased constant String := "BlitzBasic";
   K_987           : aliased constant String := "protobuf";
   M_987           : aliased constant String := "Protocol Buffer";
   K_988           : aliased constant String := "bat";
   M_988           : aliased constant String := "Batchfile";
   K_989           : aliased constant String := "pasm";
   M_989           : aliased constant String := "Parrot Assembly";
   K_990           : aliased constant String := "eclipse";
   M_990           : aliased constant String := "ECLiPSe";
   K_991           : aliased constant String := "c#";
   M_991           : aliased constant String := "C#";
   K_992           : aliased constant String := "cson";
   M_992           : aliased constant String := "CSON";
   K_993           : aliased constant String := "xten";
   M_993           : aliased constant String := "X10";
   K_994           : aliased constant String := "brighterscript";
   M_994           : aliased constant String := "BrighterScript";
   K_995           : aliased constant String := "actionscript";
   M_995           : aliased constant String := "ActionScript";
   K_996           : aliased constant String := "pony";
   M_996           : aliased constant String := "Pony";
   K_997           : aliased constant String := "irc";
   M_997           : aliased constant String := "IRC log";
   K_998           : aliased constant String := "man";
   M_998           : aliased constant String := "Roff";
   K_999           : aliased constant String := "max";
   M_999           : aliased constant String := "Max";
   K_1000          : aliased constant String := "al";
   M_1000          : aliased constant String := "AL";
   K_1001          : aliased constant String := "fluent";
   M_1001          : aliased constant String := "Fluent";
   K_1002          : aliased constant String := "xhtml";
   M_1002          : aliased constant String := "HTML";
   K_1003          : aliased constant String := "xquery";
   M_1003          : aliased constant String := "XQuery";
   K_1004          : aliased constant String := "dafny";
   M_1004          : aliased constant String := "Dafny";
   K_1005          : aliased constant String := "csound";
   M_1005          : aliased constant String := "Csound";
   K_1006          : aliased constant String := "openrc runscript";
   M_1006          : aliased constant String := "OpenRC runscript";
   K_1007          : aliased constant String := "asn.1";
   M_1007          : aliased constant String := "ASN.1";
   K_1008          : aliased constant String := "as3";
   M_1008          : aliased constant String := "ActionScript";
   K_1009          : aliased constant String := "mojo";
   M_1009          : aliased constant String := "Mojo";
   K_1010          : aliased constant String := "powershell";
   M_1010          : aliased constant String := "PowerShell";
   K_1011          : aliased constant String := "riot";
   M_1011          : aliased constant String := "Riot";
   K_1012          : aliased constant String := "amfm";
   M_1012          : aliased constant String := "Adobe Font Metrics";
   K_1013          : aliased constant String := "pwsh";
   M_1013          : aliased constant String := "PowerShell";
   K_1014          : aliased constant String := "sweave";
   M_1014          : aliased constant String := "Sweave";
   K_1015          : aliased constant String := "openscad";
   M_1015          : aliased constant String := "OpenSCAD";
   K_1016          : aliased constant String := "latex";
   M_1016          : aliased constant String := "TeX,Latex";
   K_1017          : aliased constant String := "loomscript";
   M_1017          : aliased constant String := "LoomScript";
   K_1018          : aliased constant String := "figfont";
   M_1018          : aliased constant String := "FIGlet Font";
   K_1019          : aliased constant String := "fancy";
   M_1019          : aliased constant String := "Fancy";
   K_1020          : aliased constant String := "unified parallel c";
   M_1020          : aliased constant String := "Unified Parallel C";
   K_1021          : aliased constant String := "oasv2-json";
   M_1021          : aliased constant String := "OASv2-json";
   K_1022          : aliased constant String := "vb.net";
   M_1022          : aliased constant String := "Visual Basic .NET";
   K_1023          : aliased constant String := "whiley";
   M_1023          : aliased constant String := "Whiley";
   K_1024          : aliased constant String := "lasso";
   M_1024          : aliased constant String := "Lasso";
   K_1025          : aliased constant String := "parrot assembly";
   M_1025          : aliased constant String := "Parrot Assembly";
   K_1026          : aliased constant String := "vhdl";
   M_1026          : aliased constant String := "VHDL";
   K_1027          : aliased constant String := "renderscript";
   M_1027          : aliased constant String := "RenderScript";
   K_1028          : aliased constant String := "ile rpg";
   M_1028          : aliased constant String := "RPGLE";
   K_1029          : aliased constant String := "kicad layout";
   M_1029          : aliased constant String := "KiCad Layout";
   K_1030          : aliased constant String := "hylang";
   M_1030          : aliased constant String := "Hy";
   K_1031          : aliased constant String := "smali";
   M_1031          : aliased constant String := "Smali";
   K_1032          : aliased constant String := "makefile";
   M_1032          : aliased constant String := "Makefile";
   K_1033          : aliased constant String := "c-objdump";
   M_1033          : aliased constant String := "C-ObjDump";
   K_1034          : aliased constant String := "au3";
   M_1034          : aliased constant String := "AutoIt";
   K_1035          : aliased constant String := "nush";
   M_1035          : aliased constant String := "Nu";
   K_1036          : aliased constant String := "hxml";
   M_1036          : aliased constant String := "HXML";
   K_1037          : aliased constant String := "e-mail";
   M_1037          : aliased constant String := "E-mail";
   K_1038          : aliased constant String := "autoit3";
   M_1038          : aliased constant String := "AutoIt";
   K_1039          : aliased constant String := "pawn";
   M_1039          : aliased constant String := "Pawn";
   K_1040          : aliased constant String := "help";
   M_1040          : aliased constant String := "Vim Help File";
   K_1041          : aliased constant String := "lolcode";
   M_1041          : aliased constant String := "LOLCODE";
   K_1042          : aliased constant String := "imagej macro";
   M_1042          : aliased constant String := "ImageJ Macro";
   K_1043          : aliased constant String := "wollok";
   M_1043          : aliased constant String := "Wollok";
   K_1044          : aliased constant String := "applescript";
   M_1044          : aliased constant String := "AppleScript";
   K_1045          : aliased constant String := "component pascal";
   M_1045          : aliased constant String := "Component Pascal";
   K_1046          : aliased constant String := "asl";
   M_1046          : aliased constant String := "ASL";
   K_1047          : aliased constant String := "html+php";
   M_1047          : aliased constant String := "HTML+PHP";
   K_1048          : aliased constant String := "sieve";
   M_1048          : aliased constant String := "Sieve";
   K_1049          : aliased constant String := "asm";
   M_1049          : aliased constant String := "Assembly";
   K_1050          : aliased constant String := "liquid";
   M_1050          : aliased constant String := "Liquid";
   K_1051          : aliased constant String := "java";
   M_1051          : aliased constant String := "Java";
   K_1052          : aliased constant String := "asp";
   M_1052          : aliased constant String := "Classic ASP";
   K_1053          : aliased constant String := "neon";
   M_1053          : aliased constant String := "NEON";
   K_1054          : aliased constant String := "genie";
   M_1054          : aliased constant String := "Genie";
   K_1055          : aliased constant String := "fsharp";
   M_1055          : aliased constant String := "F#";
   K_1056          : aliased constant String := "netlinx";
   M_1056          : aliased constant String := "NetLinx";
   K_1057          : aliased constant String := "ec";
   M_1057          : aliased constant String := "eC";
   K_1058          : aliased constant String := "apex";
   M_1058          : aliased constant String := "Apex";
   K_1059          : aliased constant String := "hosts";
   M_1059          : aliased constant String := "Hosts File";
   K_1060          : aliased constant String := "common lisp";
   M_1060          : aliased constant String := "Common Lisp";
   K_1061          : aliased constant String := "irc log";
   M_1061          : aliased constant String := "IRC log";
   K_1062          : aliased constant String := "lsl";
   M_1062          : aliased constant String := "LSL";
   K_1063          : aliased constant String := "eq";
   M_1063          : aliased constant String := "EQ";
   K_1064          : aliased constant String := "opa";
   M_1064          : aliased constant String := "Opa";
   K_1065          : aliased constant String := "vyper";
   M_1065          : aliased constant String := "Vyper";
   K_1066          : aliased constant String := "go sum";
   M_1066          : aliased constant String := "Go Checksums";
   K_1067          : aliased constant String := "python console";
   M_1067          : aliased constant String := "Python console";
   K_1068          : aliased constant String := "rusthon";
   M_1068          : aliased constant String := "Python";
   K_1069          : aliased constant String := "runoff";
   M_1069          : aliased constant String := "RUNOFF";
   K_1070          : aliased constant String := "batch";
   M_1070          : aliased constant String := "Batchfile";
   K_1071          : aliased constant String := "glyph";
   M_1071          : aliased constant String := "Glyph";
   K_1072          : aliased constant String := "i7";
   M_1072          : aliased constant String := "Inform 7";

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
      K_1072'Access);

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
      M_1072'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.AliasMap;
