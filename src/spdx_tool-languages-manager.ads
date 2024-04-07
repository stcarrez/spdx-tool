-- --------------------------------------------------------------------
--  spdx_tool-languages -- language identification and header extraction
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with SPDX_Tool.Infos;
with SPDX_Tool.Configs;
private with Ada.Strings.Hash;
private with Ada.Containers.Indefinite_Hashed_Maps;
private with SPDX_Tool.Languages.Extensions;
private with SPDX_Tool.Languages.Mimes;
private with SPDX_Tool.Languages.Shell;
private with SPDX_Tool.Languages.Filenames;
private with SPDX_Tool.Languages.Modelines;
package SPDX_Tool.Languages.Manager is

   type Language_Manager is tagged limited private;

   --  Initialize the language manager with the given configuration.
   procedure Initialize (Manager : in out Language_Manager;
                         Config  : in SPDX_Tool.Configs.Config_Type);

   --  Identify the language used by the given file.  The identification can be
   --  made by looking at the file extension, the mime type or by looking at
   --  the first 4K block of the file.
   procedure Find_Language (Manager  : in Language_Manager;
                            File     : in out SPDX_Tool.Infos.File_Info;
                            Content  : in out File_Type;
                            Analyzer : out Analyzer_Access);

private

   --  Map which gives the analyzer to use for a given language.
   package Language_Maps is
      new Ada.Containers.Indefinite_Hashed_Maps (Key_Type     => String,
                                                 Element_Type => Language_Descriptor,
                                                 Hash         => Ada.Strings.Hash,
                                                 Equivalent_Keys => "=");

   type Language_Manager is tagged limited record
      Languages        : Language_Maps.Map;
      Default          : Combined_Analyzer_Access;
      Mime_Detect      : Mimes.Mime_Detector_Type;
      Extension_Detect : Extensions.Extension_Detector_Type;
      Shell_Detect     : Shell.Shell_Detector_Type;
      Filename_Detect  : Filenames.Filename_Detector_Type;
      Modeline_Detect  : Modelines.Modeline_Detector_Type;
   end record;

   function Create_Analyzer (Manager : in Language_Manager;
                             Conf    : in Comment_Configuration) return Analyzer_Access;

   function Find_Analyzer (Manager : in Language_Manager;
                           Name    : in String) return Analyzer_Access;

end SPDX_Tool.Languages.Manager;
