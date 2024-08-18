-- --------------------------------------------------------------------
--  spdx_tool-licenses-repository -- licenses repository
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Log.Loggers;
with SPDX_Tool.Licenses.Reader;
with SPDX_Tool.Licenses.Files;
package body SPDX_Tool.Licenses.Repository is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses.Repository");

   --  ------------------------------
   --  Get the license template for the given license index.
   --  ------------------------------
   function Get_License (Repository : in Repository_Type;
                         License    : in License_Index) return Token_Access is
      Token : Token_Access;
   begin
      Token := Repository.Instance.Repository.Get_License (License);
      if Token = null then
         Repository.Instance.Repository.Load_License (License, Token);
      end if;
      return Token;
   end Get_License;

   --  Load the license templates defined in the directory for the license
   --  identification and analysis.
   procedure Load_Licenses (Repository : in out Repository_Type;
                            Path       : in String) is
   begin
      null;
   end Load_Licenses;

   protected body License_Tree is
      function Get_License (License : in License_Index) return Token_Access is
      begin
         return Licenses (License).Root;
      end Get_License;

      procedure Load_License (License : in License_Index;
                              Token    : out Token_Access) is
         Stamp : Util.Measures.Stamp;
      begin
         Token := Licenses (License).Root;
         if Token = null then
            Reader.Load_License (License, Licenses (License), Token);
            if Token /= null then
               Licenses (License).Root := Token;
            else
               Log.Debug ("No license loaded for {0}",
                          SPDX_Tool.Licenses.Files.Names (License).all);
            end if;
         end if;
         Report (Stamp, "Load template license");
      end Load_License;

   end License_Tree;

end SPDX_Tool.Licenses.Repository;
