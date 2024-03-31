-- --------------------------------------------------------------------
--  spdx_tool-files -- read files and identify languages and header comments
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;

with Util.Log.Loggers;
with Util.Files;
package body SPDX_Tool.Files is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Files");

   --  ------------------------------
   --  Extract from the header the list of tokens used.  Such list
   --  can be used by the license decision tree to find a matching license.
   --  We could extract more tokens such as tokens which are not really part
   --  of the license header but this is not important as the decision tree
   --  tries to find a best match.
   --  ------------------------------
   procedure Extract_Tokens (File    : in File_Type;
                             First   : in Line_Number;
                             Last    : in Line_Number;
                             Tokens  : in out SPDX_Tool.Buffer_Sets.Set) is
      Buf       : constant Buffer_Accessor := File.Buffer.Value;
      Pos       : Buffer_Index;
      First_Pos : Buffer_Index;
      Last_Pos  : Buffer_Index;
   begin
      for Line of File.Lines (First .. Last) loop
         if Line.Comment /= NO_COMMENT then
            Pos := Line.Style.Text_Start;
            Last_Pos := Line.Style.Text_Last;
            while Pos <= Last_Pos loop
               First_Pos := Skip_Spaces (Buf.Data, Pos, Last_Pos);
               exit when First_Pos > Last_Pos;
               Pos := Next_Space (Buf.Data, First_Pos, Last_Pos);
               if First_Pos <= Pos then
                  Tokens.Include (Buf.Data (First_Pos .. Pos));
               end if;
               Pos := Pos + 1;
            end loop;
         end if;
      end loop;
   end Extract_Tokens;

end SPDX_Tool.Files;
