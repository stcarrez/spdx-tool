-- --------------------------------------------------------------------
--  spdx_tool-licenses-repository -- licenses repository
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;
with Ada.Unchecked_Deallocation;
with Ada.Containers.Hashed_Sets;

with Util.Strings;
with Util.Log.Loggers;
with Util.Streams.Files;
with SCI.Similarities.COO_Arrays;
with SPDX_Tool.Licenses.Reader;
with SPDX_Tool.Licenses.Files;
with SPDX_Tool.Licenses.Templates;
package body SPDX_Tool.Licenses.Repository is

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses.Repository");

   function To_Float (Value : Float) return Float is (Value);
   procedure Dump_Frequencies (Frequencies : in Frequency_Arrays.Array_Type);

   package Token_Sets is
     new Ada.Containers.Hashed_Sets (Element_Type => Token_Index,
                                     Hash => Hash,
                                     Equivalent_Elements => "=");

   package Similarities is
      new SCI.Similarities.COO_Arrays (Arrays      => Freq_Transformers.Frequency_Arrays,
                                       Conversions => Confidence_Conversions,
                                       To_Float    => To_Float);

   function Increment (Value : in Count_Type) return Count_Type;

   --  ------------------------------
   --  Get the token from the token index.
   --  ------------------------------
   function Get_Token (Index : in Token_Index) return Buffer_Type is
      First : Buffer_Size := 1;
      Last  : Buffer_Size := 0;
   begin
      for I in 1 .. Index loop
         First := Last + 1;
         Last := First + Buffer_Size (Licenses.Templates.Token_Pos (I) - 1);
      end loop;
      return Licenses.Templates.Tokens (First .. Last);
   end Get_Token;

   --  ------------------------------
   --  Get the license index of the license in the builtin repository.
   --  ------------------------------
   function Get_License_Index (Name : in String) return License_Index is
   begin
      for I in Licenses.Files.Names'Range loop
         if Licenses.Files.Names (I).all = Name then
            return I;
         end if;
      end loop;
      Log.Warn ("License '{0}' not found in repository", Name);
      raise Not_Found;
   end Get_License_Index;

   overriding
   procedure Initialize (Repository : in out Repository_Type) is
   begin
      --  We have to get a copy of the static license/exception maps
      --  to take into account the forced licenses that are loaded dynamically.
      Repository.License_Map := Templates.License_Map;
      Repository.Exception_Map := Templates.Exception_Map;
   end Initialize;

   --  ------------------------------
   --  Get the license template for the given license index.
   --  ------------------------------
   function Get_License (Repository : in Repository_Type;
                         License    : in License_Index) return License_Template is
      Template : License_Template;
   begin
      Template := Repository.Instance.Repository.Get_License (License);
      if Template.Root = null then
         Repository.Instance.Repository.Load_License (License, Template);
      end if;
      return Template;
   end Get_License;

   --  ------------------------------
   --  Get a printable representation of a list of licenses.
   --  ------------------------------
   function To_String (Repository : in Repository_Type;
                       List       : in License_Index_Array) return String is
      Result : UString;
      Empty  : Boolean := True;
   begin
      for License of List loop
         if not Empty then
            Ada.Strings.Unbounded.Append (Result, ", ");
         else
            Empty := False;
         end if;
         Ada.Strings.Unbounded.Append (Result, Repository.Repository.Get_Name (License));
      end loop;
      return To_String (Result);
   end To_String;

   function Increment (Value : in Count_Type) return Count_Type is
   begin
      return Value + 1;
   end Increment;

   --  ------------------------------
   --  Read the license template with the given path and allocate
   --  a license index for that license template.
   --  ------------------------------
   procedure Read_License (Repository : in out Repository_Type;
                           Path       : in String;
                           License    : out License_Index) is
      use type Ada.Directories.File_Size;
      procedure Add_Token (Buf  : in Buffer_Type;
                           From : in Buffer_Index;
                           To   : in Buffer_Index);

      Tokens : Token_Sets.Set;

      type Parser_Type is new Reader.Parser_Type with null record;

      overriding
      procedure Token (Parser  : in out Parser_Type;
                       Content : in Buffer_Type;
                       Token   : in SPDX_Tool.Licenses.Token_Kind);

      procedure Add_Token (Buf  : in Buffer_Type;
                           From : in Buffer_Index;
                           To   : in Buffer_Index) is
         Len   : constant Buffer_Size := Punctuation_Length (Buf, From, To);
         First : constant Buffer_Index := (if Len > 0 then From + Len else From);
         Value : Token_Index;
      begin
         if First <= To and then not Is_Ignored (Buf (First .. To)) then
            SPDX_Tool.Token_Counters.Add_Token (Repository.Token_Counters, License,
                                                Buf (First .. To),
                                                Increment'Access,
                                                Value);
            Tokens.Include (Value);
         end if;
      end Add_Token;

      overriding
      procedure Token (Parser  : in out Parser_Type;
                       Content : in Buffer_Type;
                       Token   : in SPDX_Tool.Licenses.Token_Kind) is
      begin
         if Token = TOK_VAR then
            declare
               Last  : constant Buffer_Index := Parser.Orig_End;
               Pos   : Buffer_Index := Parser.Orig_Pos;
               Len   : Buffer_Size;
               First : Buffer_Index;
            begin
               Var_Token :
               while Pos < Last loop
                  loop
                     exit Var_Token when Pos > Last;
                     Len := SPDX_Tool.Punctuation_Length (Content, Pos, Last);
                     if Len = 0 then
                        Len := Space_Length (Content, Pos, Last);
                        exit when Len = 0;
                     end if;
                     Pos := Pos + Len;
                  end loop;
                  First := Pos;
                  Pos := SPDX_Tool.Next_Space (Content, First, Last);
                  if First <= Pos then
                     Add_Token (Content, First, Pos);
                  end if;
                  Pos := Pos + 1;
               end loop Var_Token;
            end;
         elsif Token = TOK_WORD and then Parser.Token_Pos < Parser.Current_Pos - 1 then
            Add_Token (Content, Parser.Token_Pos, Parser.Current_Pos - 1);
         end if;
         SPDX_Tool.Licenses.Reader.Parser_Type (Parser).Token (Content, Token);
      end Token;

      Ext  : constant String := Ada.Directories.Extension (Path);
      Size : constant Ada.Directories.File_Size := Ada.Directories.Size (Path);
      Info : Reader.License_Type;
      Template : License_Template;
      Parser : Parser_Type;
      License_Map : License_Index_Map := EMPTY_MAP;
   begin
      Repository.Repository.Allocate_License (License);
      if Size = 0 or else Size > MAX_LICENSE_SIZE then
         Log.Error ("license file {0} is too big", Path);
         return;
      end if;
      if Ext = "jsonld" then
         Reader.Load_JSON (Info, Path);
         declare
            Content : String := To_String (Info.Template);
            Buffer  : Buffer_Type (1 .. Content'Length);
            for Buffer'Address use Content'Address;
         begin
            Template.Name := Info.Name;
            Parser.Parse (Buffer, Template);
         end;
      else
         declare
            File   : Util.Streams.Files.File_Stream;
            Buffer : Buffer_Type (1 .. Buffer_Size (Size));
            Last   : Ada.Streams.Stream_Element_Offset;
            Name   : constant String := Ada.Directories.Base_Name (Path);
         begin
            File.Open (Mode => Ada.Streams.Stream_IO.In_File, Name => Path);
            File.Read (Into => Buffer, Last => Last);
            Template.Name := To_UString (Name);
            Parser.Parse (Buffer (1 .. Last), Template);
         end;
      end if;
      Repository.Repository.Set_License (License, Template);
      Set_License (Repository.Force_Check_List, License);
      Set_License (Repository.License_Map, License);

      Set_License (License_Map, License);
      for Token of Tokens loop
         declare
            Pos : constant Token_License_Maps.Cursor := Repository.Dyn_Index.Find (Token);
         begin
            if not Token_License_Maps.Has_Element (Pos) then
               Repository.Dyn_Index.Insert (Token, License_Map);
            else
               Set_License (Repository.Dyn_Index.Reference (Pos), License);
            end if;
         end;
      end loop;
   end Read_License;

   procedure Initialize_Tokens (Repository : in out Repository_Type) is
      First : Buffer_Index := 1;
      Last  : Buffer_Index;
   begin
      Repository.Token_Counters.Counters.Default := 0;
      if Repository.Token_Counters.Tokens.Is_Empty then
         --  Populate the builtin tokens in the token map.
         for I in Licenses.Templates.Token_Pos'Range loop
            Last := First + Buffer_Size (Licenses.Templates.Token_Pos (I) - 1);
            Repository.Token_Counters.Tokens.Insert (Licenses.Templates.Tokens (First .. Last),
                                                     SPDX_Tool.Token_Index (I));
            First := Last + 1;
         end loop;

         --  When builtin licenses are enabled, setup the token counters for each license index.
         if not Opt_No_Builtin then
            for I in Licenses.Templates.List'Range loop
               declare
                  Tokens : constant Token_Array_Access := Licenses.Templates.List (I);
               begin
                  Counter_Arrays.Fill (Repository.Token_Counters.Counters, I, Tokens.all);
               end;
            end loop;
         end if;
      end if;
   end Initialize_Tokens;

   --  ------------------------------
   --  Configure the license token frequencies when we have loaded every license template.
   --  ------------------------------
   procedure Configure_Frequencies (Repository : in out Repository_Type) is
      Stamp   : Util.Measures.Stamp;
   begin
      --  Setup the list of license tokens
      Repository.Token_Frequency.Default := 0.0;
      declare
         Cnt : constant License_Index := Repository.Repository.Get_Count;
         F   : constant Freq_Transformers.Frequency_Array
           := Freq_Transformers.IDF (Repository.Token_Counters.Counters,
                                     Natural (Repository.Repository.Get_Count));
      begin
         Repository.Token_Frequency.Cells.Clear;
         Freq_Transformers.TIDF (From     => Repository.Token_Counters.Counters,
                                 Doc_Freq => F,
                                 Into     => Repository.Token_Frequency);
         Repository.License_Frequency := new Freq_Transformers.Frequency_Array '(F);
         Repository.License_Squares := new Float_Array (0 .. Cnt);

         --  Pre-compute for each license, the Sqrt of sum of square of token frequencies.
         for I in Repository.License_Squares'Range loop
            Repository.License_Squares (I)
              := Similarities.Sqrt_Square (Repository.Token_Frequency, I);
         end loop;
      end;
      SPDX_Tool.Licenses.Report (Stamp, "configure license token frequencies");
   end Configure_Frequencies;

   --  ------------------------------
   --  Given a list of lines with their tokens, compute the token frequencies.
   --  ------------------------------
   function Compute_Frequency (Repository : in Repository_Type;
                               Lines      : in SPDX_Tool.Languages.Line_Array;
                               From       : in Line_Number;
                               To         : in Line_Number) return Frequency_Arrays.Array_Type is
      function Update (First, Second : Count_Type) return Count_Type is (First + Second);
      Stamp    : Util.Measures.Stamp;
      Counters : SPDX_Tool.Counter_Arrays.Array_Type;
      Freqs    : Frequency_Arrays.Array_Type;
   begin
      Counters.Default := 0;
      Freqs.Default := 0.0;
      for Line in From .. To loop
         SPDX_Tool.Counter_Arrays.Merge (Counters, Lines (Line).Tokens, Update'Access);
      end loop;
      if not Counters.Cells.Is_Empty and then Repository.License_Frequency /= null then
         Freq_Transformers.TIDF (From     => Counters,
                                 Doc_Freq => Repository.License_Frequency.all,
                                 Into => Freqs);
      end if;
      SPDX_Tool.Licenses.Report (Stamp, "Compute TIDF");
      return Freqs;
   end Compute_Frequency;

   procedure Find_License_Templates (Repository : in Repository_Type;
                                     Line       : in out SPDX_Tool.Languages.Line_Type;
                                     Global     : in out License_Index_Map) is
      Or_List  : License_Index_Map := SPDX_Tool.EMPTY_MAP;
      And_List : License_Index_Map := SPDX_Tool.EMPTY_MAP;
      First    : Boolean := True;
      Item     : Index_Type;
   begin
      for Token in Line.Tokens.Cells.Iterate loop
         Item.Token := Counter_Arrays.Maps.Key (Token).Column;
         if not Opt_No_Builtin then
            declare
               R    : Algorithms.Result_Type;
            begin
               R := Algorithms.Find (Licenses.Templates.Index, Item);
               if R.Found then
                  declare
                     List : constant License_Index_Array_Access
                       := Templates.Index (R.Position).List;
                  begin
                     if Util.Log.Loggers.Is_Debug_Enabled (Log) then
                        Log.Debug ("Token {0} '{1}' used by {2} licenses list",
                                   Util.Strings.Image (Natural (Item.Token)),
                                   To_String (Get_Token (Item.Token)),
                                   Util.Strings.Image (Natural (List'Length)));
                     end if;
                     declare
                        New_List : License_Index_Map := EMPTY_MAP;
                     begin
                        Set_Licenses (New_List, List.all);
                        Or_Licenses (Or_List, New_List);
                        if First then
                           And_List := New_List;
                           First := False;
                        else
                           And_Licenses (And_List, New_List);
                        end if;
                     end;
                  end;
               else
                  Log.Debug ("Token {0} not found in index",
                             Util.Strings.Image (Natural (Item.Token)));
               end if;
            end;
         end if;
         declare
            Pos : constant Token_License_Maps.Cursor := Repository.Dyn_Index.Find (Item.Token);
         begin
            if Token_License_Maps.Has_Element (Pos) then
               Or_Licenses (Or_List, Token_License_Maps.Element (Pos));
               if First then
                  And_List := Token_License_Maps.Element (Pos);
                  First := False;
               else
                  And_Licenses (And_List, Token_License_Maps.Element (Pos));
               end if;
            end if;
         end;
      end loop;
      Line.Licenses := Or_List;
      Or_Licenses (Global, Or_List);
   end Find_License_Templates;

   --  ------------------------------
   --  For each line, find the possible licenses and populate the Licenses field
   --  in each line.
   --  ------------------------------
   procedure Find_Possible_Licenses (Repository   : in Repository_Type;
                                     Lines        : in out SPDX_Tool.Languages.Line_Array;
                                     From         : in Line_Number;
                                     To           : in Line_Number) is
      Global : License_Index_Map := SPDX_Tool.EMPTY_MAP;
   begin
      for Line in From .. To loop
         Repository.Find_License_Templates (Lines (Line), Global);
      end loop;
      for Line in From .. To loop
         And_Licenses (Lines (Line).Licenses, Global);
      end loop;
      if Util.Log.Loggers.Is_Debug_Enabled (Log) then
         for Line in From .. To loop
            Log.Debug ("Line {0}: {1}", Util.Strings.Image (Natural (Line)),
                       Repository.To_String (To_License_Index_Array (Lines (Line).Licenses)));
         end loop;
      end if;
   end Find_Possible_Licenses;

   function Find_License_Templates (Repository   : in Repository_Type;
                                    Lines        : in SPDX_Tool.Languages.Line_Array;
                                    From         : in Line_Number;
                                    To           : in Line_Number;
                                    Is_Exception : in Boolean) return License_Index_Array is
      First    : Boolean := True;
      Licenses : License_Index_Map := EMPTY_MAP;
   begin
      for Line in From .. To loop
         if Get_Count (Lines (Line).Licenses) > 0 then
            if First then
               Licenses := Lines (Line).Licenses;
               First := False;
            else
               Or_Licenses (Licenses, Lines (Line).Licenses);
            end if;
            exit when Get_Count (Licenses) < 10;
         end if;
      end loop;
      Or_Licenses (Licenses, Repository.Force_Check_List);
      if Is_Exception then
         And_Licenses (Licenses, Repository.Exception_Map);
      else
         And_Licenses (Licenses, Repository.License_Map);
      end if;
      return To_License_Index_Array (Licenses);
   end Find_License_Templates;

   MIN_CONFIDENCE : constant := 500 * Confidence_Type'Small;

   procedure Dump_Frequencies (Frequencies : in Frequency_Arrays.Array_Type) is
   begin
      for Iter in Frequencies.Cells.Iterate loop
         declare
            Key : constant Frequency_Arrays.Index_Type := Frequency_Arrays.Maps.Key (Iter);
         begin
            Log.Debug ("Token {0} -> {1}",
                       To_String (Get_Token (Key.Column)),
                       Frequency_Arrays.Maps.Element (Iter)'Image);
         end;
      end loop;
   end Dump_Frequencies;

   --  ------------------------------
   --  Guess a best license based on the token inverse document frequencies (TIDF).
   --  ------------------------------
   function Guess_License (Repository : in Repository_Type;
                           Lines      : in SPDX_Tool.Languages.Line_Array;
                           From       : in Line_Number;
                           To         : in Line_Number) return License_Match is
      use type SPDX_Tool.Files.Comment_Category;

      Guess       : License_Index := 0;
      Guess_Start : Line_Number := From;
      Confidence  : Confidence_Type := 0.0;
      C           : Confidence_Type;
      Result      : License_Match := (Last => null, Depth => 0, others => <>);
      Stamp       : Util.Measures.Stamp;
   begin
      for Line in From .. To loop
         if Lines (Line).Style.Category = SPDX_Tool.Files.TEXT then
            declare
               Freqs : constant Frequency_Arrays.Array_Type
                 := Repository.Compute_Frequency (Lines, Line, To);
               Licenses : constant License_Index_Array
                 := Repository.Find_License_Templates (Lines, Line, To, False);
            begin
               if not Freqs.Cells.Is_Empty then
                  if Opt_Verbose2 then
                     Log.Info ("Checking {0} licenses at lines {1}",
                               Licenses'Length'Image,
                               Line'Image & ".." & To'Image);
                     Dump_Frequencies (Freqs);
                  end if;
                  for License of Licenses loop
                     if Repository.License_Squares (License) > 0.0 then
                        declare
                           Cosine_Stamp   : Util.Measures.Stamp;
                        begin
                           C := Similarities.Cosine (Freqs, 1, Repository.Token_Frequency, License,
                                                     Repository.License_Squares (License));
                           SPDX_Tool.Licenses.Report (Cosine_Stamp, "Cosine");
                        end;
                        if Opt_Verbose2 then
                           Log.Info ("Confidence at lines {2} with {0} -> {1}",
                                     Repository.Repository.Get_Name (License), C'Image,
                                     Line'Image & ".." & To'Image);
                        end if;
                        if Confidence < C then
                           Confidence := C;
                           Guess := License;
                           Guess_Start := Line;
                        end if;
                     end if;
                  end loop;
               end if;
            end;
         end if;
         exit when Line + 10 > To;
      end loop;
      if Confidence >= MIN_CONFIDENCE then
         Result.Info.Lines.First_Line := Guess_Start;
         Result.Info.Lines.Last_Line := To;
         for Line in reverse From + 8 .. To - 1 loop
            declare
               Freqs : constant Frequency_Arrays.Array_Type
                 := Repository.Compute_Frequency (Lines, Guess_Start, Line);
            begin
               exit when Freqs.Cells.Is_Empty;
               C := Similarities.Cosine (Freqs, 1, Repository.Token_Frequency, Guess,
                                         Repository.License_Squares (Guess));
               exit when Confidence > C;
               Result.Info.Lines.Last_Line := Line;
               Confidence := C;
            end;
         end loop;
         Result.Info.Match := Infos.GUESSED_LICENSE;
         Result.Info.Confidence := Confidence;
         Result.Info.Name := Repository.Repository.Get_Name (Guess);
         SPDX_Tool.Licenses.Report (Stamp, "Guess license");
      end if;
      return Result;
   end Guess_License;

   overriding
   procedure Finalize (Repository : in out Repository_Type) is
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Freq_Transformers.Frequency_Array,
                                         Name   => Frequency_Array_Access);
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Float_Array,
                                         Name   => Float_Array_Access);
   begin
      Free (Repository.License_Frequency);
      Free (Repository.License_Squares);
      Repository.Repository.Clear;
   exception
      when E : others =>
         Log.Error ("Exception", E);
   end Finalize;

   protected body License_Tree is

      function Get_Count return License_Index is
      begin
         if Next_Index = 0 then
            return SPDX_Tool.Licenses.Files.Names'Last + 1;
         else
            return Next_Index + 1;
         end if;
      end Get_Count;

      function Get_License (License : in License_Index) return License_Template is
      begin
         return Licenses (License);
      end Get_License;

      function Get_Name (License : in License_Index) return UString is
      begin
         if License < SPDX_Tool.Licenses.Files.Names'Last then
            declare
               Name : constant Name_Access := SPDX_Tool.Licenses.Files.Names (License);
               Pos  : constant Natural := Util.Strings.Index (Name.all, '/');
            begin
               if Pos > 0 then
                  return To_UString (Name (Pos + 1 .. Name'Last));
               else
                  return To_UString (Name.all);
               end if;
            end;
         else
            return Licenses (License).Name;
         end if;
      end Get_Name;

      procedure Load_License (License  : in License_Index;
                              Template : out License_Template) is
         Stamp : Util.Measures.Stamp;
         Token : Token_Access;
      begin
         Template := Licenses (License);
         if Template.Root = null then
            Template.Name := Get_Name (License);
            Reader.Load_License (License, Template.Name, Licenses (License), Token);
            if Token /= null then
               Template.Root := Token;
               Licenses (License) := Template;
            else
               Log.Debug ("No license loaded for {0}",
                          SPDX_Tool.Licenses.Files.Names (License).all);
            end if;
         end if;
         Report (Stamp, "Load template license");
      end Load_License;

      procedure Allocate_License (License  : out License_Index) is
      begin
         if Next_Index = 0 then
            Next_Index := SPDX_Tool.Licenses.Files.Names'Last + 1;
         end if;
         License := Next_Index;
         Next_Index := Next_Index + 1;
      end Allocate_License;

      procedure Set_License (License  : in License_Index;
                             Template : in License_Template) is
      begin
         Licenses (License) := Template;
      end Set_License;

      procedure Clear is
         procedure Release (Token : in out Token_Access);
         procedure Free is
           new Ada.Unchecked_Deallocation (Object => Token_Type'Class,
                                           Name   => Token_Access);

         procedure Release (Token : in out Token_Access) is
            T : Token_Access;
         begin
            loop
               T := Token.Alternate;
               exit when T = null;
               Token.Alternate := T.Alternate;
               Free (T);
            end loop;
            loop
               T := Token.Next;
               exit when T = null;
               Token.Next := T.Next;
               Free (T);
            end loop;
            Free (Token);
         end Release;
      begin
         for License of Licenses loop
            if License.Root /= null then
               Release (License.Root);
            end if;
         end loop;
      end Clear;

   end License_Tree;

end SPDX_Tool.Licenses.Repository;
