-- --------------------------------------------------------------------
--  spdx_tool-reports -- print various reports about files and licenses
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Strings;
with PT.Texts;
with PT.Charts;
with SCI.Occurrences;
package body SPDX_Tool.Reports is

   use type SPDX_Tool.Infos.License_Kind;

   package Occurrences is new SCI.Occurrences (Element_Type => Natural);

   procedure List_Occurrences is new Occurrences.List;

   function Format_Percent (Dv    : in Natural;
                            Value : in Natural) return String;

   function "-" (Left, Right : Natural) return PT.W_Type is
     (PT.W_Type (Natural '(Left - Right)));

   procedure Draw_Percent_Bar is
     new PT.Charts.Draw_Bar (Natural);

   function Get_License (Info : in Infos.License_Info) return String;

   To_Digit : constant array (0 .. 9) of Character := "0123456789";

   function Get_License (Info : in Infos.License_Info) return String is
   begin
      if Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
         return To_String (Info.Name);
      elsif Info.Match = Infos.UNKNOWN_LICENSE then
         return -("Unknown");
      else
         return -("None");
      end if;
   end Get_License;

   --  ------------------------------
   --  Format a percent of DV on the value.
   --  ------------------------------
   function Format_Percent (Dv    : in Natural;
                            Value : in Natural) return String is
      Val   : constant Integer := (Dv * 1000) / Value;
      Div   : constant Natural := Val mod 10;
   begin
      return Util.Strings.Image (Val / 10) & '.' & To_Digit (Div);
   end Format_Percent;

   --  ------------------------------
   --  Print the license used and their associated number of files.
   --  ------------------------------
   procedure Print_Occurences (Printer : in out PT.Printer_Type'Class;
                               Styles  : in Style_Configuration;
                               Set     : in Occurrences.Set;
                               Title   : in String) is
      Writer : PT.Texts.Printer_Type := PT.Texts.Create (Printer);
      Chart  : PT.Charts.Printer_Type := PT.Charts.Create (Writer, 0);
      Fields : PT.Texts.Field_Array (1 .. 4);
      List   : Occurrences.Vector;
   begin
      List_Occurrences (Set, List);
      declare
         Total  : constant Natural := Occurrences.Sum (List, 0);
         Max    : constant PT.X_Type := PT.X_Type (Occurrences.Longest (List));
      begin
         Writer.Create_Field (Fields (1), Styles.Title, 0.0);
         Writer.Create_Field (Fields (2), Styles.Title, 10.0);
         Writer.Create_Field (Fields (3), Styles.Title, 10.0);
         Writer.Create_Field (Fields (4), Styles.Title, 20.0);
         Writer.Set_Bottom_Right_Padding (Fields (3), (W => 2, H => 0));
         Writer.Set_Max_Dimension (Fields (1), (W => Max, H => 0));
         Writer.Set_Justify (Fields (1), PT.J_LEFT);
         Writer.Set_Justify (Fields (2), PT.J_RIGHT);
         Writer.Set_Justify (Fields (3), PT.J_RIGHT);

         Writer.Layout_Fields (Fields);

         Writer.Put (Fields (1), Title);
         Writer.Put (Fields (2), -("Count"));
         Writer.Put (Fields (3), -("Ratio"));
         Writer.New_Line;

         Writer.Set_Style (Fields (1), Styles.Default);
         Writer.Set_Style (Fields (2), Styles.Default);
         Writer.Set_Style (Fields (3), Styles.Default);
         for Item of List loop
            Writer.Put (Fields (1), Item.Item);
            Writer.Put (Fields (2), Item.Count'Image);
            Writer.Put (Fields (3), Format_Percent (Item.Count, Total));
            if Styles.With_Progress then
               Draw_Percent_Bar (Chart, Writer.Get_Box (Fields (4)),
                                 Value => Item.Count,
                                 Min   => 0,
                                 Max   => Total,
                                 Style1 => Styles.Marker1,
                                 Style2 => Styles.Marker2);
            end if;
            Writer.New_Line;
         end loop;
      end;
   end Print_Occurences;

   --  ------------------------------
   --  Print the license used and their associated number of files.
   --  ------------------------------
   procedure Print_Licenses (Printer : in out PT.Printer_Type'Class;
                             Styles  : in Style_Configuration;
                             Files   : in SPDX_Tool.Infos.File_Map) is
      Set    : Occurrences.Set;
   begin
      for File of Files loop
         if not File.Filtered then
            Occurrences.Add (Set, Get_License (File.License), 1);
         end if;
      end loop;
      Print_Occurences (Printer, Styles, Set, -("License"));
   end Print_Licenses;

   --  ------------------------------
   --  Print the license used and their associated number of files.
   --  ------------------------------
   procedure Print_Files (Printer : in out PT.Printer_Type'Class;
                          Styles  : in Style_Configuration;
                          Files   : in SPDX_Tool.Infos.File_Map) is
      Set  : Occurrences.Set;
      List : Occurrences.Vector;
      Writer         : PT.Texts.Printer_Type := PT.Texts.Create (Printer);
      License_Fields : PT.Texts.Field_Array (1 .. 3);
      File_Fields    : PT.Texts.Field_Array (1 .. 2);
   begin
      for File of Files loop
         if not File.Filtered then
            Occurrences.Add (Set, Get_License (File.License), 1);
         end if;
      end loop;
      List_Occurrences (Set, List);
      declare
         Max    : constant PT.X_Type := PT.X_Type (Occurrences.Longest (List));
      begin
         Writer.Create_Field (License_Fields (1), Styles.Title, 0.0);
         Writer.Create_Field (License_Fields (2), Styles.Title, 20.0);
         Writer.Create_Field (License_Fields (3), Styles.Title, 20.0);
         Writer.Set_Max_Dimension (License_Fields (1), (W => Max, H => 0));
         Writer.Set_Justify (License_Fields (1), PT.J_LEFT);
         Writer.Set_Justify (License_Fields (2), PT.J_RIGHT);

         Writer.Layout_Fields (License_Fields);
         Writer.Create_Field (File_Fields (1), Styles.Default, 0.0);
         Writer.Create_Field (File_Fields (2), Styles.Default, 0.0);
         Writer.Set_Max_Dimension (File_Fields (1), (W => 3, H => 0));
         Writer.Layout_Fields (File_Fields);

         for Item of List loop
            Writer.Put (License_Fields (1), Item.Item);
            Writer.Put (License_Fields (2), Item.Count'Image);
            Writer.New_Line;

            for File of Files loop
               declare
                  L : constant String := Get_License (File.License);
               begin
                  if Item.Item = L then
                     Writer.Put (File_Fields (1), "");
                     Writer.Put (File_Fields (2), File.Path);
                     Writer.New_Line;
                  end if;
               end;
            end loop;
         end loop;
      end;
   end Print_Files;

   --  ------------------------------
   --  Print the mime types used and their associated number of files.
   --  ------------------------------
   procedure Print_Mimes (Printer : in out PT.Printer_Type'Class;
                          Styles  : in Style_Configuration;
                          Files   : in SPDX_Tool.Infos.File_Map) is
      Set    : Occurrences.Set;
   begin
      for File of Files loop
         if not File.Filtered then
            Occurrences.Add (Set, To_String (File.Mime), 1);
         end if;
      end loop;
      Print_Occurences (Printer, Styles, Set, -("Mime type"));
   end Print_Mimes;

   --  Print the languages used and their associated number of files.
   procedure Print_Languages (Printer : in out PT.Printer_Type'Class;
                              Styles  : in Style_Configuration;
                              Files   : in SPDX_Tool.Infos.File_Map) is
      Set    : Occurrences.Set;
   begin
      for File of Files loop
         if not File.Filtered then
            Occurrences.Add (Set, To_String (File.Language), 1);
         end if;
      end loop;
      Print_Occurences (Printer, Styles, Set, -("Language"));
   end Print_Languages;

end SPDX_Tool.Reports;
