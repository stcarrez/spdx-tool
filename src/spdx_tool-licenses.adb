-- --------------------------------------------------------------------
--  spdx_tool-licenses -- licenses information
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Text_IO;

with Util.Log.Loggers;

package body SPDX_Tool.Licenses is

   use all type SPDX_Tool.Files.Comment_Mode;
   use type SPDX_Tool.Infos.License_Kind;

   Log : constant Util.Log.Loggers.Logger :=
     Util.Log.Loggers.Create ("SPDX_Tool.Licenses");

   function Extract_SPDX (Lines   : in SPDX_Tool.Languages.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Infos.Line_Number;
                          From    : in Buffer_Index) return Infos.License_Info;

   function Depth (Token : in Token_Type'Class) return Natural is
      Result : Natural := 0;
      Parent : Token_Access := Token.Previous;
   begin
      while Parent /= null loop
         Parent := Parent.Previous;
         Result := Result + 1;
      end loop;
      return Result;
   end Depth;

   procedure Matches (Token   : in Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
   begin
      if Token.Content = Content (From.Pos .. To.Pos) then
         Result := (Line => From.Line, Pos => To.Pos + 1);
         Next := Token.Next;
      else
         Result := From;
         Next := null;
      end if;
   end Matches;

   function Skip_Spaces (Content : in Buffer_Type;
                         Lines   : in Line_Array;
                         From    : in Line_Pos;
                         To      : in Line_Pos) return Line_Pos is
      Result : Line_Pos := From;
   begin
      while Result.Line <= To.Line loop
         declare
            Last : constant Buffer_Index := Lines (Result.Line).Style.Text_Last;
         begin
            if Result.Pos < Last then
               Result.Pos := Skip_Spaces (Content, Result.Pos, Last);
               exit when Result.Pos < Last;
            end if;
            exit when Result.Line = To.Line;
            Result.Line := Result.Line + 1;
            Result.Pos := Lines (Result.Line).Style.Text_Start;
         end;
      end loop;
      return Result;
   end Skip_Spaces;

   overriding
   procedure Matches (Token   : in Any_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
      Last  : constant Buffer_Index := Content'Last;
      Check : constant Token_Access := Token.Next;
      Pos   : Line_Pos := (Line => From.Line, Pos => To.Pos);
   begin
      if Check = null then
         Result := From;
         Next := null;
         return;
      end if;
      while Pos.Pos < Last loop
         declare
            End_Pos : constant Line_Pos := Pos;
            First   : constant Line_Pos
              := Skip_Spaces (Content, Lines, (Pos.Line, Pos.Pos + 1), To);
            End_Line : Buffer_Index;
            Len      : Buffer_Size;
         begin
            exit when First.Line > Lines'Last;
            exit when End_Pos.Pos - From.Pos > Token.Max_Length;
            exit when Lines (First.Line).Comment = NO_COMMENT;
            End_Line := Lines (First.Line).Style.Text_Last;
            exit when First.Pos > End_Line;
            Len := Punctuation_Length (Content, First.Pos, End_Line);
            if Len > 0 then
               Pos.Pos := First.Pos + Len - 1;
            else
               Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            end if;
            Match (Check, Content, Lines, First, (To.Line, Pos.Pos), Result, Next);
            if Next /= null and then Result /= First then
               return;
            end if;
            Pos.Pos := Pos.Pos + 1;
            if Pos.Pos >= End_Line then
               exit when First.Line = To.Line;
               Pos.Line := First.Line + 1;
               exit when Lines (Pos.Line).Comment = NO_COMMENT;
               Pos.Pos := Lines (Pos.Line).Style.Text_Start - 1;
            else
               Pos.Line := First.Line;
            end if;
         end;
      end loop;
      Result := From;
      Next := null;
   end Matches;

   overriding
   procedure Matches (Token   : in Regpat_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
      Last  : constant Buffer_Index := Content'Last;
      --  Start : constant Positive := Positive (From);
      --  End_Pos : Positive;
      --  First : Buffer_Index := From;
      Pos   : Line_Pos := (Line => From.Line, Pos => To.Pos);
      Check : constant Token_Access := Token.Next;
   begin
      if Check = null then
         Result := From;
         Next := null;
         return;
      end if;
      Match (Check, Content, Lines, From, To, Result, Next);
      if Next /= null and then Result /= From
        and then GNAT.Regpat.Match (Token.Pattern, "")
      then
         return;
      end if;
      while Pos.Pos < Last loop
         declare
            --  End_Pos : constant Line_Pos := Pos;
            First   : constant Line_Pos
              := Skip_Spaces (Content, Lines, (Pos.Line, Pos.Pos + 1), To);
            End_Line : Buffer_Index;
            Len      : Buffer_Size;
         begin
            exit when First.Line > Lines'Last;
            exit when Lines (First.Line).Comment = NO_COMMENT;
            End_Line := Lines (First.Line).Style.Text_Last;
            exit when First.Pos > End_Line;
            Len := Punctuation_Length (Content, First.Pos, End_Line);
            if Len > 0 then
               Pos.Pos := First.Pos + Len - 1;
            else
               Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            end if;
            Match (Check, Content, Lines, First, (To.Line, Pos.Pos), Result, Next);
            if Next /= null and then Result /= First then
               return;
            end if;
            Pos.Pos := Pos.Pos + 1;
            if Pos.Pos >= End_Line then
               exit when First.Line = To.Line;
               Pos.Line := First.Line + 1;
               Pos.Pos := Lines (Pos.Line).Style.Text_Start;
            else
               Pos.Line := First.Line;
            end if;
         end;
      end loop;
      --  while Pos.Pos < Last loop
      --   End_Pos := Positive (Pos);
      --   First := Skip_Spaces (Content, Pos + 1, Last);
      --   exit when First > Last;
      --   Pos := Next_Space (Content, First, Last);
      --   Check.Matches (Content, First, Pos - 1, Result, Next);
      --   if Next /= null and then Result /= First then
      --      declare
      --         Item : String (1 .. Content'Length);
      --         for Item'Address use Content'Address;
      --      begin
      --         Log.Debug ("Check '{0}'", Item (Start .. End_Pos));
      --          if GNAT.Regpat.Match (Token.Pattern, Item (Start .. End_Pos)) then
      --            return;
      --         end if;
      --      end;
      --   end if;
      --  end loop;
      Result := From;
      Next := null;
   end Matches;

   overriding
   procedure Matches (Token   : in Optional_Token_Type;
                      Content : in Buffer_Type;
                      Lines   : in Line_Array;
                      From    : in Line_Pos;
                      To      : in Line_Pos;
                      Result  : out Line_Pos;
                      Next    : out Token_Access) is
   begin
      if Token.Optional = null then
         Result := From;
         Next := null;
         return;
      end if;
      Token.Optional.Matches (Content, Lines, From, To, Result, Next);
      if Next = null
        and then Token.Next /= null
        and then (Result = From or else Token.Optional.Next /= null)
      then
         Token.Next.Matches (Content, Lines, From, To, Result, Next);
         return;
      end if;

      --  Other optional tokens must match.
      declare
         Last  : constant Buffer_Index := Content'Last;
         First : Line_Pos := From;
         Pos   : Line_Pos := (Line => From.Line, Pos => To.Pos);
         Check : Token_Access := Token.Optional.Next;
         End_Line : Buffer_Index;
      begin
         if Check /= null and then Next = Check.Next then
            Check := Check.Next;
         end if;
         while Check /= null loop
            if Pos.Pos + 1 > Last
              or else Lines (Pos.Line).Comment = NO_COMMENT
            then
               Result := From;
               Next := null;
               return;
            end if;
            First := Skip_Spaces (Content, Lines,
                                  (Line => Pos.Line, Pos => Pos.Pos + 1),
                                  (Line => To.Line, Pos => To.Pos));
            if First.Line > Lines'Last then
               Result := From;
               Next := null;
               return;
            end if;
            End_Line := Lines (First.Line).Style.Text_Last;
            exit when First.Pos > End_Line;
            Pos.Pos := Next_Space (Content, First.Pos, End_Line);
            Check.Matches (Content, Lines, First, (To.Line, Pos.Pos), Result, Next);
            if Next = null and then Result = First then
               Result := From;
               return;
            end if;
            Pos.Pos := Pos.Pos + 1;
            Check := Check.Next;
         end loop;
         Next := Token.Next;
         Result := (Line => Pos.Line, Pos => Pos.Pos + 1);
      end;
   end Matches;

   function Extract_SPDX (Lines   : in SPDX_Tool.Languages.Line_Array;
                          Content : in Buffer_Type;
                          Line    : in Infos.Line_Number;
                          From    : in Buffer_Index) return Infos.License_Info is
      Pos    : Buffer_Index := From;
      Last   : Buffer_Index := Lines (Line).Style.Text_Last;
      Result : Infos.License_Info;
   begin
      Pos := Skip_Spaces (Content, From, Last);
      if Lines (Line).Style.Boxed then
         while Last > Pos and then not Is_Space (Content (Last)) loop
            Last := Last - 1;
         end loop;
      end if;
      while Last > Pos and then Is_Space (Content (Last)) loop
         Last := Last - 1;
      end loop;

      --  Drop a possible parenthesis arround the SPDX license ex: '(...)'
      if Content (Pos) = OPEN_PAREN and then Content (Last) = CLOSE_PAREN then
         Pos := Pos + 1;
         Last := Last - 1;
      end if;
      Result.Lines.First_Line := Line;
      Result.Lines.Last_Line := Line;
      Result.Name := To_UString (Content (Pos .. Last));
      Result.Match := Infos.SPDX_LICENSE;
      return Result;
   end Extract_SPDX;

   procedure Match (Token   : in Token_Access;
                    Content : in Buffer_Type;
                    Lines   : in Line_Array;
                    From    : in Line_Pos;
                    Last    : in Line_Pos;
                    Result  : out Line_Pos;
                    Next    : out Token_Access) is
      Current : Token_Access := Token;
   begin
      while Current /= null loop
         Current.Matches (Content, Lines, From, Last, Result, Next);
         if Next /= null then
            return;
         end if;
         Current := Current.Alternate;
      end loop;
      Next := null;
      Result := From;
   end Match;

   --  ------------------------------
   --  Compare the two license match and return true if Left license has
   --  a better match than the Right license.
   --  ------------------------------
   function Is_Best (Left, Right : in License_Match) return Boolean is
      C1 : constant Line_Count := Left.Info.Lines.Last_Line - Left.Info.Lines.First_Line;
      C2 : constant Line_Count := Right.Info.Lines.Last_Line - Right.Info.Lines.First_Line;
   begin
      return C1 > C2;
   end Is_Best;

   function Look_License_Tree (Root    : in Token_Access;
                               Content : in Buffer_Type;
                               Lines   : in Line_Array;
                               From    : in Line_Number;
                               To      : in Line_Number)
                          return License_Match is
      function Count_Remaining (From : Token_Access) return Natural;
      function Confidence (Current, Remain : Natural) return Infos.Confidence_Type;

      function Count_Remaining (From : Token_Access) return Natural is
         Count : Natural := 0;
         Node  : Token_Access := From;
      begin
         while Node /= null loop
            Node := Node.Next;
            Count := Count + 1;
         end loop;
         return Count;
      end Count_Remaining;

      function Confidence (Current, Remain : Natural) return Infos.Confidence_Type is
         use Infos;
      begin
         if Remain = 0 then
            return 1.0;
         else
            return Confidence_Type (Float (Current) / Float (Current + Remain));
         end if;
      end Confidence;

      Current : Token_Access := null;
      Result  : License_Match;
      Pos, First : Line_Pos;
      Next_Token : Token_Access;
      Last : Line_Pos;
      Len        : Buffer_Size;
      Match_Count : Natural := 0;
      Miss_Count  : Natural := 0;
      Section_Count : Natural := 0;
      Matched : Boolean := False;
   begin
      Result.Info.Lines.First_Line := From;
      Pos.Line := From;
      Pos.Pos := Content'First;
      Result.Sections (1).Start := Pos;
      Last.Line := To;
      while Pos.Line <= To loop
         First.Line := Pos.Line;
         if Lines (Pos.Line).Style.Mode /= NO_COMMENT then
            if Pos.Pos < Lines (Pos.Line).Style.Text_Start then
               Pos.Pos := Lines (Pos.Line).Style.Text_Start;
            end if;
            Last.Pos := Lines (Pos.Line).Style.Text_Last;
            while Pos.Pos <= Last.Pos and then First.Line = Pos.Line loop
               loop
                  Len := Space_Length (Content, Pos.Pos, Last.Pos);
                  exit when Len = 0;
                  Pos.Pos := Pos.Pos + Len;
                  exit when Pos.Pos > Last.Pos;
               end loop;
               exit when Pos.Pos > Last.Pos;
               First.Pos := Pos.Pos;
               Len := Punctuation_Length (Content, Pos.Pos, Last.Pos);
               if Len > 0 then
                  Pos.Pos := Pos.Pos + Len - 1;
               else
                  Pos.Pos := Next_Space (Content, Pos.Pos, Last.Pos);
               end if;
               if Current = null then
                  Match (Root, Content, Lines, First,
                         (To, Pos.Pos), Pos, Next_Token);
               else
                  Match (Current, Content, Lines, First,
                         (To, Pos.Pos), Pos, Next_Token);
               end if;
               if Next_Token = null then
                  if Matched then
                     Result.Sections (Section_Count).Last := First;
                     if Section_Count = Result.Sections'Last then
                        Result.Info.Lines.Last_Line := Pos.Line;
                        Result.Last := Current;
                        Result.Count := Section_Count;
                        Result.Confidence := Confidence (Match_Count,
                                                         Count_Remaining (Current) + Miss_Count);
                        return Result;
                     end if;
                     Section_Count := Section_Count + 1;
                     Result.Sections (Section_Count).Start := First;
                     Matched := False;
                  elsif Section_Count = 0 then
                     Result.Confidence := 0.0;
                     return Result;
                  end if;
                  Pos.Pos := Next_Space (Content, First.Pos, Last.Pos) + 1;
                  Miss_Count := Miss_Count + 1;
               else
                  if not Matched then
                     Section_Count := Section_Count + 1;
                     if Section_Count > Result.Sections'Last then
                        Result.Info.Lines.Last_Line := Pos.Line;
                        Result.Info.Match := Infos.UNKNOWN_LICENSE;
                        Result.Last := null;
                        Result.Count := Section_Count;
                        Result.Confidence := Confidence (Match_Count,
                                                         Count_Remaining (Current) + Miss_Count);
                        return Result;
                     end if;
                     Result.Sections (Section_Count).Start := First;
                     Matched := True;
                  end if;
                  Match_Count := Match_Count + 1;
                  Current := Next_Token;
                  if Current.Next /= null
                    and then Current.Next.Kind = TOK_LICENSE
                  then
                     Current := Current.Next;
                  end if;
                  if Current.Kind = TOK_LICENSE then
                     Result.Info.Name := Final_Token_Type (Current.all).License;
                     Result.Info.Lines.Last_Line := Pos.Line;
                     Result.Info.Match := Infos.TEMPLATE_LICENSE;
                     Result.Last := Current;
                     Result.Confidence := Confidence (Match_Count, Match_Count + Miss_Count);
                     Result.Count := Section_Count;
                     return Result;
                  end if;
               end if;
            end loop;
         end if;
         if First.Line = Pos.Line then
            exit when Pos.Line = To;
            Pos.Line := Pos.Line + 1;
         end if;
      end loop;
      if Matched or else Section_Count = 0 then
         Result.Info.Lines.Last_Line := Pos.Line;
      else
         Result.Info.Lines.Last_Line := Result.Sections (Section_Count).Start.Line;
      end if;
      Result.Info.Match := Infos.UNKNOWN_LICENSE;
      Result.Last := null;
      Result.Count := Section_Count;
      Result.Confidence := Confidence (Match_Count, Count_Remaining (Current) + Miss_Count);
      return Result;
   end Look_License_Tree;

   --  ------------------------------
   --  Find in the header comment an SPDX license tag.
   --  ------------------------------
   function Look_SPDX_License (Content : in Buffer_Type;
                               Lines   : in Line_Array;
                               From    : in Line_Number;
                               To      : in Line_Number)
                               return License_Match is
      Result : License_Match;
      Pos    : Buffer_Index;
      Last   : Buffer_Index;
      First  : Buffer_Index;
   begin
      Result.Info.Lines.First_Line := From;
      Result.Info.Lines.Last_Line := To;
      for Line in From .. To loop
         Pos := Lines (Line).Style.Text_Start;
         Last := Lines (Line).Style.Text_Last;
         if Pos <= Last then
            First := Skip_Spaces (Content, Pos, Last);
            if First <= Last then
               Pos := Next_With (Content, First, SPDX_License_Tag);
               if Pos > First then
                  Result.Info := Extract_SPDX (Lines, Content, Line, Pos);
                  Result.Last := null;
                  return Result;
               end if;
            end if;
         end if;
      end loop;
      Result.Info.Match := Infos.UNKNOWN_LICENSE;
      Result.Last := null;
      return Result;
   end Look_SPDX_License;

   function Look_License (Template : in License_Template;
                          File     : in SPDX_Tool.Files.File_Type;
                          From     : in Line_Number;
                          To       : in Line_Number)
                          return License_Match is
      Buf     : constant Buffer_Accessor := File.Buffer.Value;
      Result  : License_Match := (Last => null, Depth => 0, others => <>);
      Match   : License_Match;
      Line    : Infos.Line_Number := From;
      Stamp   : Util.Measures.Stamp;
   begin
      Log.Debug ("Checking with license template '{0}'", Template.Name);

      while Line <= To loop
         if File.Lines (Line).Comment /= NO_COMMENT then
            Match := Look_License_Tree (Template.Root, Buf.Data,
                                           File.Lines, Line, To);
            if Match.Info.Match in Infos.SPDX_LICENSE | Infos.TEMPLATE_LICENSE then
               return Match;
            end if;
            if Log.Is_Info_Enabled
              and then Match.Count > 0
              and then Match.Info.Lines.First_Line + 1 < Match.Info.Lines.Last_Line
            then
               Log.Info ("license '{0}' missmatch at line{1} after {2} lines ({3} matched)",
                         To_String (Template.Name),
                         Match.Info.Lines.Last_Line'Image,
                         Infos.Image (Match.Info.Lines.Last_Line - Match.Info.Lines.First_Line),
                         Infos.Percent_Image (Match.Confidence));
            end if;
            exit when Match.Info.Lines.First_Line + 1 < Match.Info.Lines.Last_Line;
            if Match.Last /= null then
               Match.Depth := Match.Last.Depth;
               if Result.Last = null or else Match.Depth > Result.Depth then
                  Result.Last := Match.Last;
                  Result.Depth := Match.Depth;
               end if;
            end if;
         end if;
         exit when Line = To;
         Line := Line + 1;
      end loop;
      Report (Stamp, "Find license (no match)");
      if Log.Is_Info_Enabled then
         Log.Info ("license '{0}' missmatch at lines {1}..{2}",
                   To_String (Template.Name),
                   Infos.Image (From), Infos.Image (To));
      end if;
      return Result;
   end Look_License;

   procedure Performance_Report is
   begin
      Util.Measures.Write (Perf, "spdx-tool", Ada.Text_IO.Standard_Output);
   end Performance_Report;

   procedure Report (Stamp : in out Util.Measures.Stamp;
                     Title : in String;
                     Count : in Positive := 1) is
   begin
      Util.Measures.Report (Perf, Stamp, Title, Count);
   end Report;

end SPDX_Tool.Licenses;
