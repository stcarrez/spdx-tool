--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Alias mapping generated from aliases.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.AliasMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 15) of Natural :=
     (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 16, 17, 24);

   T1 : constant array (0 .. 15) of Unsigned_16 :=
     (1547, 619, 2142, 776, 914, 1025, 1255, 1727, 1311, 1110, 826, 357,
      192, 1733, 1584, 701);

   T2 : constant array (0 .. 15) of Unsigned_16 :=
     (906, 268, 675, 1614, 478, 726, 1388, 2122, 1101, 1918, 1285, 1062,
      1596, 1173, 1210, 1694);

   G : constant array (0 .. 2148) of Unsigned_16 :=
     (841, 0, 11, 444, 805, 529, 0, 0, 850, 594, 520, 28, 0, 0, 0, 952, 386,
      0, 0, 0, 0, 363, 0, 0, 0, 0, 82, 0, 0, 0, 0, 0, 934, 0, 0, 0, 0, 669,
      858, 951, 0, 861, 540, 526, 0, 336, 0, 0, 1036, 521, 0, 0, 0, 0, 0, 0,
      0, 0, 892, 270, 0, 538, 0, 0, 0, 130, 0, 563, 0, 801, 0, 0, 0, 773,
      906, 0, 0, 0, 0, 0, 0, 91, 0, 175, 973, 0, 0, 0, 535, 766, 0, 1069, 0,
      0, 954, 0, 0, 0, 294, 0, 148, 774, 259, 0, 0, 0, 129, 614, 0, 0, 976,
      526, 258, 413, 700, 0, 0, 0, 0, 0, 503, 334, 506, 0, 0, 199, 0, 0,
      1036, 0, 0, 0, 0, 0, 423, 0, 562, 501, 0, 473, 90, 0, 175, 0, 0, 520,
      898, 174, 0, 0, 0, 0, 0, 0, 297, 605, 0, 971, 733, 0, 33, 393, 783, 0,
      1048, 763, 0, 0, 0, 0, 166, 0, 781, 0, 0, 0, 567, 300, 347, 0, 0, 0,
      110, 146, 0, 276, 0, 426, 0, 218, 0, 0, 156, 0, 377, 854, 518, 0, 0,
      0, 0, 599, 0, 34, 0, 0, 0, 0, 698, 594, 0, 0, 0, 0, 1030, 0, 90, 0,
      446, 0, 0, 0, 0, 0, 0, 417, 0, 513, 384, 0, 0, 630, 0, 0, 676, 819, 0,
      0, 0, 353, 0, 1051, 0, 112, 969, 913, 33, 0, 0, 207, 0, 0, 966, 0, 0,
      0, 0, 81, 1005, 0, 761, 1012, 1051, 939, 0, 0, 0, 0, 606, 0, 221, 0,
      834, 455, 764, 879, 0, 839, 0, 680, 802, 0, 0, 0, 110, 0, 0, 0, 0, 0,
      0, 262, 0, 0, 374, 708, 591, 0, 127, 276, 172, 0, 0, 0, 0, 0, 750, 0,
      0, 898, 0, 0, 553, 0, 0, 0, 981, 269, 663, 0, 0, 0, 0, 0, 0, 0, 0,
      733, 0, 0, 0, 0, 0, 0, 711, 896, 0, 0, 0, 217, 110, 395, 0, 206, 0,
      644, 776, 356, 198, 0, 0, 0, 871, 0, 0, 0, 0, 0, 0, 156, 0, 0, 339, 0,
      0, 0, 0, 0, 0, 158, 0, 7, 0, 775, 0, 728, 282, 0, 0, 0, 0, 215, 0, 0,
      0, 162, 0, 0, 321, 0, 412, 0, 0, 236, 56, 1056, 0, 0, 0, 0, 0, 77, 0,
      0, 565, 0, 0, 0, 0, 839, 0, 0, 0, 0, 0, 842, 0, 783, 597, 0, 439, 0,
      861, 0, 737, 589, 0, 0, 0, 407, 0, 789, 0, 56, 0, 0, 0, 0, 0, 601, 0,
      0, 0, 302, 0, 213, 0, 0, 0, 0, 527, 0, 0, 0, 0, 486, 817, 0, 0, 0, 0,
      0, 0, 0, 324, 0, 424, 428, 1055, 0, 0, 0, 0, 336, 0, 443, 280, 0, 0,
      0, 0, 760, 0, 631, 249, 635, 0, 0, 0, 802, 0, 802, 0, 257, 0, 0, 0,
      919, 0, 0, 582, 0, 0, 1008, 16, 659, 136, 127, 0, 0, 990, 0, 0, 637,
      84, 0, 490, 892, 0, 0, 0, 225, 596, 957, 0, 0, 0, 0, 0, 0, 0, 794,
      172, 481, 0, 587, 0, 0, 0, 0, 1013, 514, 446, 0, 0, 430, 0, 119, 694,
      411, 64, 0, 553, 380, 0, 0, 31, 93, 799, 0, 684, 968, 0, 166, 883,
      1073, 831, 0, 640, 0, 162, 0, 24, 10, 913, 0, 0, 0, 0, 0, 0, 691, 525,
      654, 0, 0, 0, 0, 30, 0, 0, 331, 0, 0, 0, 190, 0, 636, 270, 101, 0, 0,
      336, 0, 0, 0, 179, 382, 183, 378, 0, 376, 464, 0, 0, 509, 0, 126, 0,
      0, 185, 447, 0, 651, 1003, 510, 0, 0, 0, 0, 565, 23, 1053, 0, 397, 0,
      0, 0, 0, 228, 618, 0, 0, 0, 0, 625, 197, 69, 0, 0, 664, 0, 991, 983,
      0, 236, 373, 0, 0, 0, 212, 587, 233, 0, 0, 0, 519, 0, 341, 15, 834,
      380, 0, 0, 554, 0, 46, 0, 0, 1011, 921, 0, 0, 0, 0, 432, 0, 0, 205, 0,
      975, 836, 0, 0, 0, 0, 0, 0, 336, 0, 60, 0, 0, 0, 0, 686, 0, 0, 614,
      361, 0, 893, 0, 892, 194, 520, 0, 0, 0, 217, 506, 604, 0, 1057, 58, 0,
      0, 55, 0, 0, 222, 961, 0, 0, 294, 403, 147, 0, 0, 0, 902, 210, 42,
      257, 507, 0, 625, 854, 0, 992, 140, 0, 0, 1045, 0, 82, 724, 579, 1041,
      0, 0, 0, 0, 0, 804, 232, 0, 491, 485, 1014, 649, 850, 62, 0, 0, 697,
      0, 0, 614, 14, 0, 438, 0, 0, 0, 402, 0, 0, 0, 723, 0, 0, 49, 815, 797,
      623, 0, 113, 722, 1037, 125, 0, 944, 0, 0, 0, 916, 0, 740, 0, 0, 0,
      459, 0, 0, 79, 1000, 100, 0, 0, 0, 0, 0, 685, 530, 0, 0, 0, 0, 0, 735,
      0, 325, 0, 0, 451, 0, 809, 0, 1039, 0, 753, 0, 0, 0, 0, 951, 0, 491,
      0, 349, 840, 994, 732, 950, 770, 0, 510, 0, 706, 740, 0, 929, 373, 0,
      0, 756, 628, 1006, 642, 479, 0, 731, 648, 15, 127, 0, 126, 167, 0,
      475, 0, 0, 0, 463, 0, 0, 573, 577, 0, 0, 978, 302, 729, 92, 644, 0, 0,
      694, 0, 0, 0, 0, 0, 703, 0, 37, 0, 0, 0, 0, 80, 102, 0, 0, 588, 0,
      668, 0, 0, 338, 1073, 115, 0, 0, 0, 497, 589, 0, 0, 0, 0, 0, 0, 0, 0,
      178, 0, 0, 0, 250, 0, 1001, 671, 0, 876, 0, 0, 0, 788, 0, 0, 515, 485,
      140, 0, 0, 520, 0, 0, 0, 914, 303, 0, 0, 0, 0, 809, 1045, 1041, 48, 0,
      446, 1005, 836, 165, 582, 0, 0, 0, 0, 0, 728, 335, 674, 0, 0, 80, 0,
      683, 758, 0, 343, 608, 975, 0, 0, 565, 0, 0, 0, 699, 168, 0, 390, 538,
      329, 0, 0, 0, 1006, 734, 750, 991, 0, 0, 352, 0, 170, 0, 905, 752,
      240, 198, 456, 0, 0, 70, 0, 0, 0, 0, 0, 0, 427, 891, 0, 0, 0, 246, 0,
      984, 0, 0, 213, 0, 682, 0, 776, 0, 1048, 610, 2, 295, 252, 520, 915,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 422, 127, 0, 164, 722, 0, 0, 325, 0,
      446, 458, 0, 847, 246, 0, 499, 314, 421, 0, 988, 0, 646, 0, 238, 0,
      859, 0, 873, 579, 0, 1061, 324, 0, 472, 0, 1047, 257, 0, 0, 114, 0,
      544, 0, 0, 0, 0, 386, 0, 303, 0, 0, 571, 457, 0, 742, 950, 128, 724,
      0, 132, 21, 421, 754, 359, 692, 3, 179, 0, 154, 322, 0, 396, 0, 845,
      53, 0, 0, 1038, 0, 0, 962, 73, 0, 0, 611, 1067, 1072, 0, 0, 469, 653,
      0, 631, 155, 662, 810, 0, 1057, 0, 0, 240, 0, 0, 0, 560, 0, 117, 87,
      0, 475, 0, 0, 0, 456, 0, 0, 793, 958, 0, 925, 143, 0, 0, 403, 0, 0, 0,
      153, 804, 742, 970, 0, 0, 1038, 43, 992, 55, 891, 0, 0, 0, 0, 268,
      334, 0, 0, 0, 0, 0, 507, 235, 811, 225, 73, 0, 313, 0, 164, 902, 829,
      842, 0, 0, 622, 1035, 371, 135, 620, 609, 715, 0, 0, 911, 871, 0, 0,
      220, 0, 202, 908, 0, 0, 0, 230, 0, 0, 0, 913, 0, 0, 0, 0, 0, 0, 215,
      751, 977, 0, 0, 0, 247, 174, 5, 682, 0, 0, 0, 44, 0, 644, 561, 0, 683,
      566, 0, 0, 698, 0, 695, 0, 917, 390, 0, 652, 0, 740, 0, 332, 1045, 0,
      138, 1007, 44, 353, 0, 0, 354, 0, 0, 616, 180, 28, 507, 71, 622, 817,
      145, 494, 0, 393, 0, 899, 0, 513, 0, 1003, 209, 61, 0, 0, 925, 0, 457,
      919, 955, 0, 0, 134, 515, 57, 0, 768, 379, 0, 254, 686, 0, 291, 0, 0,
      0, 0, 145, 0, 859, 0, 776, 0, 0, 0, 0, 0, 0, 745, 0, 433, 273, 468, 0,
      0, 0, 406, 13, 123, 1040, 0, 0, 480, 291, 596, 0, 0, 152, 0, 0, 521,
      159, 147, 391, 0, 435, 747, 1015, 0, 909, 0, 301, 708, 0, 0, 0, 0, 0,
      592, 18, 745, 0, 0, 0, 0, 870, 234, 0, 159, 0, 19, 418, 104, 293, 220,
      0, 0, 0, 623, 0, 227, 139, 346, 1022, 0, 137, 0, 656, 0, 0, 169, 271,
      0, 686, 0, 517, 562, 138, 0, 0, 490, 990, 0, 223, 653, 84, 0, 0, 492,
      0, 316, 0, 407, 0, 0, 0, 0, 0, 0, 0, 861, 0, 30, 321, 0, 0, 1013, 0,
      439, 852, 0, 0, 2, 297, 485, 943, 839, 0, 80, 0, 0, 661, 731, 0, 0, 0,
      781, 0, 402, 449, 0, 744, 0, 0, 269, 356, 0, 0, 0, 534, 66, 896, 572,
      647, 401, 53, 0, 0, 0, 539, 89, 0, 388, 583, 0, 2, 927, 77, 104, 0, 0,
      0, 0, 0, 347, 479, 774, 205, 900, 108, 949, 0, 0, 0, 641, 260, 761,
      120, 427, 319, 0, 0, 0, 0, 593, 582, 892, 34, 178, 326, 0, 0, 180, 0,
      927, 0, 0, 0, 745, 0, 578, 227, 0, 0, 0, 300, 506, 98, 0, 11, 315,
      766, 872, 414, 0, 0, 1004, 0, 0, 135, 0, 0, 0, 236, 845, 0, 0, 0, 0,
      0, 0, 265, 0, 66, 336, 0, 429, 0, 795, 0, 265, 0, 407, 0, 0, 17, 943,
      0, 11, 480, 0, 0, 1, 0, 880, 0, 1064, 0, 0, 0, 18, 0, 22, 0, 213, 365,
      656, 0, 726, 0, 385, 1006, 0, 0, 425, 484, 0, 0, 490, 706, 0, 0, 883,
      0, 640, 500, 258, 0, 0, 640, 0, 0, 566, 480, 234, 0, 0, 0, 458, 299,
      0, 220, 679, 0, 174, 628, 0, 0, 0, 532, 0, 931, 57, 928, 0, 925, 836,
      0, 0, 865, 0, 0, 0, 811, 487, 0, 0, 315, 616, 0, 451, 908, 0, 0, 0, 0,
      776, 0, 1072, 0, 615, 21, 725, 0, 231, 252, 0, 85, 0, 760, 0, 345,
      296, 0, 779, 18, 0, 428, 731, 106, 0, 0, 0, 40, 0, 819, 0, 0, 539,
      489, 0, 632, 0, 834, 50, 983, 0, 0, 0, 766, 0, 0, 0, 0, 527, 536, 0,
      878, 0, 0, 85, 769, 703, 523, 582, 0, 844, 0, 0, 1029, 0, 0, 103, 0,
      189, 101, 0, 74, 239, 787, 0, 0, 214, 409, 0, 0, 41, 104, 0, 449, 804,
      0, 0, 764, 8, 969, 0, 826, 285, 0, 596, 221, 0, 262, 901, 0, 0, 488,
      0, 0, 107, 0, 746, 0, 844, 698, 291, 0, 356, 608, 347, 706, 244, 0,
      753, 0, 105, 0, 0, 0, 0, 170, 975, 778, 422, 1065, 64, 0, 618, 0, 40,
      0, 175, 904, 0, 0, 211, 141, 0, 84, 630, 81, 0, 914, 0, 858, 0, 485,
      120, 0, 282, 0, 484, 9, 0, 0, 0, 580, 553, 318, 324, 0, 0, 65, 451, 0,
      1038, 564, 0, 776, 122, 657, 749, 378, 0, 953, 0, 475, 526, 0, 0, 875,
      227, 0, 588, 37, 0, 529, 0, 424, 563, 57, 0, 750, 911, 1003, 39, 0,
      868, 453, 0, 1044, 8, 150, 0, 0, 0, 651, 0, 738, 924, 0, 131, 800,
      342, 0, 161, 681, 0, 0, 0, 812, 115, 1055, 869, 0, 312, 363, 0, 807,
      637, 563, 743, 40, 635, 891, 105, 366, 179, 0, 0, 889, 588, 1066, 0,
      0, 0, 0, 0, 0, 716, 0, 74, 0, 0, 0, 691, 16, 0, 540, 169, 0, 29, 253,
      0, 0, 0, 156, 0, 0, 684, 0, 840, 471, 0, 668, 30, 0, 93, 0, 296, 32,
      0, 777, 60, 0, 58, 695, 349, 0, 1058, 436, 0, 684, 0, 0, 0, 654, 0, 0,
      395, 0, 1023, 193, 608, 438, 0, 669, 4, 1001, 167, 558, 771, 0, 959,
      0, 0, 0, 0, 829, 0, 6, 339, 0, 0, 303, 0, 0, 78, 0, 849, 0, 12, 1024,
      923, 0, 935, 69, 0, 547, 0, 0, 0, 0, 599, 0, 201, 458, 0, 660, 697, 0,
      242, 342, 264, 312, 792, 0, 842, 302, 104, 798, 0, 0, 989, 367, 0,
      537, 0, 150, 938, 0, 0, 937, 542, 206, 0, 838, 284, 716, 80, 0, 0, 0,
      0, 0, 0, 0, 527, 853, 1031, 0, 0, 45, 0, 964, 0, 372, 1049, 20, 1029,
      0, 0, 383, 545, 17, 1020, 604, 109, 441, 0, 904, 96, 0, 278, 0, 621,
      892, 875, 76, 0, 60, 213, 0, 105, 976, 752, 457, 0, 0, 296, 633, 906,
      0, 0, 0, 0, 0, 19, 682, 52, 0, 133, 0, 0, 210, 904);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 2149;
         F2 := (F2 + Natural (T2 (K)) * J) mod 2149;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 1074;
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
   K_31            : aliased constant String := "device tree source";
   M_31            : aliased constant String := "Device Tree Source";
   K_32            : aliased constant String := "dosini";
   M_32            : aliased constant String := "INI";
   K_33            : aliased constant String := "hcl";
   M_33            : aliased constant String := "HCL";
   K_34            : aliased constant String := "mustache";
   M_34            : aliased constant String := "Mustache";
   K_35            : aliased constant String := "terraform template";
   M_35            : aliased constant String := "Terraform Template";
   K_36            : aliased constant String := "microsoft developer studio project";
   M_36            : aliased constant String := "Microsoft Developer Studio Project";
   K_37            : aliased constant String := "digital command language";
   M_37            : aliased constant String := "DIGITAL Command Language";
   K_38            : aliased constant String := "wiki";
   M_38            : aliased constant String := "Wikitext";
   K_39            : aliased constant String := "clips";
   M_39            : aliased constant String := "CLIPS";
   K_40            : aliased constant String := "tsql";
   M_40            : aliased constant String := "TSQL";
   K_41            : aliased constant String := "ecmarkup";
   M_41            : aliased constant String := "Ecmarkup";
   K_42            : aliased constant String := "jsoniq";
   M_42            : aliased constant String := "JSONiq";
   K_43            : aliased constant String := "io";
   M_43            : aliased constant String := "Io";
   K_44            : aliased constant String := "conll-u";
   M_44            : aliased constant String := "CoNLL-U";
   K_45            : aliased constant String := "conll-x";
   M_45            : aliased constant String := "CoNLL-U";
   K_46            : aliased constant String := "brightscript";
   M_46            : aliased constant String := "Brightscript";
   K_47            : aliased constant String := "nginx configuration file";
   M_47            : aliased constant String := "Nginx";
   K_48            : aliased constant String := "postcss";
   M_48            : aliased constant String := "PostCSS";
   K_49            : aliased constant String := "sums";
   M_49            : aliased constant String := "Checksums";
   K_50            : aliased constant String := "redirects";
   M_50            : aliased constant String := "Redirect Rules";
   K_51            : aliased constant String := "visual basic 6.0";
   M_51            : aliased constant String := "Visual Basic 6.0";
   K_52            : aliased constant String := "vb6";
   M_52            : aliased constant String := "Visual Basic 6.0";
   K_53            : aliased constant String := "ecmarkdown";
   M_53            : aliased constant String := "Ecmarkup";
   K_54            : aliased constant String := "darcs patch";
   M_54            : aliased constant String := "Darcs Patch";
   K_55            : aliased constant String := "openstep property list";
   M_55            : aliased constant String := "OpenStep Property List";
   K_56            : aliased constant String := "razor";
   M_56            : aliased constant String := "HTML+Razor";
   K_57            : aliased constant String := "vbnet";
   M_57            : aliased constant String := "Visual Basic .NET";
   K_58            : aliased constant String := "less-css";
   M_58            : aliased constant String := "Less";
   K_59            : aliased constant String := "arexx";
   M_59            : aliased constant String := "REXX";
   K_60            : aliased constant String := "wavefront material";
   M_60            : aliased constant String := "Wavefront Material";
   K_61            : aliased constant String := "xbase";
   M_61            : aliased constant String := "xBase";
   K_62            : aliased constant String := "fstar";
   M_62            : aliased constant String := "F*";
   K_63            : aliased constant String := "sugarss";
   M_63            : aliased constant String := "SugarSS";
   K_64            : aliased constant String := "regular expression";
   M_64            : aliased constant String := "Regular Expression";
   K_65            : aliased constant String := "m2";
   M_65            : aliased constant String := "Macaulay2";
   K_66            : aliased constant String := "vbscript";
   M_66            : aliased constant String := "VBScript";
   K_67            : aliased constant String := "m4";
   M_67            : aliased constant String := "M4";
   K_68            : aliased constant String := "autoconf";
   M_68            : aliased constant String := "M4Sugar";
   K_69            : aliased constant String := "gsc";
   M_69            : aliased constant String := "GSC";
   K_70            : aliased constant String := "mumps";
   M_70            : aliased constant String := "M";
   K_71            : aliased constant String := "opencl";
   M_71            : aliased constant String := "OpenCL";
   K_72            : aliased constant String := "pep8";
   M_72            : aliased constant String := "Pep8";
   K_73            : aliased constant String := "php";
   M_73            : aliased constant String := "PHP";
   K_74            : aliased constant String := "uno";
   M_74            : aliased constant String := "Uno";
   K_75            : aliased constant String := "c";
   M_75            : aliased constant String := "C";
   K_76            : aliased constant String := "d";
   M_76            : aliased constant String := "D";
   K_77            : aliased constant String := "e";
   M_77            : aliased constant String := "E";
   K_78            : aliased constant String := "gsp";
   M_78            : aliased constant String := "Groovy Server Pages";
   K_79            : aliased constant String := "text";
   M_79            : aliased constant String := "Text";
   K_80            : aliased constant String := "j";
   M_80            : aliased constant String := "J";
   K_81            : aliased constant String := "ampl";
   M_81            : aliased constant String := "AMPL";
   K_82            : aliased constant String := "topojson";
   M_82            : aliased constant String := "JSON";
   K_83            : aliased constant String := "m";
   M_83            : aliased constant String := "M";
   K_84            : aliased constant String := "vba";
   M_84            : aliased constant String := "VBA";
   K_85            : aliased constant String := "gemini";
   M_85            : aliased constant String := "Gemini";
   K_86            : aliased constant String := "inform 7";
   M_86            : aliased constant String := "Inform 7";
   K_87            : aliased constant String := "mma";
   M_87            : aliased constant String := "Mathematica";
   K_88            : aliased constant String := "objc++";
   M_88            : aliased constant String := "Objective-C++";
   K_89            : aliased constant String := "wikitext";
   M_89            : aliased constant String := "Wikitext";
   K_90            : aliased constant String := "r";
   M_90            : aliased constant String := "R";
   K_91            : aliased constant String := "record jar";
   M_91            : aliased constant String := "Record Jar";
   K_92            : aliased constant String := "macruby";
   M_92            : aliased constant String := "Ruby";
   K_93            : aliased constant String := "ejs";
   M_93            : aliased constant String := "EJS";
   K_94            : aliased constant String := "html+erb";
   M_94            : aliased constant String := "HTML+ERB";
   K_95            : aliased constant String := "v";
   M_95            : aliased constant String := "V";
   K_96            : aliased constant String := "powerbuilder";
   M_96            : aliased constant String := "PowerBuilder";
   K_97            : aliased constant String := "bluespec classic";
   M_97            : aliased constant String := "Bluespec BH";
   K_98            : aliased constant String := "dpatch";
   M_98            : aliased constant String := "Darcs Patch";
   K_99            : aliased constant String := "curlrc";
   M_99            : aliased constant String := "cURL Config";
   K_100           : aliased constant String := "ascii stl";
   M_100           : aliased constant String := "STL";
   K_101           : aliased constant String := "classic visual basic";
   M_101           : aliased constant String := "Visual Basic 6.0";
   K_102           : aliased constant String := "md";
   M_102           : aliased constant String := "Markdown";
   K_103           : aliased constant String := "openedge abl";
   M_103           : aliased constant String := "OpenEdge ABL";
   K_104           : aliased constant String := "nette object notation";
   M_104           : aliased constant String := "NEON";
   K_105           : aliased constant String := "mf";
   M_105           : aliased constant String := "Makefile";
   K_106           : aliased constant String := "rss";
   M_106           : aliased constant String := "XML";
   K_107           : aliased constant String := "rst";
   M_107           : aliased constant String := "reStructuredText";
   K_108           : aliased constant String := "move";
   M_108           : aliased constant String := "Move";
   K_109           : aliased constant String := "saltstack";
   M_109           : aliased constant String := "SaltStack";
   K_110           : aliased constant String := "boo";
   M_110           : aliased constant String := "Boo";
   K_111           : aliased constant String := "opal";
   M_111           : aliased constant String := "Opal";
   K_112           : aliased constant String := "rescript";
   M_112           : aliased constant String := "ReScript";
   K_113           : aliased constant String := "acfm";
   M_113           : aliased constant String := "Adobe Font Metrics";
   K_114           : aliased constant String := "q#";
   M_114           : aliased constant String := "Q#";
   K_115           : aliased constant String := "xml";
   M_115           : aliased constant String := "XML";
   K_116           : aliased constant String := "oasv2-yaml";
   M_116           : aliased constant String := "OASv2-yaml";
   K_117           : aliased constant String := "oxygene";
   M_117           : aliased constant String := "Oxygene";
   K_118           : aliased constant String := "elm";
   M_118           : aliased constant String := "Elm";
   K_119           : aliased constant String := "curry";
   M_119           : aliased constant String := "Curry";
   K_120           : aliased constant String := "gedcom";
   M_120           : aliased constant String := "GEDCOM";
   K_121           : aliased constant String := "cypher";
   M_121           : aliased constant String := "Cypher";
   K_122           : aliased constant String := "redirect rules";
   M_122           : aliased constant String := "Redirect Rules";
   K_123           : aliased constant String := "vdf";
   M_123           : aliased constant String := "Valve Data Format";
   K_124           : aliased constant String := "carto";
   M_124           : aliased constant String := "CartoCSS";
   K_125           : aliased constant String := "jison lex";
   M_125           : aliased constant String := "Jison Lex";
   K_126           : aliased constant String := "freebasic";
   M_126           : aliased constant String := "FreeBasic";
   K_127           : aliased constant String := "ocaml";
   M_127           : aliased constant String := "OCaml";
   K_128           : aliased constant String := "just";
   M_128           : aliased constant String := "Just";
   K_129           : aliased constant String := "figlet font";
   M_129           : aliased constant String := "FIGlet Font";
   K_130           : aliased constant String := "wrenlang";
   M_130           : aliased constant String := "Wren";
   K_131           : aliased constant String := "igorpro";
   M_131           : aliased constant String := "IGOR Pro";
   K_132           : aliased constant String := "wolfram";
   M_132           : aliased constant String := "Mathematica";
   K_133           : aliased constant String := "ne-on";
   M_133           : aliased constant String := "NEON";
   K_134           : aliased constant String := "smpl";
   M_134           : aliased constant String := "SmPL";
   K_135           : aliased constant String := "ultisnip";
   M_135           : aliased constant String := "Vim Snippet";
   K_136           : aliased constant String := "robots txt";
   M_136           : aliased constant String := "robots.txt";
   K_137           : aliased constant String := "mbox";
   M_137           : aliased constant String := "E-mail";
   K_138           : aliased constant String := "yas";
   M_138           : aliased constant String := "YASnippet";
   K_139           : aliased constant String := "wgetrc";
   M_139           : aliased constant String := "Wget Config";
   K_140           : aliased constant String := "perl";
   M_140           : aliased constant String := "Perl";
   K_141           : aliased constant String := "jest snapshot";
   M_141           : aliased constant String := "Jest Snapshot";
   K_142           : aliased constant String := "tcsh";
   M_142           : aliased constant String := "Tcsh";
   K_143           : aliased constant String := "checksums";
   M_143           : aliased constant String := "Checksums";
   K_144           : aliased constant String := "ox";
   M_144           : aliased constant String := "Ox";
   K_145           : aliased constant String := "bazel";
   M_145           : aliased constant String := "Starlark";
   K_146           : aliased constant String := "filterscript";
   M_146           : aliased constant String := "Filterscript";
   K_147           : aliased constant String := "ncl";
   M_147           : aliased constant String := "NCL";
   K_148           : aliased constant String := "oz";
   M_148           : aliased constant String := "Oz";
   K_149           : aliased constant String := "adblock";
   M_149           : aliased constant String := "Adblock Filter List";
   K_150           : aliased constant String := "gentoo ebuild";
   M_150           : aliased constant String := "Gentoo Ebuild";
   K_151           : aliased constant String := "genshi";
   M_151           : aliased constant String := "Genshi";
   K_152           : aliased constant String := "ssh config";
   M_152           : aliased constant String := "SSH Config";
   K_153           : aliased constant String := "groovy server pages";
   M_153           : aliased constant String := "Groovy Server Pages";
   K_154           : aliased constant String := "objectivec++";
   M_154           : aliased constant String := "Objective-C++";
   K_155           : aliased constant String := "adobe composite font metrics";
   M_155           : aliased constant String := "Adobe Font Metrics";
   K_156           : aliased constant String := "dns zone";
   M_156           : aliased constant String := "DNS Zone";
   K_157           : aliased constant String := "scaml";
   M_157           : aliased constant String := "Scaml";
   K_158           : aliased constant String := "m68k";
   M_158           : aliased constant String := "Motorola 68K Assembly";
   K_159           : aliased constant String := "zenscript";
   M_159           : aliased constant String := "ZenScript";
   K_160           : aliased constant String := "progress";
   M_160           : aliased constant String := "OpenEdge ABL";
   K_161           : aliased constant String := "csound-orc";
   M_161           : aliased constant String := "Csound";
   K_162           : aliased constant String := "d-objdump";
   M_162           : aliased constant String := "D-ObjDump";
   K_163           : aliased constant String := "node";
   M_163           : aliased constant String := "JavaScript";
   K_164           : aliased constant String := "formatted";
   M_164           : aliased constant String := "Formatted";
   K_165           : aliased constant String := "ql";
   M_165           : aliased constant String := "CodeQL";
   K_166           : aliased constant String := "udiff";
   M_166           : aliased constant String := "Diff";
   K_167           : aliased constant String := "cobol";
   M_167           : aliased constant String := "COBOL";
   K_168           : aliased constant String := "slint";
   M_168           : aliased constant String := "Slint";
   K_169           : aliased constant String := "objc";
   M_169           : aliased constant String := "Objective-C";
   K_170           : aliased constant String := "coffee-script";
   M_170           : aliased constant String := "CoffeeScript";
   K_171           : aliased constant String := "textile";
   M_171           : aliased constant String := "Textile";
   K_172           : aliased constant String := "befunge";
   M_172           : aliased constant String := "Befunge";
   K_173           : aliased constant String := "max/msp";
   M_173           : aliased constant String := "Max";
   K_174           : aliased constant String := "objectpascal";
   M_174           : aliased constant String := "Pascal";
   K_175           : aliased constant String := "splus";
   M_175           : aliased constant String := "R";
   K_176           : aliased constant String := "objj";
   M_176           : aliased constant String := "Objective-J";
   K_177           : aliased constant String := "jsonnet";
   M_177           : aliased constant String := "Jsonnet";
   K_178           : aliased constant String := "bsv";
   M_178           : aliased constant String := "Bluespec";
   K_179           : aliased constant String := "matlab";
   M_179           : aliased constant String := "MATLAB";
   K_180           : aliased constant String := "soong";
   M_180           : aliased constant String := "Soong";
   K_181           : aliased constant String := "haskell";
   M_181           : aliased constant String := "Haskell";
   K_182           : aliased constant String := "webidl";
   M_182           : aliased constant String := "WebIDL";
   K_183           : aliased constant String := "cirru";
   M_183           : aliased constant String := "Cirru";
   K_184           : aliased constant String := "numpy";
   M_184           : aliased constant String := "NumPy";
   K_185           : aliased constant String := "ren'py";
   M_185           : aliased constant String := "Ren'Py";
   K_186           : aliased constant String := "xcompose";
   M_186           : aliased constant String := "XCompose";
   K_187           : aliased constant String := "terra";
   M_187           : aliased constant String := "Terra";
   K_188           : aliased constant String := "gnuplot";
   M_188           : aliased constant String := "Gnuplot";
   K_189           : aliased constant String := "htmldjango";
   M_189           : aliased constant String := "Jinja";
   K_190           : aliased constant String := "eagle";
   M_190           : aliased constant String := "Eagle";
   K_191           : aliased constant String := "cool";
   M_191           : aliased constant String := "Cool";
   K_192           : aliased constant String := "python3";
   M_192           : aliased constant String := "Python";
   K_193           : aliased constant String := "aidl";
   M_193           : aliased constant String := "AIDL";
   K_194           : aliased constant String := "django";
   M_194           : aliased constant String := "Jinja";
   K_195           : aliased constant String := "odinlang";
   M_195           : aliased constant String := "Odin";
   K_196           : aliased constant String := "sh";
   M_196           : aliased constant String := "Shell";
   K_197           : aliased constant String := "myghty";
   M_197           : aliased constant String := "Myghty";
   K_198           : aliased constant String := "csound-sco";
   M_198           : aliased constant String := "Csound Score";
   K_199           : aliased constant String := "igor";
   M_199           : aliased constant String := "IGOR Pro";
   K_200           : aliased constant String := "graphql";
   M_200           : aliased constant String := "GraphQL";
   K_201           : aliased constant String := "windows registry entries";
   M_201           : aliased constant String := "Windows Registry Entries";
   K_202           : aliased constant String := "erb";
   M_202           : aliased constant String := "HTML+ERB";
   K_203           : aliased constant String := "xsd";
   M_203           : aliased constant String := "XML";
   K_204           : aliased constant String := "routeros script";
   M_204           : aliased constant String := "RouterOS Script";
   K_205           : aliased constant String := "hashes";
   M_205           : aliased constant String := "Checksums";
   K_206           : aliased constant String := "snipmate";
   M_206           : aliased constant String := "Vim Snippet";
   K_207           : aliased constant String := "aspx";
   M_207           : aliased constant String := "ASP.NET";
   K_208           : aliased constant String := "ceylon";
   M_208           : aliased constant String := "Ceylon";
   K_209           : aliased constant String := "bsdmake";
   M_209           : aliased constant String := "Makefile";
   K_210           : aliased constant String := "sml";
   M_210           : aliased constant String := "Standard ML";
   K_211           : aliased constant String := "xsl";
   M_211           : aliased constant String := "XSLT";
   K_212           : aliased constant String := "modula-2";
   M_212           : aliased constant String := "Modula-2";
   K_213           : aliased constant String := "clarity";
   M_213           : aliased constant String := "Clarity";
   K_214           : aliased constant String := "modula-3";
   M_214           : aliased constant String := "Modula-3";
   K_215           : aliased constant String := "x bitmap";
   M_215           : aliased constant String := "X BitMap";
   K_216           : aliased constant String := "rust";
   M_216           : aliased constant String := "Rust";
   K_217           : aliased constant String := "smt";
   M_217           : aliased constant String := "SMT";
   K_218           : aliased constant String := "rmarkdown";
   M_218           : aliased constant String := "RMarkdown";
   K_219           : aliased constant String := "limbo";
   M_219           : aliased constant String := "Limbo";
   K_220           : aliased constant String := "ur/web";
   M_220           : aliased constant String := "UrWeb";
   K_221           : aliased constant String := "muf";
   M_221           : aliased constant String := "MUF";
   K_222           : aliased constant String := "cadence";
   M_222           : aliased constant String := "Cadence";
   K_223           : aliased constant String := "smithy";
   M_223           : aliased constant String := "Smithy";
   K_224           : aliased constant String := "cil";
   M_224           : aliased constant String := "CIL";
   K_225           : aliased constant String := "toit";
   M_225           : aliased constant String := "Toit";
   K_226           : aliased constant String := "svelte";
   M_226           : aliased constant String := "Svelte";
   K_227           : aliased constant String := "plantuml";
   M_227           : aliased constant String := "PlantUML";
   K_228           : aliased constant String := "webassembly";
   M_228           : aliased constant String := "WebAssembly";
   K_229           : aliased constant String := "supercollider";
   M_229           : aliased constant String := "SuperCollider";
   K_230           : aliased constant String := "workflow description language";
   M_230           : aliased constant String := "WDL";
   K_231           : aliased constant String := "fennel";
   M_231           : aliased constant String := "Fennel";
   K_232           : aliased constant String := "standard ml";
   M_232           : aliased constant String := "Standard ML";
   K_233           : aliased constant String := "futhark";
   M_233           : aliased constant String := "Futhark";
   K_234           : aliased constant String := "visual basic classic";
   M_234           : aliased constant String := "Visual Basic 6.0";
   K_235           : aliased constant String := "geojson";
   M_235           : aliased constant String := "JSON";
   K_236           : aliased constant String := "asciidoc";
   M_236           : aliased constant String := "AsciiDoc";
   K_237           : aliased constant String := "clojure";
   M_237           : aliased constant String := "Clojure";
   K_238           : aliased constant String := "golang";
   M_238           : aliased constant String := "Go";
   K_239           : aliased constant String := "coldfusion";
   M_239           : aliased constant String := "ColdFusion";
   K_240           : aliased constant String := "ur";
   M_240           : aliased constant String := "UrWeb";
   K_241           : aliased constant String := "berry";
   M_241           : aliased constant String := "Berry";
   K_242           : aliased constant String := "scilab";
   M_242           : aliased constant String := "Scilab";
   K_243           : aliased constant String := "g-code";
   M_243           : aliased constant String := "G-code";
   K_244           : aliased constant String := "bluespec bh";
   M_244           : aliased constant String := "Bluespec BH";
   K_245           : aliased constant String := "shell-script";
   M_245           : aliased constant String := "Shell";
   K_246           : aliased constant String := "nim";
   M_246           : aliased constant String := "Nim";
   K_247           : aliased constant String := "mail";
   M_247           : aliased constant String := "E-mail";
   K_248           : aliased constant String := "eiffel";
   M_248           : aliased constant String := "Eiffel";
   K_249           : aliased constant String := "clipper";
   M_249           : aliased constant String := "xBase";
   K_250           : aliased constant String := "nit";
   M_250           : aliased constant String := "Nit";
   K_251           : aliased constant String := "coldfusion html";
   M_251           : aliased constant String := "ColdFusion";
   K_252           : aliased constant String := "dylan";
   M_252           : aliased constant String := "Dylan";
   K_253           : aliased constant String := "openqasm";
   M_253           : aliased constant String := "OpenQASM";
   K_254           : aliased constant String := "1c enterprise";
   M_254           : aliased constant String := "1C Enterprise";
   K_255           : aliased constant String := "nix";
   M_255           : aliased constant String := "Nix";
   K_256           : aliased constant String := "soy";
   M_256           : aliased constant String := "Closure Templates";
   K_257           : aliased constant String := "pikchr";
   M_257           : aliased constant String := "Pic";
   K_258           : aliased constant String := "gnu asm";
   M_258           : aliased constant String := "Unix Assembly";
   K_259           : aliased constant String := "html";
   M_259           : aliased constant String := "HTML";
   K_260           : aliased constant String := "x10";
   M_260           : aliased constant String := "X10";
   K_261           : aliased constant String := "handlebars";
   M_261           : aliased constant String := "Handlebars";
   K_262           : aliased constant String := "gitattributes";
   M_262           : aliased constant String := "Git Attributes";
   K_263           : aliased constant String := "tcl";
   M_263           : aliased constant String := "Tcl";
   K_264           : aliased constant String := "abl";
   M_264           : aliased constant String := "OpenEdge ABL";
   K_265           : aliased constant String := "wl";
   M_265           : aliased constant String := "Mathematica";
   K_266           : aliased constant String := "vb .net";
   M_266           : aliased constant String := "Visual Basic .NET";
   K_267           : aliased constant String := "objdump";
   M_267           : aliased constant String := "ObjDump";
   K_268           : aliased constant String := "make";
   M_268           : aliased constant String := "Makefile";
   K_269           : aliased constant String := "sqf";
   M_269           : aliased constant String := "SQF";
   K_270           : aliased constant String := "cabal config";
   M_270           : aliased constant String := "Cabal Config";
   K_271           : aliased constant String := "nushell-script";
   M_271           : aliased constant String := "Nushell";
   K_272           : aliased constant String := "alloy";
   M_272           : aliased constant String := "Alloy";
   K_273           : aliased constant String := "sql";
   M_273           : aliased constant String := "SQL";
   K_274           : aliased constant String := "afdko";
   M_274           : aliased constant String := "OpenType Feature File";
   K_275           : aliased constant String := "byond";
   M_275           : aliased constant String := "DM";
   K_276           : aliased constant String := "mako";
   M_276           : aliased constant String := "Mako";
   K_277           : aliased constant String := "aconf";
   M_277           : aliased constant String := "ApacheConf";
   K_278           : aliased constant String := "idris";
   M_278           : aliased constant String := "Idris";
   K_279           : aliased constant String := "slash";
   M_279           : aliased constant String := "Slash";
   K_280           : aliased constant String := "ti program";
   M_280           : aliased constant String := "TI Program";
   K_281           : aliased constant String := "toml";
   M_281           : aliased constant String := "TOML";
   K_282           : aliased constant String := "gitconfig";
   M_282           : aliased constant String := "Git Config";
   K_283           : aliased constant String := "sway";
   M_283           : aliased constant String := "Sway";
   K_284           : aliased constant String := "tea";
   M_284           : aliased constant String := "Tea";
   K_285           : aliased constant String := "ada";
   M_285           : aliased constant String := "Ada";
   K_286           : aliased constant String := "pov-ray sdl";
   M_286           : aliased constant String := "POV-Ray SDL";
   K_287           : aliased constant String := "adb";
   M_287           : aliased constant String := "Adblock Filter List";
   K_288           : aliased constant String := "povray";
   M_288           : aliased constant String := "POV-Ray SDL";
   K_289           : aliased constant String := "coldfusion cfc";
   M_289           : aliased constant String := "ColdFusion CFC";
   K_290           : aliased constant String := "dosbatch";
   M_290           : aliased constant String := "Batchfile";
   K_291           : aliased constant String := "perl-6";
   M_291           : aliased constant String := "Raku";
   K_292           : aliased constant String := "b3d";
   M_292           : aliased constant String := "BlitzBasic";
   K_293           : aliased constant String := "cakescript";
   M_293           : aliased constant String := "C#";
   K_294           : aliased constant String := "holyc";
   M_294           : aliased constant String := "HolyC";
   K_295           : aliased constant String := "curl config";
   M_295           : aliased constant String := "cURL Config";
   K_296           : aliased constant String := "pike";
   M_296           : aliased constant String := "Pike";
   K_297           : aliased constant String := "open policy agent";
   M_297           : aliased constant String := "Open Policy Agent";
   K_298           : aliased constant String := "xtend";
   M_298           : aliased constant String := "Xtend";
   K_299           : aliased constant String := "opentype feature file";
   M_299           : aliased constant String := "OpenType Feature File";
   K_300           : aliased constant String := "velocity template language";
   M_300           : aliased constant String := "Velocity Template Language";
   K_301           : aliased constant String := "kicad schematic";
   M_301           : aliased constant String := "KiCad Schematic";
   K_302           : aliased constant String := "tex";
   M_302           : aliased constant String := "TeX";
   K_303           : aliased constant String := "valve data format";
   M_303           : aliased constant String := "Valve Data Format";
   K_304           : aliased constant String := "go.work.sum";
   M_304           : aliased constant String := "Go Checksums";
   K_305           : aliased constant String := "webassembly interface type";
   M_305           : aliased constant String := "WebAssembly Interface Type";
   K_306           : aliased constant String := "kotlin";
   M_306           : aliased constant String := "Kotlin";
   K_307           : aliased constant String := "wsdl";
   M_307           : aliased constant String := "XML";
   K_308           : aliased constant String := "snakefile";
   M_308           : aliased constant String := "Snakemake";
   K_309           : aliased constant String := "public key";
   M_309           : aliased constant String := "Public Key";
   K_310           : aliased constant String := "jinja";
   M_310           : aliased constant String := "Jinja";
   K_311           : aliased constant String := "prisma";
   M_311           : aliased constant String := "Prisma";
   K_312           : aliased constant String := "parrot";
   M_312           : aliased constant String := "Parrot";
   K_313           : aliased constant String := "bplus";
   M_313           : aliased constant String := "BlitzBasic";
   K_314           : aliased constant String := "visual basic .net";
   M_314           : aliased constant String := "Visual Basic .NET";
   K_315           : aliased constant String := "smarty";
   M_315           : aliased constant String := "Smarty";
   K_316           : aliased constant String := "coq";
   M_316           : aliased constant String := "Coq";
   K_317           : aliased constant String := "boogie";
   M_317           : aliased constant String := "Boogie";
   K_318           : aliased constant String := "bash session";
   M_318           : aliased constant String := "ShellSession";
   K_319           : aliased constant String := "sage";
   M_319           : aliased constant String := "Sage";
   K_320           : aliased constant String := "cloud firestore security rules";
   M_320           : aliased constant String := "Cloud Firestore Security Rules";
   K_321           : aliased constant String := "edje data collection";
   M_321           : aliased constant String := "Edje Data Collection";
   K_322           : aliased constant String := "yml";
   M_322           : aliased constant String := "YAML";
   K_323           : aliased constant String := "mql4";
   M_323           : aliased constant String := "MQL4";
   K_324           : aliased constant String := "krl";
   M_324           : aliased constant String := "KRL";
   K_325           : aliased constant String := "objectscript";
   M_325           : aliased constant String := "ObjectScript";
   K_326           : aliased constant String := "mql5";
   M_326           : aliased constant String := "MQL5";
   K_327           : aliased constant String := "c++";
   M_327           : aliased constant String := "C++";
   K_328           : aliased constant String := "charity";
   M_328           : aliased constant String := "Charity";
   K_329           : aliased constant String := "browserslist";
   M_329           : aliased constant String := "Browserslist";
   K_330           : aliased constant String := "nearley";
   M_330           : aliased constant String := "Nearley";
   K_331           : aliased constant String := "alpine abuild";
   M_331           : aliased constant String := "Alpine Abuild";
   K_332           : aliased constant String := "denizenscript";
   M_332           : aliased constant String := "DenizenScript";
   K_333           : aliased constant String := "nasl";
   M_333           : aliased constant String := "NASL";
   K_334           : aliased constant String := "wdl";
   M_334           : aliased constant String := "WDL";
   K_335           : aliased constant String := "nasm";
   M_335           : aliased constant String := "Assembly";
   K_336           : aliased constant String := "modelica";
   M_336           : aliased constant String := "Modelica";
   K_337           : aliased constant String := "markdown";
   M_337           : aliased constant String := "Markdown";
   K_338           : aliased constant String := "dcl";
   M_338           : aliased constant String := "DIGITAL Command Language";
   K_339           : aliased constant String := "cmake";
   M_339           : aliased constant String := "CMake";
   K_340           : aliased constant String := "euphoria";
   M_340           : aliased constant String := "Euphoria";
   K_341           : aliased constant String := "sum";
   M_341           : aliased constant String := "Checksums";
   K_342           : aliased constant String := "gitignore";
   M_342           : aliased constant String := "Ignore List";
   K_343           : aliased constant String := "xproc";
   M_343           : aliased constant String := "XProc";
   K_344           : aliased constant String := "procfile";
   M_344           : aliased constant String := "Procfile";
   K_345           : aliased constant String := "lfe";
   M_345           : aliased constant String := "LFE";
   K_346           : aliased constant String := "raw token data";
   M_346           : aliased constant String := "Raw token data";
   K_347           : aliased constant String := "zap";
   M_347           : aliased constant String := "ZAP";
   K_348           : aliased constant String := "gemfile.lock";
   M_348           : aliased constant String := "Gemfile.lock";
   K_349           : aliased constant String := "lean 4";
   M_349           : aliased constant String := "Lean 4";
   K_350           : aliased constant String := "bmax";
   M_350           : aliased constant String := "BlitzMax";
   K_351           : aliased constant String := "ninja";
   M_351           : aliased constant String := "Ninja";
   K_352           : aliased constant String := "ahk";
   M_352           : aliased constant String := "AutoHotkey";
   K_353           : aliased constant String := "racket";
   M_353           : aliased constant String := "Racket";
   K_354           : aliased constant String := "pogoscript";
   M_354           : aliased constant String := "PogoScript";
   K_355           : aliased constant String := "fundamental";
   M_355           : aliased constant String := "Text";
   K_356           : aliased constant String := "vim help file";
   M_356           : aliased constant String := "Vim Help File";
   K_357           : aliased constant String := "bitbake";
   M_357           : aliased constant String := "BitBake";
   K_358           : aliased constant String := "xonsh";
   M_358           : aliased constant String := "Xonsh";
   K_359           : aliased constant String := "quake";
   M_359           : aliased constant String := "Quake";
   K_360           : aliased constant String := "go workspace";
   M_360           : aliased constant String := "Go Workspace";
   K_361           : aliased constant String := "ignore";
   M_361           : aliased constant String := "Ignore List";
   K_362           : aliased constant String := "apacheconf";
   M_362           : aliased constant String := "ApacheConf";
   K_363           : aliased constant String := "godot resource";
   M_363           : aliased constant String := "Godot Resource";
   K_364           : aliased constant String := "x pixmap";
   M_364           : aliased constant String := "X PixMap";
   K_365           : aliased constant String := "adobe font metrics";
   M_365           : aliased constant String := "Adobe Font Metrics";
   K_366           : aliased constant String := "go checksums";
   M_366           : aliased constant String := "Go Checksums";
   K_367           : aliased constant String := "mirah";
   M_367           : aliased constant String := "Mirah";
   K_368           : aliased constant String := "batchfile";
   M_368           : aliased constant String := "Batchfile";
   K_369           : aliased constant String := "zimpl";
   M_369           : aliased constant String := "Zimpl";
   K_370           : aliased constant String := "literate agda";
   M_370           : aliased constant String := "Literate Agda";
   K_371           : aliased constant String := "man page";
   M_371           : aliased constant String := "Roff";
   K_372           : aliased constant String := "xslt";
   M_372           : aliased constant String := "XSLT";
   K_373           : aliased constant String := "go.work";
   M_373           : aliased constant String := "Go Workspace";
   K_374           : aliased constant String := "vtl";
   M_374           : aliased constant String := "Velocity Template Language";
   K_375           : aliased constant String := "julia";
   M_375           : aliased constant String := "Julia";
   K_376           : aliased constant String := "kerboscript";
   M_376           : aliased constant String := "KerboScript";
   K_377           : aliased constant String := "slim";
   M_377           : aliased constant String := "Slim";
   K_378           : aliased constant String := "stla";
   M_378           : aliased constant String := "STL";
   K_379           : aliased constant String := "lhs";
   M_379           : aliased constant String := "Literate Haskell";
   K_380           : aliased constant String := "go work sum";
   M_380           : aliased constant String := "Go Checksums";
   K_381           : aliased constant String := "jetbrains mps";
   M_381           : aliased constant String := "JetBrains MPS";
   K_382           : aliased constant String := "actionscript 3";
   M_382           : aliased constant String := "ActionScript";
   K_383           : aliased constant String := "vtt";
   M_383           : aliased constant String := "WebVTT";
   K_384           : aliased constant String := "css";
   M_384           : aliased constant String := "CSS";
   K_385           : aliased constant String := "puppet";
   M_385           : aliased constant String := "Puppet";
   K_386           : aliased constant String := "csv";
   M_386           : aliased constant String := "CSV";
   K_387           : aliased constant String := "reason";
   M_387           : aliased constant String := "Reason";
   K_388           : aliased constant String := "glimmer js";
   M_388           : aliased constant String := "Glimmer JS";
   K_389           : aliased constant String := "abuild";
   M_389           : aliased constant String := "Alpine Abuild";
   K_390           : aliased constant String := "earthfile";
   M_390           : aliased constant String := "Earthly";
   K_391           : aliased constant String := "ada95";
   M_391           : aliased constant String := "Ada";
   K_392           : aliased constant String := "html+razor";
   M_392           : aliased constant String := "HTML+Razor";
   K_393           : aliased constant String := "linker script";
   M_393           : aliased constant String := "Linker Script";
   K_394           : aliased constant String := "go.mod";
   M_394           : aliased constant String := "Go Module";
   K_395           : aliased constant String := "squirrel";
   M_395           : aliased constant String := "Squirrel";
   K_396           : aliased constant String := "swig";
   M_396           : aliased constant String := "SWIG";
   K_397           : aliased constant String := "click";
   M_397           : aliased constant String := "Click";
   K_398           : aliased constant String := "typst";
   M_398           : aliased constant String := "Typst";
   K_399           : aliased constant String := "volt";
   M_399           : aliased constant String := "Volt";
   K_400           : aliased constant String := "readline config";
   M_400           : aliased constant String := "Readline Config";
   K_401           : aliased constant String := "abap";
   M_401           : aliased constant String := "ABAP";
   K_402           : aliased constant String := "lassoscript";
   M_402           : aliased constant String := "Lasso";
   K_403           : aliased constant String := "gentoo eclass";
   M_403           : aliased constant String := "Gentoo Eclass";
   K_404           : aliased constant String := "bluespec bsv";
   M_404           : aliased constant String := "Bluespec";
   K_405           : aliased constant String := "mask";
   M_405           : aliased constant String := "Mask";
   K_406           : aliased constant String := "yang";
   M_406           : aliased constant String := "YANG";
   K_407           : aliased constant String := "gdb";
   M_407           : aliased constant String := "GDB";
   K_408           : aliased constant String := "rbs";
   M_408           : aliased constant String := "RBS";
   K_409           : aliased constant String := "markojs";
   M_409           : aliased constant String := "Marko";
   K_410           : aliased constant String := "wolfram lang";
   M_410           : aliased constant String := "Mathematica";
   K_411           : aliased constant String := "rbx";
   M_411           : aliased constant String := "Ruby";
   K_412           : aliased constant String := "rscript";
   M_412           : aliased constant String := "R";
   K_413           : aliased constant String := "cue";
   M_413           : aliased constant String := "CUE";
   K_414           : aliased constant String := "microsoft visual studio solution";
   M_414           : aliased constant String := "Microsoft Visual Studio Solution";
   K_415           : aliased constant String := "assembly";
   M_415           : aliased constant String := "Assembly";
   K_416           : aliased constant String := "texinfo";
   M_416           : aliased constant String := "Texinfo";
   K_417           : aliased constant String := "grammatical framework";
   M_417           : aliased constant String := "Grammatical Framework";
   K_418           : aliased constant String := "macaulay2";
   M_418           : aliased constant String := "Macaulay2";
   K_419           : aliased constant String := "option list";
   M_419           : aliased constant String := "Option List";
   K_420           : aliased constant String := "manpage";
   M_420           : aliased constant String := "Roff";
   K_421           : aliased constant String := "mediawiki";
   M_421           : aliased constant String := "Wikitext";
   K_422           : aliased constant String := "xml property list";
   M_422           : aliased constant String := "XML Property List";
   K_423           : aliased constant String := "antlers";
   M_423           : aliased constant String := "Antlers";
   K_424           : aliased constant String := "edgeql";
   M_424           : aliased constant String := "EdgeQL";
   K_425           : aliased constant String := "heex";
   M_425           : aliased constant String := "HTML+EEX";
   K_426           : aliased constant String := "rich text format";
   M_426           : aliased constant String := "Rich Text Format";
   K_427           : aliased constant String := "isabelle root";
   M_427           : aliased constant String := "Isabelle ROOT";
   K_428           : aliased constant String := "kicad legacy layout";
   M_428           : aliased constant String := "KiCad Legacy Layout";
   K_429           : aliased constant String := "creole";
   M_429           : aliased constant String := "Creole";
   K_430           : aliased constant String := "neosnippet";
   M_430           : aliased constant String := "Vim Snippet";
   K_431           : aliased constant String := "visual basic for applications";
   M_431           : aliased constant String := "VBA";
   K_432           : aliased constant String := "terraform";
   M_432           : aliased constant String := "HCL";
   K_433           : aliased constant String := "kusto";
   M_433           : aliased constant String := "Kusto";
   K_434           : aliased constant String := "html+ecr";
   M_434           : aliased constant String := "HTML+ECR";
   K_435           : aliased constant String := "maven pom";
   M_435           : aliased constant String := "Maven POM";
   K_436           : aliased constant String := "grace";
   M_436           : aliased constant String := "Grace";
   K_437           : aliased constant String := "pure data";
   M_437           : aliased constant String := "Pure Data";
   K_438           : aliased constant String := "coffeescript";
   M_438           : aliased constant String := "CoffeeScript";
   K_439           : aliased constant String := "oasv2";
   M_439           : aliased constant String := "OpenAPI Specification v2";
   K_440           : aliased constant String := "mercury";
   M_440           : aliased constant String := "Mercury";
   K_441           : aliased constant String := "oasv3";
   M_441           : aliased constant String := "OpenAPI Specification v3";
   K_442           : aliased constant String := "mtml";
   M_442           : aliased constant String := "MTML";
   K_443           : aliased constant String := "justfile";
   M_443           : aliased constant String := "Just";
   K_444           : aliased constant String := "text proto";
   M_444           : aliased constant String := "Protocol Buffer Text Format";
   K_445           : aliased constant String := "haxe";
   M_445           : aliased constant String := "Haxe";
   K_446           : aliased constant String := "cwl";
   M_446           : aliased constant String := "Common Workflow Language";
   K_447           : aliased constant String := "c2hs";
   M_447           : aliased constant String := "C2hs Haskell";
   K_448           : aliased constant String := "robots";
   M_448           : aliased constant String := "robots.txt";
   K_449           : aliased constant String := "emacs";
   M_449           : aliased constant String := "Emacs Lisp";
   K_450           : aliased constant String := "gemtext";
   M_450           : aliased constant String := "Gemini";
   K_451           : aliased constant String := "ad block filters";
   M_451           : aliased constant String := "Adblock Filter List";
   K_452           : aliased constant String := "jcl";
   M_452           : aliased constant String := "JCL";
   K_453           : aliased constant String := "gradle";
   M_453           : aliased constant String := "Gradle";
   K_454           : aliased constant String := "yul";
   M_454           : aliased constant String := "Yul";
   K_455           : aliased constant String := "ftl";
   M_455           : aliased constant String := "FreeMarker";
   K_456           : aliased constant String := "roff";
   M_456           : aliased constant String := "Roff";
   K_457           : aliased constant String := "portugol";
   M_457           : aliased constant String := "Portugol";
   K_458           : aliased constant String := "rake";
   M_458           : aliased constant String := "Ruby";
   K_459           : aliased constant String := "emacs muse";
   M_459           : aliased constant String := "Muse";
   K_460           : aliased constant String := "chpl";
   M_460           : aliased constant String := "Chapel";
   K_461           : aliased constant String := "blitzmax";
   M_461           : aliased constant String := "BlitzMax";
   K_462           : aliased constant String := "yara";
   M_462           : aliased constant String := "YARA";
   K_463           : aliased constant String := "csound score";
   M_463           : aliased constant String := "Csound Score";
   K_464           : aliased constant String := "fantom";
   M_464           : aliased constant String := "Fantom";
   K_465           : aliased constant String := "cabal";
   M_465           : aliased constant String := "Cabal Config";
   K_466           : aliased constant String := "mermaid";
   M_466           : aliased constant String := "Mermaid";
   K_467           : aliased constant String := "graph modeling language";
   M_467           : aliased constant String := "Graph Modeling Language";
   K_468           : aliased constant String := "wolfram language";
   M_468           : aliased constant String := "Mathematica";
   K_469           : aliased constant String := "flex";
   M_469           : aliased constant String := "Lex";
   K_470           : aliased constant String := "java server page";
   M_470           : aliased constant String := "Groovy Server Pages";
   K_471           : aliased constant String := "zig";
   M_471           : aliased constant String := "Zig";
   K_472           : aliased constant String := "raku";
   M_472           : aliased constant String := "Raku";
   K_473           : aliased constant String := "ring";
   M_473           : aliased constant String := "Ring";
   K_474           : aliased constant String := "unix asm";
   M_474           : aliased constant String := "Unix Assembly";
   K_475           : aliased constant String := "zil";
   M_475           : aliased constant String := "ZIL";
   K_476           : aliased constant String := "pip requirements";
   M_476           : aliased constant String := "Pip Requirements";
   K_477           : aliased constant String := "promela";
   M_477           : aliased constant String := "Promela";
   K_478           : aliased constant String := "html+eex";
   M_478           : aliased constant String := "HTML+EEX";
   K_479           : aliased constant String := "aspx-vb";
   M_479           : aliased constant String := "ASP.NET";
   K_480           : aliased constant String := "hiveql";
   M_480           : aliased constant String := "HiveQL";
   K_481           : aliased constant String := "oasv3-json";
   M_481           : aliased constant String := "OASv3-json";
   K_482           : aliased constant String := "object data instance notation";
   M_482           : aliased constant String := "Object Data Instance Notation";
   K_483           : aliased constant String := "api blueprint";
   M_483           : aliased constant String := "API Blueprint";
   K_484           : aliased constant String := "ragel";
   M_484           : aliased constant String := "Ragel";
   K_485           : aliased constant String := "ltspice symbol";
   M_485           : aliased constant String := "LTspice Symbol";
   K_486           : aliased constant String := "simple file verification";
   M_486           : aliased constant String := "Simple File Verification";
   K_487           : aliased constant String := "apl";
   M_487           : aliased constant String := "APL";
   K_488           : aliased constant String := "elixir";
   M_488           : aliased constant String := "Elixir";
   K_489           : aliased constant String := "mirc script";
   M_489           : aliased constant String := "mIRC Script";
   K_490           : aliased constant String := "cairo";
   M_490           : aliased constant String := "Cairo";
   K_491           : aliased constant String := "d2";
   M_491           : aliased constant String := "D2";
   K_492           : aliased constant String := "crystal";
   M_492           : aliased constant String := "Crystal";
   K_493           : aliased constant String := "raml";
   M_493           : aliased constant String := "RAML";
   K_494           : aliased constant String := "go module";
   M_494           : aliased constant String := "Go Module";
   K_495           : aliased constant String := "ragel-ruby";
   M_495           : aliased constant String := "Ragel";
   K_496           : aliased constant String := "be";
   M_496           : aliased constant String := "Berry";
   K_497           : aliased constant String := "javascript";
   M_497           : aliased constant String := "JavaScript";
   K_498           : aliased constant String := "osascript";
   M_498           : aliased constant String := "AppleScript";
   K_499           : aliased constant String := "bh";
   M_499           : aliased constant String := "Bluespec BH";
   K_500           : aliased constant String := "frege";
   M_500           : aliased constant String := "Frege";
   K_501           : aliased constant String := "jupyter notebook";
   M_501           : aliased constant String := "Jupyter Notebook";
   K_502           : aliased constant String := "proguard";
   M_502           : aliased constant String := "Proguard";
   K_503           : aliased constant String := "altium designer";
   M_503           : aliased constant String := "Altium Designer";
   K_504           : aliased constant String := "collada";
   M_504           : aliased constant String := "COLLADA";
   K_505           : aliased constant String := "systemverilog";
   M_505           : aliased constant String := "SystemVerilog";
   K_506           : aliased constant String := "faust";
   M_506           : aliased constant String := "Faust";
   K_507           : aliased constant String := "arc";
   M_507           : aliased constant String := "Arc";
   K_508           : aliased constant String := "f#";
   M_508           : aliased constant String := "F#";
   K_509           : aliased constant String := "xbm";
   M_509           : aliased constant String := "X BitMap";
   K_510           : aliased constant String := "containerfile";
   M_510           : aliased constant String := "Dockerfile";
   K_511           : aliased constant String := "f*";
   M_511           : aliased constant String := "F*";
   K_512           : aliased constant String := "lookml";
   M_512           : aliased constant String := "LookML";
   K_513           : aliased constant String := "ruby";
   M_513           : aliased constant String := "Ruby";
   K_514           : aliased constant String := "keyvalues";
   M_514           : aliased constant String := "Valve Data Format";
   K_515           : aliased constant String := "dart";
   M_515           : aliased constant String := "Dart";
   K_516           : aliased constant String := "gosu";
   M_516           : aliased constant String := "Gosu";
   K_517           : aliased constant String := "cap cds";
   M_517           : aliased constant String := "CAP CDS";
   K_518           : aliased constant String := "c2hs haskell";
   M_518           : aliased constant String := "C2hs Haskell";
   K_519           : aliased constant String := "tsv";
   M_519           : aliased constant String := "TSV";
   K_520           : aliased constant String := "nsis";
   M_520           : aliased constant String := "NSIS";
   K_521           : aliased constant String := "csound-csd";
   M_521           : aliased constant String := "Csound Document";
   K_522           : aliased constant String := "tsx";
   M_522           : aliased constant String := "TSX";
   K_523           : aliased constant String := "maxmsp";
   M_523           : aliased constant String := "Max";
   K_524           : aliased constant String := "sass";
   M_524           : aliased constant String := "Sass";
   K_525           : aliased constant String := "javascript+erb";
   M_525           : aliased constant String := "JavaScript+ERB";
   K_526           : aliased constant String := "nroff";
   M_526           : aliased constant String := "Roff";
   K_527           : aliased constant String := "cython";
   M_527           : aliased constant String := "Cython";
   K_528           : aliased constant String := "inform7";
   M_528           : aliased constant String := "Inform 7";
   K_529           : aliased constant String := "mdx";
   M_529           : aliased constant String := "MDX";
   K_530           : aliased constant String := "dm";
   M_530           : aliased constant String := "DM";
   K_531           : aliased constant String := "pan";
   M_531           : aliased constant String := "Pan";
   K_532           : aliased constant String := "posh";
   M_532           : aliased constant String := "PowerShell";
   K_533           : aliased constant String := "nushell";
   M_533           : aliased constant String := "Nushell";
   K_534           : aliased constant String := "netlogo";
   M_534           : aliased constant String := "NetLogo";
   K_535           : aliased constant String := "xdc";
   M_535           : aliased constant String := "Tcl";
   K_536           : aliased constant String := "hocon";
   M_536           : aliased constant String := "HOCON";
   K_537           : aliased constant String := "type language";
   M_537           : aliased constant String := "Type Language";
   K_538           : aliased constant String := "email";
   M_538           : aliased constant String := "E-mail";
   K_539           : aliased constant String := "newlisp";
   M_539           : aliased constant String := "NewLisp";
   K_540           : aliased constant String := "mdoc";
   M_540           : aliased constant String := "Roff";
   K_541           : aliased constant String := "logtalk";
   M_541           : aliased constant String := "Logtalk";
   K_542           : aliased constant String := "apache";
   M_542           : aliased constant String := "ApacheConf";
   K_543           : aliased constant String := "amusewiki";
   M_543           : aliased constant String := "Muse";
   K_544           : aliased constant String := "ecl";
   M_544           : aliased constant String := "ECL";
   K_545           : aliased constant String := "cap'n proto";
   M_545           : aliased constant String := "Cap'n Proto";
   K_546           : aliased constant String := "xdr";
   M_546           : aliased constant String := "RPC";
   K_547           : aliased constant String := "world of warcraft addon data";
   M_547           : aliased constant String := "World of Warcraft Addon Data";
   K_548           : aliased constant String := "ecr";
   M_548           : aliased constant String := "HTML+ECR";
   K_549           : aliased constant String := "glimmer ts";
   M_549           : aliased constant String := "Glimmer TS";
   K_550           : aliased constant String := "foxpro";
   M_550           : aliased constant String := "xBase";
   K_551           : aliased constant String := "jruby";
   M_551           : aliased constant String := "Ruby";
   K_552           : aliased constant String := "pyret";
   M_552           : aliased constant String := "Pyret";
   K_553           : aliased constant String := "ats";
   M_553           : aliased constant String := "ATS";
   K_554           : aliased constant String := "slice";
   M_554           : aliased constant String := "Slice";
   K_555           : aliased constant String := "pyrex";
   M_555           : aliased constant String := "Cython";
   K_556           : aliased constant String := "fb";
   M_556           : aliased constant String := "FreeBasic";
   K_557           : aliased constant String := "autohotkey";
   M_557           : aliased constant String := "AutoHotkey";
   K_558           : aliased constant String := "groff";
   M_558           : aliased constant String := "Roff";
   K_559           : aliased constant String := "cweb";
   M_559           : aliased constant String := "CWeb";
   K_560           : aliased constant String := "cfml";
   M_560           : aliased constant String := "ColdFusion";
   K_561           : aliased constant String := "augeas";
   M_561           : aliased constant String := "Augeas";
   K_562           : aliased constant String := "yasnippet";
   M_562           : aliased constant String := "YASnippet";
   K_563           : aliased constant String := "prolog";
   M_563           : aliased constant String := "Prolog";
   K_564           : aliased constant String := "coffee";
   M_564           : aliased constant String := "CoffeeScript";
   K_565           : aliased constant String := "parrot internal representation";
   M_565           : aliased constant String := "Parrot Internal Representation";
   K_566           : aliased constant String := "openapi specification v2";
   M_566           : aliased constant String := "OpenAPI Specification v2";
   K_567           : aliased constant String := "advpl";
   M_567           : aliased constant String := "xBase";
   K_568           : aliased constant String := "openapi specification v3";
   M_568           : aliased constant String := "OpenAPI Specification v3";
   K_569           : aliased constant String := "java properties";
   M_569           : aliased constant String := "Java Properties";
   K_570           : aliased constant String := "hashicorp configuration language";
   M_570           : aliased constant String := "HCL";
   K_571           : aliased constant String := "gdscript";
   M_571           : aliased constant String := "GDScript";
   K_572           : aliased constant String := "realbasic";
   M_572           : aliased constant String := "REALbasic";
   K_573           : aliased constant String := "harbour";
   M_573           : aliased constant String := "Harbour";
   K_574           : aliased constant String := "protocol buffer text format";
   M_574           : aliased constant String := "Protocol Buffer Text Format";
   K_575           : aliased constant String := "bibtex";
   M_575           : aliased constant String := "BibTeX";
   K_576           : aliased constant String := "abap cds";
   M_576           : aliased constant String := "ABAP CDS";
   K_577           : aliased constant String := "eex";
   M_577           : aliased constant String := "HTML+EEX";
   K_578           : aliased constant String := "kakscript";
   M_578           : aliased constant String := "KakouneScript";
   K_579           : aliased constant String := "ada2005";
   M_579           : aliased constant String := "Ada";
   K_580           : aliased constant String := "lisp";
   M_580           : aliased constant String := "Common Lisp";
   K_581           : aliased constant String := "editor-config";
   M_581           : aliased constant String := "EditorConfig";
   K_582           : aliased constant String := "hbs";
   M_582           : aliased constant String := "Handlebars";
   K_583           : aliased constant String := "monkey";
   M_583           : aliased constant String := "Monkey";
   K_584           : aliased constant String := "htmlbars";
   M_584           : aliased constant String := "Handlebars";
   K_585           : aliased constant String := "gitmodules";
   M_585           : aliased constant String := "Git Config";
   K_586           : aliased constant String := "moocode";
   M_586           : aliased constant String := "Moocode";
   K_587           : aliased constant String := "purebasic";
   M_587           : aliased constant String := "PureBasic";
   K_588           : aliased constant String := "pov-ray";
   M_588           : aliased constant String := "POV-Ray SDL";
   K_589           : aliased constant String := "spline font database";
   M_589           : aliased constant String := "Spline Font Database";
   K_590           : aliased constant String := "shell";
   M_590           : aliased constant String := "Shell";
   K_591           : aliased constant String := "zephir";
   M_591           : aliased constant String := "Zephir";
   K_592           : aliased constant String := "miniyaml";
   M_592           : aliased constant String := "MiniYAML";
   K_593           : aliased constant String := "xml+genshi";
   M_593           : aliased constant String := "Genshi";
   K_594           : aliased constant String := "dataweave";
   M_594           : aliased constant String := "DataWeave";
   K_595           : aliased constant String := "nasal";
   M_595           : aliased constant String := "Nasal";
   K_596           : aliased constant String := "lean";
   M_596           : aliased constant String := "Lean";
   K_597           : aliased constant String := "hy";
   M_597           : aliased constant String := "Hy";
   K_598           : aliased constant String := "jar manifest";
   M_598           : aliased constant String := "JAR Manifest";
   K_599           : aliased constant String := "lark";
   M_599           : aliased constant String := "Lark";
   K_600           : aliased constant String := "sourcepawn";
   M_600           : aliased constant String := "SourcePawn";
   K_601           : aliased constant String := "git-ignore";
   M_601           : aliased constant String := "Ignore List";
   K_602           : aliased constant String := "man-page";
   M_602           : aliased constant String := "Roff";
   K_603           : aliased constant String := "praat";
   M_603           : aliased constant String := "Praat";
   K_604           : aliased constant String := "ipython notebook";
   M_604           : aliased constant String := "Jupyter Notebook";
   K_605           : aliased constant String := "stylus";
   M_605           : aliased constant String := "Stylus";
   K_606           : aliased constant String := "rpc";
   M_606           : aliased constant String := "RPC";
   K_607           : aliased constant String := "typ";
   M_607           : aliased constant String := "Typst";
   K_608           : aliased constant String := "go.sum";
   M_608           : aliased constant String := "Go Checksums";
   K_609           : aliased constant String := "gcc machine description";
   M_609           : aliased constant String := "GCC Machine Description";
   K_610           : aliased constant String := "blitzbasic";
   M_610           : aliased constant String := "BlitzBasic";
   K_611           : aliased constant String := "module management system";
   M_611           : aliased constant String := "Module Management System";
   K_612           : aliased constant String := "wget config";
   M_612           : aliased constant String := "Wget Config";
   K_613           : aliased constant String := "ballerina";
   M_613           : aliased constant String := "Ballerina";
   K_614           : aliased constant String := "cake";
   M_614           : aliased constant String := "C#";
   K_615           : aliased constant String := "shen";
   M_615           : aliased constant String := "Shen";
   K_616           : aliased constant String := "delphi";
   M_616           : aliased constant String := "Pascal";
   K_617           : aliased constant String := "lilypond";
   M_617           : aliased constant String := "LilyPond";
   K_618           : aliased constant String := "cperl";
   M_618           : aliased constant String := "Perl";
   K_619           : aliased constant String := "csharp";
   M_619           : aliased constant String := "C#";
   K_620           : aliased constant String := "kak";
   M_620           : aliased constant String := "KakouneScript";
   K_621           : aliased constant String := "mathematica";
   M_621           : aliased constant String := "Mathematica";
   K_622           : aliased constant String := "zsh";
   M_622           : aliased constant String := "Shell";
   K_623           : aliased constant String := "labview";
   M_623           : aliased constant String := "LabVIEW";
   K_624           : aliased constant String := "sdc";
   M_624           : aliased constant String := "Tcl";
   K_625           : aliased constant String := "adblock filter list";
   M_625           : aliased constant String := "Adblock Filter List";
   K_626           : aliased constant String := "obj-c";
   M_626           : aliased constant String := "Objective-C";
   K_627           : aliased constant String := "js";
   M_627           : aliased constant String := "JavaScript";
   K_628           : aliased constant String := "json with comments";
   M_628           : aliased constant String := "JSON with Comments";
   K_629           : aliased constant String := "erlang";
   M_629           : aliased constant String := "Erlang";
   K_630           : aliased constant String := "obj-j";
   M_630           : aliased constant String := "Objective-J";
   K_631           : aliased constant String := "graphviz (dot)";
   M_631           : aliased constant String := "Graphviz (DOT)";
   K_632           : aliased constant String := "rouge";
   M_632           : aliased constant String := "Rouge";
   K_633           : aliased constant String := "xojo";
   M_633           : aliased constant String := "Xojo";
   K_634           : aliased constant String := "ackrc";
   M_634           : aliased constant String := "Option List";
   K_635           : aliased constant String := "propeller spin";
   M_635           : aliased constant String := "Propeller Spin";
   K_636           : aliased constant String := "objective-c++";
   M_636           : aliased constant String := "Objective-C++";
   K_637           : aliased constant String := "csound document";
   M_637           : aliased constant String := "Csound Document";
   K_638           : aliased constant String := "codeowners";
   M_638           : aliased constant String := "CODEOWNERS";
   K_639           : aliased constant String := "python traceback";
   M_639           : aliased constant String := "Python traceback";
   K_640           : aliased constant String := "jsonld";
   M_640           : aliased constant String := "JSONLD";
   K_641           : aliased constant String := "stringtemplate";
   M_641           : aliased constant String := "StringTemplate";
   K_642           : aliased constant String := "pic";
   M_642           : aliased constant String := "Pic";
   K_643           : aliased constant String := "html+jinja";
   M_643           : aliased constant String := "Jinja";
   K_644           : aliased constant String := "smalltalk";
   M_644           : aliased constant String := "Smalltalk";
   K_645           : aliased constant String := "hosts file";
   M_645           : aliased constant String := "Hosts File";
   K_646           : aliased constant String := "altium";
   M_646           : aliased constant String := "Altium Designer";
   K_647           : aliased constant String := "oasv3-yaml";
   M_647           : aliased constant String := "OASv3-yaml";
   K_648           : aliased constant String := "blitz3d";
   M_648           : aliased constant String := "BlitzBasic";
   K_649           : aliased constant String := "sqlrpgle";
   M_649           : aliased constant String := "RPGLE";
   K_650           : aliased constant String := "ioke";
   M_650           : aliased constant String := "Ioke";
   K_651           : aliased constant String := "rascal";
   M_651           : aliased constant String := "Rascal";
   K_652           : aliased constant String := "aspectj";
   M_652           : aliased constant String := "AspectJ";
   K_653           : aliased constant String := "pir";
   M_653           : aliased constant String := "Parrot Internal Representation";
   K_654           : aliased constant String := "brainfuck";
   M_654           : aliased constant String := "Brainfuck";
   K_655           : aliased constant String := "ls";
   M_655           : aliased constant String := "LiveScript";
   K_656           : aliased constant String := "nwscript";
   M_656           : aliased constant String := "NWScript";
   K_657           : aliased constant String := "protocol buffer";
   M_657           : aliased constant String := "Protocol Buffer";
   K_658           : aliased constant String := "xml+kid";
   M_658           : aliased constant String := "Genshi";
   K_659           : aliased constant String := "kakounescript";
   M_659           : aliased constant String := "KakouneScript";
   K_660           : aliased constant String := "plsql";
   M_660           : aliased constant String := "PLSQL";
   K_661           : aliased constant String := "imba";
   M_661           : aliased constant String := "Imba";
   K_662           : aliased constant String := "asymptote";
   M_662           : aliased constant String := "Asymptote";
   K_663           : aliased constant String := "forth";
   M_663           : aliased constant String := "Forth";
   K_664           : aliased constant String := "roff manpage";
   M_664           : aliased constant String := "Roff Manpage";
   K_665           : aliased constant String := "self";
   M_665           : aliased constant String := "Self";
   K_666           : aliased constant String := "apollo guidance computer";
   M_666           : aliased constant String := "Apollo Guidance Computer";
   K_667           : aliased constant String := "renpy";
   M_667           : aliased constant String := "Ren'Py";
   K_668           : aliased constant String := "clean";
   M_668           : aliased constant String := "Clean";
   K_669           : aliased constant String := "sarif";
   M_669           : aliased constant String := "JSON";
   K_670           : aliased constant String := "red/system";
   M_670           : aliased constant String := "Red";
   K_671           : aliased constant String := "hyphy";
   M_671           : aliased constant String := "HyPhy";
   K_672           : aliased constant String := "subrip text";
   M_672           : aliased constant String := "SubRip Text";
   K_673           : aliased constant String := "leex";
   M_673           : aliased constant String := "HTML+EEX";
   K_674           : aliased constant String := "easybuild";
   M_674           : aliased constant String := "Easybuild";
   K_675           : aliased constant String := "sfv";
   M_675           : aliased constant String := "Simple File Verification";
   K_676           : aliased constant String := "vcl";
   M_676           : aliased constant String := "VCL";
   K_677           : aliased constant String := "p4";
   M_677           : aliased constant String := "P4";
   K_678           : aliased constant String := "hack";
   M_678           : aliased constant String := "Hack";
   K_679           : aliased constant String := "selinux policy";
   M_679           : aliased constant String := "SELinux Policy";
   K_680           : aliased constant String := "qmake";
   M_680           : aliased constant String := "QMake";
   K_681           : aliased constant String := "wren";
   M_681           : aliased constant String := "Wren";
   K_682           : aliased constant String := "freemarker";
   M_682           : aliased constant String := "FreeMarker";
   K_683           : aliased constant String := "game maker language";
   M_683           : aliased constant String := "Game Maker Language";
   K_684           : aliased constant String := "llvm";
   M_684           : aliased constant String := "LLVM";
   K_685           : aliased constant String := "nl";
   M_685           : aliased constant String := "NL";
   K_686           : aliased constant String := "dotenv";
   M_686           : aliased constant String := "Dotenv";
   K_687           : aliased constant String := "clarion";
   M_687           : aliased constant String := "Clarion";
   K_688           : aliased constant String := "coccinelle";
   M_688           : aliased constant String := "SmPL";
   K_689           : aliased constant String := "vlang";
   M_689           : aliased constant String := "V";
   K_690           : aliased constant String := "singularity";
   M_690           : aliased constant String := "Singularity";
   K_691           : aliased constant String := "cuda";
   M_691           : aliased constant String := "Cuda";
   K_692           : aliased constant String := "nu";
   M_692           : aliased constant String := "Nu";
   K_693           : aliased constant String := "ad block";
   M_693           : aliased constant String := "Adblock Filter List";
   K_694           : aliased constant String := "fortran free form";
   M_694           : aliased constant String := "Fortran Free Form";
   K_695           : aliased constant String := "glyph bitmap distribution format";
   M_695           : aliased constant String := "Glyph Bitmap Distribution Format";
   K_696           : aliased constant String := "redcode";
   M_696           : aliased constant String := "Redcode";
   K_697           : aliased constant String := "vim script";
   M_697           : aliased constant String := "Vim Script";
   K_698           : aliased constant String := "eml";
   M_698           : aliased constant String := "E-mail";
   K_699           : aliased constant String := "protocol buffers";
   M_699           : aliased constant String := "Protocol Buffer";
   K_700           : aliased constant String := "rpcgen";
   M_700           : aliased constant String := "RPC";
   K_701           : aliased constant String := "kaitai struct";
   M_701           : aliased constant String := "Kaitai Struct";
   K_702           : aliased constant String := "jsp";
   M_702           : aliased constant String := "Java Server Pages";
   K_703           : aliased constant String := "objectivec";
   M_703           : aliased constant String := "Objective-C";
   K_704           : aliased constant String := "linux kernel module";
   M_704           : aliased constant String := "Linux Kernel Module";
   K_705           : aliased constant String := "scala";
   M_705           : aliased constant String := "Scala";
   K_706           : aliased constant String := "verilog";
   M_706           : aliased constant String := "Verilog";
   K_707           : aliased constant String := "win32 message file";
   M_707           : aliased constant String := "Win32 Message File";
   K_708           : aliased constant String := "rpm spec";
   M_708           : aliased constant String := "RPM Spec";
   K_709           : aliased constant String := "gleam";
   M_709           : aliased constant String := "Gleam";
   K_710           : aliased constant String := "vimhelp";
   M_710           : aliased constant String := "Vim Help File";
   K_711           : aliased constant String := "nextflow";
   M_711           : aliased constant String := "Nextflow";
   K_712           : aliased constant String := "ultisnips";
   M_712           : aliased constant String := "Vim Snippet";
   K_713           : aliased constant String := "npm config";
   M_713           : aliased constant String := "NPM Config";
   K_714           : aliased constant String := "objectivej";
   M_714           : aliased constant String := "Objective-J";
   K_715           : aliased constant String := "bicep";
   M_715           : aliased constant String := "Bicep";
   K_716           : aliased constant String := "filebench wml";
   M_716           : aliased constant String := "Filebench WML";
   K_717           : aliased constant String := "cds";
   M_717           : aliased constant String := "CAP CDS";
   K_718           : aliased constant String := "directx 3d file";
   M_718           : aliased constant String := "DirectX 3D File";
   K_719           : aliased constant String := "mps";
   M_719           : aliased constant String := "JetBrains MPS";
   K_720           : aliased constant String := "flux";
   M_720           : aliased constant String := "FLUX";
   K_721           : aliased constant String := "dlang";
   M_721           : aliased constant String := "D";
   K_722           : aliased constant String := "pascal";
   M_722           : aliased constant String := "Pascal";
   K_723           : aliased constant String := "gradle kotlin dsl";
   M_723           : aliased constant String := "Gradle Kotlin DSL";
   K_724           : aliased constant String := "omgrofl";
   M_724           : aliased constant String := "Omgrofl";
   K_725           : aliased constant String := "typescript";
   M_725           : aliased constant String := "TypeScript";
   K_726           : aliased constant String := "polar";
   M_726           : aliased constant String := "Polar";
   K_727           : aliased constant String := "postscript";
   M_727           : aliased constant String := "PostScript";
   K_728           : aliased constant String := "specfile";
   M_728           : aliased constant String := "RPM Spec";
   K_729           : aliased constant String := "monkey c";
   M_729           : aliased constant String := "Monkey C";
   K_730           : aliased constant String := "cue sheet";
   M_730           : aliased constant String := "Cue Sheet";
   K_731           : aliased constant String := "protobuf text format";
   M_731           : aliased constant String := "Protocol Buffer Text Format";
   K_732           : aliased constant String := "bro";
   M_732           : aliased constant String := "Zeek";
   K_733           : aliased constant String := "latte";
   M_733           : aliased constant String := "Latte";
   K_734           : aliased constant String := "peg.js";
   M_734           : aliased constant String := "PEG.js";
   K_735           : aliased constant String := "textmate properties";
   M_735           : aliased constant String := "TextMate Properties";
   K_736           : aliased constant String := "xpm";
   M_736           : aliased constant String := "X PixMap";
   K_737           : aliased constant String := "velocity";
   M_737           : aliased constant String := "Velocity Template Language";
   K_738           : aliased constant String := "haproxy";
   M_738           : aliased constant String := "HAProxy";
   K_739           : aliased constant String := "cfc";
   M_739           : aliased constant String := "ColdFusion CFC";
   K_740           : aliased constant String := "edge";
   M_740           : aliased constant String := "Edge";
   K_741           : aliased constant String := "muse";
   M_741           : aliased constant String := "Muse";
   K_742           : aliased constant String := "regex";
   M_742           : aliased constant String := "Regular Expression";
   K_743           : aliased constant String := "unity3d asset";
   M_743           : aliased constant String := "Unity3D Asset";
   K_744           : aliased constant String := "cfm";
   M_744           : aliased constant String := "ColdFusion";
   K_745           : aliased constant String := "twig";
   M_745           : aliased constant String := "Twig";
   K_746           : aliased constant String := "actionscript3";
   M_746           : aliased constant String := "ActionScript";
   K_747           : aliased constant String := "oberon";
   M_747           : aliased constant String := "Oberon";
   K_748           : aliased constant String := "rb";
   M_748           : aliased constant String := "Ruby";
   K_749           : aliased constant String := "blade";
   M_749           : aliased constant String := "Blade";
   K_750           : aliased constant String := "pod";
   M_750           : aliased constant String := "Pod";
   K_751           : aliased constant String := "oncrpc";
   M_751           : aliased constant String := "RPC";
   K_752           : aliased constant String := "ragel-rb";
   M_752           : aliased constant String := "Ragel";
   K_753           : aliased constant String := "nu-script";
   M_753           : aliased constant String := "Nushell";
   K_754           : aliased constant String := "dogescript";
   M_754           : aliased constant String := "Dogescript";
   K_755           : aliased constant String := "sparql";
   M_755           : aliased constant String := "SPARQL";
   K_756           : aliased constant String := "rs";
   M_756           : aliased constant String := "Rust";
   K_757           : aliased constant String := "kit";
   M_757           : aliased constant String := "Kit";
   K_758           : aliased constant String := "pot";
   M_758           : aliased constant String := "Gettext Catalog";
   K_759           : aliased constant String := "swift";
   M_759           : aliased constant String := "Swift";
   K_760           : aliased constant String := "talon";
   M_760           : aliased constant String := "Talon";
   K_761           : aliased constant String := "wasm";
   M_761           : aliased constant String := "WebAssembly";
   K_762           : aliased constant String := "vim";
   M_762           : aliased constant String := "Vim Script";
   K_763           : aliased constant String := "json";
   M_763           : aliased constant String := "JSON";
   K_764           : aliased constant String := "autoit";
   M_764           : aliased constant String := "AutoIt";
   K_765           : aliased constant String := "wast";
   M_765           : aliased constant String := "WebAssembly";
   K_766           : aliased constant String := "pact";
   M_766           : aliased constant String := "Pact";
   K_767           : aliased constant String := "elvish";
   M_767           : aliased constant String := "Elvish";
   K_768           : aliased constant String := "dtrace-script";
   M_768           : aliased constant String := "DTrace";
   K_769           : aliased constant String := "tl";
   M_769           : aliased constant String := "Type Language";
   K_770           : aliased constant String := "irc logs";
   M_770           : aliased constant String := "IRC log";
   K_771           : aliased constant String := "rhtml";
   M_771           : aliased constant String := "HTML+ERB";
   K_772           : aliased constant String := "stan";
   M_772           : aliased constant String := "Stan";
   K_773           : aliased constant String := "chuck";
   M_773           : aliased constant String := "ChucK";
   K_774           : aliased constant String := "star";
   M_774           : aliased constant String := "STAR";
   K_775           : aliased constant String := "igor pro";
   M_775           : aliased constant String := "IGOR Pro";
   K_776           : aliased constant String := "ts";
   M_776           : aliased constant String := "TypeScript";
   K_777           : aliased constant String := "yacc";
   M_777           : aliased constant String := "Yacc";
   K_778           : aliased constant String := "ags script";
   M_778           : aliased constant String := "AGS Script";
   K_779           : aliased constant String := "minid";
   M_779           : aliased constant String := "MiniD";
   K_780           : aliased constant String := "bison";
   M_780           : aliased constant String := "Bison";
   K_781           : aliased constant String := "cameligo";
   M_781           : aliased constant String := "CameLIGO";
   K_782           : aliased constant String := "snakemake";
   M_782           : aliased constant String := "Snakemake";
   K_783           : aliased constant String := "troff";
   M_783           : aliased constant String := "Roff";
   K_784           : aliased constant String := "kickstart";
   M_784           : aliased constant String := "Kickstart";
   K_785           : aliased constant String := "literate coffeescript";
   M_785           : aliased constant String := "Literate CoffeeScript";
   K_786           : aliased constant String := "dockerfile";
   M_786           : aliased constant String := "Dockerfile";
   K_787           : aliased constant String := "netlinx+erb";
   M_787           : aliased constant String := "NetLinx+ERB";
   K_788           : aliased constant String := "plpgsql";
   M_788           : aliased constant String := "PLpgSQL";
   K_789           : aliased constant String := "odin-lang";
   M_789           : aliased constant String := "Odin";
   K_790           : aliased constant String := "reasonligo";
   M_790           : aliased constant String := "ReasonLIGO";
   K_791           : aliased constant String := "solidity";
   M_791           : aliased constant String := "Solidity";
   K_792           : aliased constant String := "bash";
   M_792           : aliased constant String := "Shell";
   K_793           : aliased constant String := "octave";
   M_793           : aliased constant String := "MATLAB";
   K_794           : aliased constant String := "maxscript";
   M_794           : aliased constant String := "MAXScript";
   K_795           : aliased constant String := "visual basic";
   M_795           : aliased constant String := "Visual Basic .NET";
   K_796           : aliased constant String := "pod 6";
   M_796           : aliased constant String := "Pod 6";
   K_797           : aliased constant String := "njk";
   M_797           : aliased constant String := "Nunjucks";
   K_798           : aliased constant String := "idl";
   M_798           : aliased constant String := "IDL";
   K_799           : aliased constant String := "starlark";
   M_799           : aliased constant String := "Starlark";
   K_800           : aliased constant String := "unrealscript";
   M_800           : aliased constant String := "UnrealScript";
   K_801           : aliased constant String := "nixos";
   M_801           : aliased constant String := "Nix";
   K_802           : aliased constant String := "tm-properties";
   M_802           : aliased constant String := "TextMate Properties";
   K_803           : aliased constant String := "console";
   M_803           : aliased constant String := "ShellSession";
   K_804           : aliased constant String := "jasmin";
   M_804           : aliased constant String := "Jasmin";
   K_805           : aliased constant String := "dtrace";
   M_805           : aliased constant String := "DTrace";
   K_806           : aliased constant String := "cartocss";
   M_806           : aliased constant String := "CartoCSS";
   K_807           : aliased constant String := "asp.net";
   M_807           : aliased constant String := "ASP.NET";
   K_808           : aliased constant String := "html+ruby";
   M_808           : aliased constant String := "HTML+ERB";
   K_809           : aliased constant String := "haml";
   M_809           : aliased constant String := "Haml";
   K_810           : aliased constant String := "ecere projects";
   M_810           : aliased constant String := "Ecere Projects";
   K_811           : aliased constant String := "xc";
   M_811           : aliased constant String := "XC";
   K_812           : aliased constant String := "web ontology language";
   M_812           : aliased constant String := "Web Ontology Language";
   K_813           : aliased constant String := "pug";
   M_813           : aliased constant String := "Pug";
   K_814           : aliased constant String := "robotframework";
   M_814           : aliased constant String := "RobotFramework";
   K_815           : aliased constant String := "emacs-lisp";
   M_815           : aliased constant String := "Common Lisp";
   K_816           : aliased constant String := "apkbuild";
   M_816           : aliased constant String := "Alpine Abuild";
   K_817           : aliased constant String := "pddl";
   M_817           : aliased constant String := "PDDL";
   K_818           : aliased constant String := "diff";
   M_818           : aliased constant String := "Diff";
   K_819           : aliased constant String := "bzl";
   M_819           : aliased constant String := "Starlark";
   K_820           : aliased constant String := "groovy";
   M_820           : aliased constant String := "Groovy";
   K_821           : aliased constant String := "dhall";
   M_821           : aliased constant String := "Dhall";
   K_822           : aliased constant String := "xs";
   M_822           : aliased constant String := "XS";
   K_823           : aliased constant String := "urweb";
   M_823           : aliased constant String := "UrWeb";
   K_824           : aliased constant String := "marko";
   M_824           : aliased constant String := "Marko";
   K_825           : aliased constant String := "postscr";
   M_825           : aliased constant String := "PostScript";
   K_826           : aliased constant String := "viml";
   M_826           : aliased constant String := "Vim Script";
   K_827           : aliased constant String := "x font directory index";
   M_827           : aliased constant String := "X Font Directory Index";
   K_828           : aliased constant String := "avro idl";
   M_828           : aliased constant String := "Avro IDL";
   K_829           : aliased constant String := "adobe multiple font metrics";
   M_829           : aliased constant String := "Adobe Font Metrics";
   K_830           : aliased constant String := "cycript";
   M_830           : aliased constant String := "Cycript";
   K_831           : aliased constant String := "openrc";
   M_831           : aliased constant String := "OpenRC runscript";
   K_832           : aliased constant String := "srecode template";
   M_832           : aliased constant String := "SRecode Template";
   K_833           : aliased constant String := "live-script";
   M_833           : aliased constant String := "LiveScript";
   K_834           : aliased constant String := "editorconfig";
   M_834           : aliased constant String := "EditorConfig";
   K_835           : aliased constant String := "winbatch";
   M_835           : aliased constant String := "Batchfile";
   K_836           : aliased constant String := "angelscript";
   M_836           : aliased constant String := "AngelScript";
   K_837           : aliased constant String := "vala";
   M_837           : aliased constant String := "Vala";
   K_838           : aliased constant String := "zeek";
   M_838           : aliased constant String := "Zeek";
   K_839           : aliased constant String := "elvish transcript";
   M_839           : aliased constant String := "Elvish Transcript";
   K_840           : aliased constant String := "jison";
   M_840           : aliased constant String := "Jison";
   K_841           : aliased constant String := "autoitscript";
   M_841           : aliased constant String := "AutoIt";
   K_842           : aliased constant String := "earthly";
   M_842           : aliased constant String := "Earthly";
   K_843           : aliased constant String := "antlr";
   M_843           : aliased constant String := "ANTLR";
   K_844           : aliased constant String := "objective-c";
   M_844           : aliased constant String := "Objective-C";
   K_845           : aliased constant String := "papyrus";
   M_845           : aliased constant String := "Papyrus";
   K_846           : aliased constant String := "gerber image";
   M_846           : aliased constant String := "Gerber Image";
   K_847           : aliased constant String := "factor";
   M_847           : aliased constant String := "Factor";
   K_848           : aliased constant String := "elisp";
   M_848           : aliased constant String := "Emacs Lisp";
   K_849           : aliased constant String := "webvtt";
   M_849           : aliased constant String := "WebVTT";
   K_850           : aliased constant String := "objective-j";
   M_850           : aliased constant String := "Objective-J";
   K_851           : aliased constant String := "wgsl";
   M_851           : aliased constant String := "WGSL";
   K_852           : aliased constant String := "sourcemod";
   M_852           : aliased constant String := "SourcePawn";
   K_853           : aliased constant String := "genero per";
   M_853           : aliased constant String := "Genero per";
   K_854           : aliased constant String := "stl";
   M_854           : aliased constant String := "STL";
   K_855           : aliased constant String := "moonscript";
   M_855           : aliased constant String := "MoonScript";
   K_856           : aliased constant String := "common workflow language";
   M_856           : aliased constant String := "Common Workflow Language";
   K_857           : aliased constant String := "less";
   M_857           : aliased constant String := "Less";
   K_858           : aliased constant String := "mermaid example";
   M_858           : aliased constant String := "Mermaid";
   K_859           : aliased constant String := "litcoffee";
   M_859           : aliased constant String := "Literate CoffeeScript";
   K_860           : aliased constant String := "motorola 68k assembly";
   M_860           : aliased constant String := "Motorola 68K Assembly";
   K_861           : aliased constant String := "scheme";
   M_861           : aliased constant String := "Scheme";
   K_862           : aliased constant String := "gnat project";
   M_862           : aliased constant String := "GNAT Project";
   K_863           : aliased constant String := "bikeshed";
   M_863           : aliased constant String := "Bikeshed";
   K_864           : aliased constant String := "circom";
   M_864           : aliased constant String := "Circom";
   K_865           : aliased constant String := "git attributes";
   M_865           : aliased constant String := "Git Attributes";
   K_866           : aliased constant String := "wavefront object";
   M_866           : aliased constant String := "Wavefront Object";
   K_867           : aliased constant String := "4d";
   M_867           : aliased constant String := "4D";
   K_868           : aliased constant String := "cpp";
   M_868           : aliased constant String := "C++";
   K_869           : aliased constant String := "lex";
   M_869           : aliased constant String := "Lex";
   K_870           : aliased constant String := "go mod";
   M_870           : aliased constant String := "Go Module";
   K_871           : aliased constant String := "2-dimensional array";
   M_871           : aliased constant String := "2-Dimensional Array";
   K_872           : aliased constant String := "agda";
   M_872           : aliased constant String := "Agda";
   K_873           : aliased constant String := "motoko";
   M_873           : aliased constant String := "Motoko";
   K_874           : aliased constant String := "gaml";
   M_874           : aliased constant String := "GAML";
   K_875           : aliased constant String := "genero 4gl";
   M_875           : aliased constant String := "Genero 4gl";
   K_876           : aliased constant String := "jflex";
   M_876           : aliased constant String := "JFlex";
   K_877           : aliased constant String := "turtle";
   M_877           : aliased constant String := "Turtle";
   K_878           : aliased constant String := "m4sugar";
   M_878           : aliased constant String := "M4Sugar";
   K_879           : aliased constant String := "gams";
   M_879           : aliased constant String := "GAMS";
   K_880           : aliased constant String := "literate haskell";
   M_880           : aliased constant String := "Literate Haskell";
   K_881           : aliased constant String := "ags";
   M_881           : aliased constant String := "AGS Script";
   K_882           : aliased constant String := "emberscript";
   M_882           : aliased constant String := "EmberScript";
   K_883           : aliased constant String := "obj-c++";
   M_883           : aliased constant String := "Objective-C++";
   K_884           : aliased constant String := "inputrc";
   M_884           : aliased constant String := "Readline Config";
   K_885           : aliased constant String := "svg";
   M_885           : aliased constant String := "SVG";
   K_886           : aliased constant String := "ijm";
   M_886           : aliased constant String := "ImageJ Macro";
   K_887           : aliased constant String := "ksy";
   M_887           : aliased constant String := "Kaitai Struct";
   K_888           : aliased constant String := "conll";
   M_888           : aliased constant String := "CoNLL-U";
   K_889           : aliased constant String := "squeak";
   M_889           : aliased constant String := "Smalltalk";
   K_890           : aliased constant String := "pcbnew";
   M_890           : aliased constant String := "KiCad Layout";
   K_891           : aliased constant String := "ant build system";
   M_891           : aliased constant String := "Ant Build System";
   K_892           : aliased constant String := "json5";
   M_892           : aliased constant String := "JSON5";
   K_893           : aliased constant String := "picolisp";
   M_893           : aliased constant String := "PicoLisp";
   K_894           : aliased constant String := "lhaskell";
   M_894           : aliased constant String := "Literate Haskell";
   K_895           : aliased constant String := "turing";
   M_895           : aliased constant String := "Turing";
   K_896           : aliased constant String := "qml";
   M_896           : aliased constant String := "QML";
   K_897           : aliased constant String := "nunjucks";
   M_897           : aliased constant String := "Nunjucks";
   K_898           : aliased constant String := "gap";
   M_898           : aliased constant String := "GAP";
   K_899           : aliased constant String := "hash";
   M_899           : aliased constant String := "Checksums";
   K_900           : aliased constant String := "gas";
   M_900           : aliased constant String := "Unix Assembly";
   K_901           : aliased constant String := "tl-verilog";
   M_901           : aliased constant String := "TL-Verilog";
   K_902           : aliased constant String := "http";
   M_902           : aliased constant String := "HTTP";
   K_903           : aliased constant String := "qsharp";
   M_903           : aliased constant String := "Q#";
   K_904           : aliased constant String := "saltstate";
   M_904           : aliased constant String := "SaltStack";
   K_905           : aliased constant String := "rexx";
   M_905           : aliased constant String := "REXX";
   K_906           : aliased constant String := "scss";
   M_906           : aliased constant String := "SCSS";
   K_907           : aliased constant String := "processing";
   M_907           : aliased constant String := "Processing";
   K_908           : aliased constant String := "ignore list";
   M_908           : aliased constant String := "Ignore List";
   K_909           : aliased constant String := "scenic";
   M_909           : aliased constant String := "Scenic";
   K_910           : aliased constant String := "purescript";
   M_910           : aliased constant String := "PureScript";
   K_911           : aliased constant String := "cpp-objdump";
   M_911           : aliased constant String := "Cpp-ObjDump";
   K_912           : aliased constant String := "chapel";
   M_912           : aliased constant String := "Chapel";
   K_913           : aliased constant String := "stata";
   M_913           : aliased constant String := "Stata";
   K_914           : aliased constant String := "metal";
   M_914           : aliased constant String := "Metal";
   K_915           : aliased constant String := "plain text";
   M_915           : aliased constant String := "Text";
   K_916           : aliased constant String := "nemerle";
   M_916           : aliased constant String := "Nemerle";
   K_917           : aliased constant String := "hlsl";
   M_917           : aliased constant String := "HLSL";
   K_918           : aliased constant String := "raw";
   M_918           : aliased constant String := "Raw token data";
   K_919           : aliased constant String := "yaml";
   M_919           : aliased constant String := "YAML";
   K_920           : aliased constant String := "pandoc";
   M_920           : aliased constant String := "Markdown";
   K_921           : aliased constant String := "vue";
   M_921           : aliased constant String := "Vue";
   K_922           : aliased constant String := "jsonc";
   M_922           : aliased constant String := "JSON with Comments";
   K_923           : aliased constant String := "fortran";
   M_923           : aliased constant String := "Fortran";
   K_924           : aliased constant String := "ligolang";
   M_924           : aliased constant String := "LigoLANG";
   K_925           : aliased constant String := "git revision list";
   M_925           : aliased constant String := "Git Revision List";
   K_926           : aliased constant String := "tla";
   M_926           : aliased constant String := "TLA";
   K_927           : aliased constant String := "jsonl";
   M_927           : aliased constant String := "JSON";
   K_928           : aliased constant String := "meson";
   M_928           : aliased constant String := "Meson";
   K_929           : aliased constant String := "nginx";
   M_929           : aliased constant String := "Nginx";
   K_930           : aliased constant String := "textgrid";
   M_930           : aliased constant String := "TextGrid";
   K_931           : aliased constant String := "golo";
   M_931           : aliased constant String := "Golo";
   K_932           : aliased constant String := "closure templates";
   M_932           : aliased constant String := "Closure Templates";
   K_933           : aliased constant String := "xpages";
   M_933           : aliased constant String := "XPages";
   K_934           : aliased constant String := "shellsession";
   M_934           : aliased constant String := "ShellSession";
   K_935           : aliased constant String := "inc";
   M_935           : aliased constant String := "PHP";
   K_936           : aliased constant String := "ats2";
   M_936           : aliased constant String := "ATS";
   K_937           : aliased constant String := "ini";
   M_937           : aliased constant String := "INI";
   K_938           : aliased constant String := "salt";
   M_938           : aliased constant String := "SaltStack";
   K_939           : aliased constant String := "snippet";
   M_939           : aliased constant String := "YASnippet";
   K_940           : aliased constant String := "ink";
   M_940           : aliased constant String := "Ink";
   K_941           : aliased constant String := "esdl";
   M_941           : aliased constant String := "EdgeQL";
   K_942           : aliased constant String := "proto";
   M_942           : aliased constant String := "Protocol Buffer";
   K_943           : aliased constant String := "shaderlab";
   M_943           : aliased constant String := "ShaderLab";
   K_944           : aliased constant String := "vb 6";
   M_944           : aliased constant String := "Visual Basic 6.0";
   K_945           : aliased constant String := "rebol";
   M_945           : aliased constant String := "Rebol";
   K_946           : aliased constant String := "jolie";
   M_946           : aliased constant String := "Jolie";
   K_947           : aliased constant String := "sepolicy";
   M_947           : aliased constant String := "SELinux Policy";
   K_948           : aliased constant String := "opts";
   M_948           : aliased constant String := "Option List";
   K_949           : aliased constant String := "wit";
   M_949           : aliased constant String := "WebAssembly Interface Type";
   K_950           : aliased constant String := "mlir";
   M_950           : aliased constant String := "MLIR";
   K_951           : aliased constant String := "regexp";
   M_951           : aliased constant String := "Regular Expression";
   K_952           : aliased constant String := "pycon";
   M_952           : aliased constant String := "Python console";
   K_953           : aliased constant String := "rpgle";
   M_953           : aliased constant String := "RPGLE";
   K_954           : aliased constant String := "thrift";
   M_954           : aliased constant String := "Thrift";
   K_955           : aliased constant String := "bluespec";
   M_955           : aliased constant String := "Bluespec";
   K_956           : aliased constant String := "java server pages";
   M_956           : aliased constant String := "Java Server Pages";
   K_957           : aliased constant String := "rs-274x";
   M_957           : aliased constant String := "Gerber Image";
   K_958           : aliased constant String := "gettext catalog";
   M_958           : aliased constant String := "Gettext Catalog";
   K_959           : aliased constant String := "witcher script";
   M_959           : aliased constant String := "Witcher Script";
   K_960           : aliased constant String := "codeql";
   M_960           : aliased constant String := "CodeQL";
   K_961           : aliased constant String := "restructuredtext";
   M_961           : aliased constant String := "reStructuredText";
   K_962           : aliased constant String := "livescript";
   M_962           : aliased constant String := "LiveScript";
   K_963           : aliased constant String := "logos";
   M_963           : aliased constant String := "Logos";
   K_964           : aliased constant String := "d2lang";
   M_964           : aliased constant String := "D2";
   K_965           : aliased constant String := "ebnf";
   M_965           : aliased constant String := "EBNF";
   K_966           : aliased constant String := "inno setup";
   M_966           : aliased constant String := "Inno Setup";
   K_967           : aliased constant String := "shellcheck config";
   M_967           : aliased constant String := "ShellCheck Config";
   K_968           : aliased constant String := "checksum";
   M_968           : aliased constant String := "Checksums";
   K_969           : aliased constant String := "red";
   M_969           : aliased constant String := "Red";
   K_970           : aliased constant String := "ston";
   M_970           : aliased constant String := "STON";
   K_971           : aliased constant String := "c++-objdump";
   M_971           : aliased constant String := "Cpp-ObjDump";
   K_972           : aliased constant String := "readline";
   M_972           : aliased constant String := "Readline Config";
   K_973           : aliased constant String := "sqlpl";
   M_973           : aliased constant String := "SQLPL";
   K_974           : aliased constant String := "gherkin";
   M_974           : aliased constant String := "Gherkin";
   K_975           : aliased constant String := "beef";
   M_975           : aliased constant String := "Beef";
   K_976           : aliased constant String := "mint";
   M_976           : aliased constant String := "Mint";
   K_977           : aliased constant String := "debian package control file";
   M_977           : aliased constant String := "Debian Package Control File";
   K_978           : aliased constant String := "basic";
   M_978           : aliased constant String := "BASIC";
   K_979           : aliased constant String := "visual basic 6";
   M_979           : aliased constant String := "Visual Basic 6.0";
   K_980           : aliased constant String := "eeschema schematic";
   M_980           : aliased constant String := "KiCad Schematic";
   K_981           : aliased constant String := "rez";
   M_981           : aliased constant String := "Rez";
   K_982           : aliased constant String := "python";
   M_982           : aliased constant String := "Python";
   K_983           : aliased constant String := "selinux kernel policy language";
   M_983           : aliased constant String := "SELinux Policy";
   K_984           : aliased constant String := "glsl";
   M_984           : aliased constant String := "GLSL";
   K_985           : aliased constant String := "qt script";
   M_985           : aliased constant String := "Qt Script";
   K_986           : aliased constant String := "emacs lisp";
   M_986           : aliased constant String := "Emacs Lisp";
   K_987           : aliased constant String := "blitzplus";
   M_987           : aliased constant String := "BlitzBasic";
   K_988           : aliased constant String := "protobuf";
   M_988           : aliased constant String := "Protocol Buffer";
   K_989           : aliased constant String := "bat";
   M_989           : aliased constant String := "Batchfile";
   K_990           : aliased constant String := "pasm";
   M_990           : aliased constant String := "Parrot Assembly";
   K_991           : aliased constant String := "eclipse";
   M_991           : aliased constant String := "ECLiPSe";
   K_992           : aliased constant String := "c#";
   M_992           : aliased constant String := "C#";
   K_993           : aliased constant String := "cson";
   M_993           : aliased constant String := "CSON";
   K_994           : aliased constant String := "xten";
   M_994           : aliased constant String := "X10";
   K_995           : aliased constant String := "brighterscript";
   M_995           : aliased constant String := "BrighterScript";
   K_996           : aliased constant String := "actionscript";
   M_996           : aliased constant String := "ActionScript";
   K_997           : aliased constant String := "pony";
   M_997           : aliased constant String := "Pony";
   K_998           : aliased constant String := "irc";
   M_998           : aliased constant String := "IRC log";
   K_999           : aliased constant String := "man";
   M_999           : aliased constant String := "Roff";
   K_1000          : aliased constant String := "max";
   M_1000          : aliased constant String := "Max";
   K_1001          : aliased constant String := "al";
   M_1001          : aliased constant String := "AL";
   K_1002          : aliased constant String := "fluent";
   M_1002          : aliased constant String := "Fluent";
   K_1003          : aliased constant String := "xhtml";
   M_1003          : aliased constant String := "HTML";
   K_1004          : aliased constant String := "xquery";
   M_1004          : aliased constant String := "XQuery";
   K_1005          : aliased constant String := "dafny";
   M_1005          : aliased constant String := "Dafny";
   K_1006          : aliased constant String := "csound";
   M_1006          : aliased constant String := "Csound";
   K_1007          : aliased constant String := "openrc runscript";
   M_1007          : aliased constant String := "OpenRC runscript";
   K_1008          : aliased constant String := "asn.1";
   M_1008          : aliased constant String := "ASN.1";
   K_1009          : aliased constant String := "as3";
   M_1009          : aliased constant String := "ActionScript";
   K_1010          : aliased constant String := "mojo";
   M_1010          : aliased constant String := "Mojo";
   K_1011          : aliased constant String := "powershell";
   M_1011          : aliased constant String := "PowerShell";
   K_1012          : aliased constant String := "riot";
   M_1012          : aliased constant String := "Riot";
   K_1013          : aliased constant String := "amfm";
   M_1013          : aliased constant String := "Adobe Font Metrics";
   K_1014          : aliased constant String := "pwsh";
   M_1014          : aliased constant String := "PowerShell";
   K_1015          : aliased constant String := "sweave";
   M_1015          : aliased constant String := "Sweave";
   K_1016          : aliased constant String := "openscad";
   M_1016          : aliased constant String := "OpenSCAD";
   K_1017          : aliased constant String := "latex";
   M_1017          : aliased constant String := "TeX,Latex";
   K_1018          : aliased constant String := "loomscript";
   M_1018          : aliased constant String := "LoomScript";
   K_1019          : aliased constant String := "figfont";
   M_1019          : aliased constant String := "FIGlet Font";
   K_1020          : aliased constant String := "fancy";
   M_1020          : aliased constant String := "Fancy";
   K_1021          : aliased constant String := "unified parallel c";
   M_1021          : aliased constant String := "Unified Parallel C";
   K_1022          : aliased constant String := "oasv2-json";
   M_1022          : aliased constant String := "OASv2-json";
   K_1023          : aliased constant String := "vb.net";
   M_1023          : aliased constant String := "Visual Basic .NET";
   K_1024          : aliased constant String := "whiley";
   M_1024          : aliased constant String := "Whiley";
   K_1025          : aliased constant String := "lasso";
   M_1025          : aliased constant String := "Lasso";
   K_1026          : aliased constant String := "parrot assembly";
   M_1026          : aliased constant String := "Parrot Assembly";
   K_1027          : aliased constant String := "vhdl";
   M_1027          : aliased constant String := "VHDL";
   K_1028          : aliased constant String := "renderscript";
   M_1028          : aliased constant String := "RenderScript";
   K_1029          : aliased constant String := "ile rpg";
   M_1029          : aliased constant String := "RPGLE";
   K_1030          : aliased constant String := "kicad layout";
   M_1030          : aliased constant String := "KiCad Layout";
   K_1031          : aliased constant String := "hylang";
   M_1031          : aliased constant String := "Hy";
   K_1032          : aliased constant String := "smali";
   M_1032          : aliased constant String := "Smali";
   K_1033          : aliased constant String := "makefile";
   M_1033          : aliased constant String := "Makefile";
   K_1034          : aliased constant String := "c-objdump";
   M_1034          : aliased constant String := "C-ObjDump";
   K_1035          : aliased constant String := "au3";
   M_1035          : aliased constant String := "AutoIt";
   K_1036          : aliased constant String := "nush";
   M_1036          : aliased constant String := "Nu";
   K_1037          : aliased constant String := "hxml";
   M_1037          : aliased constant String := "HXML";
   K_1038          : aliased constant String := "e-mail";
   M_1038          : aliased constant String := "E-mail";
   K_1039          : aliased constant String := "autoit3";
   M_1039          : aliased constant String := "AutoIt";
   K_1040          : aliased constant String := "pawn";
   M_1040          : aliased constant String := "Pawn";
   K_1041          : aliased constant String := "help";
   M_1041          : aliased constant String := "Vim Help File";
   K_1042          : aliased constant String := "lolcode";
   M_1042          : aliased constant String := "LOLCODE";
   K_1043          : aliased constant String := "imagej macro";
   M_1043          : aliased constant String := "ImageJ Macro";
   K_1044          : aliased constant String := "wollok";
   M_1044          : aliased constant String := "Wollok";
   K_1045          : aliased constant String := "applescript";
   M_1045          : aliased constant String := "AppleScript";
   K_1046          : aliased constant String := "component pascal";
   M_1046          : aliased constant String := "Component Pascal";
   K_1047          : aliased constant String := "asl";
   M_1047          : aliased constant String := "ASL";
   K_1048          : aliased constant String := "html+php";
   M_1048          : aliased constant String := "HTML+PHP";
   K_1049          : aliased constant String := "sieve";
   M_1049          : aliased constant String := "Sieve";
   K_1050          : aliased constant String := "asm";
   M_1050          : aliased constant String := "Assembly";
   K_1051          : aliased constant String := "liquid";
   M_1051          : aliased constant String := "Liquid";
   K_1052          : aliased constant String := "java";
   M_1052          : aliased constant String := "Java";
   K_1053          : aliased constant String := "asp";
   M_1053          : aliased constant String := "Classic ASP";
   K_1054          : aliased constant String := "neon";
   M_1054          : aliased constant String := "NEON";
   K_1055          : aliased constant String := "genie";
   M_1055          : aliased constant String := "Genie";
   K_1056          : aliased constant String := "fsharp";
   M_1056          : aliased constant String := "F#";
   K_1057          : aliased constant String := "netlinx";
   M_1057          : aliased constant String := "NetLinx";
   K_1058          : aliased constant String := "ec";
   M_1058          : aliased constant String := "eC";
   K_1059          : aliased constant String := "apex";
   M_1059          : aliased constant String := "Apex";
   K_1060          : aliased constant String := "hosts";
   M_1060          : aliased constant String := "Hosts File";
   K_1061          : aliased constant String := "common lisp";
   M_1061          : aliased constant String := "Common Lisp";
   K_1062          : aliased constant String := "irc log";
   M_1062          : aliased constant String := "IRC log";
   K_1063          : aliased constant String := "lsl";
   M_1063          : aliased constant String := "LSL";
   K_1064          : aliased constant String := "eq";
   M_1064          : aliased constant String := "EQ";
   K_1065          : aliased constant String := "opa";
   M_1065          : aliased constant String := "Opa";
   K_1066          : aliased constant String := "vyper";
   M_1066          : aliased constant String := "Vyper";
   K_1067          : aliased constant String := "go sum";
   M_1067          : aliased constant String := "Go Checksums";
   K_1068          : aliased constant String := "python console";
   M_1068          : aliased constant String := "Python console";
   K_1069          : aliased constant String := "rusthon";
   M_1069          : aliased constant String := "Python";
   K_1070          : aliased constant String := "runoff";
   M_1070          : aliased constant String := "RUNOFF";
   K_1071          : aliased constant String := "batch";
   M_1071          : aliased constant String := "Batchfile";
   K_1072          : aliased constant String := "glyph";
   M_1072          : aliased constant String := "Glyph";
   K_1073          : aliased constant String := "i7";
   M_1073          : aliased constant String := "Inform 7";

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
      K_1072'Access, K_1073'Access);

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
      M_1072'Access, M_1073'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.AliasMap;
