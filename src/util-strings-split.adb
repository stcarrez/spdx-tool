-- --------------------------------------------------------------------
--  util-strings-split -- function to split a string and get an vector of items
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Strings.Tokenizers;
function Util.Strings.Split (Content : in String;
                             Pattern : in String) return Util.Strings.Vectors.Vector is
   procedure Collect (Item : in String; Done : out Boolean);
   Result : Util.Strings.Vectors.Vector;
   procedure Collect (Item : in String; Done : out Boolean) is
   begin
      Result.Append (Item);
      Done := False;
   end Collect;
begin
   Util.Strings.Tokenizers.Iterate_Tokens (Content, Pattern, Collect'Access);
   return Result;
end Util.Strings.Split;