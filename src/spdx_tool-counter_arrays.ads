-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with SCI.Sparse.COO_Arrays;
package SPDX_Tool.Counter_Arrays is
  new SCI.Sparse.COO_Arrays (Row_Type    => License_Index,
                             Column_Type => Token_Index,
                             Value_Type  => Natural);
