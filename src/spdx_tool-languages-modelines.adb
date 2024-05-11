-- --------------------------------------------------------------------
--  spdx_tool-languages-modelines -- Detect language by looking at Emacs modeline
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Strings.Maps;
with Ada.Strings.Fixed;
with Util.Strings.Transforms;
with SPDX_Tool.Languages.AliasMap;
package body SPDX_Tool.Languages.Modelines is

   use type Ada.Strings.Maps.Character_Set;
   use type Confidence_Type;
   package ASF renames Ada.Strings.Fixed;

   Separator : constant Ada.Strings.Maps.Character_Set
     := Ada.Strings.Maps.To_Set (' ')
     or Ada.Strings.Maps.To_Set (ASCII.HT)
     or Ada.Strings.Maps.To_Set (';');

   procedure Set_Language (Detector : in Modeline_Detector_Type;
                           Alias    : in String;
                           Result   : in out Detector_Result) is
      Lang : constant access constant String := AliasMap.Get_Mapping (Alias);
   begin
      if Lang /= null then
         Set_Language (Result, Lang.all, 1.0);
      else
         Set_Language (Result, Alias, 900 * Confidence_Type'Small);
      end if;
   end Set_Language;

   function Emacs_Detect (Detector : in Modeline_Detector_Type;
                          Buffer   : in Buffer_Type;
                          Result   : in out Detector_Result) return Boolean is
      Line : String (Natural (Buffer'First) .. Natural (Buffer'Last));
      for Line'Address use Buffer'Address;

      First : Natural;
      Last  : Natural;
   begin
      First := ASF.Index (Line, "-*-");
      if First = 0 then
         return False;
      end if;
      First := First + 3;
      Last := ASF.Index (Line, "-*-", First);
      if Last = 0 then
         return False;
      end if;
      declare
         Modeline : constant String
            := Util.Strings.Transforms.To_Lower_Case (ASF.Trim (Line (First .. Last - 1),
                                                      Ada.Strings.Both));
         Sep     : Natural;
      begin
         Sep := ASF.Index (Modeline, ":");
         if Sep = 0 then
            Detector.Set_Language (Modeline, Result);
            return True;
         end if;
         Sep := ASF.Index (Modeline, "mode");
         if Sep = 0 then
            return False;
         end if;
         if Sep > Modeline'First and then not (Modeline (Sep - 1) in ' ' | ';') then
            return False;
         end if;
         First := Sep + 4;
         while First <= Modeline'Last and then Modeline (First) = ' ' loop
            First := First + 1;
         end loop;
         if First > Modeline'Last or else Modeline (First) /= ':' then
            return False;
         end if;
         First := First + 1;
         while First <= Modeline'Last and then Modeline (First) = ' ' loop
            First := First + 1;
         end loop;
         if First > Modeline'Last then
            return False;
         end if;
         Sep := ASF.Index (Modeline, Separator, First);
         if Sep > 0 then
            Detector.Set_Language (Modeline (First .. Sep - 1), Result);
         else
            Detector.Set_Language (Modeline (First .. Modeline'Last), Result);
         end if;
         return True;
      end;
   end Emacs_Detect;

   overriding
   procedure Detect (Detector : in Modeline_Detector_Type;
                     File     : in File_Info;
                     Content  : in out File_Type;
                     Result   : in out Detector_Result) is
      Buf       : constant Buffer_Accessor := Content.Buffer.Value;
      Last_Line : constant Line_Count
         := (if Content.Count < 5 then Content.Count else 5);
   begin
      for Line in 1 .. Last_Line loop
         declare
            First  : constant Buffer_Index := Content.Lines (Line).Line_Start;
            Last   : constant Buffer_Size := Content.Lines (Line).Line_End;
            Found  : Boolean;
         begin
            Found := Detector.Emacs_Detect (Buf.Data (First .. Last), Result);
            if Found then
               Content.Lines (Line).Style.Category := Files.MODELINE;
               return;
            end if;
         end;
      end loop;
   end Detect;

end SPDX_Tool.Languages.Modelines;
