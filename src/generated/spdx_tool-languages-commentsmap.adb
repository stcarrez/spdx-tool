--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Mapping generated from comments.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.CommentsMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 11) of Natural :=
     (1, 2, 3, 4, 5, 6, 8, 9, 11, 12, 16, 24);

   T1 : constant array (0 .. 11) of Unsigned_16 :=
     (142, 914, 1058, 839, 100, 448, 917, 1357, 200, 723, 279, 1180);

   T2 : constant array (0 .. 11) of Unsigned_16 :=
     (1330, 1377, 159, 1141, 774, 412, 1339, 1429, 1016, 1183, 1307, 1071);

   G : constant array (0 .. 1440) of Unsigned_16 :=
     (0, 0, 183, 0, 0, 226, 524, 0, 67, 0, 0, 579, 137, 463, 0, 0, 0, 0, 0,
      0, 0, 702, 403, 605, 0, 403, 518, 110, 0, 332, 0, 0, 0, 0, 0, 0, 154,
      154, 621, 0, 0, 708, 0, 303, 397, 0, 0, 194, 240, 0, 73, 0, 0, 0, 0,
      0, 0, 0, 0, 51, 700, 0, 14, 0, 0, 0, 0, 0, 0, 682, 4, 159, 0, 0, 204,
      576, 0, 109, 0, 0, 0, 339, 0, 289, 100, 0, 0, 0, 0, 0, 0, 0, 709, 0,
      0, 0, 573, 0, 0, 177, 587, 0, 0, 515, 0, 385, 0, 0, 0, 0, 44, 0, 0, 0,
      0, 142, 0, 0, 0, 11, 0, 0, 0, 0, 0, 29, 0, 0, 186, 0, 365, 0, 172, 0,
      0, 0, 0, 4, 118, 630, 0, 152, 0, 0, 0, 167, 42, 0, 408, 215, 0, 0,
      106, 513, 0, 0, 465, 68, 516, 0, 0, 0, 0, 378, 0, 0, 0, 372, 0, 49,
      368, 267, 266, 87, 0, 0, 379, 586, 117, 0, 501, 195, 0, 0, 77, 559, 0,
      0, 0, 0, 0, 0, 440, 687, 261, 0, 0, 0, 0, 0, 0, 0, 504, 299, 0, 0, 0,
      0, 356, 0, 587, 534, 0, 0, 0, 96, 0, 0, 0, 670, 0, 223, 261, 0, 0, 0,
      453, 0, 87, 277, 70, 0, 0, 0, 0, 239, 46, 0, 0, 0, 0, 0, 0, 0, 0, 176,
      0, 0, 0, 411, 0, 0, 0, 0, 86, 662, 0, 0, 0, 0, 454, 0, 81, 0, 0, 0,
      252, 0, 492, 0, 0, 592, 0, 121, 0, 52, 123, 0, 87, 0, 0, 0, 0, 0, 0,
      0, 83, 335, 0, 0, 0, 0, 293, 0, 570, 0, 0, 417, 677, 90, 0, 283, 0,
      522, 0, 223, 2, 0, 0, 0, 0, 0, 0, 0, 0, 190, 0, 193, 0, 0, 0, 0, 0, 0,
      0, 118, 535, 0, 0, 0, 0, 232, 0, 96, 97, 0, 534, 558, 0, 0, 0, 0, 607,
      0, 213, 141, 0, 154, 421, 97, 0, 0, 63, 154, 631, 0, 46, 214, 0, 0, 0,
      669, 0, 0, 0, 67, 433, 329, 522, 296, 437, 0, 618, 290, 222, 0, 0,
      124, 384, 0, 485, 154, 0, 0, 0, 1, 289, 0, 0, 454, 0, 632, 508, 282,
      0, 0, 0, 0, 511, 0, 33, 265, 0, 0, 567, 174, 600, 0, 0, 58, 153, 391,
      0, 171, 252, 0, 23, 0, 248, 2, 230, 0, 402, 0, 0, 0, 124, 0, 663, 502,
      704, 505, 80, 275, 161, 341, 410, 276, 0, 0, 0, 90, 181, 193, 0, 0, 0,
      17, 291, 246, 0, 0, 0, 374, 352, 0, 0, 495, 477, 0, 597, 0, 0, 0, 570,
      0, 0, 0, 0, 135, 262, 0, 64, 0, 0, 0, 0, 277, 623, 336, 0, 0, 0, 0, 0,
      0, 0, 709, 0, 0, 303, 0, 442, 0, 412, 2, 103, 0, 11, 31, 70, 447, 478,
      637, 0, 324, 26, 0, 0, 0, 0, 387, 437, 608, 0, 0, 0, 139, 551, 0, 23,
      0, 474, 129, 0, 316, 412, 0, 97, 0, 590, 0, 0, 25, 64, 284, 0, 0, 0,
      0, 0, 0, 120, 301, 0, 124, 429, 598, 0, 519, 0, 522, 0, 0, 461, 0,
      705, 232, 105, 0, 0, 472, 401, 185, 0, 297, 13, 0, 0, 581, 0, 0, 146,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 582, 0, 308, 0, 20, 629, 704, 500,
      303, 499, 0, 0, 117, 0, 44, 0, 283, 186, 73, 0, 519, 109, 0, 0, 0, 0,
      349, 0, 0, 435, 0, 0, 710, 0, 373, 0, 0, 534, 11, 642, 493, 0, 22,
      227, 193, 160, 0, 0, 369, 0, 194, 0, 0, 0, 206, 390, 607, 0, 0, 0,
      587, 619, 0, 537, 0, 0, 0, 0, 0, 586, 4, 455, 0, 429, 82, 0, 454, 0,
      0, 0, 440, 160, 0, 461, 0, 65, 260, 0, 255, 0, 152, 492, 446, 655, 0,
      0, 0, 2, 710, 97, 0, 0, 359, 0, 0, 306, 0, 0, 0, 339, 129, 476, 168,
      0, 103, 0, 50, 235, 170, 0, 125, 580, 0, 65, 0, 0, 128, 372, 0, 428,
      166, 0, 0, 647, 240, 0, 547, 0, 0, 477, 187, 0, 0, 0, 0, 0, 282, 0, 0,
      0, 0, 0, 244, 0, 366, 0, 15, 0, 698, 0, 0, 465, 0, 464, 0, 0, 0, 0,
      567, 439, 603, 0, 13, 0, 0, 680, 0, 377, 190, 0, 105, 195, 0, 0, 676,
      354, 151, 152, 0, 642, 118, 226, 0, 0, 580, 550, 626, 0, 0, 33, 699,
      84, 0, 416, 0, 0, 394, 0, 0, 0, 0, 248, 382, 290, 255, 313, 0, 0, 177,
      301, 0, 108, 0, 349, 403, 0, 316, 0, 327, 169, 0, 0, 0, 274, 686, 88,
      0, 373, 0, 163, 0, 432, 0, 205, 431, 545, 0, 547, 7, 60, 0, 0, 0, 511,
      243, 436, 0, 558, 325, 89, 0, 274, 628, 0, 562, 72, 695, 389, 0, 0,
      339, 620, 579, 0, 0, 0, 321, 0, 269, 0, 340, 544, 507, 0, 478, 0, 0,
      0, 242, 164, 526, 220, 0, 163, 0, 146, 290, 627, 716, 0, 0, 0, 0, 439,
      121, 495, 229, 0, 663, 0, 0, 0, 0, 176, 286, 143, 0, 403, 0, 512, 0,
      445, 0, 342, 62, 0, 691, 0, 0, 26, 203, 0, 395, 0, 162, 0, 0, 0, 337,
      0, 613, 276, 274, 0, 638, 0, 0, 0, 0, 0, 608, 0, 31, 347, 687, 71, 0,
      0, 0, 0, 455, 0, 58, 334, 0, 442, 0, 0, 639, 0, 296, 0, 307, 405, 0,
      0, 19, 0, 0, 298, 633, 0, 0, 0, 98, 0, 273, 0, 0, 8, 264, 40, 0, 0, 0,
      0, 179, 35, 459, 324, 93, 75, 25, 153, 0, 0, 0, 384, 0, 343, 0, 0,
      465, 590, 574, 467, 694, 382, 225, 416, 348, 548, 163, 0, 0, 0, 0, 11,
      158, 0, 0, 432, 427, 553, 0, 0, 170, 0, 0, 0, 0, 201, 0, 0, 137, 687,
      0, 481, 2, 441, 73, 0, 0, 0, 149, 0, 0, 55, 0, 156, 0, 610, 46, 0,
      448, 543, 0, 0, 2, 0, 0, 31, 0, 291, 622, 114, 0, 126, 0, 241, 359, 0,
      25, 0, 0, 148, 0, 59, 0, 0, 0, 681, 0, 621, 0, 0, 147, 0, 0, 237, 0,
      240, 0, 0, 0, 0, 0, 0, 455, 7, 268, 29, 0, 68, 0, 339, 0, 609, 0, 596,
      0, 0, 0, 191, 400, 24, 0, 0, 0, 250, 556, 0, 0, 498, 636, 0, 0, 0, 0,
      0, 591, 280, 425, 0, 542, 0, 383, 671, 0, 33, 575, 0, 0, 458, 10, 0,
      550, 705, 306, 0, 628, 641, 3, 172, 0, 27, 0, 45, 586, 0, 0, 171, 0,
      57, 517, 565, 0, 0, 357, 0, 659, 403, 581, 0, 0, 260, 0, 0, 215, 0,
      98, 38, 195, 108, 0, 116, 429, 569, 0, 0, 76, 598, 608, 228, 416, 528,
      674, 0, 335, 0, 0, 0, 0, 0, 658, 0, 388, 175, 0, 0, 409, 654, 0, 468,
      67, 592, 431, 141, 0, 0, 626, 0, 0, 701, 0, 645, 0, 387, 83, 281, 0,
      151, 297, 0, 0, 369, 643, 41, 0, 130, 616, 89, 87, 0, 521, 226, 0,
      495, 181, 272, 12, 9, 0, 312, 300, 0, 0, 539, 683, 0, 351, 614, 447,
      0, 61, 322, 0, 591, 0, 412, 503, 22, 0, 604, 115, 0, 0, 267, 235, 17,
      0, 0, 0, 60, 0, 443, 0, 488, 0, 183, 170, 268, 0, 127, 689, 61, 436,
      164, 6, 0, 560, 0, 0, 341, 0, 458, 0, 278, 172, 0, 0, 310, 0, 0, 0, 0,
      0, 389, 667, 324, 0, 0, 713, 0, 15, 147, 82, 0, 0, 206, 435, 0, 0, 0,
      61, 193, 537, 347, 314, 445, 674, 525, 0, 0, 383, 0, 0, 36, 280, 0,
      548, 134, 14, 0, 292, 211, 0, 0, 0, 281, 258, 705, 207, 0, 222, 95,
      419, 0, 685, 0, 0, 286, 0, 355, 0, 435, 576, 0, 0, 107, 0, 0, 0, 0,
      503, 572, 98, 123, 286, 0, 553, 456, 0, 0, 0, 0, 537, 420, 386, 678,
      660, 141, 318, 0, 147, 355, 0, 109, 688, 140, 0, 0, 686, 359, 0, 101,
      199, 0, 0, 323, 0, 542, 371, 123, 665, 0, 0, 0, 324, 248, 587, 155,
      18, 545, 190, 51, 0, 119, 0, 0, 0, 287, 122, 607, 0, 54);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 1441;
         F2 := (F2 + Natural (T2 (K)) * J) mod 1441;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 720;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "Sieve";
   M_0             : aliased constant String := "";
   K_1             : aliased constant String := "desktop";
   M_1             : aliased constant String := "";
   K_2             : aliased constant String := "Org";
   M_2             : aliased constant String := "";
   K_3             : aliased constant String := "E-mail";
   M_3             : aliased constant String := "";
   K_4             : aliased constant String := "Graph Modeling Language";
   M_4             : aliased constant String := "";
   K_5             : aliased constant String := "Component Pascal";
   M_5             : aliased constant String := "";
   K_6             : aliased constant String := "OASv3-json";
   M_6             : aliased constant String := "";
   K_7             : aliased constant String := "JavaScript";
   M_7             : aliased constant String := "C-style";
   K_8             : aliased constant String := "EJS";
   M_8             : aliased constant String := "";
   K_9             : aliased constant String := "Cirru";
   M_9             : aliased constant String := "";
   K_10            : aliased constant String := "Metal";
   M_10            : aliased constant String := "";
   K_11            : aliased constant String := "Slash";
   M_11            : aliased constant String := "";
   K_12            : aliased constant String := "Git Attributes";
   M_12            : aliased constant String := "";
   K_13            : aliased constant String := "cURL Config";
   M_13            : aliased constant String := "";
   K_14            : aliased constant String := "Processing";
   M_14            : aliased constant String := "";
   K_15            : aliased constant String := "Awk";
   M_15            : aliased constant String := "";
   K_16            : aliased constant String := "Groovy Server Pages";
   M_16            : aliased constant String := "";
   K_17            : aliased constant String := "Modelica";
   M_17            : aliased constant String := "";
   K_18            : aliased constant String := "TextGrid";
   M_18            : aliased constant String := "";
   K_19            : aliased constant String := "Pan";
   M_19            : aliased constant String := "";
   K_20            : aliased constant String := "Golo";
   M_20            : aliased constant String := "";
   K_21            : aliased constant String := "ASL";
   M_21            : aliased constant String := "";
   K_22            : aliased constant String := "ASP.NET";
   M_22            : aliased constant String := "";
   K_23            : aliased constant String := "SystemVerilog";
   M_23            : aliased constant String := "";
   K_24            : aliased constant String := "DirectX 3D File";
   M_24            : aliased constant String := "";
   K_25            : aliased constant String := "Motorola 68K Assembly";
   M_25            : aliased constant String := "";
   K_26            : aliased constant String := "Haxe";
   M_26            : aliased constant String := "";
   K_27            : aliased constant String := "JSONiq";
   M_27            : aliased constant String := "";
   K_28            : aliased constant String := "Git Config";
   M_28            : aliased constant String := "";
   K_29            : aliased constant String := "reStructuredText";
   M_29            : aliased constant String := "";
   K_30            : aliased constant String := "Terraform Template";
   M_30            : aliased constant String := "";
   K_31            : aliased constant String := "LFE";
   M_31            : aliased constant String := "";
   K_32            : aliased constant String := "LOLCODE";
   M_32            : aliased constant String := "";
   K_33            : aliased constant String := "EBNF";
   M_33            : aliased constant String := "";
   K_34            : aliased constant String := "ZAP";
   M_34            : aliased constant String := "";
   K_35            : aliased constant String := "Cloud Firestore Security Rules";
   M_35            : aliased constant String := "";
   K_36            : aliased constant String := "YAML";
   M_36            : aliased constant String := "";
   K_37            : aliased constant String := "Python";
   M_37            : aliased constant String := "";
   K_38            : aliased constant String := "GEDCOM";
   M_38            : aliased constant String := "";
   K_39            : aliased constant String := "Adobe Font Metrics";
   M_39            : aliased constant String := "";
   K_40            : aliased constant String := "Antlers";
   M_40            : aliased constant String := "";
   K_41            : aliased constant String := "Altium Designer";
   M_41            : aliased constant String := "";
   K_42            : aliased constant String := "Scheme";
   M_42            : aliased constant String := "";
   K_43            : aliased constant String := "Glimmer JS";
   M_43            : aliased constant String := "";
   K_44            : aliased constant String := "Unified Parallel C";
   M_44            : aliased constant String := "";
   K_45            : aliased constant String := "Slim";
   M_45            : aliased constant String := "";
   K_46            : aliased constant String := "QML";
   M_46            : aliased constant String := "";
   K_47            : aliased constant String := "ColdFusion CFC";
   M_47            : aliased constant String := "";
   K_48            : aliased constant String := "Hy";
   M_48            : aliased constant String := "";
   K_49            : aliased constant String := "Stan";
   M_49            : aliased constant String := "";
   K_50            : aliased constant String := "Cpp-ObjDump";
   M_50            : aliased constant String := "";
   K_51            : aliased constant String := "MQL4";
   M_51            : aliased constant String := "";
   K_52            : aliased constant String := "Euphoria";
   M_52            : aliased constant String := "";
   K_53            : aliased constant String := "wisp";
   M_53            : aliased constant String := "";
   K_54            : aliased constant String := "MQL5";
   M_54            : aliased constant String := "";
   K_55            : aliased constant String := "Ragel";
   M_55            : aliased constant String := "";
   K_56            : aliased constant String := "CWeb";
   M_56            : aliased constant String := "";
   K_57            : aliased constant String := "ChucK";
   M_57            : aliased constant String := "";
   K_58            : aliased constant String := "Wget Config";
   M_58            : aliased constant String := "";
   K_59            : aliased constant String := "Solidity";
   M_59            : aliased constant String := "";
   K_60            : aliased constant String := "Csound";
   M_60            : aliased constant String := "";
   K_61            : aliased constant String := "Brightscript";
   M_61            : aliased constant String := "";
   K_62            : aliased constant String := "GSC";
   M_62            : aliased constant String := "";
   K_63            : aliased constant String := "RUNOFF";
   M_63            : aliased constant String := "";
   K_64            : aliased constant String := "Turtle";
   M_64            : aliased constant String := "";
   K_65            : aliased constant String := "GLSL";
   M_65            : aliased constant String := "";
   K_66            : aliased constant String := "Shell";
   M_66            : aliased constant String := "";
   K_67            : aliased constant String := "C";
   M_67            : aliased constant String := "C-style";
   K_68            : aliased constant String := "D";
   M_68            : aliased constant String := "C-style";
   K_69            : aliased constant String := "Nim";
   M_69            : aliased constant String := "";
   K_70            : aliased constant String := "E";
   M_70            : aliased constant String := "";
   K_71            : aliased constant String := "Record Jar";
   M_71            : aliased constant String := "";
   K_72            : aliased constant String := "Edje Data Collection";
   M_72            : aliased constant String := "";
   K_73            : aliased constant String := "Pug";
   M_73            : aliased constant String := "";
   K_74            : aliased constant String := "Sweave";
   M_74            : aliased constant String := "";
   K_75            : aliased constant String := "XCompose";
   M_75            : aliased constant String := "";
   K_76            : aliased constant String := "XSLT";
   M_76            : aliased constant String := "";
   K_77            : aliased constant String := "Meson";
   M_77            : aliased constant String := "";
   K_78            : aliased constant String := "Gentoo Eclass";
   M_78            : aliased constant String := "";
   K_79            : aliased constant String := "Glimmer TS";
   M_79            : aliased constant String := "";
   K_80            : aliased constant String := "J";
   M_80            : aliased constant String := "";
   K_81            : aliased constant String := "Nit";
   M_81            : aliased constant String := "";
   K_82            : aliased constant String := "dircolors";
   M_82            : aliased constant String := "";
   K_83            : aliased constant String := "ActionScript";
   M_83            : aliased constant String := "";
   K_84            : aliased constant String := "Earthly";
   M_84            : aliased constant String := "";
   K_85            : aliased constant String := "M";
   M_85            : aliased constant String := "";
   K_86            : aliased constant String := "EQ";
   M_86            : aliased constant String := "";
   K_87            : aliased constant String := "Jsonnet";
   M_87            : aliased constant String := "";
   K_88            : aliased constant String := "Nix";
   M_88            : aliased constant String := "";
   K_89            : aliased constant String := "Genero 4gl";
   M_89            : aliased constant String := "";
   K_90            : aliased constant String := "mcfunction";
   M_90            : aliased constant String := "";
   K_91            : aliased constant String := "Portugol";
   M_91            : aliased constant String := "";
   K_92            : aliased constant String := "Unix Assembly";
   M_92            : aliased constant String := "";
   K_93            : aliased constant String := "R";
   M_93            : aliased constant String := "";
   K_94            : aliased constant String := "APL";
   M_94            : aliased constant String := "";
   K_95            : aliased constant String := "Fluent";
   M_95            : aliased constant String := "";
   K_96            : aliased constant String := "ShaderLab";
   M_96            : aliased constant String := "";
   K_97            : aliased constant String := "V";
   M_97            : aliased constant String := "";
   K_98            : aliased constant String := "TSQL";
   M_98            : aliased constant String := "";
   K_99            : aliased constant String := "Wollok";
   M_99            : aliased constant String := "";
   K_100           : aliased constant String := "Papyrus";
   M_100           : aliased constant String := "";
   K_101           : aliased constant String := "Swift";
   M_101           : aliased constant String := "C-style";
   K_102           : aliased constant String := "Ren'Py";
   M_102           : aliased constant String := "";
   K_103           : aliased constant String := "Option List";
   M_103           : aliased constant String := "";
   K_104           : aliased constant String := "AMPL";
   M_104           : aliased constant String := "";
   K_105           : aliased constant String := "Gentoo Ebuild";
   M_105           : aliased constant String := "";
   K_106           : aliased constant String := "Gradle";
   M_106           : aliased constant String := "";
   K_107           : aliased constant String := "Shen";
   M_107           : aliased constant String := "";
   K_108           : aliased constant String := "Clean";
   M_108           : aliased constant String := "";
   K_109           : aliased constant String := "Common Lisp";
   M_109           : aliased constant String := "semicolon";
   K_110           : aliased constant String := "Python traceback";
   M_110           : aliased constant String := "";
   K_111           : aliased constant String := "Crystal";
   M_111           : aliased constant String := "";
   K_112           : aliased constant String := "Cue Sheet";
   M_112           : aliased constant String := "";
   K_113           : aliased constant String := "Odin";
   M_113           : aliased constant String := "";
   K_114           : aliased constant String := "Qt Script";
   M_114           : aliased constant String := "";
   K_115           : aliased constant String := "Clojure";
   M_115           : aliased constant String := "";
   K_116           : aliased constant String := "Fancy";
   M_116           : aliased constant String := "";
   K_117           : aliased constant String := "JSONLD";
   M_117           : aliased constant String := "";
   K_118           : aliased constant String := "Sass";
   M_118           : aliased constant String := "";
   K_119           : aliased constant String := "Valve Data Format";
   M_119           : aliased constant String := "";
   K_120           : aliased constant String := "Oberon";
   M_120           : aliased constant String := "";
   K_121           : aliased constant String := "LTspice Symbol";
   M_121           : aliased constant String := "";
   K_122           : aliased constant String := "RPC";
   M_122           : aliased constant String := "";
   K_123           : aliased constant String := "Gnuplot";
   M_123           : aliased constant String := "";
   K_124           : aliased constant String := "q";
   M_124           : aliased constant String := "";
   K_125           : aliased constant String := "Omgrofl";
   M_125           : aliased constant String := "";
   K_126           : aliased constant String := "Latte";
   M_126           : aliased constant String := "";
   K_127           : aliased constant String := "Bison";
   M_127           : aliased constant String := "";
   K_128           : aliased constant String := "ANTLR";
   M_128           : aliased constant String := "";
   K_129           : aliased constant String := "Cuda";
   M_129           : aliased constant String := "";
   K_130           : aliased constant String := "SVG";
   M_130           : aliased constant String := "";
   K_131           : aliased constant String := "KerboScript";
   M_131           : aliased constant String := "";
   K_132           : aliased constant String := "Gosu";
   M_132           : aliased constant String := "";
   K_133           : aliased constant String := "MiniYAML";
   M_133           : aliased constant String := "";
   K_134           : aliased constant String := "Alpine Abuild";
   M_134           : aliased constant String := "";
   K_135           : aliased constant String := "Procfile";
   M_135           : aliased constant String := "";
   K_136           : aliased constant String := "xBase";
   M_136           : aliased constant String := "";
   K_137           : aliased constant String := "Ring";
   M_137           : aliased constant String := "";
   K_138           : aliased constant String := "Mirah";
   M_138           : aliased constant String := "";
   K_139           : aliased constant String := "Volt";
   M_139           : aliased constant String := "";
   K_140           : aliased constant String := "C++";
   M_140           : aliased constant String := "C-style";
   K_141           : aliased constant String := "Vue";
   M_141           : aliased constant String := "";
   K_142           : aliased constant String := "DTrace";
   M_142           : aliased constant String := "";
   K_143           : aliased constant String := "Nunjucks";
   M_143           : aliased constant String := "";
   K_144           : aliased constant String := "Java";
   M_144           : aliased constant String := "C-style";
   K_145           : aliased constant String := "PicoLisp";
   M_145           : aliased constant String := "";
   K_146           : aliased constant String := "TI Program";
   M_146           : aliased constant String := "";
   K_147           : aliased constant String := "XML Property List";
   M_147           : aliased constant String := "";
   K_148           : aliased constant String := "Gemfile.lock";
   M_148           : aliased constant String := "";
   K_149           : aliased constant String := "Blade";
   M_149           : aliased constant String := "";
   K_150           : aliased constant String := "TOML";
   M_150           : aliased constant String := "";
   K_151           : aliased constant String := "BibTeX";
   M_151           : aliased constant String := "";
   K_152           : aliased constant String := "Literate CoffeeScript";
   M_152           : aliased constant String := "";
   K_153           : aliased constant String := "PogoScript";
   M_153           : aliased constant String := "";
   K_154           : aliased constant String := "Quake";
   M_154           : aliased constant String := "";
   K_155           : aliased constant String := "World of Warcraft Addon Data";
   M_155           : aliased constant String := "";
   K_156           : aliased constant String := "Motoko";
   M_156           : aliased constant String := "";
   K_157           : aliased constant String := "2-Dimensional Array";
   M_157           : aliased constant String := "";
   K_158           : aliased constant String := "Rich Text Format";
   M_158           : aliased constant String := "";
   K_159           : aliased constant String := "Type Language";
   M_159           : aliased constant String := "";
   K_160           : aliased constant String := "GCC Machine Description";
   M_160           : aliased constant String := "";
   K_161           : aliased constant String := "QMake";
   M_161           : aliased constant String := "";
   K_162           : aliased constant String := "fish";
   M_162           : aliased constant String := "";
   K_163           : aliased constant String := "Proguard";
   M_163           : aliased constant String := "";
   K_164           : aliased constant String := "Darcs Patch";
   M_164           : aliased constant String := "";
   K_165           : aliased constant String := "Ox";
   M_165           : aliased constant String := "";
   K_166           : aliased constant String := "Oz";
   M_166           : aliased constant String := "";
   K_167           : aliased constant String := "GDScript";
   M_167           : aliased constant String := "";
   K_168           : aliased constant String := "CodeQL";
   M_168           : aliased constant String := "";
   K_169           : aliased constant String := "Vyper";
   M_169           : aliased constant String := "";
   K_170           : aliased constant String := "Easybuild";
   M_170           : aliased constant String := "";
   K_171           : aliased constant String := "XQuery";
   M_171           : aliased constant String := "";
   K_172           : aliased constant String := "WGSL";
   M_172           : aliased constant String := "";
   K_173           : aliased constant String := "Marko";
   M_173           : aliased constant String := "";
   K_174           : aliased constant String := "EmberScript";
   M_174           : aliased constant String := "";
   K_175           : aliased constant String := "MoonScript";
   M_175           : aliased constant String := "";
   K_176           : aliased constant String := "Typst";
   M_176           : aliased constant String := "";
   K_177           : aliased constant String := "Modula-2";
   M_177           : aliased constant String := "";
   K_178           : aliased constant String := "AspectJ";
   M_178           : aliased constant String := "";
   K_179           : aliased constant String := "Modula-3";
   M_179           : aliased constant String := "";
   K_180           : aliased constant String := "Makefile";
   M_180           : aliased constant String := "Shell";
   K_181           : aliased constant String := "WebAssembly Interface Type";
   M_181           : aliased constant String := "";
   K_182           : aliased constant String := "Isabelle";
   M_182           : aliased constant String := "";
   K_183           : aliased constant String := "Jison";
   M_183           : aliased constant String := "";
   K_184           : aliased constant String := "Cython";
   M_184           : aliased constant String := "";
   K_185           : aliased constant String := "Ada";
   M_185           : aliased constant String := "dash-style";
   K_186           : aliased constant String := "Clarion";
   M_186           : aliased constant String := "";
   K_187           : aliased constant String := "Common Workflow Language";
   M_187           : aliased constant String := "";
   K_188           : aliased constant String := "OpenSCAD";
   M_188           : aliased constant String := "";
   K_189           : aliased constant String := "Elvish Transcript";
   M_189           : aliased constant String := "";
   K_190           : aliased constant String := "Dockerfile";
   M_190           : aliased constant String := "";
   K_191           : aliased constant String := "Zig";
   M_191           : aliased constant String := "";
   K_192           : aliased constant String := "Ecmarkup";
   M_192           : aliased constant String := "";
   K_193           : aliased constant String := "Bicep";
   M_193           : aliased constant String := "";
   K_194           : aliased constant String := "NASL";
   M_194           : aliased constant String := "";
   K_195           : aliased constant String := "kvlang";
   M_195           : aliased constant String := "";
   K_196           : aliased constant String := "Macaulay2";
   M_196           : aliased constant String := "";
   K_197           : aliased constant String := "SourcePawn";
   M_197           : aliased constant String := "";
   K_198           : aliased constant String := "Lean";
   M_198           : aliased constant String := "";
   K_199           : aliased constant String := "HTML+ECR";
   M_199           : aliased constant String := "";
   K_200           : aliased constant String := "Browserslist";
   M_200           : aliased constant String := "";
   K_201           : aliased constant String := "EditorConfig";
   M_201           : aliased constant String := "";
   K_202           : aliased constant String := "LabVIEW";
   M_202           : aliased constant String := "";
   K_203           : aliased constant String := "Genshi";
   M_203           : aliased constant String := "";
   K_204           : aliased constant String := "Pep8";
   M_204           : aliased constant String := "";
   K_205           : aliased constant String := "Faust";
   M_205           : aliased constant String := "";
   K_206           : aliased constant String := "Text";
   M_206           : aliased constant String := "";
   K_207           : aliased constant String := "Pod";
   M_207           : aliased constant String := "";
   K_208           : aliased constant String := "Forth";
   M_208           : aliased constant String := "Forth-style";
   K_209           : aliased constant String := "Talon";
   M_209           : aliased constant String := "";
   K_210           : aliased constant String := "Genero per";
   M_210           : aliased constant String := "";
   K_211           : aliased constant String := "G-code";
   M_211           : aliased constant String := "";
   K_212           : aliased constant String := "ASN.1";
   M_212           : aliased constant String := "";
   K_213           : aliased constant String := "Janet";
   M_213           : aliased constant String := "";
   K_214           : aliased constant String := "OASv3-yaml";
   M_214           : aliased constant String := "";
   K_215           : aliased constant String := "Checksums";
   M_215           : aliased constant String := "";
   K_216           : aliased constant String := "Visual Basic .NET";
   M_216           : aliased constant String := "";
   K_217           : aliased constant String := "Xojo";
   M_217           : aliased constant String := "";
   K_218           : aliased constant String := "CODEOWNERS";
   M_218           : aliased constant String := "";
   K_219           : aliased constant String := "TLA";
   M_219           : aliased constant String := "";
   K_220           : aliased constant String := "GAML";
   M_220           : aliased constant String := "";
   K_221           : aliased constant String := "Pip Requirements";
   M_221           : aliased constant String := "";
   K_222           : aliased constant String := "Stata";
   M_222           : aliased constant String := "";
   K_223           : aliased constant String := "SRecode Template";
   M_223           : aliased constant String := "";
   K_224           : aliased constant String := "Asymptote";
   M_224           : aliased constant String := "";
   K_225           : aliased constant String := "HXML";
   M_225           : aliased constant String := "";
   K_226           : aliased constant String := "GAMS";
   M_226           : aliased constant String := "";
   K_227           : aliased constant String := "Move";
   M_227           : aliased constant String := "";
   K_228           : aliased constant String := "REALbasic";
   M_228           : aliased constant String := "";
   K_229           : aliased constant String := "Objective-C";
   M_229           : aliased constant String := "C-style";
   K_230           : aliased constant String := "VBScript";
   M_230           : aliased constant String := "";
   K_231           : aliased constant String := "MLIR";
   M_231           : aliased constant String := "";
   K_232           : aliased constant String := "Scaml";
   M_232           : aliased constant String := "";
   K_233           : aliased constant String := "SubRip Text";
   M_233           : aliased constant String := "";
   K_234           : aliased constant String := "Oxygene";
   M_234           : aliased constant String := "";
   K_235           : aliased constant String := "Objective-J";
   M_235           : aliased constant String := "";
   K_236           : aliased constant String := "OpenEdge ABL";
   M_236           : aliased constant String := "";
   K_237           : aliased constant String := "Zephir";
   M_237           : aliased constant String := "";
   K_238           : aliased constant String := "Godot Resource";
   M_238           : aliased constant String := "";
   K_239           : aliased constant String := "JFlex";
   M_239           : aliased constant String := "";
   K_240           : aliased constant String := "Ninja";
   M_240           : aliased constant String := "";
   K_241           : aliased constant String := "Promela";
   M_241           : aliased constant String := "";
   K_242           : aliased constant String := "BlitzMax";
   M_242           : aliased constant String := "";
   K_243           : aliased constant String := "C-ObjDump";
   M_243           : aliased constant String := "";
   K_244           : aliased constant String := "Svelte";
   M_244           : aliased constant String := "";
   K_245           : aliased constant String := "PlantUML";
   M_245           : aliased constant String := "";
   K_246           : aliased constant String := "XML";
   M_246           : aliased constant String := "";
   K_247           : aliased constant String := "Propeller Spin";
   M_247           : aliased constant String := "";
   K_248           : aliased constant String := "Ballerina";
   M_248           : aliased constant String := "";
   K_249           : aliased constant String := "Mercury";
   M_249           : aliased constant String := "";
   K_250           : aliased constant String := "JSON with Comments";
   M_250           : aliased constant String := "";
   K_251           : aliased constant String := "StringTemplate";
   M_251           : aliased constant String := "";
   K_252           : aliased constant String := "ATS";
   M_252           : aliased constant String := "";
   K_253           : aliased constant String := "YANG";
   M_253           : aliased constant String := "";
   K_254           : aliased constant String := "CIL";
   M_254           : aliased constant String := "";
   K_255           : aliased constant String := "Wikitext";
   M_255           : aliased constant String := "";
   K_256           : aliased constant String := "Tcl";
   M_256           : aliased constant String := "";
   K_257           : aliased constant String := "Spline Font Database";
   M_257           : aliased constant String := "";
   K_258           : aliased constant String := "ZenScript";
   M_258           : aliased constant String := "";
   K_259           : aliased constant String := "CMake";
   M_259           : aliased constant String := "";
   K_260           : aliased constant String := "Closure Templates";
   M_260           : aliased constant String := "";
   K_261           : aliased constant String := "F#";
   M_261           : aliased constant String := "";
   K_262           : aliased constant String := "Apollo Guidance Computer";
   M_262           : aliased constant String := "";
   K_263           : aliased constant String := "API Blueprint";
   M_263           : aliased constant String := "";
   K_264           : aliased constant String := "Jolie";
   M_264           : aliased constant String := "";
   K_265           : aliased constant String := "Kusto";
   M_265           : aliased constant String := "";
   K_266           : aliased constant String := "F*";
   M_266           : aliased constant String := "";
   K_267           : aliased constant String := "LigoLANG";
   M_267           : aliased constant String := "";
   K_268           : aliased constant String := "Imba";
   M_268           : aliased constant String := "";
   K_269           : aliased constant String := "Io";
   M_269           : aliased constant String := "";
   K_270           : aliased constant String := "TL-Verilog";
   M_270           : aliased constant String := "";
   K_271           : aliased constant String := "Public Key";
   M_271           : aliased constant String := "";
   K_272           : aliased constant String := "AutoIt";
   M_272           : aliased constant String := "";
   K_273           : aliased constant String := "Csound Document";
   M_273           : aliased constant String := "";
   K_274           : aliased constant String := "Snakemake";
   M_274           : aliased constant String := "";
   K_275           : aliased constant String := "Redcode";
   M_275           : aliased constant String := "";
   K_276           : aliased constant String := "Tcsh";
   M_276           : aliased constant String := "";
   K_277           : aliased constant String := "Lua";
   M_277           : aliased constant String := "";
   K_278           : aliased constant String := "PHP";
   M_278           : aliased constant String := "C-style";
   K_279           : aliased constant String := "Nushell";
   M_279           : aliased constant String := "";
   K_280           : aliased constant String := "Parrot Assembly";
   M_280           : aliased constant String := "";
   K_281           : aliased constant String := "Haskell";
   M_281           : aliased constant String := "Haskell-style";
   K_282           : aliased constant String := "Brainfuck";
   M_282           : aliased constant String := "";
   K_283           : aliased constant String := "Praat";
   M_283           : aliased constant String := "";
   K_284           : aliased constant String := "Dhall";
   M_284           : aliased constant String := "";
   K_285           : aliased constant String := "Monkey C";
   M_285           : aliased constant String := "";
   K_286           : aliased constant String := "Smalltalk";
   M_286           : aliased constant String := "Smalltalk-style";
   K_287           : aliased constant String := "Alloy";
   M_287           : aliased constant String := "";
   K_288           : aliased constant String := "Opa";
   M_288           : aliased constant String := "";
   K_289           : aliased constant String := "Berry";
   M_289           : aliased constant String := "";
   K_290           : aliased constant String := "Literate Haskell";
   M_290           : aliased constant String := "";
   K_291           : aliased constant String := "CSS";
   M_291           : aliased constant String := "C-block";
   K_292           : aliased constant String := "Elm";
   M_292           : aliased constant String := "";
   K_293           : aliased constant String := "Markdown";
   M_293           : aliased constant String := "";
   K_294           : aliased constant String := "CSV";
   M_294           : aliased constant String := "";
   K_295           : aliased constant String := "HTML+Razor";
   M_295           : aliased constant String := "";
   K_296           : aliased constant String := "LookML";
   M_296           : aliased constant String := "";
   K_297           : aliased constant String := "Gettext Catalog";
   M_297           : aliased constant String := "";
   K_298           : aliased constant String := "LLVM";
   M_298           : aliased constant String := "";
   K_299           : aliased constant String := "JetBrains MPS";
   M_299           : aliased constant String := "";
   K_300           : aliased constant String := "TextMate Properties";
   M_300           : aliased constant String := "";
   K_301           : aliased constant String := "Maven POM";
   M_301           : aliased constant String := "";
   K_302           : aliased constant String := "JSON5";
   M_302           : aliased constant String := "";
   K_303           : aliased constant String := "UnrealScript";
   M_303           : aliased constant String := "";
   K_304           : aliased constant String := "jq";
   M_304           : aliased constant String := "";
   K_305           : aliased constant String := "Monkey";
   M_305           : aliased constant String := "";
   K_306           : aliased constant String := "Cairo";
   M_306           : aliased constant String := "";
   K_307           : aliased constant String := "WDL";
   M_307           : aliased constant String := "";
   K_308           : aliased constant String := "Visual Basic 6.0";
   M_308           : aliased constant String := "";
   K_309           : aliased constant String := "HCL";
   M_309           : aliased constant String := "";
   K_310           : aliased constant String := "EdgeQL";
   M_310           : aliased constant String := "";
   K_311           : aliased constant String := "nesC";
   M_311           : aliased constant String := "";
   K_312           : aliased constant String := "P4";
   M_312           : aliased constant String := "";
   K_313           : aliased constant String := "Parrot Internal Representation";
   M_313           : aliased constant String := "";
   K_314           : aliased constant String := "Texinfo";
   M_314           : aliased constant String := "";
   K_315           : aliased constant String := "Puppet";
   M_315           : aliased constant String := "";
   K_316           : aliased constant String := "Rouge";
   M_316           : aliased constant String := "";
   K_317           : aliased constant String := "Wren";
   M_317           : aliased constant String := "";
   K_318           : aliased constant String := "robots.txt";
   M_318           : aliased constant String := "";
   K_319           : aliased constant String := "NWScript";
   M_319           : aliased constant String := "";
   K_320           : aliased constant String := "TypeScript";
   M_320           : aliased constant String := "C-style";
   K_321           : aliased constant String := "X Font Directory Index";
   M_321           : aliased constant String := "";
   K_322           : aliased constant String := "Gemini";
   M_322           : aliased constant String := "";
   K_323           : aliased constant String := "Groovy";
   M_323           : aliased constant String := "C-style";
   K_324           : aliased constant String := "C#";
   M_324           : aliased constant String := "C-style";
   K_325           : aliased constant String := "SMT";
   M_325           : aliased constant String := "";
   K_326           : aliased constant String := "Wavefront Object";
   M_326           : aliased constant String := "";
   K_327           : aliased constant String := "Win32 Message File";
   M_327           : aliased constant String := "";
   K_328           : aliased constant String := "Pic";
   M_328           : aliased constant String := "";
   K_329           : aliased constant String := "NSIS";
   M_329           : aliased constant String := "";
   K_330           : aliased constant String := "Cool";
   M_330           : aliased constant String := "";
   K_331           : aliased constant String := "ABAP CDS";
   M_331           : aliased constant String := "";
   K_332           : aliased constant String := "Limbo";
   M_332           : aliased constant String := "";
   K_333           : aliased constant String := "BlitzBasic";
   M_333           : aliased constant String := "";
   K_334           : aliased constant String := "Smithy";
   M_334           : aliased constant String := "";
   K_335           : aliased constant String := "Befunge";
   M_335           : aliased constant String := "";
   K_336           : aliased constant String := "TSV";
   M_336           : aliased constant String := "";
   K_337           : aliased constant String := "Assembly";
   M_337           : aliased constant String := "";
   K_338           : aliased constant String := "TSX";
   M_338           : aliased constant String := "";
   K_339           : aliased constant String := "Pod 6";
   M_339           : aliased constant String := "";
   K_340           : aliased constant String := "UrWeb";
   M_340           : aliased constant String := "";
   K_341           : aliased constant String := "Mako";
   M_341           : aliased constant String := "";
   K_342           : aliased constant String := "Witcher Script";
   M_342           : aliased constant String := "";
   K_343           : aliased constant String := "Objective-C++";
   M_343           : aliased constant String := "";
   K_344           : aliased constant String := "Prolog";
   M_344           : aliased constant String := "";
   K_345           : aliased constant String := "Click";
   M_345           : aliased constant String := "";
   K_346           : aliased constant String := "JavaScript+ERB";
   M_346           : aliased constant String := "";
   K_347           : aliased constant String := "SPARQL";
   M_347           : aliased constant String := "";
   K_348           : aliased constant String := "Java Properties";
   M_348           : aliased constant String := "";
   K_349           : aliased constant String := "Eagle";
   M_349           : aliased constant String := "";
   K_350           : aliased constant String := "Circom";
   M_350           : aliased constant String := "";
   K_351           : aliased constant String := "FreeMarker";
   M_351           : aliased constant String := "";
   K_352           : aliased constant String := "Ioke";
   M_352           : aliased constant String := "";
   K_353           : aliased constant String := "Microsoft Developer Studio Project";
   M_353           : aliased constant String := "";
   K_354           : aliased constant String := "Muse";
   M_354           : aliased constant String := "";
   K_355           : aliased constant String := "ZIL";
   M_355           : aliased constant String := "";
   K_356           : aliased constant String := "YASnippet";
   M_356           : aliased constant String := "";
   K_357           : aliased constant String := "D-ObjDump";
   M_357           : aliased constant String := "";
   K_358           : aliased constant String := "Go Module";
   M_358           : aliased constant String := "";
   K_359           : aliased constant String := "Cabal Config";
   M_359           : aliased constant String := "";
   K_360           : aliased constant String := "Simple File Verification";
   M_360           : aliased constant String := "";
   K_361           : aliased constant String := "Nearley";
   M_361           : aliased constant String := "";
   K_362           : aliased constant String := "Sage";
   M_362           : aliased constant String := "";
   K_363           : aliased constant String := "Ignore List";
   M_363           : aliased constant String := "";
   K_364           : aliased constant String := "NPM Config";
   M_364           : aliased constant String := "";
   K_365           : aliased constant String := "KiCad Layout";
   M_365           : aliased constant String := "";
   K_366           : aliased constant String := "DataWeave";
   M_366           : aliased constant String := "";
   K_367           : aliased constant String := "Nasal";
   M_367           : aliased constant String := "";
   K_368           : aliased constant String := "OASv2-json";
   M_368           : aliased constant String := "";
   K_369           : aliased constant String := "Arc";
   M_369           : aliased constant String := "";
   K_370           : aliased constant String := "Riot";
   M_370           : aliased constant String := "";
   K_371           : aliased constant String := "NCL";
   M_371           : aliased constant String := "";
   K_372           : aliased constant String := "Augeas";
   M_372           : aliased constant String := "";
   K_373           : aliased constant String := "Max";
   M_373           : aliased constant String := "";
   K_374           : aliased constant String := "Toit";
   M_374           : aliased constant String := "";
   K_375           : aliased constant String := "Diff";
   M_375           : aliased constant String := "";
   K_376           : aliased constant String := "Jison Lex";
   M_376           : aliased constant String := "";
   K_377           : aliased constant String := "Gerber Image";
   M_377           : aliased constant String := "";
   K_378           : aliased constant String := "Raw token data";
   M_378           : aliased constant String := "";
   K_379           : aliased constant String := "KakouneScript";
   M_379           : aliased constant String := "";
   K_380           : aliased constant String := "M4";
   M_380           : aliased constant String := "";
   K_381           : aliased constant String := "sed";
   M_381           : aliased constant String := "";
   K_382           : aliased constant String := "Yacc";
   M_382           : aliased constant String := "C-style";
   K_383           : aliased constant String := "nanorc";
   M_383           : aliased constant String := "";
   K_384           : aliased constant String := "Eiffel";
   M_384           : aliased constant String := "";
   K_385           : aliased constant String := "Fantom";
   M_385           : aliased constant String := "";
   K_386           : aliased constant String := "KRL";
   M_386           : aliased constant String := "";
   K_387           : aliased constant String := "SWIG";
   M_387           : aliased constant String := "";
   K_388           : aliased constant String := "Pike";
   M_388           : aliased constant String := "";
   K_389           : aliased constant String := "HAProxy";
   M_389           : aliased constant String := "";
   K_390           : aliased constant String := "Creole";
   M_390           : aliased constant String := "";
   K_391           : aliased constant String := "Curry";
   M_391           : aliased constant String := "";
   K_392           : aliased constant String := "Linux Kernel Module";
   M_392           : aliased constant String := "";
   K_393           : aliased constant String := "OpenType Feature File";
   M_393           : aliased constant String := "";
   K_394           : aliased constant String := "KiCad Legacy Layout";
   M_394           : aliased constant String := "";
   K_395           : aliased constant String := "GDB";
   M_395           : aliased constant String := "";
   K_396           : aliased constant String := "IGOR Pro";
   M_396           : aliased constant String := "";
   K_397           : aliased constant String := "Filebench WML";
   M_397           : aliased constant String := "";
   K_398           : aliased constant String := "mupad";
   M_398           : aliased constant String := "";
   K_399           : aliased constant String := "Lex";
   M_399           : aliased constant String := "C-style";
   K_400           : aliased constant String := "Pony";
   M_400           : aliased constant String := "";
   K_401           : aliased constant String := "Scilab";
   M_401           : aliased constant String := "";
   K_402           : aliased constant String := "ShellSession";
   M_402           : aliased constant String := "";
   K_403           : aliased constant String := "Whiley";
   M_403           : aliased constant String := "";
   K_404           : aliased constant String := "HyPhy";
   M_404           : aliased constant String := "";
   K_405           : aliased constant String := "Racket";
   M_405           : aliased constant String := "";
   K_406           : aliased constant String := "ABNF";
   M_406           : aliased constant String := "";
   K_407           : aliased constant String := "Filterscript";
   M_407           : aliased constant String := "";
   K_408           : aliased constant String := "Web Ontology Language";
   M_408           : aliased constant String := "";
   K_409           : aliased constant String := "YARA";
   M_409           : aliased constant String := "";
   K_410           : aliased constant String := "Zimpl";
   M_410           : aliased constant String := "";
   K_411           : aliased constant String := "STAR";
   M_411           : aliased constant String := "";
   K_412           : aliased constant String := "DenizenScript";
   M_412           : aliased constant String := "";
   K_413           : aliased constant String := "M4Sugar";
   M_413           : aliased constant String := "";
   K_414           : aliased constant String := "STL";
   M_414           : aliased constant String := "";
   K_415           : aliased constant String := "Roff Manpage";
   M_415           : aliased constant String := "";
   K_416           : aliased constant String := "Kit";
   M_416           : aliased constant String := "";
   K_417           : aliased constant String := "IRC log";
   M_417           : aliased constant String := "";
   K_418           : aliased constant String := "FreeBasic";
   M_418           : aliased constant String := "";
   K_419           : aliased constant String := "Jupyter Notebook";
   M_419           : aliased constant String := "";
   K_420           : aliased constant String := "Genie";
   M_420           : aliased constant String := "";
   K_421           : aliased constant String := "Logos";
   M_421           : aliased constant String := "";
   K_422           : aliased constant String := "Slice";
   M_422           : aliased constant String := "";
   K_423           : aliased constant String := "HTML";
   M_423           : aliased constant String := "";
   K_424           : aliased constant String := "Red";
   M_424           : aliased constant String := "";
   K_425           : aliased constant String := "AsciiDoc";
   M_425           : aliased constant String := "";
   K_426           : aliased constant String := "Literate Agda";
   M_426           : aliased constant String := "";
   K_427           : aliased constant String := "Bluespec BH";
   M_427           : aliased constant String := "";
   K_428           : aliased constant String := "Frege";
   M_428           : aliased constant String := "";
   K_429           : aliased constant String := "1C Enterprise";
   M_429           : aliased constant String := "";
   K_430           : aliased constant String := "Go Checksums";
   M_430           : aliased constant String := "";
   K_431           : aliased constant String := "Julia";
   M_431           : aliased constant String := "";
   K_432           : aliased constant String := "C2hs Haskell";
   M_432           : aliased constant String := "";
   K_433           : aliased constant String := "ABAP";
   M_433           : aliased constant String := "";
   K_434           : aliased constant String := "SmPL";
   M_434           : aliased constant String := "";
   K_435           : aliased constant String := "Dotenv";
   M_435           : aliased constant String := "";
   K_436           : aliased constant String := "Thrift";
   M_436           : aliased constant String := "";
   K_437           : aliased constant String := "RPM Spec";
   M_437           : aliased constant String := "";
   K_438           : aliased constant String := "AppleScript";
   M_438           : aliased constant String := "";
   K_439           : aliased constant String := "VBA";
   M_439           : aliased constant String := "";
   K_440           : aliased constant String := "RobotFramework";
   M_440           : aliased constant String := "";
   K_441           : aliased constant String := "Gherkin";
   M_441           : aliased constant String := "";
   K_442           : aliased constant String := "Dogescript";
   M_442           : aliased constant String := "";
   K_443           : aliased constant String := "Adblock Filter List";
   M_443           : aliased constant String := "";
   K_444           : aliased constant String := "Rez";
   M_444           : aliased constant String := "";
   K_445           : aliased constant String := "Glyph Bitmap Distribution Format";
   M_445           : aliased constant String := "";
   K_446           : aliased constant String := "Python console";
   M_446           : aliased constant String := "";
   K_447           : aliased constant String := "Soong";
   M_447           : aliased constant String := "";
   K_448           : aliased constant String := "Regular Expression";
   M_448           : aliased constant String := "";
   K_449           : aliased constant String := "Standard ML";
   M_449           : aliased constant String := "OCaml";
   K_450           : aliased constant String := "SugarSS";
   M_450           : aliased constant String := "";
   K_451           : aliased constant String := "Roc";
   M_451           : aliased constant String := "";
   K_452           : aliased constant String := "Sway";
   M_452           : aliased constant String := "";
   K_453           : aliased constant String := "Graphviz (DOT)";
   M_453           : aliased constant String := "";
   K_454           : aliased constant String := "FIGlet Font";
   M_454           : aliased constant String := "";
   K_455           : aliased constant String := "MDX";
   M_455           : aliased constant String := "";
   K_456           : aliased constant String := "GAP";
   M_456           : aliased constant String := "";
   K_457           : aliased constant String := "OpenQASM";
   M_457           : aliased constant String := "";
   K_458           : aliased constant String := "Vala";
   M_458           : aliased constant String := "";
   K_459           : aliased constant String := "WebIDL";
   M_459           : aliased constant String := "";
   K_460           : aliased constant String := "Xonsh";
   M_460           : aliased constant String := "";
   K_461           : aliased constant String := "JAR Manifest";
   M_461           : aliased constant String := "";
   K_462           : aliased constant String := "PowerBuilder";
   M_462           : aliased constant String := "";
   K_463           : aliased constant String := "SuperCollider";
   M_463           : aliased constant String := "";
   K_464           : aliased constant String := "Cycript";
   M_464           : aliased constant String := "";
   K_465           : aliased constant String := "Lean 4";
   M_465           : aliased constant String := "";
   K_466           : aliased constant String := "SQF";
   M_466           : aliased constant String := "";
   K_467           : aliased constant String := "CSON";
   M_467           : aliased constant String := "";
   K_468           : aliased constant String := "Debian Package Control File";
   M_468           : aliased constant String := "";
   K_469           : aliased constant String := "SQL";
   M_469           : aliased constant String := "";
   K_470           : aliased constant String := "Hack";
   M_470           : aliased constant String := "";
   K_471           : aliased constant String := "Myghty";
   M_471           : aliased constant String := "";
   K_472           : aliased constant String := "Redirect Rules";
   M_472           : aliased constant String := "";
   K_473           : aliased constant String := "Inform 7";
   M_473           : aliased constant String := "";
   K_474           : aliased constant String := "ShellCheck Config";
   M_474           : aliased constant String := "";
   K_475           : aliased constant String := "NetLinx+ERB";
   M_475           : aliased constant String := "";
   K_476           : aliased constant String := "Hosts File";
   M_476           : aliased constant String := "";
   K_477           : aliased constant String := "Mojo";
   M_477           : aliased constant String := "";
   K_478           : aliased constant String := "Gleam";
   M_478           : aliased constant String := "";
   K_479           : aliased constant String := "Pact";
   M_479           : aliased constant String := "";
   K_480           : aliased constant String := "ImageJ Macro";
   M_480           : aliased constant String := "";
   K_481           : aliased constant String := "PostCSS";
   M_481           : aliased constant String := "";
   K_482           : aliased constant String := "Ceylon";
   M_482           : aliased constant String := "";
   K_483           : aliased constant String := "BitBake";
   M_483           : aliased constant String := "";
   K_484           : aliased constant String := "Charity";
   M_484           : aliased constant String := "";
   K_485           : aliased constant String := "Lasso";
   M_485           : aliased constant String := "";
   K_486           : aliased constant String := "Pickle";
   M_486           : aliased constant String := "";
   K_487           : aliased constant String := "Elvish";
   M_487           : aliased constant String := "";
   K_488           : aliased constant String := "Kaitai Struct";
   M_488           : aliased constant String := "";
   K_489           : aliased constant String := "Haml";
   M_489           : aliased constant String := "";
   K_490           : aliased constant String := "Ruby";
   M_490           : aliased constant String := "Shell";
   K_491           : aliased constant String := "Liquid";
   M_491           : aliased constant String := "";
   K_492           : aliased constant String := "Cypher";
   M_492           : aliased constant String := "";
   K_493           : aliased constant String := "Go Workspace";
   M_493           : aliased constant String := "";
   K_494           : aliased constant String := "SaltStack";
   M_494           : aliased constant String := "";
   K_495           : aliased constant String := "LoomScript";
   M_495           : aliased constant String := "";
   K_496           : aliased constant String := "Inno Setup";
   M_496           : aliased constant String := "";
   K_497           : aliased constant String := "Unity3D Asset";
   M_497           : aliased constant String := "";
   K_498           : aliased constant String := "Q#";
   M_498           : aliased constant String := "";
   K_499           : aliased constant String := "COLLADA";
   M_499           : aliased constant String := "";
   K_500           : aliased constant String := "Logtalk";
   M_500           : aliased constant String := "";
   K_501           : aliased constant String := "GraphQL";
   M_501           : aliased constant String := "";
   K_502           : aliased constant String := "Protocol Buffer Text Format";
   M_502           : aliased constant String := "";
   K_503           : aliased constant String := "edn";
   M_503           : aliased constant String := "";
   K_504           : aliased constant String := "Lark";
   M_504           : aliased constant String := "";
   K_505           : aliased constant String := "ObjectScript";
   M_505           : aliased constant String := "";
   K_506           : aliased constant String := "PostScript";
   M_506           : aliased constant String := "";
   K_507           : aliased constant String := "Verilog";
   M_507           : aliased constant String := "";
   K_508           : aliased constant String := "GN";
   M_508           : aliased constant String := "";
   K_509           : aliased constant String := "Idris";
   M_509           : aliased constant String := "";
   K_510           : aliased constant String := "Mermaid";
   M_510           : aliased constant String := "";
   K_511           : aliased constant String := "Starlark";
   M_511           : aliased constant String := "";
   K_512           : aliased constant String := "HTTP";
   M_512           : aliased constant String := "";
   K_513           : aliased constant String := "ColdFusion";
   M_513           : aliased constant String := "";
   K_514           : aliased constant String := "Rebol";
   M_514           : aliased constant String := "";
   K_515           : aliased constant String := "Ink";
   M_515           : aliased constant String := "";
   K_516           : aliased constant String := "Beef";
   M_516           : aliased constant String := "";
   K_517           : aliased constant String := "Kickstart";
   M_517           : aliased constant String := "";
   K_518           : aliased constant String := "Self";
   M_518           : aliased constant String := "";
   K_519           : aliased constant String := "Bikeshed";
   M_519           : aliased constant String := "";
   K_520           : aliased constant String := "Yul";
   M_520           : aliased constant String := "";
   K_521           : aliased constant String := "PLSQL";
   M_521           : aliased constant String := "";
   K_522           : aliased constant String := "Zeek";
   M_522           : aliased constant String := "";
   K_523           : aliased constant String := "Classic ASP";
   M_523           : aliased constant String := "";
   K_524           : aliased constant String := "Turing";
   M_524           : aliased constant String := "";
   K_525           : aliased constant String := "Cadence";
   M_525           : aliased constant String := "";
   K_526           : aliased constant String := "Batchfile";
   M_526           : aliased constant String := "";
   K_527           : aliased constant String := "Dart";
   M_527           : aliased constant String := "C-style";
   K_528           : aliased constant String := "NumPy";
   M_528           : aliased constant String := "";
   K_529           : aliased constant String := "CoNLL-U";
   M_529           : aliased constant String := "";
   K_530           : aliased constant String := "Less";
   M_530           : aliased constant String := "";
   K_531           : aliased constant String := "Fortran";
   M_531           : aliased constant String := "";
   K_532           : aliased constant String := "PowerShell";
   M_532           : aliased constant String := "PowerShell-style";
   K_533           : aliased constant String := "Smali";
   M_533           : aliased constant String := "";
   K_534           : aliased constant String := "Chapel";
   M_534           : aliased constant String := "";
   K_535           : aliased constant String := "Pawn";
   M_535           : aliased constant String := "";
   K_536           : aliased constant String := "Polar";
   M_536           : aliased constant String := "";
   K_537           : aliased constant String := "HTML+PHP";
   M_537           : aliased constant String := "";
   K_538           : aliased constant String := "Linker Script";
   M_538           : aliased constant String := "";
   K_539           : aliased constant String := "NEON";
   M_539           : aliased constant String := "";
   K_540           : aliased constant String := "Gradle Kotlin DSL";
   M_540           : aliased constant String := "";
   K_541           : aliased constant String := "ObjDump";
   M_541           : aliased constant String := "";
   K_542           : aliased constant String := "RenderScript";
   M_542           : aliased constant String := "";
   K_543           : aliased constant String := "Singularity";
   M_543           : aliased constant String := "";
   K_544           : aliased constant String := "Go";
   M_544           : aliased constant String := "C-style";
   K_545           : aliased constant String := "Avro IDL";
   M_545           : aliased constant String := "";
   K_546           : aliased constant String := "OASv2-yaml";
   M_546           : aliased constant String := "";
   K_547           : aliased constant String := "Smarty";
   M_547           : aliased constant String := "Smarty-style";
   K_548           : aliased constant String := "PureBasic";
   M_548           : aliased constant String := "";
   K_549           : aliased constant String := "Clarity";
   M_549           : aliased constant String := "";
   K_550           : aliased constant String := "D2";
   M_550           : aliased constant String := "";
   K_551           : aliased constant String := "AIDL";
   M_551           : aliased constant String := "";
   K_552           : aliased constant String := "Terra";
   M_552           : aliased constant String := "";
   K_553           : aliased constant String := "Velocity Template Language";
   M_553           : aliased constant String := "";
   K_554           : aliased constant String := "SELinux Policy";
   M_554           : aliased constant String := "";
   K_555           : aliased constant String := "Futhark";
   M_555           : aliased constant String := "";
   K_556           : aliased constant String := "DNS Zone";
   M_556           : aliased constant String := "";
   K_557           : aliased constant String := "AGS Script";
   M_557           : aliased constant String := "";
   K_558           : aliased constant String := "Boo";
   M_558           : aliased constant String := "";
   K_559           : aliased constant String := "JSON";
   M_559           : aliased constant String := "";
   K_560           : aliased constant String := "Microsoft Visual Studio Solution";
   M_560           : aliased constant String := "";
   K_561           : aliased constant String := "X10";
   M_561           : aliased constant String := "C-style";
   K_562           : aliased constant String := "JCL";
   M_562           : aliased constant String := "";
   K_563           : aliased constant String := "Erlang";
   M_563           : aliased constant String := "";
   K_564           : aliased constant String := "HiveQL";
   M_564           : aliased constant String := "";
   K_565           : aliased constant String := "Nextflow";
   M_565           : aliased constant String := "";
   K_566           : aliased constant String := "ECLiPSe";
   M_566           : aliased constant String := "";
   K_567           : aliased constant String := "MUF";
   M_567           : aliased constant String := "";
   K_568           : aliased constant String := "CartoCSS";
   M_568           : aliased constant String := "";
   K_569           : aliased constant String := "Edge";
   M_569           : aliased constant String := "";
   K_570           : aliased constant String := "Pyret";
   M_570           : aliased constant String := "";
   K_571           : aliased constant String := "CAP CDS";
   M_571           : aliased constant String := "";
   K_572           : aliased constant String := "Jinja";
   M_572           : aliased constant String := "";
   K_573           : aliased constant String := "SAS";
   M_573           : aliased constant String := "";
   K_574           : aliased constant String := "RMarkdown";
   M_574           : aliased constant String := "";
   K_575           : aliased constant String := "ReScript";
   M_575           : aliased constant String := "";
   K_576           : aliased constant String := "Squirrel";
   M_576           : aliased constant String := "";
   K_577           : aliased constant String := "OCaml";
   M_577           : aliased constant String := "";
   K_578           : aliased constant String := "ApacheConf";
   M_578           : aliased constant String := "";
   K_579           : aliased constant String := "HTML+ERB";
   M_579           : aliased constant String := "";
   K_580           : aliased constant String := "DM";
   M_580           : aliased constant String := "";
   K_581           : aliased constant String := "Grace";
   M_581           : aliased constant String := "";
   K_582           : aliased constant String := "hoon";
   M_582           : aliased constant String := "";
   K_583           : aliased constant String := "PLpgSQL";
   M_583           : aliased constant String := "";
   K_584           : aliased constant String := "CoffeeScript";
   M_584           : aliased constant String := "CoffeeScript-style";
   K_585           : aliased constant String := "Vim Script";
   M_585           : aliased constant String := "";
   K_586           : aliased constant String := "Dafny";
   M_586           : aliased constant String := "";
   K_587           : aliased constant String := "BASIC";
   M_587           : aliased constant String := "";
   K_588           : aliased constant String := "RPGLE";
   M_588           : aliased constant String := "";
   K_589           : aliased constant String := "Roff";
   M_589           : aliased constant String := "";
   K_590           : aliased constant String := "Reason";
   M_590           : aliased constant String := "";
   K_591           : aliased constant String := "STON";
   M_591           : aliased constant String := "";
   K_592           : aliased constant String := "BrighterScript";
   M_592           : aliased constant String := "";
   K_593           : aliased constant String := "Mint";
   M_593           : aliased constant String := "";
   K_594           : aliased constant String := "Scenic";
   M_594           : aliased constant String := "";
   K_595           : aliased constant String := "Moocode";
   M_595           : aliased constant String := "";
   K_596           : aliased constant String := "Glyph";
   M_596           : aliased constant String := "";
   K_597           : aliased constant String := "Java Server Pages";
   M_597           : aliased constant String := "JSP-style";
   K_598           : aliased constant String := "HOCON";
   M_598           : aliased constant String := "";
   K_599           : aliased constant String := "RDoc";
   M_599           : aliased constant String := "";
   K_600           : aliased constant String := "eC";
   M_600           : aliased constant String := "";
   K_601           : aliased constant String := "MAXScript";
   M_601           : aliased constant String := "";
   K_602           : aliased constant String := "Readline Config";
   M_602           : aliased constant String := "";
   K_603           : aliased constant String := "ooc";
   M_603           : aliased constant String := "";
   K_604           : aliased constant String := "LilyPond";
   M_604           : aliased constant String := "";
   K_605           : aliased constant String := "Isabelle ROOT";
   M_605           : aliased constant String := "";
   K_606           : aliased constant String := "Apex";
   M_606           : aliased constant String := "";
   K_607           : aliased constant String := "MiniD";
   M_607           : aliased constant String := "";
   K_608           : aliased constant String := "Raku";
   M_608           : aliased constant String := "";
   K_609           : aliased constant String := "NL";
   M_609           : aliased constant String := "";
   K_610           : aliased constant String := "Object Data Instance Notation";
   M_610           : aliased constant String := "";
   K_611           : aliased constant String := "Mustache";
   M_611           : aliased constant String := "";
   K_612           : aliased constant String := "DIGITAL Command Language";
   M_612           : aliased constant String := "";
   K_613           : aliased constant String := "Pascal";
   M_613           : aliased constant String := "";
   K_614           : aliased constant String := "Open Policy Agent";
   M_614           : aliased constant String := "";
   K_615           : aliased constant String := "X PixMap";
   M_615           : aliased constant String := "";
   K_616           : aliased constant String := "WebVTT";
   M_616           : aliased constant String := "";
   K_617           : aliased constant String := "OpenCL";
   M_617           : aliased constant String := "";
   K_618           : aliased constant String := "RouterOS Script";
   M_618           : aliased constant String := "";
   K_619           : aliased constant String := "Prisma";
   M_619           : aliased constant String := "";
   K_620           : aliased constant String := "Astro";
   M_620           : aliased constant String := "";
   K_621           : aliased constant String := "Rust";
   M_621           : aliased constant String := "C-style";
   K_622           : aliased constant String := "OpenAPI Specification v2";
   M_622           : aliased constant String := "";
   K_623           : aliased constant String := "FLUX";
   M_623           : aliased constant String := "";
   K_624           : aliased constant String := "Opal";
   M_624           : aliased constant String := "";
   K_625           : aliased constant String := "OpenAPI Specification v3";
   M_625           : aliased constant String := "";
   K_626           : aliased constant String := "Xtend";
   M_626           : aliased constant String := "";
   K_627           : aliased constant String := "WebAssembly";
   M_627           : aliased constant String := "";
   K_628           : aliased constant String := "Mathematica";
   M_628           : aliased constant String := "";
   K_629           : aliased constant String := "NewLisp";
   M_629           : aliased constant String := "";
   K_630           : aliased constant String := "HTML+EEX";
   M_630           : aliased constant String := "";
   K_631           : aliased constant String := "XC";
   M_631           : aliased constant String := "";
   K_632           : aliased constant String := "Cap'n Proto";
   M_632           : aliased constant String := "";
   K_633           : aliased constant String := "PEG.js";
   M_633           : aliased constant String := "";
   K_634           : aliased constant String := "ECL";
   M_634           : aliased constant String := "";
   K_635           : aliased constant String := "Just";
   M_635           : aliased constant String := "";
   K_636           : aliased constant String := "Nemerle";
   M_636           : aliased constant String := "";
   K_637           : aliased constant String := "Stylus";
   M_637           : aliased constant String := "";
   K_638           : aliased constant String := "Uno";
   M_638           : aliased constant String := "";
   K_639           : aliased constant String := "Vim Help File";
   M_639           : aliased constant String := "";
   K_640           : aliased constant String := "Ant Build System";
   M_640           : aliased constant String := "";
   K_641           : aliased constant String := "AL";
   M_641           : aliased constant String := "";
   K_642           : aliased constant String := "Vim Snippet";
   M_642           : aliased constant String := "";
   K_643           : aliased constant String := "Dylan";
   M_643           : aliased constant String := "";
   K_644           : aliased constant String := "Agda";
   M_644           : aliased constant String := "";
   K_645           : aliased constant String := "Mask";
   M_645           : aliased constant String := "";
   K_646           : aliased constant String := "XS";
   M_646           : aliased constant String := "";
   K_647           : aliased constant String := "Nu";
   M_647           : aliased constant String := "";
   K_648           : aliased constant String := "Rascal";
   M_648           : aliased constant String := "";
   K_649           : aliased constant String := "IDL";
   M_649           : aliased constant String := "";
   K_650           : aliased constant String := "NetLogo";
   M_650           : aliased constant String := "";
   K_651           : aliased constant String := "Factor";
   M_651           : aliased constant String := "";
   K_652           : aliased constant String := "POV-Ray SDL";
   M_652           : aliased constant String := "";
   K_653           : aliased constant String := "Nginx";
   M_653           : aliased constant String := "";
   K_654           : aliased constant String := "Jasmin";
   M_654           : aliased constant String := "";
   K_655           : aliased constant String := "RAML";
   M_655           : aliased constant String := "";
   K_656           : aliased constant String := "RBS";
   M_656           : aliased constant String := "";
   K_657           : aliased constant String := "Emacs Lisp";
   M_657           : aliased constant String := "";
   K_658           : aliased constant String := "SSH Config";
   M_658           : aliased constant String := "";
   K_659           : aliased constant String := "mIRC Script";
   M_659           : aliased constant String := "";
   K_660           : aliased constant String := "ReasonLIGO";
   M_660           : aliased constant String := "";
   K_661           : aliased constant String := "Twig";
   M_661           : aliased constant String := "";
   K_662           : aliased constant String := "4D";
   M_662           : aliased constant String := "";
   K_663           : aliased constant String := "Harbour";
   M_663           : aliased constant String := "";
   K_664           : aliased constant String := "Module Management System";
   M_664           : aliased constant String := "";
   K_665           : aliased constant String := "Wavefront Material";
   M_665           : aliased constant String := "";
   K_666           : aliased constant String := "CLIPS";
   M_666           : aliased constant String := "";
   K_667           : aliased constant String := "OpenRC runscript";
   M_667           : aliased constant String := "";
   K_668           : aliased constant String := "HolyC";
   M_668           : aliased constant String := "";
   K_669           : aliased constant String := "Parrot";
   M_669           : aliased constant String := "";
   K_670           : aliased constant String := "PigLatin";
   M_670           : aliased constant String := "";
   K_671           : aliased constant String := "VCL";
   M_671           : aliased constant String := "";
   K_672           : aliased constant String := "Fennel";
   M_672           : aliased constant String := "";
   K_673           : aliased constant String := "LiveScript";
   M_673           : aliased constant String := "";
   K_674           : aliased constant String := "Jest Snapshot";
   M_674           : aliased constant String := "";
   K_675           : aliased constant String := "TeX";
   M_675           : aliased constant String := "";
   K_676           : aliased constant String := "AngelScript";
   M_676           : aliased constant String := "";
   K_677           : aliased constant String := "PureScript";
   M_677           : aliased constant String := "";
   K_678           : aliased constant String := "INI";
   M_678           : aliased constant String := "";
   K_679           : aliased constant String := "Fortran Free Form";
   M_679           : aliased constant String := "";
   K_680           : aliased constant String := "Perl";
   M_680           : aliased constant String := "Shell";
   K_681           : aliased constant String := "Tea";
   M_681           : aliased constant String := "";
   K_682           : aliased constant String := "OpenStep Property List";
   M_682           : aliased constant String := "";
   K_683           : aliased constant String := "Slint";
   M_683           : aliased constant String := "";
   K_684           : aliased constant String := "VHDL";
   M_684           : aliased constant String := "";
   K_685           : aliased constant String := "Game Maker Language";
   M_685           : aliased constant String := "";
   K_686           : aliased constant String := "SQLPL";
   M_686           : aliased constant String := "";
   K_687           : aliased constant String := "MTML";
   M_687           : aliased constant String := "";
   K_688           : aliased constant String := "Coq";
   M_688           : aliased constant String := "";
   K_689           : aliased constant String := "TXL";
   M_689           : aliased constant String := "";
   K_690           : aliased constant String := "Textile";
   M_690           : aliased constant String := "";
   K_691           : aliased constant String := "CameLIGO";
   M_691           : aliased constant String := "";
   K_692           : aliased constant String := "Protocol Buffer";
   M_692           : aliased constant String := "";
   K_693           : aliased constant String := "COBOL";
   M_693           : aliased constant String := "";
   K_694           : aliased constant String := "NetLinx";
   M_694           : aliased constant String := "";
   K_695           : aliased constant String := "Ecere Projects";
   M_695           : aliased constant String := "";
   K_696           : aliased constant String := "KiCad Schematic";
   M_696           : aliased constant String := "";
   K_697           : aliased constant String := "HLSL";
   M_697           : aliased constant String := "";
   K_698           : aliased constant String := "Bluespec";
   M_698           : aliased constant String := "";
   K_699           : aliased constant String := "PDDL";
   M_699           : aliased constant String := "";
   K_700           : aliased constant String := "Windows Registry Entries";
   M_700           : aliased constant String := "";
   K_701           : aliased constant String := "XPages";
   M_701           : aliased constant String := "";
   K_702           : aliased constant String := "CUE";
   M_702           : aliased constant String := "";
   K_703           : aliased constant String := "MATLAB";
   M_703           : aliased constant String := "";
   K_704           : aliased constant String := "Git Revision List";
   M_704           : aliased constant String := "";
   K_705           : aliased constant String := "SCSS";
   M_705           : aliased constant String := "";
   K_706           : aliased constant String := "Kotlin";
   M_706           : aliased constant String := "C-style";
   K_707           : aliased constant String := "Scala";
   M_707           : aliased constant String := "C-style";
   K_708           : aliased constant String := "Formatted";
   M_708           : aliased constant String := "";
   K_709           : aliased constant String := "Boogie";
   M_709           : aliased constant String := "";
   K_710           : aliased constant String := "Handlebars";
   M_710           : aliased constant String := "";
   K_711           : aliased constant String := "REXX";
   M_711           : aliased constant String := "";
   K_712           : aliased constant String := "Pure Data";
   M_712           : aliased constant String := "";
   K_713           : aliased constant String := "Elixir";
   M_713           : aliased constant String := "Shell";
   K_714           : aliased constant String := "Grammatical Framework";
   M_714           : aliased constant String := "";
   K_715           : aliased constant String := "LSL";
   M_715           : aliased constant String := "";
   K_716           : aliased constant String := "XProc";
   M_716           : aliased constant String := "";
   K_717           : aliased constant String := "Csound Score";
   M_717           : aliased constant String := "";
   K_718           : aliased constant String := "AutoHotkey";
   M_718           : aliased constant String := "";
   K_719           : aliased constant String := "X BitMap";
   M_719           : aliased constant String := "";

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
      K_716'Access, K_717'Access, K_718'Access, K_719'Access);

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
      M_716'Access, M_717'Access, M_718'Access, M_719'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.CommentsMap;
