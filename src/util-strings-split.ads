-- --------------------------------------------------------------------
--  util-strings-split -- function to split a string and get an vector of items
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Strings.Vectors;
function Util.Strings.Split (Content : in String;
                             Pattern : in String) return Util.Strings.Vectors.Vector;