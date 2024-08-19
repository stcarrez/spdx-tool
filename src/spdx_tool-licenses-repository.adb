-- --------------------------------------------------------------------
--  spdx_tool-licenses-repository -- licenses repository
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Streams.Stream_IO;
with Ada.Unchecked_Deallocation;

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

   package Similarities is
      new SCI.Similarities.COO_Arrays (Arrays      => Freq_Transformers.Frequency_Arrays,
                                       Conversions => Confidence_Conversions,
                                       To_Float    => To_Float);

   function Increment (Value : in Count_Type) return Count_Type;

   function Is_Ignored (Token : in Buffer_Type) return Boolean is
      Word : String (Natural (Token'First) .. Natural (Token'Last));
      for Word'Address use Token'Address;
   begin
      if Word'Length = 1 then
         return True;
      end if;
      if Word in "of" | "is" | "to" | "in" | "do" | "be" then
         return True;
      end if;
      if Word in "all" | "any" | "and" | "the" then
         return True;
      end if;
      if Word in "2008" | "2009" | "2011" then
         return True;
      end if;
      return False;
   end Is_Ignored;

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
      begin
         if First <= To and then not Licenses.Repository.Is_Ignored (Buf (First .. To)) then
            SPDX_Tool.Token_Counters.Add_Token (Repository.Token_Counters, License,
                                                Buf (First .. To),
                                                Increment'Access);
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
               while Pos < Last loop
                  loop
                     if Pos > Last then
                        return;
                     end if;
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
               end loop;
            end;
         elsif Token = TOK_WORD and then Parser.Token_Pos < Parser.Current_Pos - 1 then
            Add_Token (Content, Parser.Token_Pos, Parser.Current_Pos - 1);
         end if;
      end Token;

      Ext  : constant String := Ada.Directories.Extension (Path);
      Size : constant Ada.Directories.File_Size := Ada.Directories.Size (Path);
      Info : Reader.License_Type;
      Template : License_Template;
      Parser : Parser_Type;
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
   end Read_License;

   procedure Initialize_Tokens (Repository : in out Repository_Type) is
      First : Buffer_Index := 1;
      Last  : Buffer_Index;
   begin
      Repository.Token_Counters.Counters.Default := 0;
      if Repository.Token_Counters.Tokens.Is_Empty then
         for I in Licenses.Templates.Token_Pos'Range loop
            Last := First + Buffer_Size (Licenses.Templates.Token_Pos (I) - 1);
            Repository.Token_Counters.Tokens.Insert (Licenses.Templates.Tokens (First .. Last),
                                                     SPDX_Tool.Token_Index (I));
            First := Last + 1;
         end loop;
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
      for I in Licenses.Templates.List'Range loop
         declare
            Tokens : constant Token_Array_Access := Licenses.Templates.List (I);
         begin
            Counter_Arrays.Fill (Repository.Token_Counters.Counters, I, Tokens.all);
         end;
      end loop;
      declare
         F : constant Freq_Transformers.Frequency_Array
           := Freq_Transformers.IDF (Repository.Token_Counters.Counters);
      begin
         Repository.Token_Frequency.Cells.Clear;
         Freq_Transformers.TIDF (From     => Repository.Token_Counters.Counters,
                                 Doc_Freq => F,
                                 Into     => Repository.Token_Frequency);
         Repository.License_Frequency := new Freq_Transformers.Frequency_Array '(F);
         Repository.License_Squares := new Float_Array (Licenses.Templates.List'Range);

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

   function Find_License_Templates (Lines   : in SPDX_Tool.Languages.Line_Array;
                                    From    : in Line_Number;
                                    To      : in Line_Number) return License_Index_Array is
      First    : Boolean := True;
      Licenses : License_Index_Map := EMPTY_MAP;
   begin
      for Line in From .. To loop
         if Get_Count (Lines (Line).Licenses) > 0 then
            if First then
               Licenses := Lines (Line).Licenses;
               First := False;
            else
               And_Licenses (Licenses, Lines (Line).Licenses);
            end if;
            exit when Get_Count (Licenses) < 10;
         end if;
      end loop;
      return To_License_Index_Array (Licenses);
   end Find_License_Templates;

   MIN_CONFIDENCE : constant := 500 * Confidence_Type'Small;

   --  ------------------------------
   --  Guess a best license based on the token inverse document frequencies (TIDF).
   --  ------------------------------
   function Guess_License (Repository : in Repository_Type;
                           Lines      : in SPDX_Tool.Languages.Line_Array;
                           From       : in Line_Number;
                           To         : in Line_Number) return License_Match is
      Guess : License_Index := 0;
      Confidence : Confidence_Type := 0.0;
      C : Confidence_Type;
      Result  : License_Match := (Last => null, Depth => 0, others => <>);
      Stamp   : Util.Measures.Stamp;
      Freqs   : Frequency_Arrays.Array_Type := Repository.Compute_Frequency (Lines, From, To);
   begin
      if not Freqs.Cells.Is_Empty then
         declare
            Licenses : constant License_Index_Array
               := Find_License_Templates (Lines, From, To);
         begin
            for License of Licenses loop
               declare
                  Cosine_Stamp   : Util.Measures.Stamp;
               begin
                  C := Similarities.Cosine (Freqs, 1, Repository.Token_Frequency, License,
                                            Repository.License_Squares (License));
                  SPDX_Tool.Licenses.Report (Cosine_Stamp, "Cosine");
               end;
               if Opt_Verbose2 then
                  Log.Info ("Confidence with {0} -> {1}",
                            Get_License_Name (License), C'Image);
               end if;
               if Confidence < C then
                  Confidence := C;
                  Guess := License;
               end if;
            end loop;
         end;
      end if;
      if Confidence >= MIN_CONFIDENCE then
         Result.Info.First_Line := From;
         Result.Info.Last_Line := To;
         for Line in From + 1 .. To - 1 loop
            Freqs := Repository.Compute_Frequency (Lines, Line, To);
            exit when Freqs.Cells.Is_Empty;
            C := Similarities.Cosine (Freqs, 1, Repository.Token_Frequency, Guess,
                                      Repository.License_Squares (Guess));
            exit when Confidence > C;
            Result.Info.First_Line := Line;
            Confidence := C;
         end loop;
         Result.Info.Match := Infos.GUESSED_LICENSE;
         Result.Info.Confidence := Confidence;
         Result.Info.Name := To_UString (Get_License_Name (Guess));
         SPDX_Tool.Licenses.Report (Stamp, "Guess license");
      end if;
      return Result;
   end Guess_License;

   overriding
   procedure Finalize (Repository : in out Repository_Type) is
      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Freq_Transformers.Frequency_Array,
                                         Name   => Frequency_Array_Access);
   begin
      Free (Repository.License_Frequency);
   end Finalize;

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

      procedure Allocate_License (License  : out License_Index) is
      begin
         if Next_Index = 0 then
            Next_Index := SPDX_Tool.Licenses.Files.Names'Last + 1;
         end if;
         License := Next_Index;
         --  Licenses (License) := Template;
         Next_Index := Next_Index + 1;
      end Allocate_License;

   end License_Tree;

end SPDX_Tool.Licenses.Repository;
