-- --------------------------------------------------------------------
--  spdx_tool-languages-shell -- Shell detector language
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
package body SPDX_Tool.Languages.Shell is

   overriding
   procedure Detect (Detector : in Shell_Detector_Type;
                     File     : in File_Info;
                     Content  : in File_Type;
                     Result   : in out Detector_Result) is
   begin
      if Content.Count = 0 then
         return;
      end if;
      declare
         Buf       : constant Buffer_Accessor := Content.Buffer.Value;
         Last      : constant Buffer_Index := Content.Lines (1).Line_End;
         Pos       : Buffer_Index := Next_With (Buf.Data, Buf.Data'First, "#!");
         Next      : Buffer_Index;
         End_Pos   : Buffer_Index;
         Start_Pos : Buffer_Index;
      begin
         if Pos >= Last or else Pos = Buf.Data'First then
            return;
         end if;
         Pos := Skip_Spaces (Buf.Data, Pos, Last);
         if Pos >= Last then
            return;
         end if;
         while Pos < Last loop
            Next := Next_Space (Buf.Data, Pos, Last);
            if Next >= Last and then Next_With (Buf.Data, Pos, "/sh") = Next + 1 then
               Set_Language (Result, "Shell");
               return;
            end if;
            Pos := Next + 1;
         end loop;
      end;
   end Detect;

end SPDX_Tool.Languages.Shell;
