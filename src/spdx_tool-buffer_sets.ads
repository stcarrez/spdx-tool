-- --------------------------------------------------------------------
--  spdx_tool -- SPDX Tool
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Containers.Indefinite_Ordered_Sets;
package SPDX_Tool.Buffer_Sets is
  new Ada.Containers.Indefinite_Ordered_Sets (Element_Type => Buffer_Type);
