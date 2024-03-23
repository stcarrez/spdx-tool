-- --------------------------------------------------------------------
--  spdx_tool-configs -- tool configuration
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

   function Get_Config (List : in TOML.TOML_Value;
                        Name : in String)
      return UString is
        (if List.Has (Name) and then List.Get (Name).Kind = TOML.TOML_String
         then List.Get (Name).As_Unbounded_String else To_UString (""));

   function TOML_Parse_String is
     new TOML.Generic_Parse (Input_Stream => Default_Input_Stream,
                             Get => Get);

   function To_String (Location : in TOML.Source_Location) return String
     is (Util.Strings.Image (Location.Line) & ":" &
            Util.Strings.Image (Location.Column));

   --  ------------------------------
   --  Load the default configuration embedded in the tool.
   --  ------------------------------
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

   --  ------------------------------
   --  Read the tool configuration file.
   --  ------------------------------
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

      if From.Default.Is_Null or else not From.Default.Has (Name) then
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

   procedure Configure (From    : in Config_Type;
                        Process : not null access
                         procedure (Config : in Comment_Configuration)) is
      Value : TOML.TOML_Value;
   begin
      Log.Debug ("Configure comments");

      if From.Main.Is_Null or else not From.Main.Has (Sections.COMMENTS) then
         return;
      end if;

      Value := From.Main.Get (Sections.COMMENTS);
      if Value.Kind = TOML.TOML_Table then
         declare
            Comments : constant TOML.Table_Entry_Array := TOML.Iterate_On_Table (Value);
         begin
            for Comment of Comments loop
               if Comment.Value.Kind /= TOML.TOML_Table then
                  Log.Error ("Invalid configuration {0}", To_String (Comment.Key));
               else
                  declare
                     Conf  : Comment_Configuration;
                  begin
                     Conf.Language := Comment.Key;
                     Conf.Start := Get_Config (Comment.Value, Names.START);
                     Conf.Block_Start := Get_Config (Comment.Value, Names.BLOCK_START);
                     Conf.Block_End := Get_Config (Comment.Value, Names.BLOCK_END);
                     Conf.Alternative := Get_Config (Comment.Value, Names.ALTERNATIVE);
                     Process (Conf);
                  end;
               end if;
            end loop;
         end;
      end if;
   end Configure;

   procedure Configure (From    : in Config_Type;
                        Process : not null access
                         procedure (Config : in Language_Configuration)) is
      procedure Configure_Language (Name  : in String;
                                    Table : in TOML.TOML_Value);

      procedure Configure_Language (Name  : in String;
                                    Table : in TOML.TOML_Value) is
         Len  : constant Natural := TOML.Length (Table);
         Conf : Language_Configuration;
      begin
         Conf.Language := To_UString (Name);
         for I in 1 .. Len loop
            declare
               Item : constant TOML.TOML_Value := TOML.Item (Table, I);
            begin
               if Item.Kind = TOML.TOML_String then
                  Conf.Extensions.Append (Item.As_String);
               elsif Item.Kind = TOML.TOML_Table then
                  Conf.Comment := Get_Config (Item, Names.COMMENT);
               end if;
            end;
         end loop;
         Process (Conf);
      end Configure_Language;

      Value : TOML.TOML_Value;
   begin
      Log.Debug ("Configure languages");

      if From.Main.Is_Null or else not From.Main.Has (Sections.LANGUAGES) then
         return;
      end if;

      Value := From.Main.Get (Sections.LANGUAGES);
      if Value.Kind = TOML.TOML_Table then
         declare
            Items : constant TOML.Table_Entry_Array := TOML.Iterate_On_Table (Value);
         begin
            for Item of Items loop
               if Item.Value.Kind = TOML.TOML_Array then
                  Configure_Language (To_String (Item.Key), Item.Value);
               end if;
            end loop;
         end;
      end if;
   end Configure;

end SPDX_Tool.Configs;
