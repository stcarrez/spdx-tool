--  Advanced Resource Embedder 1.3.0
--  SPDX-License-Identifier: Apache-2.0
--  License templates extracted from https://github.com/spdx/license-list-data.git
package SPDX_Tool.Licenses.Files is

   type Content_Access is access constant Buffer_Type;

   type Name_Access is access constant String;

   type Name_Array is array (Natural range <>) of Name_Access;

   Names : constant Name_Array;

   --  Returns the data stream with the given name or null.
   function Get_Content (Name : String) return
      access constant Buffer_Type;

private


   K_0             : aliased constant String := "Apache-2.0-alt";
   K_1             : aliased constant String := "gnat-asis";
   K_2             : aliased constant String := "gnat-gcc";
   K_3             : aliased constant String := "gnat-gcc-exception";
   K_4             : aliased constant String := "standard/AFL-1.1";
   K_5             : aliased constant String := "standard/AFL-1.2";
   K_6             : aliased constant String := "standard/AFL-2.0";
   K_7             : aliased constant String := "standard/AFL-2.1";
   K_8             : aliased constant String := "standard/AFL-3.0";
   K_9             : aliased constant String := "standard/AGPL-3.0";
   K_10            : aliased constant String := "standard/AGPL-3.0-only";
   K_11            : aliased constant String := "standard/AGPL-3.0-or-later";
   K_12            : aliased constant String := "standard/APSL-2.0";
   K_13            : aliased constant String := "standard/Apache-2.0";
   K_14            : aliased constant String := "standard/BUSL-1.1";
   K_15            : aliased constant String := "standard/BitTorrent-1.0";
   K_16            : aliased constant String := "standard/BitTorrent-1.1";
   K_17            : aliased constant String := "standard/CPAL-1.0";
   K_18            : aliased constant String := "standard/CUA-OPL-1.0";
   K_19            : aliased constant String := "standard/ECL-1.0";
   K_20            : aliased constant String := "standard/ECL-2.0";
   K_21            : aliased constant String := "standard/GFDL-1.1";
   K_22            : aliased constant String := "standard/GFDL-1.1-invariants-only";
   K_23            : aliased constant String := "standard/GFDL-1.1-invariants-or-later";
   K_24            : aliased constant String := "standard/GFDL-1.1-no-invariants-only";
   K_25            : aliased constant String := "standard/GFDL-1.1-no-invariants-or-later";
   K_26            : aliased constant String := "standard/GFDL-1.1-only";
   K_27            : aliased constant String := "standard/GFDL-1.1-or-later";
   K_28            : aliased constant String := "standard/GFDL-1.2";
   K_29            : aliased constant String := "standard/GFDL-1.2-invariants-only";
   K_30            : aliased constant String := "standard/GFDL-1.2-invariants-or-later";
   K_31            : aliased constant String := "standard/GFDL-1.2-no-invariants-only";
   K_32            : aliased constant String := "standard/GFDL-1.2-no-invariants-or-later";
   K_33            : aliased constant String := "standard/GFDL-1.2-only";
   K_34            : aliased constant String := "standard/GFDL-1.2-or-later";
   K_35            : aliased constant String := "standard/GFDL-1.3";
   K_36            : aliased constant String := "standard/GFDL-1.3-invariants-only";
   K_37            : aliased constant String := "standard/GFDL-1.3-invariants-or-later";
   K_38            : aliased constant String := "standard/GFDL-1.3-no-invariants-only";
   K_39            : aliased constant String := "standard/GFDL-1.3-no-invariants-or-later";
   K_40            : aliased constant String := "standard/GFDL-1.3-only";
   K_41            : aliased constant String := "standard/GFDL-1.3-or-later";
   K_42            : aliased constant String := "standard/GPL-1.0";
   K_43            : aliased constant String := "standard/GPL-1.0+";
   K_44            : aliased constant String := "standard/GPL-1.0-only";
   K_45            : aliased constant String := "standard/GPL-1.0-or-later";
   K_46            : aliased constant String := "standard/GPL-2.0";
   K_47            : aliased constant String := "standard/GPL-2.0+";
   K_48            : aliased constant String := "standard/GPL-2.0-only";
   K_49            : aliased constant String := "standard/GPL-2.0-or-later";
   K_50            : aliased constant String := "standard/GPL-3.0";
   K_51            : aliased constant String := "standard/GPL-3.0+";
   K_52            : aliased constant String := "standard/GPL-3.0-only";
   K_53            : aliased constant String := "standard/GPL-3.0-or-later";
   K_54            : aliased constant String := "standard/Interbase-1.0";
   K_55            : aliased constant String := "standard/LGPL-2.0";
   K_56            : aliased constant String := "standard/LGPL-2.0+";
   K_57            : aliased constant String := "standard/LGPL-2.0-only";
   K_58            : aliased constant String := "standard/LGPL-2.0-or-later";
   K_59            : aliased constant String := "standard/LGPL-2.1";
   K_60            : aliased constant String := "standard/LGPL-2.1+";
   K_61            : aliased constant String := "standard/LGPL-2.1-only";
   K_62            : aliased constant String := "standard/LGPL-2.1-or-later";
   K_63            : aliased constant String := "standard/LPPL-1.0";
   K_64            : aliased constant String := "standard/LPPL-1.1";
   K_65            : aliased constant String := "standard/LPPL-1.2";
   K_66            : aliased constant String := "standard/LPPL-1.3a";
   K_67            : aliased constant String := "standard/LPPL-1.3c";
   K_68            : aliased constant String := "standard/MPL-1.0";
   K_69            : aliased constant String := "standard/MPL-1.1";
   K_70            : aliased constant String := "standard/MPL-2.0";
   K_71            : aliased constant String := "standard/MPL-2.0-no-copyleft-exception";
   K_72            : aliased constant String := "standard/MulanPSL-1.0";
   K_73            : aliased constant String := "standard/MulanPSL-2.0";
   K_74            : aliased constant String := "standard/OCLC-2.0";
   K_75            : aliased constant String := "standard/OSL-1.0";
   K_76            : aliased constant String := "standard/OSL-1.1";
   K_77            : aliased constant String := "standard/OSL-2.0";
   K_78            : aliased constant String := "standard/OSL-2.1";
   K_79            : aliased constant String := "standard/OSL-3.0";
   K_80            : aliased constant String := "standard/RPSL-1.0";
   K_81            : aliased constant String := "standard/SCEA";
   K_82            : aliased constant String := "standard/SGI-B-1.0";
   K_83            : aliased constant String := "standard/SGI-B-1.1";
   K_84            : aliased constant String := "standard/SHL-0.5";
   K_85            : aliased constant String := "standard/SHL-0.51";
   K_86            : aliased constant String := "standard/SISSL";
   K_87            : aliased constant String := "standard/SISSL-1.2";
   K_88            : aliased constant String := "standard/SPL-1.0";
   K_89            : aliased constant String := "standard/SSPL-1.0";
   K_90            : aliased constant String := "standard/TPL-1.0";
   K_91            : aliased constant String := "standard/UCL-1.0";
   K_92            : aliased constant String := "standard/W3C";
   K_93            : aliased constant String := "standard/W3C-20150513";
   K_94            : aliased constant String := "standard/equiv";
   K_95            : aliased constant String := "standard/template";

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
      K_92'Access, K_93'Access, K_94'Access, K_95'Access);
end SPDX_Tool.Licenses.Files;
