-- --------------------------------------------------------------------
--  spdx_tool-reports -- print various reports about files and licenses
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Containers;
with Util.Strings;
with PT.Texts;
with PT.Charts;
with SCI.Occurrences.Finites;
package body SPDX_Tool.Reports is

   use type SPDX_Tool.Infos.License_Kind;
   use type Ada.Containers.Count_Type;

   function "<" (Left, Right : UString) return Boolean
                 renames Ada.Strings.Unbounded."<";
   function "=" (Left, Right : UString) return Boolean
                 renames Ada.Strings.Unbounded."=";

   type License_Tag is record
      Name : UString;
      SPDX : Boolean := False;
   end record;

   function "<" (Left, Right : License_Tag)
                 return Boolean is (Left.Name < Right.Name
                                    or else (Left.SPDX < Right.SPDX and then Left.Name = Right.Name));

   package Occurrences is
     new SCI.Occurrences.Finites (Element_Type => License_Tag,
                                  Occurrence_Type => Natural);

   function Length (Item : License_Tag) return Natural is (Length (Item.Name));
   procedure List_Occurrences is new Occurrences.List;
   function Sum is new Occurrences.Sum;
   function Longest is new Occurrences.Longest (Length);
   procedure Add is new Occurrences.Add;

   function Format_Percent (Dv    : in Natural;
                            Value : in Natural) return String;

   function "-" (Left, Right : Natural) return PT.W_Type is
     (PT.W_Type (Natural '(Left - Right)));

   procedure Draw_Percent_Bar is
     new PT.Charts.Draw_Bar (Natural);

   function Get_License (Info : in Infos.License_Info) return License_Tag;

   procedure Print_Occurences (Printer : in out PT.Printer_Type'Class;
                               Styles  : in Style_Configuration;
                               Set     : in Occurrences.Set;
                               Title   : in String);

   To_Digit : constant array (0 .. 9) of Character := "0123456789";

   function Get_License (Info : in Infos.License_Info) return License_Tag is
   begin
      if Info.Match = Infos.SPDX_LICENSE then
         return (Info.Name, True);
      elsif Info.Match = Infos.TEMPLATE_LICENSE then
         return (Info.Name, False);
      elsif Info.Match = Infos.UNKNOWN_LICENSE then
         return (To_UString (-("Unknown")), False);
      else
         return (To_UString (-("None")), False);
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
      List   : Occurrences.Vector;
   begin
      List_Occurrences (Set, List);
      declare
         Total  : constant Natural := Sum (List, 0);
         Max    : constant PT.X_Type := PT.X_Type (Longest (List));
         Chart  : PT.Charts.Printer_Type := PT.Charts.Create (Writer, 0);
         Fields : PT.Texts.Field_Array (1 .. 5);
      begin
         Writer.Create_Field (Fields (1), Styles.Title, 0.0);
         Writer.Create_Field (Fields (2), Styles.Title, 5.0);
         Writer.Create_Field (Fields (3), Styles.Title, 10.0);
         Writer.Create_Field (Fields (4), Styles.Title, 10.0);
         Writer.Create_Field (Fields (5), Styles.Title, 20.0);
         Writer.Set_Bottom_Right_Padding (Fields (4), (W => 2, H => 0));
         Writer.Set_Max_Dimension (Fields (1), (W => Max, H => 0));
         Writer.Set_Justify (Fields (1), PT.J_LEFT);
         Writer.Set_Justify (Fields (2), PT.J_RIGHT);
         Writer.Set_Justify (Fields (3), PT.J_RIGHT);
         Writer.Set_Justify (Fields (4), PT.J_RIGHT);

         Writer.Layout_Fields (Fields);

         Writer.Put (Fields (1), Title);
         Writer.Put (Fields (2), -("SPDX"));
         Writer.Put (Fields (3), -("Count"));
         Writer.Put (Fields (4), -("Ratio"));
         Writer.New_Line;

         Writer.Set_Style (Fields (1), Styles.Default);
         Writer.Set_Style (Fields (2), Styles.Default);
         Writer.Set_Style (Fields (3), Styles.Default);
         Writer.Set_Style (Fields (4), Styles.Default);
         for Item of List loop
            Writer.Put (Fields (1), To_String (Item.Element.Name));
            Writer.Put (Fields (2), (if Item.Element.SPDX then "*" else " "));
            Writer.Put (Fields (3), Item.Occurrence'Image);
            Writer.Put (Fields (4), Format_Percent (Item.Occurrence, Total));
            if Styles.With_Progress then
               Draw_Percent_Bar (Chart, Writer.Get_Box (Fields (5)),
                                 Value => Item.Occurrence,
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
            Add (Set, Get_License (File.License), 1);
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
            Add (Set, Get_License (File.License), 1);
         end if;
      end loop;
      List_Occurrences (Set, List);
      declare
         Max    : constant PT.X_Type := PT.X_Type (Longest (List));
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
            Writer.Put (License_Fields (1), To_String (Item.Element.Name));
            Writer.Put (License_Fields (2), Item.Occurrence'Image);
            Writer.New_Line;

            for File of Files loop
               declare
                  L : constant License_Tag := Get_License (File.License);
               begin
                  if Item.Element = L then
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
            Add (Set, (File.Mime, False), 1);
         end if;
      end loop;
      Print_Occurences (Printer, Styles, Set, -("Mime type"));
   end Print_Mimes;

   --  ------------------------------
   --  Print the languages used and their associated number of files.
   --  ------------------------------
   procedure Print_Languages (Printer : in out PT.Printer_Type'Class;
                              Styles  : in Style_Configuration;
                              Files   : in SPDX_Tool.Infos.File_Map) is
      Set    : Occurrences.Set;
   begin
      for File of Files loop
         if not File.Filtered then
            Add (Set, (File.Language, False), 1);
         end if;
      end loop;
      Print_Occurences (Printer, Styles, Set, -("Language"));
   end Print_Languages;

   function Visible_File_Count (Files : in SPDX_Tool.Infos.File_Map) return Natural is
      Count : Natural := 0;
   begin
      for File of Files loop
         if not File.Filtered then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Visible_File_Count;

   --  ------------------------------
   --  Print the license name with the file name as prefix.
   --  ------------------------------
   procedure Print_Identify (Printer : in out PT.Printer_Type'Class;
                             Styles  : in Style_Configuration;
                             Files   : in SPDX_Tool.Infos.File_Map) is
      Visible_Files : constant Natural := Visible_File_Count (Files);
      Writer        : PT.Texts.Printer_Type := PT.Texts.Create (Printer);
   begin
      for File of Files loop
         if not File.Filtered then
            if Visible_Files > 1 then
               Writer.Put_UTF8 (File.Path & ": ");
            end if;
            Writer.Put_UTF8 (To_String (File.License.Name));
            Writer.New_Line;
         end if;
      end loop;
   end Print_Identify;

   procedure Print_License_Text (Printer : in out PT.Printer_Type'Class;
                                 Styles  : in Style_Configuration;
                                 Text    : in Infos.License_Text) is
      pragma Unreferenced (Styles);
      Last    : constant Natural := Natural (Text.Len);
      Content : String (1 .. Last);
      for Content'Address use Text.Content'Address;

      Writer : PT.Texts.Printer_Type := PT.Texts.Create (Printer);
      Pos    : Natural := 1;
      First  : Natural;
   begin
      loop
         First := Pos;
         while Pos <= Content'Last
           and then not Is_Eol (Text.Content (Buffer_Index (Pos)))
         loop
            Pos := Pos + 1;
         end loop;
         Writer.Put_UTF8 (Content (First .. Pos - 1));
         Writer.New_Line;
         Pos := Pos + 1;
         exit when Pos > Content'Last;
      end loop;
   end Print_License_Text;

   --  Print the license texts content found in header files.
   procedure Print_Texts (Printer : in out PT.Printer_Type'Class;
                          Styles  : in Style_Configuration;
                          Files   : in SPDX_Tool.Infos.File_Map) is
      use type Infos.License_Text_Access;
   begin
      for File of Files loop
         if not File.Filtered and then File.Text /= null then
            Print_License_Text (Printer, Styles, File.Text.all);
         end if;
      end loop;
   end Print_Texts;

end SPDX_Tool.Reports;
