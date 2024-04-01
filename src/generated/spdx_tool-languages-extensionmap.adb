--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
--  Extensions mapping generated from extensions.json
with Interfaces; use Interfaces;

package body SPDX_Tool.Languages.ExtensionMap is
   function Hash (S : String) return Natural;

   P : constant array (0 .. 10) of Natural :=
     (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12);

   T1 : constant array (0 .. 10) of Unsigned_16 :=
     (34, 1493, 265, 441, 1343, 2624, 2171, 2619, 888, 2614, 2701);

   T2 : constant array (0 .. 10) of Unsigned_16 :=
     (968, 2311, 947, 171, 1363, 858, 1089, 334, 2666, 2183, 1738);

   G : constant array (0 .. 2710) of Unsigned_16 :=
     (293, 0, 861, 844, 0, 0, 414, 354, 0, 88, 1329, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 1243, 0, 0, 0, 0, 0, 343, 118, 0, 0, 0, 0, 0, 744,
      0, 0, 0, 992, 0, 0, 270, 471, 914, 1332, 0, 212, 0, 0, 176, 754, 0, 0,
      0, 470, 0, 0, 0, 0, 0, 7, 0, 972, 0, 0, 1147, 0, 970, 0, 261, 804,
      1280, 248, 867, 266, 0, 0, 568, 634, 0, 0, 459, 753, 0, 870, 45, 0, 0,
      0, 0, 0, 1099, 0, 1222, 905, 1004, 300, 0, 0, 0, 0, 534, 0, 931, 655,
      0, 0, 0, 763, 0, 0, 0, 0, 0, 0, 1013, 230, 390, 0, 0, 1094, 0, 0, 0,
      799, 0, 0, 0, 768, 0, 705, 1252, 0, 318, 0, 0, 0, 398, 810, 0, 0, 0,
      0, 0, 0, 1270, 945, 0, 768, 0, 166, 0, 0, 249, 617, 0, 684, 19, 1172,
      0, 0, 0, 0, 0, 4, 1017, 0, 521, 0, 0, 0, 0, 241, 1207, 0, 0, 0, 0, 0,
      0, 676, 0, 0, 87, 960, 988, 0, 45, 0, 0, 1030, 0, 0, 0, 866, 1131, 0,
      0, 0, 0, 510, 0, 0, 680, 0, 298, 1338, 1171, 1230, 0, 0, 0, 0, 0, 0,
      517, 391, 0, 0, 356, 0, 399, 1256, 0, 0, 0, 0, 496, 1059, 0, 925, 71,
      1090, 0, 985, 0, 0, 0, 0, 0, 105, 0, 1254, 0, 1056, 30, 1204, 1050, 0,
      0, 767, 62, 0, 577, 0, 0, 0, 1133, 0, 0, 714, 0, 0, 0, 0, 0, 0, 9, 0,
      109, 1109, 0, 0, 514, 0, 0, 0, 0, 414, 0, 0, 0, 1080, 0, 56, 0, 0, 0,
      352, 0, 705, 421, 0, 0, 1238, 0, 1326, 0, 0, 0, 991, 627, 0, 673, 422,
      714, 0, 0, 0, 0, 1346, 0, 745, 290, 0, 253, 0, 0, 714, 0, 0, 0, 1012,
      906, 1031, 0, 234, 0, 1331, 149, 0, 0, 1014, 415, 0, 0, 676, 637, 0,
      598, 982, 173, 50, 0, 1321, 606, 708, 0, 0, 0, 0, 502, 126, 0, 0, 0,
      0, 434, 0, 0, 0, 822, 516, 0, 610, 690, 193, 1055, 581, 953, 877, 0,
      127, 0, 881, 1229, 0, 0, 483, 0, 628, 1029, 0, 284, 0, 790, 0, 0, 0,
      0, 1121, 0, 0, 0, 0, 161, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 273, 0, 0,
      44, 418, 296, 774, 348, 0, 210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1219, 0, 0,
      1179, 0, 894, 0, 65, 0, 0, 616, 480, 0, 989, 508, 0, 0, 0, 0, 1296,
      415, 0, 1117, 0, 0, 0, 0, 288, 731, 0, 0, 0, 0, 808, 0, 395, 0, 0, 0,
      0, 0, 0, 0, 0, 1307, 0, 0, 303, 0, 0, 78, 0, 115, 283, 135, 489, 0, 0,
      0, 934, 0, 0, 0, 0, 1047, 0, 0, 820, 0, 759, 0, 0, 518, 0, 0, 0, 0, 0,
      992, 474, 649, 469, 0, 0, 0, 0, 598, 0, 0, 0, 0, 912, 0, 0, 820, 0,
      280, 0, 0, 0, 1189, 0, 0, 0, 0, 154, 769, 0, 373, 0, 884, 675, 1007,
      784, 0, 0, 0, 0, 0, 0, 0, 1183, 0, 0, 0, 146, 89, 0, 76, 0, 823, 0, 0,
      0, 0, 0, 317, 0, 657, 62, 0, 0, 0, 1180, 0, 0, 0, 0, 0, 528, 629, 758,
      0, 237, 0, 0, 0, 0, 0, 14, 258, 0, 0, 0, 948, 0, 0, 807, 937, 568, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 1101, 840, 116, 1197, 0, 1290, 0, 79, 217, 0,
      133, 0, 0, 0, 0, 0, 378, 0, 1065, 0, 770, 0, 651, 164, 649, 1285, 0,
      0, 0, 0, 583, 0, 394, 0, 899, 0, 0, 0, 0, 0, 0, 0, 0, 27, 356, 0, 111,
      0, 0, 0, 644, 0, 472, 0, 0, 197, 0, 40, 1064, 384, 0, 908, 94, 104, 0,
      0, 824, 1187, 0, 1121, 992, 1164, 0, 603, 0, 0, 0, 0, 205, 0, 842, 86,
      315, 891, 0, 276, 0, 784, 0, 1109, 0, 167, 0, 962, 1038, 0, 0, 0, 0,
      0, 888, 461, 440, 0, 0, 0, 1221, 0, 0, 0, 0, 0, 405, 496, 115, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 8, 166, 1113, 637, 0, 0, 199, 0, 222, 0, 0, 231,
      0, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 946, 0, 0, 722, 693, 0, 586, 0, 397,
      0, 0, 746, 0, 1337, 0, 793, 0, 11, 0, 1186, 0, 0, 0, 1340, 0, 183, 0,
      0, 0, 0, 0, 1060, 0, 0, 748, 62, 0, 537, 317, 0, 1058, 170, 53, 242,
      1282, 0, 0, 0, 0, 0, 0, 1290, 557, 685, 854, 0, 1188, 0, 0, 0, 0, 0,
      98, 1193, 0, 47, 0, 0, 552, 655, 495, 195, 718, 0, 0, 786, 41, 0, 17,
      0, 457, 972, 1238, 862, 0, 0, 0, 335, 404, 0, 0, 0, 153, 472, 637, 0,
      263, 0, 0, 0, 0, 1201, 0, 800, 0, 389, 0, 1167, 794, 4, 975, 0, 20, 0,
      682, 1329, 1315, 0, 539, 0, 0, 90, 0, 649, 0, 1324, 0, 0, 877, 0, 85,
      0, 0, 813, 0, 545, 67, 0, 575, 0, 1197, 0, 0, 10, 963, 0, 34, 0, 0,
      404, 533, 879, 0, 0, 543, 51, 570, 64, 0, 0, 0, 670, 0, 0, 0, 283, 0,
      94, 248, 547, 0, 686, 0, 0, 0, 876, 0, 158, 33, 650, 0, 0, 0, 0, 807,
      203, 0, 609, 0, 1331, 990, 0, 0, 659, 0, 0, 0, 401, 479, 0, 378, 0,
      1110, 0, 0, 127, 0, 1162, 0, 0, 624, 1024, 0, 276, 1342, 0, 1111, 0,
      0, 0, 312, 0, 147, 0, 0, 314, 0, 1060, 152, 0, 1, 5, 0, 0, 0, 978, 0,
      0, 344, 24, 0, 220, 0, 227, 0, 0, 620, 168, 804, 522, 0, 0, 0, 0, 0,
      0, 0, 84, 0, 0, 391, 1258, 0, 0, 932, 1235, 0, 0, 0, 0, 491, 0, 0, 60,
      0, 231, 294, 0, 1283, 0, 295, 45, 0, 0, 0, 91, 0, 0, 661, 244, 722, 0,
      0, 0, 179, 0, 0, 0, 177, 0, 1160, 0, 381, 376, 617, 0, 574, 0, 0, 0,
      0, 1242, 0, 0, 345, 0, 426, 135, 0, 0, 0, 242, 0, 323, 0, 1246, 187,
      0, 460, 853, 0, 0, 0, 0, 929, 807, 1236, 0, 307, 0, 0, 0, 0, 1145,
      479, 0, 1144, 219, 0, 844, 0, 0, 0, 1, 0, 0, 0, 0, 981, 0, 1025, 0, 0,
      646, 511, 0, 0, 1137, 674, 1206, 416, 0, 0, 844, 709, 138, 659, 0, 0,
      845, 980, 0, 0, 543, 119, 28, 0, 911, 0, 0, 0, 1058, 1222, 562, 0, 0,
      0, 824, 0, 0, 392, 0, 0, 0, 0, 0, 42, 334, 175, 0, 0, 0, 0, 969, 0, 0,
      0, 0, 597, 1141, 1257, 0, 0, 0, 823, 609, 0, 975, 904, 0, 677, 0, 0,
      1182, 160, 338, 143, 35, 400, 0, 0, 477, 472, 479, 0, 0, 41, 0, 0,
      279, 867, 0, 0, 0, 1348, 704, 767, 58, 0, 1069, 0, 1153, 0, 1133, 399,
      1018, 144, 0, 981, 922, 0, 0, 1295, 0, 92, 211, 0, 144, 1347, 0, 0, 0,
      823, 1088, 0, 225, 0, 0, 0, 0, 0, 7, 0, 0, 169, 0, 204, 434, 0, 0,
      296, 605, 0, 0, 693, 0, 0, 374, 177, 0, 48, 140, 0, 0, 0, 0, 0, 201,
      0, 0, 659, 0, 0, 0, 0, 0, 0, 145, 0, 198, 0, 0, 614, 0, 0, 1322, 462,
      0, 0, 0, 98, 74, 0, 0, 956, 146, 0, 0, 0, 0, 0, 1141, 671, 334, 883,
      0, 0, 564, 0, 0, 456, 0, 0, 0, 0, 0, 0, 0, 0, 989, 0, 0, 648, 0, 168,
      0, 184, 678, 0, 1334, 0, 0, 0, 1086, 0, 1066, 0, 0, 1273, 0, 0, 0,
      816, 0, 954, 0, 0, 0, 1080, 593, 0, 278, 0, 830, 1094, 0, 0, 0, 0,
      481, 0, 0, 1019, 0, 1083, 0, 490, 909, 889, 0, 1084, 126, 0, 176,
      1087, 240, 1184, 0, 0, 72, 144, 0, 0, 0, 0, 1162, 0, 0, 0, 164, 0,
      175, 0, 0, 1270, 0, 953, 4, 0, 921, 569, 1174, 0, 0, 0, 0, 0, 0, 0, 0,
      307, 131, 0, 0, 0, 0, 0, 827, 598, 0, 593, 0, 0, 1052, 255, 0, 0, 599,
      1273, 816, 0, 0, 20, 0, 0, 950, 40, 609, 1268, 552, 1238, 0, 22, 415,
      490, 0, 633, 0, 0, 1097, 136, 0, 342, 0, 1159, 485, 1193, 0, 0, 581,
      0, 481, 1023, 0, 174, 0, 0, 0, 1059, 973, 0, 0, 35, 943, 0, 0, 600, 0,
      921, 0, 1291, 509, 0, 600, 168, 0, 0, 186, 0, 986, 240, 156, 1166,
      727, 887, 331, 0, 1185, 0, 0, 386, 0, 0, 0, 0, 391, 192, 791, 0, 461,
      377, 1125, 0, 0, 438, 0, 0, 983, 0, 0, 2, 1281, 0, 1145, 0, 0, 0, 890,
      635, 859, 65, 214, 0, 0, 961, 0, 0, 0, 0, 0, 0, 792, 0, 1201, 0, 0,
      519, 923, 895, 0, 0, 0, 0, 958, 1345, 0, 392, 0, 221, 0, 0, 0, 938,
      1062, 122, 1088, 518, 0, 0, 524, 0, 0, 1193, 860, 163, 227, 0, 1322,
      0, 0, 0, 0, 0, 0, 735, 0, 0, 387, 0, 28, 1263, 890, 0, 890, 492, 0, 0,
      0, 305, 0, 0, 0, 1037, 930, 1064, 947, 0, 34, 0, 0, 0, 81, 147, 1306,
      0, 1105, 0, 1261, 644, 1334, 0, 669, 319, 66, 96, 448, 978, 1024,
      1058, 0, 0, 412, 0, 1175, 268, 0, 293, 1307, 0, 912, 0, 851, 652, 264,
      0, 0, 0, 970, 839, 0, 330, 0, 0, 670, 0, 0, 1344, 454, 484, 0, 54, 0,
      427, 779, 651, 0, 682, 0, 0, 1057, 82, 0, 0, 685, 138, 0, 695, 182,
      1259, 14, 0, 0, 0, 1003, 0, 633, 77, 0, 0, 0, 0, 0, 300, 0, 921, 0,
      177, 319, 0, 271, 0, 1317, 0, 0, 0, 573, 1076, 290, 0, 0, 0, 1063,
      1197, 0, 835, 86, 1046, 0, 289, 0, 163, 944, 0, 399, 1022, 0, 1258, 0,
      59, 0, 1260, 393, 1044, 366, 0, 0, 1009, 390, 991, 0, 965, 431, 1027,
      1109, 0, 0, 0, 0, 0, 0, 0, 0, 1198, 0, 0, 0, 1043, 0, 0, 355, 0, 292,
      60, 517, 0, 0, 0, 774, 0, 265, 0, 192, 464, 0, 0, 0, 990, 623, 0, 0,
      781, 450, 210, 0, 0, 885, 36, 0, 1093, 636, 410, 0, 45, 0, 248, 0, 0,
      0, 0, 0, 452, 383, 933, 652, 599, 372, 366, 0, 0, 930, 54, 0, 1259,
      621, 0, 0, 0, 761, 0, 0, 0, 1302, 842, 114, 690, 1151, 362, 0, 1052,
      0, 64, 0, 299, 427, 0, 438, 861, 0, 0, 0, 428, 518, 0, 1138, 0, 0, 0,
      0, 0, 0, 0, 407, 229, 0, 0, 920, 0, 734, 557, 0, 1102, 0, 0, 725, 67,
      0, 0, 613, 996, 0, 607, 535, 0, 0, 0, 256, 585, 340, 223, 0, 135, 647,
      1019, 0, 0, 0, 1138, 0, 0, 272, 1020, 296, 662, 506, 424, 804, 69, 0,
      0, 1007, 0, 0, 1109, 938, 0, 0, 139, 1183, 371, 626, 1134, 0, 0, 280,
      0, 983, 0, 0, 1148, 0, 0, 384, 752, 481, 0, 748, 10, 0, 357, 1165,
      527, 0, 1051, 0, 263, 161, 0, 927, 0, 279, 599, 6, 293, 864, 136, 90,
      1278, 256, 0, 0, 0, 39, 547, 166, 132, 0, 0, 1061, 874, 1118, 632,
      1160, 769, 0, 0, 0, 429, 7, 0, 606, 0, 0, 0, 0, 0, 0, 0, 467, 0, 764,
      0, 3, 0, 1345, 350, 0, 0, 0, 0, 0, 1061, 30, 0, 873, 0, 701, 69, 0,
      214, 0, 630, 474, 0, 251, 0, 658, 167, 110, 1300, 0, 0, 0, 0, 0, 0,
      950, 1284, 1305, 129, 344, 0, 0, 684, 638, 0, 109, 0, 13, 0, 880, 0,
      1180, 720, 956, 0, 941, 1233, 660, 0, 206, 558, 609, 0, 0, 544, 0,
      632, 0, 631, 0, 0, 207, 0, 884, 0, 0, 1018, 0, 128, 0, 1048, 37, 1098,
      0, 0, 0, 1195, 1188, 1124, 0, 0, 855, 19, 0, 0, 272, 1063, 1191, 0,
      142, 0, 107, 538, 0, 0, 0, 317, 0, 1161, 1173, 307, 217, 964, 0, 0,
      288, 0, 0, 951, 860, 0, 264, 58, 413, 238, 0, 192, 137, 0, 0, 236,
      280, 0, 779, 0, 1215, 294, 404, 1258, 0, 77, 721, 728, 0, 769, 860, 0,
      859, 1096, 1325, 1313, 495, 412, 0, 681, 578, 516, 1331, 488, 1025, 0,
      0, 1000, 0, 0, 26, 0, 443, 0, 0, 36, 934, 89, 0, 458, 142, 1110, 0,
      522, 0, 848, 0, 0, 976, 0, 375, 181, 0, 0, 782, 0, 89, 0, 212, 731,
      542, 31, 1056, 0, 0, 210, 0, 448, 931, 1301, 365, 555, 1319, 1283, 21,
      0, 626, 1207, 1101, 287, 284, 0, 1038, 0, 769, 84, 684, 990, 1205, 0,
      1114, 0, 350, 942, 0, 140, 1256, 611, 280, 328, 243, 0, 724, 0, 359,
      0, 73, 0, 625, 0, 1085, 1106, 0, 1135, 1121, 829, 232, 437, 0, 1099,
      433, 587, 1196, 1246, 769, 0, 0, 0, 0, 0, 265, 0, 68, 1199, 724, 585,
      0, 827, 88, 1284, 0, 924, 0, 0, 0, 0, 366, 435, 0, 1102, 391, 0, 1146,
      1115, 0, 587, 80, 556, 851, 571, 0, 95, 530, 455, 790, 0, 230, 256, 0,
      0, 1287, 158, 0, 0, 695, 1241, 0, 148, 0, 423, 127, 653, 499, 0, 0,
      640, 70, 23, 485, 833, 0, 0, 491, 0, 1176, 0, 748, 1328, 0, 0, 0,
      1177, 0, 128, 1284, 1040, 301, 0, 862, 0, 468, 1220, 0, 0, 898, 0,
      209, 0, 1333, 0, 0, 434, 0, 0, 1303, 684, 1173, 0, 1340, 0, 0, 330,
      1312, 713, 546, 746, 0, 1291, 0, 677, 447, 0, 1214, 0, 0, 1070, 0,
      911, 0, 481, 1303, 0, 426, 692, 0, 1283, 245, 1327, 1192, 1335, 827,
      1292, 0, 0, 625, 43, 0, 106, 0, 1113, 1031, 97, 1047, 780, 0, 259,
      111, 558, 0, 209, 0, 56, 444, 34, 771, 0, 840, 6, 189, 953, 0, 807,
      740, 0, 596, 1333, 0, 0, 657, 559, 0, 0, 0, 0, 1041, 1080, 662, 425,
      1141, 1325, 108, 0, 0, 447, 29, 0, 0, 579, 0, 96, 0, 747, 253, 0, 261,
      500, 0, 91, 31, 0, 0, 0, 246, 0, 612, 0, 379, 418, 722, 365, 490, 483,
      271, 191, 719, 0, 38, 12, 0, 1251, 488, 1108, 0, 988, 0, 1023, 289, 0,
      0, 52, 0, 0, 0, 675, 41, 0, 0, 688, 0, 0, 0, 157, 843, 108, 475, 0, 0,
      0, 37, 142, 0, 470, 0, 1282, 243, 61, 330, 0, 1049, 1087, 334, 949, 0,
      473, 716, 150, 149, 0, 1306, 428, 626, 0, 0, 0, 651, 104, 1296, 380,
      961, 953, 0, 190, 1094, 1312, 689, 668, 0, 1072, 0, 730, 915, 878,
      680, 0, 0, 0, 0, 1335, 508, 258, 277, 713, 0, 865, 1140, 576, 227, 0,
      0, 389, 1091, 22, 1108, 0, 1329, 0, 290, 995, 1058, 0, 0, 432, 1039,
      0, 1209, 0, 1159, 256, 217, 0, 1237, 282, 850, 770, 506, 977, 0, 1198,
      710, 0, 149, 494, 36, 0, 378, 0, 0, 0, 925, 492, 0, 5, 0, 998, 0, 996,
      0, 1127, 0, 1202, 0, 283, 1221, 0, 555, 25, 0, 33, 740, 739, 1046,
      438, 0, 1055, 0, 743, 0, 5, 32, 1327, 0, 0, 0, 0, 1272, 18, 0, 1268,
      948, 411, 224, 153, 323, 703, 0, 259, 206, 913, 1025, 0, 294, 0, 31,
      0, 0, 1172, 0, 282, 41, 0, 0, 0, 858, 0, 602, 902, 0, 0, 1106, 172, 0,
      0, 0, 370, 894, 0, 239, 1226, 0, 314, 305, 0, 185, 780, 80, 759, 136,
      983, 745, 109, 150, 196, 0, 0, 0, 0, 0, 1245, 71, 272, 1294, 1272,
      432, 1216, 0, 123, 0, 0, 0, 0);

   function Hash (S : String) return Natural is
      F : constant Natural := S'First - 1;
      L : constant Natural := S'Length;
      F1, F2 : Natural := 0;
      J : Natural;
   begin
      for K in P'Range loop
         exit when L < P (K);
         J  := Character'Pos (S (P (K) + F));
         F1 := (F1 + Natural (T1 (K)) * J) mod 2711;
         F2 := (F2 + Natural (T2 (K)) * J) mod 2711;
      end loop;
      return (Natural (G (F1)) + Natural (G (F2))) mod 1355;
   end Hash;

   type Name_Array is array (Natural range <>) of Content_Access;

   K_0             : aliased constant String := "janet";
   M_0             : aliased constant String := "Janet";
   K_1             : aliased constant String := "gd";
   M_1             : aliased constant String := "GAP, GDScript";
   K_2             : aliased constant String := "har";
   M_2             : aliased constant String := "JSON";
   K_3             : aliased constant String := "bib";
   M_3             : aliased constant String := "BibTeX";
   K_4             : aliased constant String := "pde";
   M_4             : aliased constant String := "Processing";
   K_5             : aliased constant String := "rdoc";
   M_5             : aliased constant String := "RDoc";
   K_6             : aliased constant String := "4dm";
   M_6             : aliased constant String := "4D";
   K_7             : aliased constant String := "gf";
   M_7             : aliased constant String := "Grammatical Framework";
   K_8             : aliased constant String := "lua";
   M_8             : aliased constant String := "Lua";
   K_9             : aliased constant String := "spec";
   M_9             : aliased constant String := "Ruby, RPM Spec, Python";
   K_10            : aliased constant String := "god";
   M_10            : aliased constant String := "Ruby";
   K_11            : aliased constant String := "gi";
   M_11            : aliased constant String := "GAP";
   K_12            : aliased constant String := "_ls";
   M_12            : aliased constant String := "LiveScript";
   K_13            : aliased constant String := "gn";
   M_13            : aliased constant String := "GN";
   K_14            : aliased constant String := "odin";
   M_14            : aliased constant String := "Object Data Instance Notation, Odin";
   K_15            : aliased constant String := "zpl";
   M_15            : aliased constant String := "Zimpl";
   K_16            : aliased constant String := "go";
   M_16            : aliased constant String := "Go";
   K_17            : aliased constant String := "ixx";
   M_17            : aliased constant String := "C++";
   K_18            : aliased constant String := "gp";
   M_18            : aliased constant String := "Gnuplot";
   K_19            : aliased constant String := "crc32";
   M_19            : aliased constant String := "Checksums";
   K_20            : aliased constant String := "ndproj";
   M_20            : aliased constant String := "XML";
   K_21            : aliased constant String := "gs";
   M_21            : aliased constant String := "Genie, Gosu, GLSL, JavaScript";
   K_22            : aliased constant String := "f77";
   M_22            : aliased constant String := "Fortran";
   K_23            : aliased constant String := "orc";
   M_23            : aliased constant String := "Csound";
   K_24            : aliased constant String := "gv";
   M_24            : aliased constant String := "Graphviz (DOT)";
   K_25            : aliased constant String := "pegjs";
   M_25            : aliased constant String := "PEG.js";
   K_26            : aliased constant String := "org";
   M_26            : aliased constant String := "Org";
   K_27            : aliased constant String := "sthlp";
   M_27            : aliased constant String := "Stata";
   K_28            : aliased constant String := "astro";
   M_28            : aliased constant String := "Astro";
   K_29            : aliased constant String := "tmCommand";
   M_29            : aliased constant String := "XML Property List";
   K_30            : aliased constant String := "8xp";
   M_30            : aliased constant String := "TI Program";
   K_31            : aliased constant String := "txi";
   M_31            : aliased constant String := "Texinfo";
   K_32            : aliased constant String := "apib";
   M_32            : aliased constant String := "API Blueprint";
   K_33            : aliased constant String := "cproject";
   M_33            : aliased constant String := "XML";
   K_34            : aliased constant String := "epsi";
   M_34            : aliased constant String := "PostScript";
   K_35            : aliased constant String := "txl";
   M_35            : aliased constant String := "TXL";
   K_36            : aliased constant String := "awk";
   M_36            : aliased constant String := "Awk";
   K_37            : aliased constant String := "sas";
   M_37            : aliased constant String := "SAS";
   K_38            : aliased constant String := "roc";
   M_38            : aliased constant String := "Roc";
   K_39            : aliased constant String := "styl";
   M_39            : aliased constant String := "Stylus";
   K_40            : aliased constant String := "abnf";
   M_40            : aliased constant String := "ABNF";
   K_41            : aliased constant String := "ipynb";
   M_41            : aliased constant String := "Jupyter Notebook";
   K_42            : aliased constant String := "1in";
   M_42            : aliased constant String := "Roff, Roff Manpage";
   K_43            : aliased constant String := "txt";
   M_43            : aliased constant String := "Vim Help File, Adblock Filter List, Text";
   K_44            : aliased constant String := "religo";
   M_44            : aliased constant String := "ReasonLIGO";
   K_45            : aliased constant String := "hcl";
   M_45            : aliased constant String := "HCL";
   K_46            : aliased constant String := "mustache";
   M_46            : aliased constant String := "Mustache";
   K_47            : aliased constant String := "lagda";
   M_47            : aliased constant String := "Literate Agda";
   K_48            : aliased constant String := "txx";
   M_48            : aliased constant String := "C++";
   K_49            : aliased constant String := "pfa";
   M_49            : aliased constant String := "PostScript";
   K_50            : aliased constant String := "intr";
   M_50            : aliased constant String := "Dylan";
   K_51            : aliased constant String := "mir";
   M_51            : aliased constant String := "YAML";
   K_52            : aliased constant String := "wiki";
   M_52            : aliased constant String := "Wikitext";
   K_53            : aliased constant String := "ig";
   M_53            : aliased constant String := "Modula-3";
   K_54            : aliased constant String := "1";
   M_54            : aliased constant String := "Roff, Roff Manpage";
   K_55            : aliased constant String := "ik";
   M_55            : aliased constant String := "Ioke";
   K_56            : aliased constant String := "psgi";
   M_56            : aliased constant String := "Perl";
   K_57            : aliased constant String := "2";
   M_57            : aliased constant String := "Roff, Roff Manpage";
   K_58            : aliased constant String := "f90";
   M_58            : aliased constant String := "Fortran Free Form";
   K_59            : aliased constant String := "3";
   M_59            : aliased constant String := "Roff, Roff Manpage";
   K_60            : aliased constant String := "4";
   M_60            : aliased constant String := "Roff, Roff Manpage";
   K_61            : aliased constant String := "5";
   M_61            : aliased constant String := "Roff, Roff Manpage";
   K_62            : aliased constant String := "dtx";
   M_62            : aliased constant String := "TeX";
   K_63            : aliased constant String := "io";
   M_63            : aliased constant String := "Io";
   K_64            : aliased constant String := "6";
   M_64            : aliased constant String := "Roff, Roff Manpage";
   K_65            : aliased constant String := "weechatlog";
   M_65            : aliased constant String := "IRC log";
   K_66            : aliased constant String := "xib";
   M_66            : aliased constant String := "XML";
   K_67            : aliased constant String := "7";
   M_67            : aliased constant String := "Roff, Roff Manpage";
   K_68            : aliased constant String := "gql";
   M_68            : aliased constant String := "GraphQL";
   K_69            : aliased constant String := "scd";
   M_69            : aliased constant String := "SuperCollider, Markdown";
   K_70            : aliased constant String := "f95";
   M_70            : aliased constant String := "Fortran Free Form";
   K_71            : aliased constant String := "8";
   M_71            : aliased constant String := "Roff, Roff Manpage";
   K_72            : aliased constant String := "sce";
   M_72            : aliased constant String := "Scilab";
   K_73            : aliased constant String := "lvproj";
   M_73            : aliased constant String := "LabVIEW";
   K_74            : aliased constant String := "9";
   M_74            : aliased constant String := "Roff, Roff Manpage";
   K_75            : aliased constant String := "hxsl";
   M_75            : aliased constant String := "Haxe";
   K_76            : aliased constant String := "fish";
   M_76            : aliased constant String := "fish";
   K_77            : aliased constant String := "sch";
   M_77            : aliased constant String := "KiCad Schematic, Eagle, XML, Scheme";
   K_78            : aliased constant String := "postcss";
   M_78            : aliased constant String := "PostCSS";
   K_79            : aliased constant String := "sci";
   M_79            : aliased constant String := "Scilab";
   K_80            : aliased constant String := "pmod";
   M_80            : aliased constant String := "Pike";
   K_81            : aliased constant String := "pbtxt";
   M_81            : aliased constant String := "Protocol Buffer Text Format";
   K_82            : aliased constant String := "scm";
   M_82            : aliased constant String := "Scheme";
   K_83            : aliased constant String := "cljc";
   M_83            : aliased constant String := "Clojure";
   K_84            : aliased constant String := "sco";
   M_84            : aliased constant String := "Csound Score";
   K_85            : aliased constant String := "razor";
   M_85            : aliased constant String := "HTML+Razor";
   K_86            : aliased constant String := "sublime-commands";
   M_86            : aliased constant String := "JSON with Comments";
   K_87            : aliased constant String := "mkd";
   M_87            : aliased constant String := "Markdown";
   K_88            : aliased constant String := "reek";
   M_88            : aliased constant String := "YAML";
   K_89            : aliased constant String := "shproj";
   M_89            : aliased constant String := "XML";
   K_90            : aliased constant String := "jsfl";
   M_90            : aliased constant String := "JavaScript";
   K_91            : aliased constant String := "m2";
   M_91            : aliased constant String := "Macaulay2";
   K_92            : aliased constant String := "m3";
   M_92            : aliased constant String := "Modula-3";
   K_93            : aliased constant String := "cljs";
   M_93            : aliased constant String := "Clojure";
   K_94            : aliased constant String := "m4";
   M_94            : aliased constant String := "M4Sugar, M4";
   K_95            : aliased constant String := "ccproj";
   M_95            : aliased constant String := "XML";
   K_96            : aliased constant String := "cljx";
   M_96            : aliased constant String := "Clojure";
   K_97            : aliased constant String := "axs.erb";
   M_97            : aliased constant String := "NetLinx+ERB";
   K_98            : aliased constant String := "gsc";
   M_98            : aliased constant String := "GSC";
   K_99            : aliased constant String := "mumps";
   M_99            : aliased constant String := "M";
   K_100           : aliased constant String := "opencl";
   M_100           : aliased constant String := "OpenCL";
   K_101           : aliased constant String := "purs";
   M_101           : aliased constant String := "PureScript";
   K_102           : aliased constant String := "texi";
   M_102           : aliased constant String := "Texinfo";
   K_103           : aliased constant String := "gsh";
   M_103           : aliased constant String := "GSC";
   K_104           : aliased constant String := "a51";
   M_104           : aliased constant String := "Assembly";
   K_105           : aliased constant String := "rest.txt";
   M_105           : aliased constant String := "reStructuredText";
   K_106           : aliased constant String := "mcmeta";
   M_106           : aliased constant String := "JSON";
   K_107           : aliased constant String := "php";
   M_107           : aliased constant String := "Hack, PHP";
   K_108           : aliased constant String := "uno";
   M_108           : aliased constant String := "Uno";
   K_109           : aliased constant String := "b";
   M_109           : aliased constant String := "Limbo, Brainfuck";
   K_110           : aliased constant String := "sed";
   M_110           : aliased constant String := "sed";
   K_111           : aliased constant String := "c";
   M_111           : aliased constant String := "C";
   K_112           : aliased constant String := "spin";
   M_112           : aliased constant String := "Propeller Spin";
   K_113           : aliased constant String := "d";
   M_113           : aliased constant String := "Makefile, DTrace, D";
   K_114           : aliased constant String := "ks";
   M_114           : aliased constant String := "Kickstart, KerboScript";
   K_115           : aliased constant String := "e";
   M_115           : aliased constant String := "Eiffel, E, Euphoria";
   K_116           : aliased constant String := "kt";
   M_116           : aliased constant String := "Kotlin";
   K_117           : aliased constant String := "gsp";
   M_117           : aliased constant String := "Groovy Server Pages";
   K_118           : aliased constant String := "ashx";
   M_118           : aliased constant String := "ASP.NET";
   K_119           : aliased constant String := "f";
   M_119           : aliased constant String := "Fortran, Filebench WML, Forth";
   K_120           : aliased constant String := "g";
   M_120           : aliased constant String := "GAP, G-code";
   K_121           : aliased constant String := "kv";
   M_121           : aliased constant String := "kvlang";
   K_122           : aliased constant String := "h";
   M_122           : aliased constant String := "Objective-C, C++, C";
   K_123           : aliased constant String := "i";
   M_123           : aliased constant String := "SWIG, Assembly, Motorola 68K Assembly";
   K_124           : aliased constant String := "textproto";
   M_124           : aliased constant String := "Protocol Buffer Text Format";
   K_125           : aliased constant String := "gst";
   M_125           : aliased constant String := "XML, Gosu";
   K_126           : aliased constant String := "graphqls";
   M_126           : aliased constant String := "GraphQL";
   K_127           : aliased constant String := "j";
   M_127           : aliased constant String := "Jasmin, Objective-J";
   K_128           : aliased constant String := "ampl";
   M_128           : aliased constant String := "AMPL";
   K_129           : aliased constant String := "l";
   M_129           : aliased constant String := "Roff, Lex, PicoLisp, Common Lisp";
   K_130           : aliased constant String := "bmx";
   M_130           : aliased constant String := "BlitzMax";
   K_131           : aliased constant String := "topojson";
   M_131           : aliased constant String := "JSON";
   K_132           : aliased constant String := "m";
   M_132           : aliased constant String := "MATLAB, Mathematica, MUF, Limbo, Mercury,"
       & " Objective-C, M";
   K_133           : aliased constant String := "vba";
   M_133           : aliased constant String := "Vim Script, VBA";
   K_134           : aliased constant String := "gsx";
   M_134           : aliased constant String := "Gosu";
   K_135           : aliased constant String := "n";
   M_135           : aliased constant String := "Nemerle, Roff";
   K_136           : aliased constant String := "p";
   M_136           : aliased constant String := "OpenEdge ABL, Gnuplot";
   K_137           : aliased constant String := "wikitext";
   M_137           : aliased constant String := "Wikitext";
   K_138           : aliased constant String := "q";
   M_138           : aliased constant String := "HiveQL, q";
   K_139           : aliased constant String := "r";
   M_139           : aliased constant String := "Rebol, Rez, R";
   K_140           : aliased constant String := "darcspatch";
   M_140           : aliased constant String := "Darcs Patch";
   K_141           : aliased constant String := "s";
   M_141           : aliased constant String := "Unix Assembly, Motorola 68K Assembly";
   K_142           : aliased constant String := "mmd";
   M_142           : aliased constant String := "Mermaid";
   K_143           : aliased constant String := "rsc";
   M_143           : aliased constant String := "Rascal, RouterOS Script";
   K_144           : aliased constant String := "t";
   M_144           : aliased constant String := "Perl, Raku, Terra, Turing";
   K_145           : aliased constant String := "ejs";
   M_145           : aliased constant String := "EJS";
   K_146           : aliased constant String := "v";
   M_146           : aliased constant String := "Coq, Verilog, V";
   K_147           : aliased constant String := "w";
   M_147           : aliased constant String := "OpenEdge ABL, CWeb";
   K_148           : aliased constant String := "x";
   M_148           : aliased constant String := "Linker Script, Logos, RPC, DirectX 3D Fil"
       & "e";
   K_149           : aliased constant String := "rsh";
   M_149           : aliased constant String := "RenderScript";
   K_150           : aliased constant String := "y";
   M_150           : aliased constant String := "Yacc";
   K_151           : aliased constant String := "mmk";
   M_151           : aliased constant String := "Module Management System";
   K_152           : aliased constant String := "psm1";
   M_152           : aliased constant String := "PowerShell";
   K_153           : aliased constant String := "jspre";
   M_153           : aliased constant String := "JavaScript";
   K_154           : aliased constant String := "dpatch";
   M_154           : aliased constant String := "Darcs Patch";
   K_155           : aliased constant String := "rego";
   M_155           : aliased constant String := "Open Policy Agent";
   K_156           : aliased constant String := "ma";
   M_156           : aliased constant String := "Mathematica";
   K_157           : aliased constant String := "pl6";
   M_157           : aliased constant String := "Raku";
   K_158           : aliased constant String := "vbs";
   M_158           : aliased constant String := "VBScript";
   K_159           : aliased constant String := "mc";
   M_159           : aliased constant String := "M4, Win32 Message File, Monkey C";
   K_160           : aliased constant String := "md";
   M_160           : aliased constant String := "Markdown, GCC Machine Description";
   K_161           : aliased constant String := "upc";
   M_161           : aliased constant String := "Unified Parallel C";
   K_162           : aliased constant String := "me";
   M_162           : aliased constant String := "Roff";
   K_163           : aliased constant String := "mms";
   M_163           : aliased constant String := "Module Management System";
   K_164           : aliased constant String := "sublime-menu";
   M_164           : aliased constant String := "JSON with Comments";
   K_165           : aliased constant String := "rss";
   M_165           : aliased constant String := "XML";
   K_166           : aliased constant String := "mg";
   M_166           : aliased constant String := "Modula-3";
   K_167           : aliased constant String := "rst";
   M_167           : aliased constant String := "reStructuredText";
   K_168           : aliased constant String := "jisonlex";
   M_168           : aliased constant String := "Jison Lex";
   K_169           : aliased constant String := "move";
   M_169           : aliased constant String := "Move";
   K_170           : aliased constant String := "mk";
   M_170           : aliased constant String := "Makefile";
   K_171           : aliased constant String := "rsx";
   M_171           : aliased constant String := "R";
   K_172           : aliased constant String := "ml";
   M_172           : aliased constant String := "OCaml, Standard ML";
   K_173           : aliased constant String := "mm";
   M_173           : aliased constant String := "Objective-C++, XML";
   K_174           : aliased constant String := "mo";
   M_174           : aliased constant String := "Motoko, Modelica";
   K_175           : aliased constant String := "eclass";
   M_175           : aliased constant String := "Gentoo Eclass";
   K_176           : aliased constant String := "jelly";
   M_176           : aliased constant String := "XML";
   K_177           : aliased constant String := "boo";
   M_177           : aliased constant String := "Boo";
   K_178           : aliased constant String := "ms";
   M_178           : aliased constant String := "MAXScript, Roff, Unix Assembly";
   K_179           : aliased constant String := "mt";
   M_179           : aliased constant String := "Mathematica";
   K_180           : aliased constant String := "opal";
   M_180           : aliased constant String := "Opal";
   K_181           : aliased constant String := "mu";
   M_181           : aliased constant String := "mupad";
   K_182           : aliased constant String := "code-workspace";
   M_182           : aliased constant String := "JSON with Comments";
   K_183           : aliased constant String := "xmi";
   M_183           : aliased constant String := "XML";
   K_184           : aliased constant String := "xml";
   M_184           : aliased constant String := "XML";
   K_185           : aliased constant String := "oxh";
   M_185           : aliased constant String := "Ox";
   K_186           : aliased constant String := "oxygene";
   M_186           : aliased constant String := "Oxygene";
   K_187           : aliased constant String := "elm";
   M_187           : aliased constant String := "Elm";
   K_188           : aliased constant String := "mq4";
   M_188           : aliased constant String := "MQL4";
   K_189           : aliased constant String := "xmp";
   M_189           : aliased constant String := "XML";
   K_190           : aliased constant String := "curry";
   M_190           : aliased constant String := "Curry";
   K_191           : aliased constant String := "cypher";
   M_191           : aliased constant String := "Cypher";
   K_192           : aliased constant String := "mq5";
   M_192           : aliased constant String := "MQL5";
   K_193           : aliased constant String := "nas";
   M_193           : aliased constant String := "Nasal, Assembly";
   K_194           : aliased constant String := "hic";
   M_194           : aliased constant String := "Clojure";
   K_195           : aliased constant String := "vdf";
   M_195           : aliased constant String := "Valve Data Format";
   K_196           : aliased constant String := "dircolors";
   M_196           : aliased constant String := "dircolors";
   K_197           : aliased constant String := "oxo";
   M_197           : aliased constant String := "Ox";
   K_198           : aliased constant String := "mod";
   M_198           : aliased constant String := "Linux Kernel Module, XML, Modula-2, AMPL";
   K_199           : aliased constant String := "asn1";
   M_199           : aliased constant String := "ASN.1";
   K_200           : aliased constant String := "elv";
   M_200           : aliased constant String := "Elvish";
   K_201           : aliased constant String := "mkdn";
   M_201           : aliased constant String := "Markdown";
   K_202           : aliased constant String := "ccp";
   M_202           : aliased constant String := "COBOL";
   K_203           : aliased constant String := "moo";
   M_203           : aliased constant String := "Moocode, Mercury";
   K_204           : aliased constant String := "plb";
   M_204           : aliased constant String := "PLSQL";
   K_205           : aliased constant String := "bones";
   M_205           : aliased constant String := "JavaScript";
   K_206           : aliased constant String := "4DForm";
   M_206           : aliased constant String := "JSON";
   K_207           : aliased constant String := "numpyw";
   M_207           : aliased constant String := "NumPy";
   K_208           : aliased constant String := "ol";
   M_208           : aliased constant String := "Jolie";
   K_209           : aliased constant String := "yap";
   M_209           : aliased constant String := "Prolog";
   K_210           : aliased constant String := "url";
   M_210           : aliased constant String := "INI";
   K_211           : aliased constant String := "mxml";
   M_211           : aliased constant String := "XML";
   K_212           : aliased constant String := "mbox";
   M_212           : aliased constant String := "E-mail";
   K_213           : aliased constant String := "yar";
   M_213           : aliased constant String := "YARA";
   K_214           : aliased constant String := "perl";
   M_214           : aliased constant String := "Perl";
   K_215           : aliased constant String := "os";
   M_215           : aliased constant String := "1C Enterprise";
   K_216           : aliased constant String := "axaml";
   M_216           : aliased constant String := "XML";
   K_217           : aliased constant String := "pls";
   M_217           : aliased constant String := "PLSQL";
   K_218           : aliased constant String := "urs";
   M_218           : aliased constant String := "UrWeb";
   K_219           : aliased constant String := "sig";
   M_219           : aliased constant String := "Standard ML";
   K_220           : aliased constant String := "tcsh";
   M_220           : aliased constant String := "Tcsh";
   K_221           : aliased constant String := "plt";
   M_221           : aliased constant String := "Prolog, Gnuplot";
   K_222           : aliased constant String := "webmanifest";
   M_222           : aliased constant String := "JSON";
   K_223           : aliased constant String := "ox";
   M_223           : aliased constant String := "Ox";
   K_224           : aliased constant String := "plx";
   M_224           : aliased constant String := "Perl";
   K_225           : aliased constant String := "ncl";
   M_225           : aliased constant String := "Gerber Image, NCL, XML, Text";
   K_226           : aliased constant String := "oz";
   M_226           : aliased constant String := "Oz";
   K_227           : aliased constant String := "smt2";
   M_227           : aliased constant String := "SMT";
   K_228           : aliased constant String := "mkdown";
   M_228           : aliased constant String := "Markdown";
   K_229           : aliased constant String := "tfstate";
   M_229           : aliased constant String := "JSON";
   K_230           : aliased constant String := "ssjs";
   M_230           : aliased constant String := "JavaScript";
   K_231           : aliased constant String := "env";
   M_231           : aliased constant String := "Dotenv";
   K_232           : aliased constant String := "mqh";
   M_232           : aliased constant String := "MQL5, MQL4";
   K_233           : aliased constant String := "sublime-completions";
   M_233           : aliased constant String := "JSON with Comments";
   K_234           : aliased constant String := "scaml";
   M_234           : aliased constant String := "Scaml";
   K_235           : aliased constant String := "d-objdump";
   M_235           : aliased constant String := "D-ObjDump";
   K_236           : aliased constant String := "ql";
   M_236           : aliased constant String := "CodeQL";
   K_237           : aliased constant String := "pprx";
   M_237           : aliased constant String := "REXX";
   K_238           : aliased constant String := "wisp";
   M_238           : aliased constant String := "wisp";
   K_239           : aliased constant String := "bsl";
   M_239           : aliased constant String := "1C Enterprise";
   K_240           : aliased constant String := "cobol";
   M_240           : aliased constant String := "COBOL";
   K_241           : aliased constant String := "slint";
   M_241           : aliased constant String := "Slint";
   K_242           : aliased constant String := "textile";
   M_242           : aliased constant String := "Textile";
   K_243           : aliased constant String := "befunge";
   M_243           : aliased constant String := "Befunge";
   K_244           : aliased constant String := "qs";
   M_244           : aliased constant String := "Q#, Qt Script";
   K_245           : aliased constant String := "gyp";
   M_245           : aliased constant String := "Python";
   K_246           : aliased constant String := "axi.erb";
   M_246           : aliased constant String := "NetLinx+ERB";
   K_247           : aliased constant String := "jsonnet";
   M_247           : aliased constant String := "Jsonnet";
   K_248           : aliased constant String := "_coffee";
   M_248           : aliased constant String := "CoffeeScript";
   K_249           : aliased constant String := "asset";
   M_249           : aliased constant String := "Unity3D Asset";
   K_250           : aliased constant String := "bsv";
   M_250           : aliased constant String := "Bluespec";
   K_251           : aliased constant String := "jsproj";
   M_251           : aliased constant String := "XML";
   K_252           : aliased constant String := "epj";
   M_252           : aliased constant String := "Ecere Projects";
   K_253           : aliased constant String := "xql";
   M_253           : aliased constant String := "XQuery";
   K_254           : aliased constant String := "xqm";
   M_254           : aliased constant String := "XQuery";
   K_255           : aliased constant String := "matlab";
   M_255           : aliased constant String := "MATLAB";
   K_256           : aliased constant String := "vhd";
   M_256           : aliased constant String := "VHDL";
   K_257           : aliased constant String := "vhf";
   M_257           : aliased constant String := "VHDL";
   K_258           : aliased constant String := "xojo_menu";
   M_258           : aliased constant String := "Xojo";
   K_259           : aliased constant String := "msd";
   M_259           : aliased constant String := "JetBrains MPS";
   K_260           : aliased constant String := "vhi";
   M_260           : aliased constant String := "VHDL";
   K_261           : aliased constant String := "webidl";
   M_261           : aliased constant String := "WebIDL";
   K_262           : aliased constant String := "eps";
   M_262           : aliased constant String := "PostScript";
   K_263           : aliased constant String := "cirru";
   M_263           : aliased constant String := "Cirru";
   K_264           : aliased constant String := "eam.fs";
   M_264           : aliased constant String := "Formatted";
   K_265           : aliased constant String := "cgi";
   M_265           : aliased constant String := "Perl, Shell, Python";
   K_266           : aliased constant String := "cocci";
   M_266           : aliased constant String := "SmPL";
   K_267           : aliased constant String := "numpy";
   M_267           : aliased constant String := "NumPy";
   K_268           : aliased constant String := "xliff";
   M_268           : aliased constant String := "XML";
   K_269           : aliased constant String := "xqy";
   M_269           : aliased constant String := "XQuery";
   K_270           : aliased constant String := "vho";
   M_270           : aliased constant String := "VHDL";
   K_271           : aliased constant String := "qbs";
   M_271           : aliased constant String := "QML";
   K_272           : aliased constant String := "vhs";
   M_272           : aliased constant String := "VHDL";
   K_273           : aliased constant String := "gnuplot";
   M_273           : aliased constant String := "Gnuplot";
   K_274           : aliased constant String := "vht";
   M_274           : aliased constant String := "VHDL";
   K_275           : aliased constant String := "sc";
   M_275           : aliased constant String := "Scala, SuperCollider";
   K_276           : aliased constant String := "vhw";
   M_276           : aliased constant String := "VHDL";
   K_277           : aliased constant String := "mss";
   M_277           : aliased constant String := "CartoCSS";
   K_278           : aliased constant String := "aidl";
   M_278           : aliased constant String := "AIDL";
   K_279           : aliased constant String := "sh";
   M_279           : aliased constant String := "Shell";
   K_280           : aliased constant String := "sj";
   M_280           : aliased constant String := "Objective-J";
   K_281           : aliased constant String := "sl";
   M_281           : aliased constant String := "Slash";
   K_282           : aliased constant String := "sma";
   M_282           : aliased constant String := "Pawn";
   K_283           : aliased constant String := "graphql";
   M_283           : aliased constant String := "GraphQL";
   K_284           : aliased constant String := "cats";
   M_284           : aliased constant String := "C";
   K_285           : aliased constant String := "sp";
   M_285           : aliased constant String := "SourcePawn";
   K_286           : aliased constant String := "erb";
   M_286           : aliased constant String := "HTML+ERB";
   K_287           : aliased constant String := "xsd";
   M_287           : aliased constant String := "XML";
   K_288           : aliased constant String := "ss";
   M_288           : aliased constant String := "Scheme";
   K_289           : aliased constant String := "aspx";
   M_289           : aliased constant String := "ASP.NET";
   K_290           : aliased constant String := "st";
   M_290           : aliased constant String := "Smalltalk, StringTemplate";
   K_291           : aliased constant String := "xsh";
   M_291           : aliased constant String := "Xonsh";
   K_292           : aliased constant String := "sv";
   M_292           : aliased constant String := "SystemVerilog";
   K_293           : aliased constant String := "ceylon";
   M_293           : aliased constant String := "Ceylon";
   K_294           : aliased constant String := "sw";
   M_294           : aliased constant String := "Sway, XML";
   K_295           : aliased constant String := "smk";
   M_295           : aliased constant String := "Snakemake";
   K_296           : aliased constant String := "sml";
   M_296           : aliased constant String := "Standard ML";
   K_297           : aliased constant String := "xsl";
   M_297           : aliased constant String := "XSLT";
   K_298           : aliased constant String := "erl";
   M_298           : aliased constant String := "Erlang";
   K_299           : aliased constant String := "smt";
   M_299           : aliased constant String := "SMT";
   K_300           : aliased constant String := "mud";
   M_300           : aliased constant String := "ZIL";
   K_301           : aliased constant String := "glyphs";
   M_301           : aliased constant String := "OpenStep Property List";
   K_302           : aliased constant String := "muf";
   M_302           : aliased constant String := "MUF";
   K_303           : aliased constant String := "smithy";
   M_303           : aliased constant String := "Smithy";
   K_304           : aliased constant String := "cil";
   M_304           : aliased constant String := "CIL";
   K_305           : aliased constant String := "tab";
   M_305           : aliased constant String := "SQL";
   K_306           : aliased constant String := "toit";
   M_306           : aliased constant String := "Toit";
   K_307           : aliased constant String := "tac";
   M_307           : aliased constant String := "Python";
   K_308           : aliased constant String := "svelte";
   M_308           : aliased constant String := "Svelte";
   K_309           : aliased constant String := "plantuml";
   M_309           : aliased constant String := "PlantUML";
   K_310           : aliased constant String := "robot";
   M_310           : aliased constant String := "RobotFramework";
   K_311           : aliased constant String := "tag";
   M_311           : aliased constant String := "Java Server Pages";
   K_312           : aliased constant String := "prc";
   M_312           : aliased constant String := "PLSQL, SQL";
   K_313           : aliased constant String := "erb.deface";
   M_313           : aliased constant String := "HTML+ERB";
   K_314           : aliased constant String := "uc";
   M_314           : aliased constant String := "UnrealScript";
   K_315           : aliased constant String := "prg";
   M_315           : aliased constant String := "xBase";
   K_316           : aliased constant String := "pri";
   M_316           : aliased constant String := "QMake";
   K_317           : aliased constant String := "ui";
   M_317           : aliased constant String := "XML";
   K_318           : aliased constant String := "csproj";
   M_318           : aliased constant String := "XML";
   K_319           : aliased constant String := "TextGrid";
   M_319           : aliased constant String := "TextGrid";
   K_320           : aliased constant String := "decls";
   M_320           : aliased constant String := "BlitzBasic";
   K_321           : aliased constant String := "h++";
   M_321           : aliased constant String := "C++";
   K_322           : aliased constant String := "pro";
   M_322           : aliased constant String := "INI, IDL, Prolog, Proguard, QMake";
   K_323           : aliased constant String := "geojson";
   M_323           : aliased constant String := "JSON";
   K_324           : aliased constant String := "asciidoc";
   M_324           : aliased constant String := "AsciiDoc";
   K_325           : aliased constant String := "ice";
   M_325           : aliased constant String := "JSON, Slice";
   K_326           : aliased constant String := "ur";
   M_326           : aliased constant String := "UrWeb";
   K_327           : aliased constant String := "qasm";
   M_327           : aliased constant String := "OpenQASM";
   K_328           : aliased constant String := "prw";
   M_328           : aliased constant String := "xBase";
   K_329           : aliased constant String := "asddls";
   M_329           : aliased constant String := "ABAP CDS";
   K_330           : aliased constant String := "icl";
   M_330           : aliased constant String := "Clean";
   K_331           : aliased constant String := "ux";
   M_331           : aliased constant String := "XML";
   K_332           : aliased constant String := "yml.mysql";
   M_332           : aliased constant String := "YAML";
   K_333           : aliased constant String := "nim";
   M_333           : aliased constant String := "Nim";
   K_334           : aliased constant String := "sol";
   M_334           : aliased constant String := "Gerber Image, Solidity";
   K_335           : aliased constant String := "xul";
   M_335           : aliased constant String := "XML";
   K_336           : aliased constant String := "nit";
   M_336           : aliased constant String := "Nit";
   K_337           : aliased constant String := "dylan";
   M_337           : aliased constant String := "Dylan";
   K_338           : aliased constant String := "ccxml";
   M_338           : aliased constant String := "XML";
   K_339           : aliased constant String := "hqf";
   M_339           : aliased constant String := "SQF";
   K_340           : aliased constant String := "sfproj";
   M_340           : aliased constant String := "XML";
   K_341           : aliased constant String := "nix";
   M_341           : aliased constant String := "Nix";
   K_342           : aliased constant String := "soy";
   M_342           : aliased constant String := "Closure Templates";
   K_343           : aliased constant String := "gdbinit";
   M_343           : aliased constant String := "GDB";
   K_344           : aliased constant String := "hql";
   M_344           : aliased constant String := "HiveQL";
   K_345           : aliased constant String := "tcc";
   M_345           : aliased constant String := "C++";
   K_346           : aliased constant String := "rbfrm";
   M_346           : aliased constant String := "REALbasic";
   K_347           : aliased constant String := "zone";
   M_347           : aliased constant String := "DNS Zone";
   K_348           : aliased constant String := "html";
   M_348           : aliased constant String := "HTML, Ecmarkup";
   K_349           : aliased constant String := "4th";
   M_349           : aliased constant String := "Forth";
   K_350           : aliased constant String := "eclxml";
   M_350           : aliased constant String := "ECL";
   K_351           : aliased constant String := "sublime-project";
   M_351           : aliased constant String := "JSON with Comments";
   K_352           : aliased constant String := "meta";
   M_352           : aliased constant String := "Unity3D Asset";
   K_353           : aliased constant String := "x10";
   M_353           : aliased constant String := "X10";
   K_354           : aliased constant String := "nimrod";
   M_354           : aliased constant String := "Nim";
   K_355           : aliased constant String := "handlebars";
   M_355           : aliased constant String := "Handlebars";
   K_356           : aliased constant String := "tcl";
   M_356           : aliased constant String := "Tcl";
   K_357           : aliased constant String := "csdef";
   M_357           : aliased constant String := "XML";
   K_358           : aliased constant String := "wl";
   M_358           : aliased constant String := "Mathematica";
   K_359           : aliased constant String := "objdump";
   M_359           : aliased constant String := "ObjDump";
   K_360           : aliased constant String := "pkgproj";
   M_360           : aliased constant String := "XML";
   K_361           : aliased constant String := "gshader";
   M_361           : aliased constant String := "GLSL";
   K_362           : aliased constant String := "make";
   M_362           : aliased constant String := "Makefile";
   K_363           : aliased constant String := "ws";
   M_363           : aliased constant String := "Witcher Script";
   K_364           : aliased constant String := "sqf";
   M_364           : aliased constant String := "SQF";
   K_365           : aliased constant String := "nginxconf";
   M_365           : aliased constant String := "Nginx";
   K_366           : aliased constant String := "rviz";
   M_366           : aliased constant String := "YAML";
   K_367           : aliased constant String := "bats";
   M_367           : aliased constant String := "Shell";
   K_368           : aliased constant String := "podspec";
   M_368           : aliased constant String := "Ruby";
   K_369           : aliased constant String := "sql";
   M_369           : aliased constant String := "SQLPL, PLpgSQL, PLSQL, SQL, TSQL";
   K_370           : aliased constant String := "mako";
   M_370           : aliased constant String := "Mako";
   K_371           : aliased constant String := "properties";
   M_371           : aliased constant String := "INI, Java Properties";
   K_372           : aliased constant String := "hsc";
   M_372           : aliased constant String := "Haskell";
   K_373           : aliased constant String := "cmd";
   M_373           : aliased constant String := "Batchfile";
   K_374           : aliased constant String := "toml";
   M_374           : aliased constant String := "TOML";
   K_375           : aliased constant String := "gitconfig";
   M_375           : aliased constant String := "Git Config";
   K_376           : aliased constant String := "cmake.in";
   M_376           : aliased constant String := "CMake";
   K_377           : aliased constant String := "tea";
   M_377           : aliased constant String := "Tea";
   K_378           : aliased constant String := "ada";
   M_378           : aliased constant String := "Ada";
   K_379           : aliased constant String := "adb";
   M_379           : aliased constant String := "Ada";
   K_380           : aliased constant String := "livemd";
   M_380           : aliased constant String := "Markdown";
   K_381           : aliased constant String := "cmp";
   M_381           : aliased constant String := "Gerber Image";
   K_382           : aliased constant String := "rest";
   M_382           : aliased constant String := "reStructuredText";
   K_383           : aliased constant String := "hs-boot";
   M_383           : aliased constant String := "Haskell";
   K_384           : aliased constant String := "pike";
   M_384           : aliased constant String := "Pike";
   K_385           : aliased constant String := "lbx";
   M_385           : aliased constant String := "TeX";
   K_386           : aliased constant String := "gdnlib";
   M_386           : aliased constant String := "Godot Resource";
   K_387           : aliased constant String := "myt";
   M_387           : aliased constant String := "Myghty";
   K_388           : aliased constant String := "resx";
   M_388           : aliased constant String := "XML";
   K_389           : aliased constant String := "xtend";
   M_389           : aliased constant String := "Xtend";
   K_390           : aliased constant String := "1m";
   M_390           : aliased constant String := "Roff, Roff Manpage";
   K_391           : aliased constant String := "lektorproject";
   M_391           : aliased constant String := "INI";
   K_392           : aliased constant String := "ado";
   M_392           : aliased constant String := "Stata";
   K_393           : aliased constant String := "avsc";
   M_393           : aliased constant String := "JSON";
   K_394           : aliased constant String := "adp";
   M_394           : aliased constant String := "Tcl";
   K_395           : aliased constant String := "tmSnippet";
   M_395           : aliased constant String := "XML Property List";
   K_396           : aliased constant String := "dae";
   M_396           : aliased constant String := "COLLADA";
   K_397           : aliased constant String := "sublime-syntax";
   M_397           : aliased constant String := "YAML";
   K_398           : aliased constant String := "ads";
   M_398           : aliased constant String := "Ada";
   K_399           : aliased constant String := "tex";
   M_399           : aliased constant String := "TeX";
   K_400           : aliased constant String := "1x";
   M_400           : aliased constant String := "Roff, Roff Manpage";
   K_401           : aliased constant String := "yy";
   M_401           : aliased constant String := "JSON, Yacc";
   K_402           : aliased constant String := "cob";
   M_402           : aliased constant String := "COBOL";
   K_403           : aliased constant String := "wsdl";
   M_403           : aliased constant String := "XML";
   K_404           : aliased constant String := "snakefile";
   M_404           : aliased constant String := "Snakemake";
   K_405           : aliased constant String := "sss";
   M_405           : aliased constant String := "SugarSS";
   K_406           : aliased constant String := "rbxs";
   M_406           : aliased constant String := "Lua";
   K_407           : aliased constant String := "tool";
   M_407           : aliased constant String := "Shell";
   K_408           : aliased constant String := "exs";
   M_408           : aliased constant String := "Elixir";
   K_409           : aliased constant String := "pcss";
   M_409           : aliased constant String := "PostCSS";
   K_410           : aliased constant String := "rchit";
   M_410           : aliased constant String := "GLSL";
   K_411           : aliased constant String := "jinja";
   M_411           : aliased constant String := "Jinja";
   K_412           : aliased constant String := "prisma";
   M_412           : aliased constant String := "Prisma";
   K_413           : aliased constant String := "parrot";
   M_413           : aliased constant String := "Parrot";
   K_414           : aliased constant String := "com";
   M_414           : aliased constant String := "DIGITAL Command Language";
   K_415           : aliased constant String := "service";
   M_415           : aliased constant String := "desktop";
   K_416           : aliased constant String := "lds";
   M_416           : aliased constant String := "Linker Script";
   K_417           : aliased constant String := "coq";
   M_417           : aliased constant String := "Coq";
   K_418           : aliased constant String := "lvclass";
   M_418           : aliased constant String := "LabVIEW";
   K_419           : aliased constant String := "pxd";
   M_419           : aliased constant String := "Cython";
   K_420           : aliased constant String := "flf";
   M_420           : aliased constant String := "FIGlet Font";
   K_421           : aliased constant String := "sage";
   M_421           : aliased constant String := "Sage";
   K_422           : aliased constant String := "3m";
   M_422           : aliased constant String := "Roff, Roff Manpage";
   K_423           : aliased constant String := "yml";
   M_423           : aliased constant String := "OASv2-yaml, OASv3-yaml, MiniYAML, YAML";
   K_424           : aliased constant String := "pxi";
   M_424           : aliased constant String := "Cython";
   K_425           : aliased constant String := "scpt";
   M_425           : aliased constant String := "AppleScript";
   K_426           : aliased constant String := "afm";
   M_426           : aliased constant String := "Adobe Font Metrics";
   K_427           : aliased constant String := "3p";
   M_427           : aliased constant String := "Roff, Roff Manpage";
   K_428           : aliased constant String := "krl";
   M_428           : aliased constant String := "KRL";
   K_429           : aliased constant String := "c++";
   M_429           : aliased constant String := "C++";
   K_430           : aliased constant String := "x3d";
   M_430           : aliased constant String := "XML";
   K_431           : aliased constant String := "nearley";
   M_431           : aliased constant String := "Nearley";
   K_432           : aliased constant String := "nasl";
   M_432           : aliased constant String := "NASL";
   K_433           : aliased constant String := "3x";
   M_433           : aliased constant String := "Roff, Roff Manpage";
   K_434           : aliased constant String := "wdl";
   M_434           : aliased constant String := "WDL";
   K_435           : aliased constant String := "nasm";
   M_435           : aliased constant String := "Assembly";
   K_436           : aliased constant String := "markdown";
   M_436           : aliased constant String := "Markdown";
   K_437           : aliased constant String := "dcl";
   M_437           : aliased constant String := "Clean";
   K_438           : aliased constant String := "cmake";
   M_438           : aliased constant String := "CMake";
   K_439           : aliased constant String := "iced";
   M_439           : aliased constant String := "CoffeeScript";
   K_440           : aliased constant String := "nuspec";
   M_440           : aliased constant String := "XML";
   K_441           : aliased constant String := "gitignore";
   M_441           : aliased constant String := "Ignore List";
   K_442           : aliased constant String := "xproc";
   M_442           : aliased constant String := "XProc";
   K_443           : aliased constant String := "lfe";
   M_443           : aliased constant String := "LFE";
   K_444           : aliased constant String := "xsjs";
   M_444           : aliased constant String := "JavaScript";
   K_445           : aliased constant String := "cljs.hl";
   M_445           : aliased constant String := "Clojure";
   K_446           : aliased constant String := "xproj";
   M_446           : aliased constant String := "XML";
   K_447           : aliased constant String := "zap";
   M_447           : aliased constant String := "ZAP";
   K_448           : aliased constant String := "qll";
   M_448           : aliased constant String := "CodeQL";
   K_449           : aliased constant String := "cql";
   M_449           : aliased constant String := "SQL";
   K_450           : aliased constant String := "pogo";
   M_450           : aliased constant String := "PogoScript";
   K_451           : aliased constant String := "fnc";
   M_451           : aliased constant String := "PLSQL";
   K_452           : aliased constant String := "vshader";
   M_452           : aliased constant String := "GLSL";
   K_453           : aliased constant String := "ninja";
   M_453           : aliased constant String := "Ninja";
   K_454           : aliased constant String := "vimrc";
   M_454           : aliased constant String := "Vim Script";
   K_455           : aliased constant String := "vrx";
   M_455           : aliased constant String := "GLSL";
   K_456           : aliased constant String := "ahk";
   M_456           : aliased constant String := "AutoHotkey";
   K_457           : aliased constant String := "fnl";
   M_457           : aliased constant String := "Fennel";
   K_458           : aliased constant String := "ktm";
   M_458           : aliased constant String := "Kotlin";
   K_459           : aliased constant String := "cjsx";
   M_459           : aliased constant String := "CoffeeScript";
   K_460           : aliased constant String := "jake";
   M_460           : aliased constant String := "JavaScript";
   K_461           : aliased constant String := "kts";
   M_461           : aliased constant String := "Kotlin";
   K_462           : aliased constant String := "apacheconf";
   M_462           : aliased constant String := "ApacheConf";
   K_463           : aliased constant String := "rst.txt";
   M_463           : aliased constant String := "reStructuredText";
   K_464           : aliased constant String := "mirah";
   M_464           : aliased constant String := "Mirah";
   K_465           : aliased constant String := "ditamap";
   M_465           : aliased constant String := "XML";
   K_466           : aliased constant String := "c++objdump";
   M_466           : aliased constant String := "Cpp-ObjDump";
   K_467           : aliased constant String := "zimpl";
   M_467           : aliased constant String := "Zimpl";
   K_468           : aliased constant String := "nqp";
   M_468           : aliased constant String := "Raku";
   K_469           : aliased constant String := "csc";
   M_469           : aliased constant String := "GSC";
   K_470           : aliased constant String := "xslt";
   M_470           : aliased constant String := "XSLT";
   K_471           : aliased constant String := "qhelp";
   M_471           : aliased constant String := "XML";
   K_472           : aliased constant String := "csd";
   M_472           : aliased constant String := "Csound Document";
   K_473           : aliased constant String := "gbl";
   M_473           : aliased constant String := "Gerber Image";
   K_474           : aliased constant String := "csh";
   M_474           : aliased constant String := "Tcsh";
   K_475           : aliased constant String := "vtl";
   M_475           : aliased constant String := "Velocity Template Language";
   K_476           : aliased constant String := "gbo";
   M_476           : aliased constant String := "Gerber Image";
   K_477           : aliased constant String := "gbp";
   M_477           : aliased constant String := "Gerber Image";
   K_478           : aliased constant String := "csl";
   M_478           : aliased constant String := "Kusto, XML";
   K_479           : aliased constant String := "gbr";
   M_479           : aliased constant String := "Gerber Image";
   K_480           : aliased constant String := "slim";
   M_480           : aliased constant String := "Slim";
   K_481           : aliased constant String := "gbs";
   M_481           : aliased constant String := "Gerber Image";
   K_482           : aliased constant String := "lhs";
   M_482           : aliased constant String := "Literate Haskell";
   K_483           : aliased constant String := "mspec";
   M_483           : aliased constant String := "Ruby";
   K_484           : aliased constant String := "hoon";
   M_484           : aliased constant String := "hoon";
   K_485           : aliased constant String := "vtt";
   M_485           : aliased constant String := "WebVTT";
   K_486           : aliased constant String := "css";
   M_486           : aliased constant String := "CSS";
   K_487           : aliased constant String := "csv";
   M_487           : aliased constant String := "CSV";
   K_488           : aliased constant String := "csx";
   M_488           : aliased constant String := "C#";
   K_489           : aliased constant String := "hats";
   M_489           : aliased constant String := "ATS";
   K_490           : aliased constant String := "fpp";
   M_490           : aliased constant String := "Fortran";
   K_491           : aliased constant String := "rbi";
   M_491           : aliased constant String := "Ruby";
   K_492           : aliased constant String := "nse";
   M_492           : aliased constant String := "Lua";
   K_493           : aliased constant String := "nawk";
   M_493           : aliased constant String := "Awk";
   K_494           : aliased constant String := "nsh";
   M_494           : aliased constant String := "NSIS";
   K_495           : aliased constant String := "ligo";
   M_495           : aliased constant String := "LigoLANG";
   K_496           : aliased constant String := "click";
   M_496           : aliased constant String := "Click";
   K_497           : aliased constant String := "volt";
   M_497           : aliased constant String := "Volt";
   K_498           : aliased constant String := "nsi";
   M_498           : aliased constant String := "NSIS";
   K_499           : aliased constant String := "abap";
   M_499           : aliased constant String := "ABAP";
   K_500           : aliased constant String := "iml";
   M_500           : aliased constant String := "XML";
   K_501           : aliased constant String := "mask";
   M_501           : aliased constant String := "Mask, Unity3D Asset";
   K_502           : aliased constant String := "yang";
   M_502           : aliased constant String := "YANG";
   K_503           : aliased constant String := "gdb";
   M_503           : aliased constant String := "GDB";
   K_504           : aliased constant String := "rbs";
   M_504           : aliased constant String := "RBS";
   K_505           : aliased constant String := "rbw";
   M_505           : aliased constant String := "Ruby";
   K_506           : aliased constant String := "nss";
   M_506           : aliased constant String := "NWScript";
   K_507           : aliased constant String := "depproj";
   M_507           : aliased constant String := "XML";
   K_508           : aliased constant String := "rbx";
   M_508           : aliased constant String := "Ruby";
   K_509           : aliased constant String := "cue";
   M_509           : aliased constant String := "CUE, Cue Sheet";
   K_510           : aliased constant String := "sublime-macro";
   M_510           : aliased constant String := "JSON with Comments";
   K_511           : aliased constant String := "cuh";
   M_511           : aliased constant String := "Cuda";
   K_512           : aliased constant String := "texinfo";
   M_512           : aliased constant String := "Texinfo";
   K_513           : aliased constant String := "zep";
   M_513           : aliased constant String := "Zephir";
   K_514           : aliased constant String := "mkvi";
   M_514           : aliased constant String := "TeX";
   K_515           : aliased constant String := "scxml";
   M_515           : aliased constant String := "XML";
   K_516           : aliased constant String := "mediawiki";
   M_516           : aliased constant String := "Wikitext";
   K_517           : aliased constant String := "edgeql";
   M_517           : aliased constant String := "EdgeQL";
   K_518           : aliased constant String := "frg";
   M_518           : aliased constant String := "GLSL";
   K_519           : aliased constant String := "p6l";
   M_519           : aliased constant String := "Raku";
   K_520           : aliased constant String := "tmLanguage";
   M_520           : aliased constant String := "XML Property List";
   K_521           : aliased constant String := "tml";
   M_521           : aliased constant String := "XML";
   K_522           : aliased constant String := "p6m";
   M_522           : aliased constant String := "Raku";
   K_523           : aliased constant String := "frm";
   M_523           : aliased constant String := "VBA, Visual Basic 6.0";
   K_524           : aliased constant String := "rdf";
   M_524           : aliased constant String := "XML";
   K_525           : aliased constant String := "xsp.metadata";
   M_525           : aliased constant String := "XPages";
   K_526           : aliased constant String := "jav";
   M_526           : aliased constant String := "Java";
   K_527           : aliased constant String := "als";
   M_527           : aliased constant String := "Alloy";
   K_528           : aliased constant String := "creole";
   M_528           : aliased constant String := "Creole";
   K_529           : aliased constant String := "frt";
   M_529           : aliased constant String := "Forth";
   K_530           : aliased constant String := "iol";
   M_530           : aliased constant String := "Jolie";
   K_531           : aliased constant String := "sublime-build";
   M_531           : aliased constant String := "JSON with Comments";
   K_532           : aliased constant String := "rakumod";
   M_532           : aliased constant String := "Raku";
   K_533           : aliased constant String := "grace";
   M_533           : aliased constant String := "Grace";
   K_534           : aliased constant String := "nut";
   M_534           : aliased constant String := "Squirrel";
   K_535           : aliased constant String := "mtml";
   M_535           : aliased constant String := "MTML";
   K_536           : aliased constant String := "launch";
   M_536           : aliased constant String := "XML";
   K_537           : aliased constant String := "cwl";
   M_537           : aliased constant String := "Common Workflow Language";
   K_538           : aliased constant String := "toc";
   M_538           : aliased constant String := "TeX, World of Warcraft Addon Data";
   K_539           : aliased constant String := "story";
   M_539           : aliased constant String := "Gherkin";
   K_540           : aliased constant String := "fsti";
   M_540           : aliased constant String := "F*";
   K_541           : aliased constant String := "kicad_wks";
   M_541           : aliased constant String := "KiCad Layout";
   K_542           : aliased constant String := "3in";
   M_542           : aliased constant String := "Roff, Roff Manpage";
   K_543           : aliased constant String := "emacs";
   M_543           : aliased constant String := "Emacs Lisp";
   K_544           : aliased constant String := "jcl";
   M_544           : aliased constant String := "JCL";
   K_545           : aliased constant String := "fth";
   M_545           : aliased constant String := "Forth";
   K_546           : aliased constant String := "nproj";
   M_546           : aliased constant String := "XML";
   K_547           : aliased constant String := "gradle";
   M_547           : aliased constant String := "Gradle";
   K_548           : aliased constant String := "yul";
   M_548           : aliased constant String := "Yul";
   K_549           : aliased constant String := "ftl";
   M_549           : aliased constant String := "FreeMarker, Fluent";
   K_550           : aliased constant String := "roff";
   M_550           : aliased constant String := "Roff";
   K_551           : aliased constant String := "dotsettings";
   M_551           : aliased constant String := "XML";
   K_552           : aliased constant String := "rake";
   M_552           : aliased constant String := "Ruby";
   K_553           : aliased constant String := "chpl";
   M_553           : aliased constant String := "Chapel";
   K_554           : aliased constant String := "ant";
   M_554           : aliased constant String := "XML";
   K_555           : aliased constant String := "wlk";
   M_555           : aliased constant String := "Wollok";
   K_556           : aliased constant String := "yara";
   M_556           : aliased constant String := "YARA";
   K_557           : aliased constant String := "cabal";
   M_557           : aliased constant String := "Cabal Config";
   K_558           : aliased constant String := "mermaid";
   M_558           : aliased constant String := "Mermaid";
   K_559           : aliased constant String := "builds";
   M_559           : aliased constant String := "XML";
   K_560           : aliased constant String := "flex";
   M_560           : aliased constant String := "JFlex";
   K_561           : aliased constant String := "mawk";
   M_561           : aliased constant String := "Awk";
   K_562           : aliased constant String := "zig";
   M_562           : aliased constant String := "Zig";
   K_563           : aliased constant String := "wlt";
   M_563           : aliased constant String := "Mathematica";
   K_564           : aliased constant String := "raku";
   M_564           : aliased constant String := "Raku";
   K_565           : aliased constant String := "ring";
   M_565           : aliased constant String := "Ring";
   K_566           : aliased constant String := "gltf";
   M_566           : aliased constant String := "JSON";
   K_567           : aliased constant String := "zil";
   M_567           : aliased constant String := "ZIL";
   K_568           : aliased constant String := "f03";
   M_568           : aliased constant String := "Fortran Free Form";
   K_569           : aliased constant String := "podsl";
   M_569           : aliased constant String := "Common Lisp";
   K_570           : aliased constant String := "f08";
   M_570           : aliased constant String := "Fortran Free Form";
   K_571           : aliased constant String := "cyp";
   M_571           : aliased constant String := "Cypher";
   K_572           : aliased constant String := "bbx";
   M_572           : aliased constant String := "TeX";
   K_573           : aliased constant String := "md2";
   M_573           : aliased constant String := "Checksums";
   K_574           : aliased constant String := "pgsql";
   M_574           : aliased constant String := "PLpgSQL";
   K_575           : aliased constant String := "md4";
   M_575           : aliased constant String := "Checksums";
   K_576           : aliased constant String := "md5";
   M_576           : aliased constant String := "Checksums";
   K_577           : aliased constant String := "apl";
   M_577           : aliased constant String := "APL";
   K_578           : aliased constant String := "monkey2";
   M_578           : aliased constant String := "Monkey";
   K_579           : aliased constant String := "vsixmanifest";
   M_579           : aliased constant String := "XML";
   K_580           : aliased constant String := "glade";
   M_580           : aliased constant String := "XML";
   K_581           : aliased constant String := "app";
   M_581           : aliased constant String := "Erlang";
   K_582           : aliased constant String := "cairo";
   M_582           : aliased constant String := "Cairo";
   K_583           : aliased constant String := "d2";
   M_583           : aliased constant String := "D2";
   K_584           : aliased constant String := "clar";
   M_584           : aliased constant String := "Clarity";
   K_585           : aliased constant String := "rs.in";
   M_585           : aliased constant String := "Rust";
   K_586           : aliased constant String := "raml";
   M_586           : aliased constant String := "RAML";
   K_587           : aliased constant String := "sublime_session";
   M_587           : aliased constant String := "JSON with Comments";
   K_588           : aliased constant String := "bb";
   M_588           : aliased constant String := "BitBake, BlitzBasic, Clojure";
   K_589           : aliased constant String := "isl";
   M_589           : aliased constant String := "Inno Setup";
   K_590           : aliased constant String := "be";
   M_590           : aliased constant String := "Berry";
   K_591           : aliased constant String := "javascript";
   M_591           : aliased constant String := "JavaScript";
   K_592           : aliased constant String := "bf";
   M_592           : aliased constant String := "Beef, HyPhy, Befunge, Brainfuck";
   K_593           : aliased constant String := "bi";
   M_593           : aliased constant String := "FreeBasic";
   K_594           : aliased constant String := "bdf";
   M_594           : aliased constant String := "Glyph Bitmap Distribution Format";
   K_595           : aliased constant String := "builder";
   M_595           : aliased constant String := "Ruby";
   K_596           : aliased constant String := "iss";
   M_596           : aliased constant String := "Inno Setup";
   K_597           : aliased constant String := "sha224";
   M_597           : aliased constant String := "Checksums";
   K_598           : aliased constant String := "frag";
   M_598           : aliased constant String := "GLSL, JavaScript";
   K_599           : aliased constant String := "rbtbar";
   M_599           : aliased constant String := "REALbasic";
   K_600           : aliased constant String := "bs";
   M_600           : aliased constant String := "BrighterScript, Bikeshed, Bluespec BH";
   K_601           : aliased constant String := "haml.deface";
   M_601           : aliased constant String := "Haml";
   K_602           : aliased constant String := "gjs";
   M_602           : aliased constant String := "Glimmer JS";
   K_603           : aliased constant String := "lpr";
   M_603           : aliased constant String := "Pascal";
   K_604           : aliased constant String := "arc";
   M_604           : aliased constant String := "Arc";
   K_605           : aliased constant String := "xbm";
   M_605           : aliased constant String := "X BitMap";
   K_606           : aliased constant String := "bdy";
   M_606           : aliased constant String := "PLSQL";
   K_607           : aliased constant String := "sha1";
   M_607           : aliased constant String := "Checksums";
   K_608           : aliased constant String := "fxh";
   M_608           : aliased constant String := "HLSL";
   K_609           : aliased constant String := "sha2";
   M_609           : aliased constant String := "Checksums";
   K_610           : aliased constant String := "xojo_script";
   M_610           : aliased constant String := "Xojo";
   K_611           : aliased constant String := "sha3";
   M_611           : aliased constant String := "Checksums";
   K_612           : aliased constant String := "nanorc";
   M_612           : aliased constant String := "nanorc";
   K_613           : aliased constant String := "lookml";
   M_613           : aliased constant String := "LookML";
   K_614           : aliased constant String := "yyp";
   M_614           : aliased constant String := "JSON";
   K_615           : aliased constant String := "ruby";
   M_615           : aliased constant String := "Ruby";
   K_616           : aliased constant String := "tst";
   M_616           : aliased constant String := "GAP, Scilab";
   K_617           : aliased constant String := "dart";
   M_617           : aliased constant String := "Dart";
   K_618           : aliased constant String := "arr";
   M_618           : aliased constant String := "Pyret";
   K_619           : aliased constant String := "dof";
   M_619           : aliased constant String := "INI";
   K_620           : aliased constant String := "rbmnu";
   M_620           : aliased constant String := "REALbasic";
   K_621           : aliased constant String := "tsv";
   M_621           : aliased constant String := "TSV";
   K_622           : aliased constant String := "psd1";
   M_622           : aliased constant String := "PowerShell";
   K_623           : aliased constant String := "doh";
   M_623           : aliased constant String := "Stata";
   K_624           : aliased constant String := "tsx";
   M_624           : aliased constant String := "TSX, XML";
   K_625           : aliased constant String := "fancypack";
   M_625           : aliased constant String := "Fancy";
   K_626           : aliased constant String := "sass";
   M_626           : aliased constant String := "Sass";
   K_627           : aliased constant String := "pac";
   M_627           : aliased constant String := "JavaScript";
   K_628           : aliased constant String := "cshtml";
   M_628           : aliased constant String := "HTML+Razor";
   K_629           : aliased constant String := "di";
   M_629           : aliased constant String := "D";
   K_630           : aliased constant String := "glf";
   M_630           : aliased constant String := "Glyph";
   K_631           : aliased constant String := "dot";
   M_631           : aliased constant String := "Graphviz (DOT)";
   K_632           : aliased constant String := "mdx";
   M_632           : aliased constant String := "MDX";
   K_633           : aliased constant String := "dm";
   M_633           : aliased constant String := "DM";
   K_634           : aliased constant String := "tmTheme";
   M_634           : aliased constant String := "XML Property List";
   K_635           : aliased constant String := "pan";
   M_635           : aliased constant String := "Pan";
   K_636           : aliased constant String := "do";
   M_636           : aliased constant String := "Stata";
   K_637           : aliased constant String := "dll.config";
   M_637           : aliased constant String := "XML";
   K_638           : aliased constant String := "xdc";
   M_638           : aliased constant String := "Tcl";
   K_639           : aliased constant String := "hocon";
   M_639           : aliased constant String := "HOCON";
   K_640           : aliased constant String := "pas";
   M_640           : aliased constant String := "Pascal";
   K_641           : aliased constant String := "pat";
   M_641           : aliased constant String := "Max";
   K_642           : aliased constant String := "urdf";
   M_642           : aliased constant String := "XML";
   K_643           : aliased constant String := "asax";
   M_643           : aliased constant String := "ASP.NET";
   K_644           : aliased constant String := "ooc";
   M_644           : aliased constant String := "ooc";
   K_645           : aliased constant String := "lvlib";
   M_645           : aliased constant String := "LabVIEW";
   K_646           : aliased constant String := "mdoc";
   M_646           : aliased constant String := "Roff, Roff Manpage";
   K_647           : aliased constant String := "logtalk";
   M_647           : aliased constant String := "Logtalk";
   K_648           : aliased constant String := "sha512";
   M_648           : aliased constant String := "Checksums";
   K_649           : aliased constant String := "PrjPCB";
   M_649           : aliased constant String := "Altium Designer";
   K_650           : aliased constant String := "ecl";
   M_650           : aliased constant String := "ECL, ECLiPSe";
   K_651           : aliased constant String := "ecr";
   M_651           : aliased constant String := "HTML+ECR";
   K_652           : aliased constant String := "ect";
   M_652           : aliased constant String := "EJS";
   K_653           : aliased constant String := "filters";
   M_653           : aliased constant String := "XML";
   K_654           : aliased constant String := "dats";
   M_654           : aliased constant String := "ATS";
   K_655           : aliased constant String := "puml";
   M_655           : aliased constant String := "PlantUML";
   K_656           : aliased constant String := "tesc";
   M_656           : aliased constant String := "GLSL";
   K_657           : aliased constant String := "tese";
   M_657           : aliased constant String := "GLSL";
   K_658           : aliased constant String := "antlers.html";
   M_658           : aliased constant String := "Antlers";
   K_659           : aliased constant String := "cfml";
   M_659           : aliased constant String := "ColdFusion";
   K_660           : aliased constant String := "yasnippet";
   M_660           : aliased constant String := "YASnippet";
   K_661           : aliased constant String := "pck";
   M_661           : aliased constant String := "PLSQL";
   K_662           : aliased constant String := "watchr";
   M_662           : aliased constant String := "Ruby";
   K_663           : aliased constant String := "prolog";
   M_663           : aliased constant String := "Prolog";
   K_664           : aliased constant String := "gni";
   M_664           : aliased constant String := "GN";
   K_665           : aliased constant String := "coffee";
   M_665           : aliased constant String := "CoffeeScript";
   K_666           : aliased constant String := "workbook";
   M_666           : aliased constant String := "Markdown";
   K_667           : aliased constant String := "fp";
   M_667           : aliased constant String := "GLSL";
   K_668           : aliased constant String := "desktop";
   M_668           : aliased constant String := "desktop";
   K_669           : aliased constant String := "fr";
   M_669           : aliased constant String := "Frege, Forth, Text";
   K_670           : aliased constant String := "fs";
   M_670           : aliased constant String := "Filterscript, F#, Forth, GLSL";
   K_671           : aliased constant String := "moon";
   M_671           : aliased constant String := "MoonScript";
   K_672           : aliased constant String := "ascx";
   M_672           : aliased constant String := "ASP.NET";
   K_673           : aliased constant String := "maxproj";
   M_673           : aliased constant String := "Max";
   K_674           : aliased constant String := "fx";
   M_674           : aliased constant String := "HLSL, FLUX";
   K_675           : aliased constant String := "fy";
   M_675           : aliased constant String := "Fancy";
   K_676           : aliased constant String := "gnu";
   M_676           : aliased constant String := "Gnuplot";
   K_677           : aliased constant String := "feature";
   M_677           : aliased constant String := "Gherkin";
   K_678           : aliased constant String := "ltx";
   M_678           : aliased constant String := "TeX";
   K_679           : aliased constant String := "3qt";
   M_679           : aliased constant String := "Roff, Roff Manpage";
   K_680           : aliased constant String := "bibtex";
   M_680           : aliased constant String := "BibTeX";
   K_681           : aliased constant String := "vxml";
   M_681           : aliased constant String := "XML";
   K_682           : aliased constant String := "dsc";
   M_682           : aliased constant String := "Debian Package Control File, DenizenScrip"
       & "t";
   K_683           : aliased constant String := "rnh";
   M_683           : aliased constant String := "RUNOFF";
   K_684           : aliased constant String := "j2";
   M_684           : aliased constant String := "Jinja";
   K_685           : aliased constant String := "eex";
   M_685           : aliased constant String := "HTML+EEX";
   K_686           : aliased constant String := "zcml";
   M_686           : aliased constant String := "XML";
   K_687           : aliased constant String := "nlogo";
   M_687           : aliased constant String := "NetLogo";
   K_688           : aliased constant String := "js.erb";
   M_688           : aliased constant String := "JavaScript+ERB";
   K_689           : aliased constant String := "ronn";
   M_689           : aliased constant String := "Markdown";
   K_690           : aliased constant String := "hb";
   M_690           : aliased constant String := "Harbour";
   K_691           : aliased constant String := "lisp";
   M_691           : aliased constant String := "NewLisp, Common Lisp";
   K_692           : aliased constant String := "hc";
   M_692           : aliased constant String := "HolyC";
   K_693           : aliased constant String := "dsl";
   M_693           : aliased constant String := "ASL";
   K_694           : aliased constant String := "rno";
   M_694           : aliased constant String := "Roff, RUNOFF";
   K_695           : aliased constant String := "hbs";
   M_695           : aliased constant String := "Handlebars";
   K_696           : aliased constant String := "gpb";
   M_696           : aliased constant String := "Gerber Image";
   K_697           : aliased constant String := "xojo_code";
   M_697           : aliased constant String := "Xojo";
   K_698           : aliased constant String := "monkey";
   M_698           : aliased constant String := "Monkey";
   K_699           : aliased constant String := "dsp";
   M_699           : aliased constant String := "Microsoft Developer Studio Project, Faust";
   K_700           : aliased constant String := "hh";
   M_700           : aliased constant String := "Hack, C++";
   K_701           : aliased constant String := "pluginspec";
   M_701           : aliased constant String := "Ruby, XML";
   K_702           : aliased constant String := "rnw";
   M_702           : aliased constant String := "Sweave";
   K_703           : aliased constant String := "pep";
   M_703           : aliased constant String := "Pep8";
   K_704           : aliased constant String := "per";
   M_704           : aliased constant String := "Genero per";
   K_705           : aliased constant String := "targets";
   M_705           : aliased constant String := "XML";
   K_706           : aliased constant String := "hs";
   M_706           : aliased constant String := "Haskell";
   K_707           : aliased constant String := "escript";
   M_707           : aliased constant String := "Erlang";
   K_708           : aliased constant String := "mysql";
   M_708           : aliased constant String := "SQL";
   K_709           : aliased constant String := "clixml";
   M_709           : aliased constant String := "XML";
   K_710           : aliased constant String := "hx";
   M_710           : aliased constant String := "Haxe";
   K_711           : aliased constant String := "gpt";
   M_711           : aliased constant String := "Gerber Image";
   K_712           : aliased constant String := "lean";
   M_712           : aliased constant String := "Lean 4, Lean";
   K_713           : aliased constant String := "hy";
   M_713           : aliased constant String := "Hy";
   K_714           : aliased constant String := "axd";
   M_714           : aliased constant String := "ASP.NET";
   K_715           : aliased constant String := "lark";
   M_715           : aliased constant String := "Lark";
   K_716           : aliased constant String := "ml4";
   M_716           : aliased constant String := "OCaml";
   K_717           : aliased constant String := "axi";
   M_717           : aliased constant String := "NetLinx";
   K_718           : aliased constant String := "osm";
   M_718           : aliased constant String := "XML";
   K_719           : aliased constant String := "praat";
   M_719           : aliased constant String := "Praat";
   K_720           : aliased constant String := "sbt";
   M_720           : aliased constant String := "Scala";
   K_721           : aliased constant String := "xht";
   M_721           : aliased constant String := "HTML";
   K_722           : aliased constant String := "typ";
   M_722           : aliased constant String := "XML, Typst";
   K_723           : aliased constant String := "6pl";
   M_723           : aliased constant String := "Raku";
   K_724           : aliased constant String := "6pm";
   M_724           : aliased constant String := "Raku";
   K_725           : aliased constant String := "ejs.t";
   M_725           : aliased constant String := "EJS";
   K_726           : aliased constant String := "kicad_sch";
   M_726           : aliased constant String := "KiCad Schematic";
   K_727           : aliased constant String := "axs";
   M_727           : aliased constant String := "NetLinx";
   K_728           : aliased constant String := "cake";
   M_728           : aliased constant String := "CoffeeScript, C#";
   K_729           : aliased constant String := "reds";
   M_729           : aliased constant String := "Red";
   K_730           : aliased constant String := "shen";
   M_730           : aliased constant String := "Shen";
   K_731           : aliased constant String := "4gl";
   M_731           : aliased constant String := "Genero 4gl";
   K_732           : aliased constant String := "mjs";
   M_732           : aliased constant String := "JavaScript";
   K_733           : aliased constant String := "axml";
   M_733           : aliased constant String := "XML";
   K_734           : aliased constant String := "kak";
   M_734           : aliased constant String := "KakouneScript";
   K_735           : aliased constant String := "mathematica";
   M_735           : aliased constant String := "Mathematica";
   K_736           : aliased constant String := "zsh";
   M_736           : aliased constant String := "Shell";
   K_737           : aliased constant String := "jl";
   M_737           : aliased constant String := "Julia";
   K_738           : aliased constant String := "rpy";
   M_738           : aliased constant String := "Ren'Py, Python";
   K_739           : aliased constant String := "mjml";
   M_739           : aliased constant String := "XML";
   K_740           : aliased constant String := "sdc";
   M_740           : aliased constant String := "Tcl";
   K_741           : aliased constant String := "jq";
   M_741           : aliased constant String := "jq, JSONiq";
   K_742           : aliased constant String := "js";
   M_742           : aliased constant String := "JavaScript";
   K_743           : aliased constant String := "avdl";
   M_743           : aliased constant String := "Avro IDL";
   K_744           : aliased constant String := "grt";
   M_744           : aliased constant String := "Groovy";
   K_745           : aliased constant String := "geom";
   M_745           : aliased constant String := "GLSL";
   K_746           : aliased constant String := "cscfg";
   M_746           : aliased constant String := "XML";
   K_747           : aliased constant String := "bbclass";
   M_747           : aliased constant String := "BitBake";
   K_748           : aliased constant String := "scad";
   M_748           : aliased constant String := "OpenSCAD";
   K_749           : aliased constant String := "4DProject";
   M_749           : aliased constant String := "JSON";
   K_750           : aliased constant String := "mli";
   M_750           : aliased constant String := "OCaml";
   K_751           : aliased constant String := "wxi";
   M_751           : aliased constant String := "XML";
   K_752           : aliased constant String := "mll";
   M_752           : aliased constant String := "OCaml";
   K_753           : aliased constant String := "jsonld";
   M_753           : aliased constant String := "JSONLD";
   K_754           : aliased constant String := "wxl";
   M_754           : aliased constant String := "XML";
   K_755           : aliased constant String := "dwl";
   M_755           : aliased constant String := "DataWeave";
   K_756           : aliased constant String := "pic";
   M_756           : aliased constant String := "Pic";
   K_757           : aliased constant String := "ld";
   M_757           : aliased constant String := "Linker Script";
   K_758           : aliased constant String := "xml.dist";
   M_758           : aliased constant String := "XML";
   K_759           : aliased constant String := "pig";
   M_759           : aliased constant String := "PigLatin";
   K_760           : aliased constant String := "wxs";
   M_760           : aliased constant String := "XML";
   K_761           : aliased constant String := "mly";
   M_761           : aliased constant String := "OCaml";
   K_762           : aliased constant String := "ll";
   M_762           : aliased constant String := "LLVM";
   K_763           : aliased constant String := "sqlrpgle";
   M_763           : aliased constant String := "RPGLE";
   K_764           : aliased constant String := "gtl";
   M_764           : aliased constant String := "Gerber Image";
   K_765           : aliased constant String := "sfd";
   M_765           : aliased constant String := "Spline Font Database";
   K_766           : aliased constant String := "pir";
   M_766           : aliased constant String := "Parrot Internal Representation";
   K_767           : aliased constant String := "gto";
   M_767           : aliased constant String := "Gerber Image";
   K_768           : aliased constant String := "ls";
   M_768           : aliased constant String := "LiveScript, LoomScript";
   K_769           : aliased constant String := "gtp";
   M_769           : aliased constant String := "Gerber Image";
   K_770           : aliased constant String := "xlf";
   M_770           : aliased constant String := "XML";
   K_771           : aliased constant String := "cppobjdump";
   M_771           : aliased constant String := "Cpp-ObjDump";
   K_772           : aliased constant String := "imba";
   M_772           : aliased constant String := "Imba";
   K_773           : aliased constant String := "gts";
   M_773           : aliased constant String := "Gerber Image, Glimmer TS";
   K_774           : aliased constant String := "plsql";
   M_774           : aliased constant String := "PLSQL";
   K_775           : aliased constant String := "ahkl";
   M_775           : aliased constant String := "AutoHotkey";
   K_776           : aliased constant String := "ly";
   M_776           : aliased constant String := "LilyPond";
   K_777           : aliased constant String := "forth";
   M_777           : aliased constant String := "Forth";
   K_778           : aliased constant String := "self";
   M_778           : aliased constant String := "Self";
   K_779           : aliased constant String := "sarif";
   M_779           : aliased constant String := "JSON";
   K_780           : aliased constant String := "sublime-mousemap";
   M_780           : aliased constant String := "JSON with Comments";
   K_781           : aliased constant String := "natvis";
   M_781           : aliased constant String := "XML";
   K_782           : aliased constant String := "owl";
   M_782           : aliased constant String := "Web Ontology Language";
   K_783           : aliased constant String := "snap";
   M_783           : aliased constant String := "Jest Snapshot";
   K_784           : aliased constant String := "pyde";
   M_784           : aliased constant String := "Python";
   K_785           : aliased constant String := "tfvars";
   M_785           : aliased constant String := "HCL";
   K_786           : aliased constant String := "mdwn";
   M_786           : aliased constant String := "Markdown";
   K_787           : aliased constant String := "sfv";
   M_787           : aliased constant String := "Simple File Verification";
   K_788           : aliased constant String := "emacs.desktop";
   M_788           : aliased constant String := "Emacs Lisp";
   K_789           : aliased constant String := "rtf";
   M_789           : aliased constant String := "Rich Text Format";
   K_790           : aliased constant String := "hhi";
   M_790           : aliased constant String := "Hack";
   K_791           : aliased constant String := "vcl";
   M_791           : aliased constant String := "VCL";
   K_792           : aliased constant String := "zsh-theme";
   M_792           : aliased constant String := "Shell";
   K_793           : aliased constant String := "cbl";
   M_793           : aliased constant String := "COBOL";
   K_794           : aliased constant String := "p4";
   M_794           : aliased constant String := "P4";
   K_795           : aliased constant String := "vert";
   M_795           : aliased constant String := "GLSL";
   K_796           : aliased constant String := "hack";
   M_796           : aliased constant String := "Hack";
   K_797           : aliased constant String := "p6";
   M_797           : aliased constant String := "Raku";
   K_798           : aliased constant String := "pm6";
   M_798           : aliased constant String := "Raku";
   K_799           : aliased constant String := "nb";
   M_799           : aliased constant String := "Mathematica, Text";
   K_800           : aliased constant String := "pkb";
   M_800           : aliased constant String := "PLSQL";
   K_801           : aliased constant String := "nc";
   M_801           : aliased constant String := "nesC";
   K_802           : aliased constant String := "dyl";
   M_802           : aliased constant String := "Dylan";
   K_803           : aliased constant String := "p8";
   M_803           : aliased constant String := "Lua";
   K_804           : aliased constant String := "irclog";
   M_804           : aliased constant String := "IRC log";
   K_805           : aliased constant String := "ne";
   M_805           : aliased constant String := "Nearley";
   K_806           : aliased constant String := "nf";
   M_806           : aliased constant String := "Nextflow";
   K_807           : aliased constant String := "wren";
   M_807           : aliased constant String := "Wren";
   K_808           : aliased constant String := "xsp-config";
   M_808           : aliased constant String := "XPages";
   K_809           : aliased constant String := "kicad_mod";
   M_809           : aliased constant String := "KiCad Layout";
   K_810           : aliased constant String := "ni";
   M_810           : aliased constant String := "Inform 7";
   K_811           : aliased constant String := "cbx";
   M_811           : aliased constant String := "TeX";
   K_812           : aliased constant String := "i7x";
   M_812           : aliased constant String := "Inform 7";
   K_813           : aliased constant String := "xacro";
   M_813           : aliased constant String := "XML";
   K_814           : aliased constant String := "nl";
   M_814           : aliased constant String := "NewLisp, NL";
   K_815           : aliased constant String := "pkl";
   M_815           : aliased constant String := "Pickle";
   K_816           : aliased constant String := "vbproj";
   M_816           : aliased constant String := "XML";
   K_817           : aliased constant String := "scrbl";
   M_817           : aliased constant String := "Racket";
   K_818           : aliased constant String := "code-snippets";
   M_818           : aliased constant String := "JSON with Comments";
   K_819           : aliased constant String := "no";
   M_819           : aliased constant String := "Text";
   K_820           : aliased constant String := "bpl";
   M_820           : aliased constant String := "Boogie";
   K_821           : aliased constant String := "php3";
   M_821           : aliased constant String := "PHP";
   K_822           : aliased constant String := "php4";
   M_822           : aliased constant String := "PHP";
   K_823           : aliased constant String := "nr";
   M_823           : aliased constant String := "Roff";
   K_824           : aliased constant String := "php5";
   M_824           : aliased constant String := "PHP";
   K_825           : aliased constant String := "jsb";
   M_825           : aliased constant String := "JavaScript";
   K_826           : aliased constant String := "pks";
   M_826           : aliased constant String := "PLSQL";
   K_827           : aliased constant String := "tfstate.backup";
   M_827           : aliased constant String := "JSON";
   K_828           : aliased constant String := "nu";
   M_828           : aliased constant String := "Nu, Nushell";
   K_829           : aliased constant String := "fshader";
   M_829           : aliased constant String := "GLSL";
   K_830           : aliased constant String := "druby";
   M_830           : aliased constant String := "Mirah";
   K_831           : aliased constant String := "jsh";
   M_831           : aliased constant String := "Java";
   K_832           : aliased constant String := "ny";
   M_832           : aliased constant String := "Common Lisp";
   K_833           : aliased constant String := "eml";
   M_833           : aliased constant String := "E-mail";
   K_834           : aliased constant String := "nbp";
   M_834           : aliased constant String := "Mathematica";
   K_835           : aliased constant String := "gvy";
   M_835           : aliased constant String := "Groovy";
   K_836           : aliased constant String := "jsm";
   M_836           : aliased constant String := "JavaScript";
   K_837           : aliased constant String := "cdc";
   M_837           : aliased constant String := "Cadence";
   K_838           : aliased constant String := "rbuistate";
   M_838           : aliased constant String := "REALbasic";
   K_839           : aliased constant String := "jsp";
   M_839           : aliased constant String := "Java Server Pages";
   K_840           : aliased constant String := "cdf";
   M_840           : aliased constant String := "Mathematica";
   K_841           : aliased constant String := "jss";
   M_841           : aliased constant String := "JavaScript";
   K_842           : aliased constant String := "command";
   M_842           : aliased constant String := "Shell";
   K_843           : aliased constant String := "scala";
   M_843           : aliased constant String := "Scala";
   K_844           : aliased constant String := "jst";
   M_844           : aliased constant String := "EJS";
   K_845           : aliased constant String := "gleam";
   M_845           : aliased constant String := "Gleam";
   K_846           : aliased constant String := "r2";
   M_846           : aliased constant String := "Rebol";
   K_847           : aliased constant String := "fsproj";
   M_847           : aliased constant String := "XML";
   K_848           : aliased constant String := "jsx";
   M_848           : aliased constant String := "JavaScript";
   K_849           : aliased constant String := "r3";
   M_849           : aliased constant String := "Rebol";
   K_850           : aliased constant String := "veo";
   M_850           : aliased constant String := "Verilog";
   K_851           : aliased constant String := "mpl";
   M_851           : aliased constant String := "JetBrains MPS";
   K_852           : aliased constant String := "bicep";
   M_852           : aliased constant String := "Bicep";
   K_853           : aliased constant String := "pb";
   M_853           : aliased constant String := "PureBasic";
   K_854           : aliased constant String := "cxx-objdump";
   M_854           : aliased constant String := "Cpp-ObjDump";
   K_855           : aliased constant String := "cds";
   M_855           : aliased constant String := "CAP CDS";
   K_856           : aliased constant String := "pd";
   M_856           : aliased constant String := "Pure Data";
   K_857           : aliased constant String := "flux";
   M_857           : aliased constant String := "FLUX";
   K_858           : aliased constant String := "2da";
   M_858           : aliased constant String := "2-Dimensional Array";
   K_859           : aliased constant String := "mps";
   M_859           : aliased constant String := "JetBrains MPS";
   K_860           : aliased constant String := "brd";
   M_860           : aliased constant String := "KiCad Legacy Layout, Eagle";
   K_861           : aliased constant String := "ph";
   M_861           : aliased constant String := "Perl";
   K_862           : aliased constant String := "pascal";
   M_862           : aliased constant String := "Pascal";
   K_863           : aliased constant String := "omgrofl";
   M_863           : aliased constant String := "Omgrofl";
   K_864           : aliased constant String := "fan";
   M_864           : aliased constant String := "Fantom";
   K_865           : aliased constant String := "pl";
   M_865           : aliased constant String := "Perl, Raku, Prolog";
   K_866           : aliased constant String := "pml";
   M_866           : aliased constant String := "Promela";
   K_867           : aliased constant String := "polar";
   M_867           : aliased constant String := "Polar";
   K_868           : aliased constant String := "pm";
   M_868           : aliased constant String := "Perl, X PixMap, Raku";
   K_869           : aliased constant String := "po";
   M_869           : aliased constant String := "Gettext Catalog";
   K_870           : aliased constant String := "pp";
   M_870           : aliased constant String := "Pascal, Puppet";
   K_871           : aliased constant String := "latte";
   M_871           : aliased constant String := "Latte";
   K_872           : aliased constant String := "bro";
   M_872           : aliased constant String := "Zeek";
   K_873           : aliased constant String := "ps";
   M_873           : aliased constant String := "PostScript";
   K_874           : aliased constant String := "asmx";
   M_874           : aliased constant String := "ASP.NET";
   K_875           : aliased constant String := "pt";
   M_875           : aliased constant String := "XML";
   K_876           : aliased constant String := "brs";
   M_876           : aliased constant String := "Brightscript";
   K_877           : aliased constant String := "py";
   M_877           : aliased constant String := "Python";
   K_878           : aliased constant String := "xpl";
   M_878           : aliased constant String := "XProc";
   K_879           : aliased constant String := "xpm";
   M_879           : aliased constant String := "X PixMap";
   K_880           : aliased constant String := "cfc";
   M_880           : aliased constant String := "ColdFusion CFC";
   K_881           : aliased constant String := "sjs";
   M_881           : aliased constant String := "JavaScript";
   K_882           : aliased constant String := "mrc";
   M_882           : aliased constant String := "mIRC Script";
   K_883           : aliased constant String := "cfg";
   M_883           : aliased constant String := "INI, HAProxy";
   K_884           : aliased constant String := "muse";
   M_884           : aliased constant String := "Muse";
   K_885           : aliased constant String := "edge";
   M_885           : aliased constant String := "Edge";
   K_886           : aliased constant String := "phps";
   M_886           : aliased constant String := "PHP";
   K_887           : aliased constant String := "phpt";
   M_887           : aliased constant String := "PHP";
   K_888           : aliased constant String := "regex";
   M_888           : aliased constant String := "Regular Expression";
   K_889           : aliased constant String := "Dsr";
   M_889           : aliased constant String := "Visual Basic 6.0";
   K_890           : aliased constant String := "xpy";
   M_890           : aliased constant String := "Python";
   K_891           : aliased constant String := "cfm";
   M_891           : aliased constant String := "ColdFusion";
   K_892           : aliased constant String := "twig";
   M_892           : aliased constant String := "Twig";
   K_893           : aliased constant String := "rb";
   M_893           : aliased constant String := "Ruby";
   K_894           : aliased constant String := "kid";
   M_894           : aliased constant String := "Genshi";
   K_895           : aliased constant String := "capnp";
   M_895           : aliased constant String := "Cap'n Proto";
   K_896           : aliased constant String := "blade";
   M_896           : aliased constant String := "Blade";
   K_897           : aliased constant String := "pod";
   M_897           : aliased constant String := "Pod 6, Pod";
   K_898           : aliased constant String := "rd";
   M_898           : aliased constant String := "R";
   K_899           : aliased constant String := "re";
   M_899           : aliased constant String := "Reason, C++";
   K_900           : aliased constant String := "rg";
   M_900           : aliased constant String := "Rouge";
   K_901           : aliased constant String := "anim";
   M_901           : aliased constant String := "Unity3D Asset";
   K_902           : aliased constant String := "JSON-tmLanguage";
   M_902           : aliased constant String := "JSON";
   K_903           : aliased constant String := "rl";
   M_903           : aliased constant String := "Ragel";
   K_904           : aliased constant String := "sparql";
   M_904           : aliased constant String := "SPARQL";
   K_905           : aliased constant String := "es6";
   M_905           : aliased constant String := "JavaScript";
   K_906           : aliased constant String := "rq";
   M_906           : aliased constant String := "SPARQL";
   K_907           : aliased constant String := "sld";
   M_907           : aliased constant String := "Scheme";
   K_908           : aliased constant String := "por";
   M_908           : aliased constant String := "Portugol";
   K_909           : aliased constant String := "kit";
   M_909           : aliased constant String := "Kit";
   K_910           : aliased constant String := "rs";
   M_910           : aliased constant String := "Rust, RenderScript, XML";
   K_911           : aliased constant String := "pot";
   M_911           : aliased constant String := "Gettext Catalog";
   K_912           : aliased constant String := "sublime-settings";
   M_912           : aliased constant String := "JSON with Comments";
   K_913           : aliased constant String := "ru";
   M_913           : aliased constant String := "Ruby";
   K_914           : aliased constant String := "pov";
   M_914           : aliased constant String := "POV-Ray SDL";
   K_915           : aliased constant String := "swift";
   M_915           : aliased constant String := "Swift";
   K_916           : aliased constant String := "xrl";
   M_916           : aliased constant String := "Erlang";
   K_917           : aliased constant String := "sln";
   M_917           : aliased constant String := "Microsoft Visual Studio Solution";
   K_918           : aliased constant String := "blade.php";
   M_918           : aliased constant String := "Blade";
   K_919           : aliased constant String := "sls";
   M_919           : aliased constant String := "SaltStack, Scheme";
   K_920           : aliased constant String := "rbuild";
   M_920           : aliased constant String := "Ruby";
   K_921           : aliased constant String := "xsjslib";
   M_921           : aliased constant String := "JavaScript";
   K_922           : aliased constant String := "talon";
   M_922           : aliased constant String := "Talon";
   K_923           : aliased constant String := "mligo";
   M_923           : aliased constant String := "CameLIGO";
   K_924           : aliased constant String := "mkii";
   M_924           : aliased constant String := "TeX";
   K_925           : aliased constant String := "SchDoc";
   M_925           : aliased constant String := "Altium Designer";
   K_926           : aliased constant String := "ps1";
   M_926           : aliased constant String := "PowerShell";
   K_927           : aliased constant String := "vim";
   M_927           : aliased constant String := "Vim Script";
   K_928           : aliased constant String := "nims";
   M_928           : aliased constant String := "Nim";
   K_929           : aliased constant String := "fea";
   M_929           : aliased constant String := "OpenType Feature File";
   K_930           : aliased constant String := "json";
   M_930           : aliased constant String := "JSON, OASv2-json, OASv3-json";
   K_931           : aliased constant String := "mtl";
   M_931           : aliased constant String := "Wavefront Material";
   K_932           : aliased constant String := "unity";
   M_932           : aliased constant String := "Unity3D Asset";
   K_933           : aliased constant String := "wast";
   M_933           : aliased constant String := "WebAssembly";
   K_934           : aliased constant String := "chs";
   M_934           : aliased constant String := "C2hs Haskell";
   K_935           : aliased constant String := "kojo";
   M_935           : aliased constant String := "Scala";
   K_936           : aliased constant String := "te";
   M_936           : aliased constant String := "SELinux Policy";
   K_937           : aliased constant String := "mts";
   M_937           : aliased constant String := "TypeScript";
   K_938           : aliased constant String := "pact";
   M_938           : aliased constant String := "Pact";
   K_939           : aliased constant String := "tf";
   M_939           : aliased constant String := "HCL";
   K_940           : aliased constant String := "viw";
   M_940           : aliased constant String := "SQL";
   K_941           : aliased constant String := "mkiv";
   M_941           : aliased constant String := "TeX";
   K_942           : aliased constant String := "tres";
   M_942           : aliased constant String := "Godot Resource";
   K_943           : aliased constant String := "yaml-tmlanguage";
   M_943           : aliased constant String := "YAML";
   K_944           : aliased constant String := "tl";
   M_944           : aliased constant String := "Type Language";
   K_945           : aliased constant String := "rhtml";
   M_945           : aliased constant String := "HTML+ERB";
   K_946           : aliased constant String := "stan";
   M_946           : aliased constant String := "Stan";
   K_947           : aliased constant String := "tm";
   M_947           : aliased constant String := "Tcl";
   K_948           : aliased constant String := "numsc";
   M_948           : aliased constant String := "NumPy";
   K_949           : aliased constant String := "star";
   M_949           : aliased constant String := "Starlark, STAR";
   K_950           : aliased constant String := "xojo_report";
   M_950           : aliased constant String := "Xojo";
   K_951           : aliased constant String := "ts";
   M_951           : aliased constant String := "TypeScript, XML";
   K_952           : aliased constant String := "gemspec";
   M_952           : aliased constant String := "Ruby";
   K_953           : aliased constant String := "tu";
   M_953           : aliased constant String := "Turing";
   K_954           : aliased constant String := "yacc";
   M_954           : aliased constant String := "Yacc";
   K_955           : aliased constant String := "cl2";
   M_955           : aliased constant String := "Clojure";
   K_956           : aliased constant String := "minid";
   M_956           : aliased constant String := "MiniD";
   K_957           : aliased constant String := "bison";
   M_957           : aliased constant String := "Bison";
   K_958           : aliased constant String := "snip";
   M_958           : aliased constant String := "Vim Snippet";
   K_959           : aliased constant String := "dockerfile";
   M_959           : aliased constant String := "Dockerfile";
   K_960           : aliased constant String := "tmac";
   M_960           : aliased constant String := "Roff";
   K_961           : aliased constant String := "sha384";
   M_961           : aliased constant String := "Checksums";
   K_962           : aliased constant String := "xspec";
   M_962           : aliased constant String := "XML";
   K_963           : aliased constant String := "trigger";
   M_963           : aliased constant String := "Apex, Shell";
   K_964           : aliased constant String := "hpp";
   M_964           : aliased constant String := "C++";
   K_965           : aliased constant String := "vb";
   M_965           : aliased constant String := "Visual Basic .NET";
   K_966           : aliased constant String := "fxml";
   M_966           : aliased constant String := "XML";
   K_967           : aliased constant String := "psc";
   M_967           : aliased constant String := "Papyrus";
   K_968           : aliased constant String := "cjs";
   M_968           : aliased constant String := "JavaScript";
   K_969           : aliased constant String := "iuml";
   M_969           : aliased constant String := "PlantUML";
   K_970           : aliased constant String := "vh";
   M_970           : aliased constant String := "SystemVerilog";
   K_971           : aliased constant String := "bash";
   M_971           : aliased constant String := "Shell";
   K_972           : aliased constant String := "kml";
   M_972           : aliased constant String := "XML";
   K_973           : aliased constant String := "wlua";
   M_973           : aliased constant String := "Lua";
   K_974           : aliased constant String := "eliom";
   M_974           : aliased constant String := "OCaml";
   K_975           : aliased constant String := "idc";
   M_975           : aliased constant String := "C";
   K_976           : aliased constant String := "spc";
   M_976           : aliased constant String := "PLSQL";
   K_977           : aliased constant String := "jade";
   M_977           : aliased constant String := "Pug";
   K_978           : aliased constant String := "jslib";
   M_978           : aliased constant String := "JavaScript";
   K_979           : aliased constant String := "vs";
   M_979           : aliased constant String := "GLSL";
   K_980           : aliased constant String := "hlean";
   M_980           : aliased constant String := "Lean";
   K_981           : aliased constant String := "njk";
   M_981           : aliased constant String := "Nunjucks";
   K_982           : aliased constant String := "vw";
   M_982           : aliased constant String := "PLSQL";
   K_983           : aliased constant String := "vy";
   M_983           : aliased constant String := "Vyper";
   K_984           : aliased constant String := "pod6";
   M_984           : aliased constant String := "Pod 6";
   K_985           : aliased constant String := "vmb";
   M_985           : aliased constant String := "Vim Script";
   K_986           : aliased constant String := "idr";
   M_986           : aliased constant String := "Idris";
   K_987           : aliased constant String := "njs";
   M_987           : aliased constant String := "JavaScript";
   K_988           : aliased constant String := "sps";
   M_988           : aliased constant String := "Scheme";
   K_989           : aliased constant String := "clj";
   M_989           : aliased constant String := "Clojure";
   K_990           : aliased constant String := "html.hl";
   M_990           : aliased constant String := "HTML";
   K_991           : aliased constant String := "hrl";
   M_991           : aliased constant String := "Erlang";
   K_992           : aliased constant String := "las";
   M_992           : aliased constant String := "Lasso";
   K_993           : aliased constant String := "nim.cfg";
   M_993           : aliased constant String := "Nim";
   K_994           : aliased constant String := "clp";
   M_994           : aliased constant String := "CLIPS";
   K_995           : aliased constant String := "haml";
   M_995           : aliased constant String := "Haml";
   K_996           : aliased constant String := "pub";
   M_996           : aliased constant String := "Public Key";
   K_997           : aliased constant String := "xc";
   M_997           : aliased constant String := "XC";
   K_998           : aliased constant String := "cls";
   M_998           : aliased constant String := "TeX, Apex, ObjectScript, VBA, Visual Basi"
       & "c 6.0, OpenEdge ABL";
   K_999           : aliased constant String := "gypi";
   M_999           : aliased constant String := "Python";
   K_1000          : aliased constant String := "mxt";
   M_1000          : aliased constant String := "Max";
   K_1001          : aliased constant String := "db2";
   M_1001          : aliased constant String := "SQLPL";
   K_1002          : aliased constant String := "pug";
   M_1002          : aliased constant String := "Pug";
   K_1003          : aliased constant String := "clw";
   M_1003          : aliased constant String := "Clarion";
   K_1004          : aliased constant String := "xi";
   M_1004          : aliased constant String := "Logos";
   K_1005          : aliased constant String := "grxml";
   M_1005          : aliased constant String := "XML";
   K_1006          : aliased constant String := "pddl";
   M_1006          : aliased constant String := "PDDL";
   K_1007          : aliased constant String := "xm";
   M_1007          : aliased constant String := "Logos";
   K_1008          : aliased constant String := "sra";
   M_1008          : aliased constant String := "PowerBuilder";
   K_1009          : aliased constant String := "diff";
   M_1009          : aliased constant String := "Diff";
   K_1010          : aliased constant String := "bzl";
   M_1010          : aliased constant String := "Starlark";
   K_1011          : aliased constant String := "rbres";
   M_1011          : aliased constant String := "REALbasic";
   K_1012          : aliased constant String := "chem";
   M_1012          : aliased constant String := "Pic";
   K_1013          : aliased constant String := "xq";
   M_1013          : aliased constant String := "XQuery";
   K_1014          : aliased constant String := "groovy";
   M_1014          : aliased constant String := "Groovy";
   K_1015          : aliased constant String := "dhall";
   M_1015          : aliased constant String := "Dhall";
   K_1016          : aliased constant String := "xs";
   M_1016          : aliased constant String := "XS";
   K_1017          : aliased constant String := "nimble";
   M_1017          : aliased constant String := "Nim";
   K_1018          : aliased constant String := "lslp";
   M_1018          : aliased constant String := "LSL";
   K_1019          : aliased constant String := "marko";
   M_1019          : aliased constant String := "Marko";
   K_1020          : aliased constant String := "wat";
   M_1020          : aliased constant String := "WebAssembly";
   K_1021          : aliased constant String := "hta";
   M_1021          : aliased constant String := "HTML";
   K_1022          : aliased constant String := "rbbas";
   M_1022          : aliased constant String := "REALbasic";
   K_1023          : aliased constant String := "cnc";
   M_1023          : aliased constant String := "G-code";
   K_1024          : aliased constant String := "srt";
   M_1024          : aliased constant String := "SubRip Text, SRecode Template";
   K_1025          : aliased constant String := "cnf";
   M_1025          : aliased constant String := "INI";
   K_1026          : aliased constant String := "ob2";
   M_1026          : aliased constant String := "Oberon";
   K_1027          : aliased constant String := "sru";
   M_1027          : aliased constant String := "PowerBuilder";
   K_1028          : aliased constant String := "sexp";
   M_1028          : aliased constant String := "Common Lisp";
   K_1029          : aliased constant String := "srw";
   M_1029          : aliased constant String := "PowerBuilder";
   K_1030          : aliased constant String := "maxpat";
   M_1030          : aliased constant String := "Max";
   K_1031          : aliased constant String := "py3";
   M_1031          : aliased constant String := "Python";
   K_1032          : aliased constant String := "htm";
   M_1032          : aliased constant String := "HTML";
   K_1033          : aliased constant String := "editorconfig";
   M_1033          : aliased constant String := "EditorConfig";
   K_1034          : aliased constant String := "angelscript";
   M_1034          : aliased constant String := "AngelScript";
   K_1035          : aliased constant String := "vala";
   M_1035          : aliased constant String := "Vala";
   K_1036          : aliased constant String := "zeek";
   M_1036          : aliased constant String := "Zeek";
   K_1037          : aliased constant String := "jison";
   M_1037          : aliased constant String := "Jison";
   K_1038          : aliased constant String := "kql";
   M_1038          : aliased constant String := "Kusto";
   K_1039          : aliased constant String := "fcgi";
   M_1039          : aliased constant String := "Perl, Ruby, PHP, Lua, Shell, Python";
   K_1040          : aliased constant String := "pwn";
   M_1040          : aliased constant String := "Pawn";
   K_1041          : aliased constant String := "factor";
   M_1041          : aliased constant String := "Factor";
   K_1042          : aliased constant String := "zs";
   M_1042          : aliased constant String := "ZenScript";
   K_1043          : aliased constant String := "rabl";
   M_1043          : aliased constant String := "Ruby";
   K_1044          : aliased constant String := "eye";
   M_1044          : aliased constant String := "Ruby";
   K_1045          : aliased constant String := "wgsl";
   M_1045          : aliased constant String := "WGSL";
   K_1046          : aliased constant String := "cljscm";
   M_1046          : aliased constant String := "Clojure";
   K_1047          : aliased constant String := "stl";
   M_1047          : aliased constant String := "STL";
   K_1048          : aliased constant String := "vssettings";
   M_1048          : aliased constant String := "XML";
   K_1049          : aliased constant String := "less";
   M_1049          : aliased constant String := "Less";
   K_1050          : aliased constant String := "plist";
   M_1050          : aliased constant String := "OpenStep Property List, XML Property List";
   K_1051          : aliased constant String := "PcbDoc";
   M_1051          : aliased constant String := "Altium Designer";
   K_1052          : aliased constant String := "litcoffee";
   M_1052          : aliased constant String := "Literate CoffeeScript";
   K_1053          : aliased constant String := "vcxproj";
   M_1053          : aliased constant String := "XML";
   K_1054          : aliased constant String := "sty";
   M_1054          : aliased constant String := "TeX";
   K_1055          : aliased constant String := "sha256sum";
   M_1055          : aliased constant String := "Checksums";
   K_1056          : aliased constant String := "circom";
   M_1056          : aliased constant String := "Circom";
   K_1057          : aliased constant String := "agc";
   M_1057          : aliased constant String := "Apollo Guidance Computer";
   K_1058          : aliased constant String := "cpp";
   M_1058          : aliased constant String := "C++";
   K_1059          : aliased constant String := "sagews";
   M_1059          : aliased constant String := "Sage";
   K_1060          : aliased constant String := "cps";
   M_1060          : aliased constant String := "Component Pascal";
   K_1061          : aliased constant String := "obj";
   M_1061          : aliased constant String := "Wavefront Object";
   K_1062          : aliased constant String := "lex";
   M_1062          : aliased constant String := "Lex";
   K_1063          : aliased constant String := "OutJob";
   M_1063          : aliased constant String := "Altium Designer";
   K_1064          : aliased constant String := "lkml";
   M_1064          : aliased constant String := "LookML";
   K_1065          : aliased constant String := "ksh";
   M_1065          : aliased constant String := "Shell";
   K_1066          : aliased constant String := "agda";
   M_1066          : aliased constant String := "Agda";
   K_1067          : aliased constant String := "gaml";
   M_1067          : aliased constant String := "GAML";
   K_1068          : aliased constant String := "pyi";
   M_1068          : aliased constant String := "Python";
   K_1069          : aliased constant String := "cpy";
   M_1069          : aliased constant String := "COBOL";
   K_1070          : aliased constant String := "stTheme";
   M_1070          : aliased constant String := "XML Property List";
   K_1071          : aliased constant String := "x68";
   M_1071          : aliased constant String := "Motorola 68K Assembly";
   K_1072          : aliased constant String := "jflex";
   M_1072          : aliased constant String := "JFlex";
   K_1073          : aliased constant String := "pyp";
   M_1073          : aliased constant String := "Python";
   K_1074          : aliased constant String := "emberscript";
   M_1074          : aliased constant String := "EmberScript";
   K_1075          : aliased constant String := "pyt";
   M_1075          : aliased constant String := "Python";
   K_1076          : aliased constant String := "svg";
   M_1076          : aliased constant String := "SVG";
   K_1077          : aliased constant String := "thy";
   M_1077          : aliased constant String := "Isabelle";
   K_1078          : aliased constant String := "svh";
   M_1078          : aliased constant String := "SystemVerilog";
   K_1079          : aliased constant String := "ddl";
   M_1079          : aliased constant String := "PLSQL, SQL";
   K_1080          : aliased constant String := "lidr";
   M_1080          : aliased constant String := "Idris";
   K_1081          : aliased constant String := "pyw";
   M_1081          : aliased constant String := "Python";
   K_1082          : aliased constant String := "ijm";
   M_1082          : aliased constant String := "ImageJ Macro";
   K_1083          : aliased constant String := "ksy";
   M_1083          : aliased constant String := "Kaitai Struct";
   K_1084          : aliased constant String := "conll";
   M_1084          : aliased constant String := "CoNLL-U";
   K_1085          : aliased constant String := "pyx";
   M_1085          : aliased constant String := "Cython";
   K_1086          : aliased constant String := "html.leex";
   M_1086          : aliased constant String := "HTML+EEX";
   K_1087          : aliased constant String := "wsgi";
   M_1087          : aliased constant String := "Python";
   K_1088          : aliased constant String := "props";
   M_1088          : aliased constant String := "XML";
   K_1089          : aliased constant String := "storyboard";
   M_1089          : aliased constant String := "XML";
   K_1090          : aliased constant String := "workflow";
   M_1090          : aliased constant String := "HCL, XML";
   K_1091          : aliased constant String := "qmd";
   M_1091          : aliased constant String := "RMarkdown";
   K_1092          : aliased constant String := "tmPreferences";
   M_1092          : aliased constant String := "XML Property List";
   K_1093          : aliased constant String := "json5";
   M_1093          : aliased constant String := "JSON5";
   K_1094          : aliased constant String := "ijs";
   M_1094          : aliased constant String := "J";
   K_1095          : aliased constant String := "pytb";
   M_1095          : aliased constant String := "Python traceback";
   K_1096          : aliased constant String := "antlers.php";
   M_1096          : aliased constant String := "Antlers";
   K_1097          : aliased constant String := "vsh";
   M_1097          : aliased constant String := "GLSL";
   K_1098          : aliased constant String := "ihlp";
   M_1098          : aliased constant String := "Stata";
   K_1099          : aliased constant String := "qml";
   M_1099          : aliased constant String := "QML";
   K_1100          : aliased constant String := "gap";
   M_1100          : aliased constant String := "GAP";
   K_1101          : aliased constant String := "odd";
   M_1101          : aliased constant String := "XML";
   K_1102          : aliased constant String := "tftpl";
   M_1102          : aliased constant String := "Terraform Template";
   K_1103          : aliased constant String := "lgt";
   M_1103          : aliased constant String := "Logtalk";
   K_1104          : aliased constant String := "http";
   M_1104          : aliased constant String := "HTTP";
   K_1105          : aliased constant String := "gtpl";
   M_1105          : aliased constant String := "Groovy";
   K_1106          : aliased constant String := "eliomi";
   M_1106          : aliased constant String := "OCaml";
   K_1107          : aliased constant String := "rexx";
   M_1107          : aliased constant String := "REXX";
   K_1108          : aliased constant String := "scss";
   M_1108          : aliased constant String := "SCSS";
   K_1109          : aliased constant String := "hxx";
   M_1109          : aliased constant String := "C++";
   K_1110          : aliased constant String := "scenic";
   M_1110          : aliased constant String := "Scenic";
   K_1111          : aliased constant String := "vapi";
   M_1111          : aliased constant String := "Vala";
   K_1112          : aliased constant String := "lasso8";
   M_1112          : aliased constant String := "Lasso";
   K_1113          : aliased constant String := "lasso9";
   M_1113          : aliased constant String := "Lasso";
   K_1114          : aliased constant String := "for";
   M_1114          : aliased constant String := "Formatted, Fortran, Forth";
   K_1115          : aliased constant String := "cpp-objdump";
   M_1115          : aliased constant String := "Cpp-ObjDump";
   K_1116          : aliased constant String := "rockspec";
   M_1116          : aliased constant String := "Lua";
   K_1117          : aliased constant String := "cginc";
   M_1117          : aliased constant String := "HLSL";
   K_1118          : aliased constant String := "ps1xml";
   M_1118          : aliased constant String := "XML";
   K_1119          : aliased constant String := "metal";
   M_1119          : aliased constant String := "Metal";
   K_1120          : aliased constant String := "dfm";
   M_1120          : aliased constant String := "Pascal";
   K_1121          : aliased constant String := "pd_lua";
   M_1121          : aliased constant String := "Lua";
   K_1122          : aliased constant String := "prawn";
   M_1122          : aliased constant String := "Ruby";
   K_1123          : aliased constant String := "prefs";
   M_1123          : aliased constant String := "INI";
   K_1124          : aliased constant String := "lid";
   M_1124          : aliased constant String := "Dylan";
   K_1125          : aliased constant String := "hlsl";
   M_1125          : aliased constant String := "HLSL";
   K_1126          : aliased constant String := "glslf";
   M_1126          : aliased constant String := "GLSL";
   K_1127          : aliased constant String := "raw";
   M_1127          : aliased constant String := "Raw token data";
   K_1128          : aliased constant String := "snippets";
   M_1128          : aliased constant String := "Vim Snippet";
   K_1129          : aliased constant String := "tscn";
   M_1129          : aliased constant String := "Godot Resource";
   K_1130          : aliased constant String := "yaml";
   M_1130          : aliased constant String := "OASv2-yaml, OASv3-yaml, MiniYAML, YAML";
   K_1131          : aliased constant String := "sublime-snippet";
   M_1131          : aliased constant String := "XML";
   K_1132          : aliased constant String := "vue";
   M_1132          : aliased constant String := "Vue";
   K_1133          : aliased constant String := "jsonc";
   M_1133          : aliased constant String := "JSON with Comments";
   K_1134          : aliased constant String := "dfy";
   M_1134          : aliased constant String := "Dafny";
   K_1135          : aliased constant String := "ily";
   M_1135          : aliased constant String := "LilyPond";
   K_1136          : aliased constant String := "gco";
   M_1136          : aliased constant String := "G-code";
   K_1137          : aliased constant String := "tla";
   M_1137          : aliased constant String := "TLA";
   K_1138          : aliased constant String := "ctl";
   M_1138          : aliased constant String := "Visual Basic 6.0";
   K_1139          : aliased constant String := "yaml.sed";
   M_1139          : aliased constant String := "YAML";
   K_1140          : aliased constant String := "jsonl";
   M_1140          : aliased constant String := "JSON";
   K_1141          : aliased constant String := "antlers.xml";
   M_1141          : aliased constant String := "Antlers";
   K_1142          : aliased constant String := "ctp";
   M_1142          : aliased constant String := "PHP";
   K_1143          : aliased constant String := "glslv";
   M_1143          : aliased constant String := "GLSL";
   K_1144          : aliased constant String := "hzp";
   M_1144          : aliased constant String := "XML";
   K_1145          : aliased constant String := "cts";
   M_1145          : aliased constant String := "TypeScript";
   K_1146          : aliased constant String := "bbappend";
   M_1146          : aliased constant String := "BitBake";
   K_1147          : aliased constant String := "nginx";
   M_1147          : aliased constant String := "Nginx";
   K_1148          : aliased constant String := "yrl";
   M_1148          : aliased constant String := "Erlang";
   K_1149          : aliased constant String := "golo";
   M_1149          : aliased constant String := "Golo";
   K_1150          : aliased constant String := "phtml";
   M_1150          : aliased constant String := "HTML+PHP";
   K_1151          : aliased constant String := "inc";
   M_1151          : aliased constant String := "POV-Ray SDL, Pascal, Pawn, BitBake, SQL, "
       & "HTML, Assembly, PHP, SourcePawn, NASL, C++, Motorola 68K Assembly";
   K_1152          : aliased constant String := "rktd";
   M_1152          : aliased constant String := "Racket";
   K_1153          : aliased constant String := "vark";
   M_1153          : aliased constant String := "Gosu";
   K_1154          : aliased constant String := "mata";
   M_1154          : aliased constant String := "Stata";
   K_1155          : aliased constant String := "sh-session";
   M_1155          : aliased constant String := "ShellSession";
   K_1156          : aliased constant String := "srdf";
   M_1156          : aliased constant String := "XML";
   K_1157          : aliased constant String := "tlv";
   M_1157          : aliased constant String := "TL-Verilog";
   K_1158          : aliased constant String := "shader";
   M_1158          : aliased constant String := "ShaderLab, GLSL";
   K_1159          : aliased constant String := "ini";
   M_1159          : aliased constant String := "INI";
   K_1160          : aliased constant String := "snippet";
   M_1160          : aliased constant String := "Vim Snippet";
   K_1161          : aliased constant String := "maxhelp";
   M_1161          : aliased constant String := "Max";
   K_1162          : aliased constant String := "ink";
   M_1162          : aliased constant String := "Ink";
   K_1163          : aliased constant String := "esdl";
   M_1163          : aliased constant String := "EdgeQL";
   K_1164          : aliased constant String := "rktl";
   M_1164          : aliased constant String := "Racket";
   K_1165          : aliased constant String := "vstemplate";
   M_1165          : aliased constant String := "XML";
   K_1166          : aliased constant String := "inl";
   M_1166          : aliased constant String := "C++";
   K_1167          : aliased constant String := "proto";
   M_1167          : aliased constant String := "Protocol Buffer";
   K_1168          : aliased constant String := "rebol";
   M_1168          : aliased constant String := "Rebol";
   K_1169          : aliased constant String := "syntax";
   M_1169          : aliased constant String := "YAML";
   K_1170          : aliased constant String := "vbhtml";
   M_1170          : aliased constant String := "Visual Basic .NET";
   K_1171          : aliased constant String := "webapp";
   M_1171          : aliased constant String := "JSON";
   K_1172          : aliased constant String := "ino";
   M_1172          : aliased constant String := "C++";
   K_1173          : aliased constant String := "ged";
   M_1173          : aliased constant String := "GEDCOM";
   K_1174          : aliased constant String := "wit";
   M_1174          : aliased constant String := "WebAssembly Interface Type";
   K_1175          : aliased constant String := "gdns";
   M_1175          : aliased constant String := "Godot Resource";
   K_1176          : aliased constant String := "mlir";
   M_1176          : aliased constant String := "MLIR";
   K_1177          : aliased constant String := "regexp";
   M_1177          : aliased constant String := "Regular Expression";
   K_1178          : aliased constant String := "ins";
   M_1178          : aliased constant String := "TeX";
   K_1179          : aliased constant String := "prefab";
   M_1179          : aliased constant String := "Unity3D Asset";
   K_1180          : aliased constant String := "rpgle";
   M_1180          : aliased constant String := "RPGLE";
   K_1181          : aliased constant String := "cppm";
   M_1181          : aliased constant String := "C++";
   K_1182          : aliased constant String := "thrift";
   M_1182          : aliased constant String := "Thrift";
   K_1183          : aliased constant String := "boot";
   M_1183          : aliased constant String := "Clojure";
   K_1184          : aliased constant String := "coffee.md";
   M_1184          : aliased constant String := "Literate CoffeeScript";
   K_1185          : aliased constant String := "plot";
   M_1185          : aliased constant String := "Gnuplot";
   K_1186          : aliased constant String := "gradle.kts";
   M_1186          : aliased constant String := "Gradle Kotlin DSL";
   K_1187          : aliased constant String := "8xp.txt";
   M_1187          : aliased constant String := "TI Program";
   K_1188          : aliased constant String := "geo";
   M_1188          : aliased constant String := "GLSL";
   K_1189          : aliased constant String := "ebuild";
   M_1189          : aliased constant String := "Gentoo Ebuild";
   K_1190          : aliased constant String := "sublime-workspace";
   M_1190          : aliased constant String := "JSON with Comments";
   K_1191          : aliased constant String := "adml";
   M_1191          : aliased constant String := "XML";
   K_1192          : aliased constant String := "fsh";
   M_1192          : aliased constant String := "GLSL";
   K_1193          : aliased constant String := "ebnf";
   M_1193          : aliased constant String := "EBNF";
   K_1194          : aliased constant String := "fsi";
   M_1194          : aliased constant String := "F#";
   K_1195          : aliased constant String := "reb";
   M_1195          : aliased constant String := "Rebol";
   K_1196          : aliased constant String := "red";
   M_1196          : aliased constant String := "Red";
   K_1197          : aliased constant String := "bicepparam";
   M_1197          : aliased constant String := "Bicep";
   K_1198          : aliased constant String := "ston";
   M_1198          : aliased constant String := "STON";
   K_1199          : aliased constant String := "c++-objdump";
   M_1199          : aliased constant String := "Cpp-ObjDump";
   K_1200          : aliased constant String := "reg";
   M_1200          : aliased constant String := "Windows Registry Entries";
   K_1201          : aliased constant String := "rei";
   M_1201          : aliased constant String := "Reason";
   K_1202          : aliased constant String := "ipf";
   M_1202          : aliased constant String := "IGOR Pro";
   K_1203          : aliased constant String := "admx";
   M_1203          : aliased constant String := "XML";
   K_1204          : aliased constant String := "fst";
   M_1204          : aliased constant String := "F*";
   K_1205          : aliased constant String := "mint";
   M_1205          : aliased constant String := "Mint";
   K_1206          : aliased constant String := "zmpl";
   M_1206          : aliased constant String := "Zimpl";
   K_1207          : aliased constant String := "wixproj";
   M_1207          : aliased constant String := "XML";
   K_1208          : aliased constant String := "fsx";
   M_1208          : aliased constant String := "F#";
   K_1209          : aliased constant String := "desktop.in";
   M_1209          : aliased constant String := "desktop";
   K_1210          : aliased constant String := "libsonnet";
   M_1210          : aliased constant String := "Jsonnet";
   K_1211          : aliased constant String := "res";
   M_1211          : aliased constant String := "ReScript, XML";
   K_1212          : aliased constant String := "sublime-theme";
   M_1212          : aliased constant String := "JSON with Comments";
   K_1213          : aliased constant String := "ipp";
   M_1213          : aliased constant String := "C++";
   K_1214          : aliased constant String := "djs";
   M_1214          : aliased constant String := "Dogescript";
   K_1215          : aliased constant String := "rex";
   M_1215          : aliased constant String := "REXX";
   K_1216          : aliased constant String := "sh.in";
   M_1216          : aliased constant String := "Shell";
   K_1217          : aliased constant String := "vhost";
   M_1217          : aliased constant String := "Nginx, ApacheConf";
   K_1218          : aliased constant String := "app.src";
   M_1218          : aliased constant String := "Erlang";
   K_1219          : aliased constant String := "lmi";
   M_1219          : aliased constant String := "Python";
   K_1220          : aliased constant String := "bal";
   M_1220          : aliased constant String := "Ballerina";
   K_1221          : aliased constant String := "glsl";
   M_1221          : aliased constant String := "GLSL";
   K_1222          : aliased constant String := "xaml";
   M_1222          : aliased constant String := "XML";
   K_1223          : aliased constant String := "adoc";
   M_1223          : aliased constant String := "AsciiDoc";
   K_1224          : aliased constant String := "tpb";
   M_1224          : aliased constant String := "PLSQL";
   K_1225          : aliased constant String := "bas";
   M_1225          : aliased constant String := "BASIC, VBA, FreeBasic, Visual Basic 6.0";
   K_1226          : aliased constant String := "bat";
   M_1226          : aliased constant String := "Batchfile";
   K_1227          : aliased constant String := "pasm";
   M_1227          : aliased constant String := "Parrot Assembly";
   K_1228          : aliased constant String := "duby";
   M_1228          : aliased constant String := "Mirah";
   K_1229          : aliased constant String := "cson";
   M_1229          : aliased constant String := "CSON";
   K_1230          : aliased constant String := "tpl";
   M_1230          : aliased constant String := "Smarty";
   K_1231          : aliased constant String := "pony";
   M_1231          : aliased constant String := "Pony";
   K_1232          : aliased constant String := "cxx";
   M_1232          : aliased constant String := "C++";
   K_1233          : aliased constant String := "tpp";
   M_1233          : aliased constant String := "C++";
   K_1234          : aliased constant String := "fun";
   M_1234          : aliased constant String := "Standard ML";
   K_1235          : aliased constant String := "tps";
   M_1235          : aliased constant String := "PLSQL";
   K_1236          : aliased constant String := "mak";
   M_1236          : aliased constant String := "Makefile";
   K_1237          : aliased constant String := "fut";
   M_1237          : aliased constant String := "Futhark";
   K_1238          : aliased constant String := "man";
   M_1238          : aliased constant String := "Roff, Roff Manpage";
   K_1239          : aliased constant String := "mao";
   M_1239          : aliased constant String := "Mako";
   K_1240          : aliased constant String := "conllu";
   M_1240          : aliased constant String := "CoNLL-U";
   K_1241          : aliased constant String := "dlm";
   M_1241          : aliased constant String := "IDL";
   K_1242          : aliased constant String := "mdown";
   M_1242          : aliased constant String := "Markdown";
   K_1243          : aliased constant String := "mat";
   M_1243          : aliased constant String := "Unity3D Asset";
   K_1244          : aliased constant String := "udf";
   M_1244          : aliased constant String := "SQL";
   K_1245          : aliased constant String := "aj";
   M_1245          : aliased constant String := "AspectJ";
   K_1246          : aliased constant String := "rmiss";
   M_1246          : aliased constant String := "GLSL";
   K_1247          : aliased constant String := "al";
   M_1247          : aliased constant String := "Perl, AL";
   K_1248          : aliased constant String := "xhtml";
   M_1248          : aliased constant String := "HTML";
   K_1249          : aliased constant String := "udo";
   M_1249          : aliased constant String := "Csound";
   K_1250          : aliased constant String := "xquery";
   M_1250          : aliased constant String := "XQuery";
   K_1251          : aliased constant String := "lol";
   M_1251          : aliased constant String := "LOLCODE";
   K_1252          : aliased constant String := "as";
   M_1252          : aliased constant String := "AngelScript, ActionScript";
   K_1253          : aliased constant String := "mojo";
   M_1253          : aliased constant String := "Mojo, XML";
   K_1254          : aliased constant String := "aw";
   M_1254          : aliased constant String := "PHP";
   K_1255          : aliased constant String := "riot";
   M_1255          : aliased constant String := "Riot";
   K_1256          : aliased constant String := "xojo_window";
   M_1256          : aliased constant String := "Xojo";
   K_1257          : aliased constant String := "trg";
   M_1257          : aliased constant String := "PLSQL";
   K_1258          : aliased constant String := "gawk";
   M_1258          : aliased constant String := "Awk";
   K_1259          : aliased constant String := "patch";
   M_1259          : aliased constant String := "Diff";
   K_1260          : aliased constant String := "dita";
   M_1260          : aliased constant String := "XML";
   K_1261          : aliased constant String := "jinja2";
   M_1261          : aliased constant String := "Jinja";
   K_1262          : aliased constant String := "hlsli";
   M_1262          : aliased constant String := "HLSL";
   K_1263          : aliased constant String := "psc1";
   M_1263          : aliased constant String := "XML";
   K_1264          : aliased constant String := "whiley";
   M_1264          : aliased constant String := "Whiley";
   K_1265          : aliased constant String := "cc";
   M_1265          : aliased constant String := "C++";
   K_1266          : aliased constant String := "linq";
   M_1266          : aliased constant String := "C#";
   K_1267          : aliased constant String := "lasso";
   M_1267          : aliased constant String := "Lasso";
   K_1268          : aliased constant String := "vhdl";
   M_1268          : aliased constant String := "VHDL";
   K_1269          : aliased constant String := "mcr";
   M_1269          : aliased constant String := "MAXScript";
   K_1270          : aliased constant String := "ch";
   M_1270          : aliased constant String := "Charity, xBase";
   K_1271          : aliased constant String := "ck";
   M_1271          : aliased constant String := "ChucK";
   K_1272          : aliased constant String := "html.heex";
   M_1272          : aliased constant String := "HTML+EEX";
   K_1273          : aliased constant String := "cl";
   M_1273          : aliased constant String := "OpenCL, Cool, Common Lisp";
   K_1274          : aliased constant String := "smali";
   M_1274          : aliased constant String := "Smali";
   K_1275          : aliased constant String := "dyalog";
   M_1275          : aliased constant String := "APL";
   K_1276          : aliased constant String := "makefile";
   M_1276          : aliased constant String := "Makefile";
   K_1277          : aliased constant String := "cp";
   M_1277          : aliased constant String := "C++, Component Pascal";
   K_1278          : aliased constant String := "xzap";
   M_1278          : aliased constant String := "ZAP";
   K_1279          : aliased constant String := "c-objdump";
   M_1279          : aliased constant String := "C-ObjDump";
   K_1280          : aliased constant String := "cr";
   M_1280          : aliased constant String := "Crystal";
   K_1281          : aliased constant String := "au3";
   M_1281          : aliased constant String := "AutoIt";
   K_1282          : aliased constant String := "gko";
   M_1282          : aliased constant String := "Gerber Image";
   K_1283          : aliased constant String := "cs";
   M_1283          : aliased constant String := "C#, Smalltalk";
   K_1284          : aliased constant String := "hxml";
   M_1284          : aliased constant String := "HXML";
   K_1285          : aliased constant String := "ct";
   M_1285          : aliased constant String := "XML";
   K_1286          : aliased constant String := "mdpolicy";
   M_1286          : aliased constant String := "XML";
   K_1287          : aliased constant String := "cu";
   M_1287          : aliased constant String := "Cuda";
   K_1288          : aliased constant String := "sublime_metrics";
   M_1288          : aliased constant String := "JSON with Comments";
   K_1289          : aliased constant String := "cw";
   M_1289          : aliased constant String := "Redcode";
   K_1290          : aliased constant String := "asc";
   M_1290          : aliased constant String := "AGS Script, AsciiDoc, Public Key";
   K_1291          : aliased constant String := "jscad";
   M_1291          : aliased constant String := "JavaScript";
   K_1292          : aliased constant String := "cy";
   M_1292          : aliased constant String := "Cycript";
   K_1293          : aliased constant String := "asd";
   M_1293          : aliased constant String := "Common Lisp";
   K_1294          : aliased constant String := "ash";
   M_1294          : aliased constant String := "AGS Script";
   K_1295          : aliased constant String := "proj";
   M_1295          : aliased constant String := "XML";
   K_1296          : aliased constant String := "ttl";
   M_1296          : aliased constant String := "Turtle";
   K_1297          : aliased constant String := "applescript";
   M_1297          : aliased constant String := "AppleScript";
   K_1298          : aliased constant String := "asl";
   M_1298          : aliased constant String := "ASL";
   K_1299          : aliased constant String := "sieve";
   M_1299          : aliased constant String := "Sieve";
   K_1300          : aliased constant String := "asm";
   M_1300          : aliased constant String := "Assembly, Motorola 68K Assembly";
   K_1301          : aliased constant String := "liquid";
   M_1301          : aliased constant String := "Liquid";
   K_1302          : aliased constant String := "asn";
   M_1302          : aliased constant String := "ASN.1";
   K_1303          : aliased constant String := "java";
   M_1303          : aliased constant String := "Java";
   K_1304          : aliased constant String := "asp";
   M_1304          : aliased constant String := "Classic ASP";
   K_1305          : aliased constant String := "neon";
   M_1305          : aliased constant String := "NEON";
   K_1306          : aliased constant String := "g4";
   M_1306          : aliased constant String := "ANTLR";
   K_1307          : aliased constant String := "ditaval";
   M_1307          : aliased constant String := "XML";
   K_1308          : aliased constant String := "gcode";
   M_1308          : aliased constant String := "G-code";
   K_1309          : aliased constant String := "nomad";
   M_1309          : aliased constant String := "HCL";
   K_1310          : aliased constant String := "sats";
   M_1310          : aliased constant String := "ATS";
   K_1311          : aliased constant String := "eb";
   M_1311          : aliased constant String := "Easybuild";
   K_1312          : aliased constant String := "asy";
   M_1312          : aliased constant String := "Asymptote, LTspice Symbol";
   K_1313          : aliased constant String := "ec";
   M_1313          : aliased constant String := "eC";
   K_1314          : aliased constant String := "matah";
   M_1314          : aliased constant String := "Stata";
   K_1315          : aliased constant String := "xojo_toolbar";
   M_1315          : aliased constant String := "Xojo";
   K_1316          : aliased constant String := "eh";
   M_1316          : aliased constant String := "eC";
   K_1317          : aliased constant String := "rkt";
   M_1317          : aliased constant String := "Racket";
   K_1318          : aliased constant String := "dpr";
   M_1318          : aliased constant String := "Pascal";
   K_1319          : aliased constant String := "_js";
   M_1319          : aliased constant String := "JavaScript";
   K_1320          : aliased constant String := "pbi";
   M_1320          : aliased constant String := "PureBasic";
   K_1321          : aliased constant String := "el";
   M_1321          : aliased constant String := "Emacs Lisp";
   K_1322          : aliased constant String := "gmi";
   M_1322          : aliased constant String := "Gemini";
   K_1323          : aliased constant String := "em";
   M_1323          : aliased constant String := "EmberScript";
   K_1324          : aliased constant String := "tcl.in";
   M_1324          : aliased constant String := "Tcl";
   K_1325          : aliased constant String := "mcfunction";
   M_1325          : aliased constant String := "mcfunction";
   K_1326          : aliased constant String := "arpa";
   M_1326          : aliased constant String := "DNS Zone";
   K_1327          : aliased constant String := "gml";
   M_1327          : aliased constant String := "Game Maker Language, Gerber Image, XML, G"
       & "raph Modeling Language";
   K_1328          : aliased constant String := "sha256";
   M_1328          : aliased constant String := "Checksums";
   K_1329          : aliased constant String := "lsl";
   M_1329          : aliased constant String := "LSL";
   K_1330          : aliased constant String := "eq";
   M_1330          : aliased constant String := "EQ";
   K_1331          : aliased constant String := "ivy";
   M_1331          : aliased constant String := "XML";
   K_1332          : aliased constant String := "kicad_pcb";
   M_1332          : aliased constant String := "KiCad Layout";
   K_1333          : aliased constant String := "edc";
   M_1333          : aliased constant String := "Edje Data Collection";
   K_1334          : aliased constant String := "es";
   M_1334          : aliased constant String := "Erlang, JavaScript";
   K_1335          : aliased constant String := "opa";
   M_1335          : aliased constant String := "Opa";
   K_1336          : aliased constant String := "mkfile";
   M_1336          : aliased constant String := "Makefile";
   K_1337          : aliased constant String := "pbt";
   M_1337          : aliased constant String := "Protocol Buffer Text Format, PowerBuilder";
   K_1338          : aliased constant String := "cs.pp";
   M_1338          : aliased constant String := "C#";
   K_1339          : aliased constant String := "lsp";
   M_1339          : aliased constant String := "NewLisp, Common Lisp";
   K_1340          : aliased constant String := "gms";
   M_1340          : aliased constant String := "GAMS";
   K_1341          : aliased constant String := "3pm";
   M_1341          : aliased constant String := "Roff, Roff Manpage";
   K_1342          : aliased constant String := "ex";
   M_1342          : aliased constant String := "Elixir, Euphoria";
   K_1343          : aliased constant String := "aug";
   M_1343          : aliased constant String := "Augeas";
   K_1344          : aliased constant String := "gmx";
   M_1344          : aliased constant String := "XML";
   K_1345          : aliased constant String := "edn";
   M_1345          : aliased constant String := "edn";
   K_1346          : aliased constant String := "thor";
   M_1346          : aliased constant String := "Ruby";
   K_1347          : aliased constant String := "auk";
   M_1347          : aliased constant String := "Awk";
   K_1348          : aliased constant String := "jbuilder";
   M_1348          : aliased constant String := "Ruby";
   K_1349          : aliased constant String := "rmd";
   M_1349          : aliased constant String := "RMarkdown";
   K_1350          : aliased constant String := "sublime-keymap";
   M_1350          : aliased constant String := "JSON with Comments";
   K_1351          : aliased constant String := "tmux";
   M_1351          : aliased constant String := "Shell";
   K_1352          : aliased constant String := "wsf";
   M_1352          : aliased constant String := "XML";
   K_1353          : aliased constant String := "i3";
   M_1353          : aliased constant String := "Modula-3";
   K_1354          : aliased constant String := "aux";
   M_1354          : aliased constant String := "TeX";

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
      K_1072'Access, K_1073'Access, K_1074'Access, K_1075'Access,
      K_1076'Access, K_1077'Access, K_1078'Access, K_1079'Access,
      K_1080'Access, K_1081'Access, K_1082'Access, K_1083'Access,
      K_1084'Access, K_1085'Access, K_1086'Access, K_1087'Access,
      K_1088'Access, K_1089'Access, K_1090'Access, K_1091'Access,
      K_1092'Access, K_1093'Access, K_1094'Access, K_1095'Access,
      K_1096'Access, K_1097'Access, K_1098'Access, K_1099'Access,
      K_1100'Access, K_1101'Access, K_1102'Access, K_1103'Access,
      K_1104'Access, K_1105'Access, K_1106'Access, K_1107'Access,
      K_1108'Access, K_1109'Access, K_1110'Access, K_1111'Access,
      K_1112'Access, K_1113'Access, K_1114'Access, K_1115'Access,
      K_1116'Access, K_1117'Access, K_1118'Access, K_1119'Access,
      K_1120'Access, K_1121'Access, K_1122'Access, K_1123'Access,
      K_1124'Access, K_1125'Access, K_1126'Access, K_1127'Access,
      K_1128'Access, K_1129'Access, K_1130'Access, K_1131'Access,
      K_1132'Access, K_1133'Access, K_1134'Access, K_1135'Access,
      K_1136'Access, K_1137'Access, K_1138'Access, K_1139'Access,
      K_1140'Access, K_1141'Access, K_1142'Access, K_1143'Access,
      K_1144'Access, K_1145'Access, K_1146'Access, K_1147'Access,
      K_1148'Access, K_1149'Access, K_1150'Access, K_1151'Access,
      K_1152'Access, K_1153'Access, K_1154'Access, K_1155'Access,
      K_1156'Access, K_1157'Access, K_1158'Access, K_1159'Access,
      K_1160'Access, K_1161'Access, K_1162'Access, K_1163'Access,
      K_1164'Access, K_1165'Access, K_1166'Access, K_1167'Access,
      K_1168'Access, K_1169'Access, K_1170'Access, K_1171'Access,
      K_1172'Access, K_1173'Access, K_1174'Access, K_1175'Access,
      K_1176'Access, K_1177'Access, K_1178'Access, K_1179'Access,
      K_1180'Access, K_1181'Access, K_1182'Access, K_1183'Access,
      K_1184'Access, K_1185'Access, K_1186'Access, K_1187'Access,
      K_1188'Access, K_1189'Access, K_1190'Access, K_1191'Access,
      K_1192'Access, K_1193'Access, K_1194'Access, K_1195'Access,
      K_1196'Access, K_1197'Access, K_1198'Access, K_1199'Access,
      K_1200'Access, K_1201'Access, K_1202'Access, K_1203'Access,
      K_1204'Access, K_1205'Access, K_1206'Access, K_1207'Access,
      K_1208'Access, K_1209'Access, K_1210'Access, K_1211'Access,
      K_1212'Access, K_1213'Access, K_1214'Access, K_1215'Access,
      K_1216'Access, K_1217'Access, K_1218'Access, K_1219'Access,
      K_1220'Access, K_1221'Access, K_1222'Access, K_1223'Access,
      K_1224'Access, K_1225'Access, K_1226'Access, K_1227'Access,
      K_1228'Access, K_1229'Access, K_1230'Access, K_1231'Access,
      K_1232'Access, K_1233'Access, K_1234'Access, K_1235'Access,
      K_1236'Access, K_1237'Access, K_1238'Access, K_1239'Access,
      K_1240'Access, K_1241'Access, K_1242'Access, K_1243'Access,
      K_1244'Access, K_1245'Access, K_1246'Access, K_1247'Access,
      K_1248'Access, K_1249'Access, K_1250'Access, K_1251'Access,
      K_1252'Access, K_1253'Access, K_1254'Access, K_1255'Access,
      K_1256'Access, K_1257'Access, K_1258'Access, K_1259'Access,
      K_1260'Access, K_1261'Access, K_1262'Access, K_1263'Access,
      K_1264'Access, K_1265'Access, K_1266'Access, K_1267'Access,
      K_1268'Access, K_1269'Access, K_1270'Access, K_1271'Access,
      K_1272'Access, K_1273'Access, K_1274'Access, K_1275'Access,
      K_1276'Access, K_1277'Access, K_1278'Access, K_1279'Access,
      K_1280'Access, K_1281'Access, K_1282'Access, K_1283'Access,
      K_1284'Access, K_1285'Access, K_1286'Access, K_1287'Access,
      K_1288'Access, K_1289'Access, K_1290'Access, K_1291'Access,
      K_1292'Access, K_1293'Access, K_1294'Access, K_1295'Access,
      K_1296'Access, K_1297'Access, K_1298'Access, K_1299'Access,
      K_1300'Access, K_1301'Access, K_1302'Access, K_1303'Access,
      K_1304'Access, K_1305'Access, K_1306'Access, K_1307'Access,
      K_1308'Access, K_1309'Access, K_1310'Access, K_1311'Access,
      K_1312'Access, K_1313'Access, K_1314'Access, K_1315'Access,
      K_1316'Access, K_1317'Access, K_1318'Access, K_1319'Access,
      K_1320'Access, K_1321'Access, K_1322'Access, K_1323'Access,
      K_1324'Access, K_1325'Access, K_1326'Access, K_1327'Access,
      K_1328'Access, K_1329'Access, K_1330'Access, K_1331'Access,
      K_1332'Access, K_1333'Access, K_1334'Access, K_1335'Access,
      K_1336'Access, K_1337'Access, K_1338'Access, K_1339'Access,
      K_1340'Access, K_1341'Access, K_1342'Access, K_1343'Access,
      K_1344'Access, K_1345'Access, K_1346'Access, K_1347'Access,
      K_1348'Access, K_1349'Access, K_1350'Access, K_1351'Access,
      K_1352'Access, K_1353'Access, K_1354'Access);

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
      M_1072'Access, M_1073'Access, M_1074'Access, M_1075'Access,
      M_1076'Access, M_1077'Access, M_1078'Access, M_1079'Access,
      M_1080'Access, M_1081'Access, M_1082'Access, M_1083'Access,
      M_1084'Access, M_1085'Access, M_1086'Access, M_1087'Access,
      M_1088'Access, M_1089'Access, M_1090'Access, M_1091'Access,
      M_1092'Access, M_1093'Access, M_1094'Access, M_1095'Access,
      M_1096'Access, M_1097'Access, M_1098'Access, M_1099'Access,
      M_1100'Access, M_1101'Access, M_1102'Access, M_1103'Access,
      M_1104'Access, M_1105'Access, M_1106'Access, M_1107'Access,
      M_1108'Access, M_1109'Access, M_1110'Access, M_1111'Access,
      M_1112'Access, M_1113'Access, M_1114'Access, M_1115'Access,
      M_1116'Access, M_1117'Access, M_1118'Access, M_1119'Access,
      M_1120'Access, M_1121'Access, M_1122'Access, M_1123'Access,
      M_1124'Access, M_1125'Access, M_1126'Access, M_1127'Access,
      M_1128'Access, M_1129'Access, M_1130'Access, M_1131'Access,
      M_1132'Access, M_1133'Access, M_1134'Access, M_1135'Access,
      M_1136'Access, M_1137'Access, M_1138'Access, M_1139'Access,
      M_1140'Access, M_1141'Access, M_1142'Access, M_1143'Access,
      M_1144'Access, M_1145'Access, M_1146'Access, M_1147'Access,
      M_1148'Access, M_1149'Access, M_1150'Access, M_1151'Access,
      M_1152'Access, M_1153'Access, M_1154'Access, M_1155'Access,
      M_1156'Access, M_1157'Access, M_1158'Access, M_1159'Access,
      M_1160'Access, M_1161'Access, M_1162'Access, M_1163'Access,
      M_1164'Access, M_1165'Access, M_1166'Access, M_1167'Access,
      M_1168'Access, M_1169'Access, M_1170'Access, M_1171'Access,
      M_1172'Access, M_1173'Access, M_1174'Access, M_1175'Access,
      M_1176'Access, M_1177'Access, M_1178'Access, M_1179'Access,
      M_1180'Access, M_1181'Access, M_1182'Access, M_1183'Access,
      M_1184'Access, M_1185'Access, M_1186'Access, M_1187'Access,
      M_1188'Access, M_1189'Access, M_1190'Access, M_1191'Access,
      M_1192'Access, M_1193'Access, M_1194'Access, M_1195'Access,
      M_1196'Access, M_1197'Access, M_1198'Access, M_1199'Access,
      M_1200'Access, M_1201'Access, M_1202'Access, M_1203'Access,
      M_1204'Access, M_1205'Access, M_1206'Access, M_1207'Access,
      M_1208'Access, M_1209'Access, M_1210'Access, M_1211'Access,
      M_1212'Access, M_1213'Access, M_1214'Access, M_1215'Access,
      M_1216'Access, M_1217'Access, M_1218'Access, M_1219'Access,
      M_1220'Access, M_1221'Access, M_1222'Access, M_1223'Access,
      M_1224'Access, M_1225'Access, M_1226'Access, M_1227'Access,
      M_1228'Access, M_1229'Access, M_1230'Access, M_1231'Access,
      M_1232'Access, M_1233'Access, M_1234'Access, M_1235'Access,
      M_1236'Access, M_1237'Access, M_1238'Access, M_1239'Access,
      M_1240'Access, M_1241'Access, M_1242'Access, M_1243'Access,
      M_1244'Access, M_1245'Access, M_1246'Access, M_1247'Access,
      M_1248'Access, M_1249'Access, M_1250'Access, M_1251'Access,
      M_1252'Access, M_1253'Access, M_1254'Access, M_1255'Access,
      M_1256'Access, M_1257'Access, M_1258'Access, M_1259'Access,
      M_1260'Access, M_1261'Access, M_1262'Access, M_1263'Access,
      M_1264'Access, M_1265'Access, M_1266'Access, M_1267'Access,
      M_1268'Access, M_1269'Access, M_1270'Access, M_1271'Access,
      M_1272'Access, M_1273'Access, M_1274'Access, M_1275'Access,
      M_1276'Access, M_1277'Access, M_1278'Access, M_1279'Access,
      M_1280'Access, M_1281'Access, M_1282'Access, M_1283'Access,
      M_1284'Access, M_1285'Access, M_1286'Access, M_1287'Access,
      M_1288'Access, M_1289'Access, M_1290'Access, M_1291'Access,
      M_1292'Access, M_1293'Access, M_1294'Access, M_1295'Access,
      M_1296'Access, M_1297'Access, M_1298'Access, M_1299'Access,
      M_1300'Access, M_1301'Access, M_1302'Access, M_1303'Access,
      M_1304'Access, M_1305'Access, M_1306'Access, M_1307'Access,
      M_1308'Access, M_1309'Access, M_1310'Access, M_1311'Access,
      M_1312'Access, M_1313'Access, M_1314'Access, M_1315'Access,
      M_1316'Access, M_1317'Access, M_1318'Access, M_1319'Access,
      M_1320'Access, M_1321'Access, M_1322'Access, M_1323'Access,
      M_1324'Access, M_1325'Access, M_1326'Access, M_1327'Access,
      M_1328'Access, M_1329'Access, M_1330'Access, M_1331'Access,
      M_1332'Access, M_1333'Access, M_1334'Access, M_1335'Access,
      M_1336'Access, M_1337'Access, M_1338'Access, M_1339'Access,
      M_1340'Access, M_1341'Access, M_1342'Access, M_1343'Access,
      M_1344'Access, M_1345'Access, M_1346'Access, M_1347'Access,
      M_1348'Access, M_1349'Access, M_1350'Access, M_1351'Access,
      M_1352'Access, M_1353'Access, M_1354'Access);

   function Get_Mapping (Name : String) return access constant String is
      H : constant Natural := Hash (Name);
   begin
      return (if Names (H).all = Name then Contents (H) else null);
   end Get_Mapping;

end SPDX_Tool.Languages.ExtensionMap;
