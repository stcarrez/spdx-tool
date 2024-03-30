-- --------------------------------------------------------------------
--  spdx_tool-languages-shell -- Shell detector language
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
package body SPDX_Tool.Languages.Shell is

   overriding
   procedure Detect (Detector : in Shell_Detector_Type;
                     File     : in File_Info;
                     Buffer   : in Buffer_Type;
                     Result   : in out Detector_Result) is
      Line_Count  : Natural := 0;
      Text_Count  : Natural := 0;
      Bin_Count   : Natural := 0;
      Pound_Cmt   : Natural := 0;
      Column      : Natural := 0;
      Byte        : Stream_Element;
      Pos         : Buffer_Index := Next_With (Buffer, Buffer'First, "#!");
   begin
      if Pos > Buffer'First then
        Pos := Skip_Spaces (Buffer, Pos, Buffer'Last);
      end if;
      for Pos in Buffer'Range loop
         Byte := Buffer (Pos);
         if Byte in LF | CR then
            Line_Count := Line_Count + 1;
            Column := 0;
         elsif Byte in 16#20# .. 16#80# then
            if Column = 0 then
               if Byte = Character'Pos ('#') then
                  Pound_Cmt := Pound_Cmt + 1;

               end if;
            end if;
            Text_Count := Text_Count + 1;
            Column := Column + 1;
         elsif not (Byte in SPACE | TAB) then
            Bin_Count := Bin_Count + 1;
            Column := Column + 1;
         end if;
      end loop;
   end Detect;

end SPDX_Tool.Languages.Shell;
