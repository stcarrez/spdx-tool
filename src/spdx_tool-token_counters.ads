-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with SCI.Vectorizers.Indefinite_Counters;
with SPDX_Tool.Counter_Arrays;
package SPDX_Tool.Token_Counters is
  new SCI.Vectorizers.Indefinite_Counters (Token_Type => Buffer_Type,
                                           Arrays     => SPDX_Tool.Counter_Arrays);
