-- --------------------------------------------------------------------
--  spdx_tool-magic -- File identification with libmagic
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Log.Loggers;
with Interfaces.C.Strings;

package body SPDX_Tool.Magic is

   package ICS renames Interfaces.C.Strings;
   use type ICS.chars_ptr;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Magic");

   --  ------------------------------
   --  Initialize the magic manager and prepare the libmagic library.
   --  ------------------------------
   procedure Initialize (Manager : in out Magic_Manager;
                         Path    : in String) is
      E : Integer;
      S : ICS.chars_ptr;
   begin
      Manager.Magic_Cookie := Open (MAGIC_MIME);
      if Manager.Magic_Cookie = null then
         return;
      end if;

      S := ICS.New_String (Path);
      E := Load (Manager.Magic_Cookie, S);
      ICS.Free (S);
      if E /= 0 then
         S := Error (Manager.Magic_Cookie);
         if S /= ICS.Null_Ptr then
            Log.Error (-("cannot load magic file {0}: {1}"),
                       Path, Interfaces.C.Strings.Value (S));
         else
            Log.Error (-("cannot load magic file {0}"),
                       Path);
         end if;
      end if;
   end Initialize;

   overriding
   procedure Finalize (Manager : in out Magic_Manager) is
   begin
      if Manager.Magic_Cookie /= null then
         Close (Manager.Magic_Cookie);
         Manager.Magic_Cookie := null;
      end if;
   end Finalize;

   --  Identify the content of the buffer by using the libmagic library.
   function Identify (Manager : in Magic_Manager;
                      Data    : in Buffer_Type) return String is
      R : Interfaces.C.Strings.chars_ptr;
   begin
      R := Buffer (Manager.Magic_Cookie,
                   Data'Address, Interfaces.C.size_t (Data'Length));
      if R /= Interfaces.C.Strings.Null_Ptr then
         return Interfaces.C.Strings.Value (R);
      else
         return "unkown";
         --  Log.Info ("{0}: error {1}", Path,
         --                Magic.Errno (Manager.Magic_Cookie)'Image);
         --         File.Ident.Mime := To_UString ("unknown");
      end if;
   end Identify;

end SPDX_Tool.Magic;
