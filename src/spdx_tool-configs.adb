-- --------------------------------------------------------------------
--  spdx_tool-configs -- configuration
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

with Util.Log.Loggers;
with Util.Strings;
with TOML.File_IO;
with TOML.Generic_Parse;
with SPDX_Tool.Configs.Default;
package body SPDX_Tool.Configs is

   use type TOML.Any_Value_Kind;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Configs");

   type Default_Input_Stream is record
      Pos : Natural := 0;
   end record;

   procedure Get (Stream : in out Default_Input_Stream;
                  EOF    : out Boolean;
                  Byte   : out Character);

   procedure Get (Stream : in out Default_Input_Stream;
                  EOF    : out Boolean;
                  Byte   : out Character) is
   begin
      if Stream.Pos >= SPDX_Tool.Configs.Default.default'Last then
         EOF := True;
         Byte := ' ';
      else
         Stream.Pos := Stream.Pos + 1;
         EOF := False;
         Byte := SPDX_Tool.Configs.Default.default (Stream.Pos);
      end if;
   end Get;

   function TOML_Parse_String is
     new TOML.Generic_Parse (Input_Stream => Default_Input_Stream,
                             Get => Get);

   function To_String (Location : in TOML.Source_Location) return String
   is (Util.Strings.Image (Location.Line) & ":" &
           Util.Strings.Image (Location.Column));

   procedure Load_Default (Into : in out Config_Type) is
      S      : Default_Input_Stream;
      Result : TOML.Read_Result;
   begin
      Log.Info ("Loading default configuration");

      Result := TOML_Parse_String (S);
      if not Result.Success then
         Log.Error ("Invalid default configuration file");
         Log.Error ("{0}: {1}", To_String (Result.Location),
                    To_String (Result.Message));
      else
         Into.Main := Result.Value;
         if Into.Main.Has (Sections.DEFAULT) then
            Into.Default := Into.Main.Get (Sections.DEFAULT);
         end if;
      end if;
   end Load_Default;

   --  Read the tool configuration file.
   procedure Read (Into : in out Config_Type;
                   Path : in String) is
   begin
      Log.Info ("Reading configuration file '{0}'", Path);
      declare
         Result : constant TOML.Read_Result := TOML.File_IO.Load_File (Path);
      begin
         if not Result.Success then
            Log.Error (-("Invalid configuration file:"), Path);
            Log.Error ("{0}:{1}: {2}",
                       Path,
                       To_String (Result.Location),
                       To_String (Result.Message));
            raise Error;
         end if;
         Into.Main := Result.Value;
         if Into.Main.Has (Sections.DEFAULT) then
            Into.Default := Into.Main.Get (Sections.DEFAULT);
         end if;
      end;
   end Read;

   procedure Configure (From    : in Config_Type;
                        Name    : in String;
                        Process : not null access procedure (Value : in String)) is
      Value : TOML.TOML_Value;
   begin
      Log.Debug ("Configure with {0}", Name);

      if not From.Default.Has (Name) then
         return;
      end if;

      Value := From.Default.Get (Name);
      if Value.Kind = TOML.TOML_String then
         Process (Value.As_String);
      elsif Value.Kind = TOML.TOML_Array then
         declare
            Len  : constant Natural := TOML.Length (Value);
            Item : TOML.TOML_Value;
         begin
            for I in 1 .. Len loop
               Item := TOML.Item (Value, I);
               if Item.Kind = TOML.TOML_String then
                  Process (Item.As_String);
               end if;
            end loop;
         end;
      end if;
   end Configure;

end SPDX_Tool.Configs;
