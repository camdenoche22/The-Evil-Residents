with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random;

package body Movie_DB is

   type Movie is record
      Title     : Ada.Strings.Unbounded.Unbounded_String;
      Genre     : Ada.Strings.Unbounded.Unbounded_String;
      Duration  : Integer;
      Platform  : Ada.Strings.Unbounded.Unbounded_String;
      Rating    : Integer;
   end record;

   type Movie_List is array (Positive range <>) of Movie;
   type Movie_List_Access is access all Movie_List;

   Movie_DB    : Movie_List_Access;
   DB_Size     : Positive := 0;
   Watchlist   : array(1..10) of Movie;
   Watchlist_Size : Integer := 0;

   -- Load movie data into the database from file
   procedure Load_Database is
      File : Ada.Text_IO.File_Type;
      Line : String (1 .. 200);
      Index : Positive := 0;
   begin
      Ada.Text_IO.Open(File, Ada.Text_IO.In_File, "../data/movies.txt");

      while not Ada.Text_IO.End_Of_File(File) loop
         Ada.Text_IO.Get_Line(File, Line);
         if Line /= "" then
            DB_Size := DB_Size + 1;
         end if;
      end loop;
      Ada.Text_IO.Close(File);

      Movie_DB := new Movie_List(1 .. DB_Size);

      Ada.Text_IO.Open(File, Ada.Text_IO.In_File, "../data/movies.txt");
      Index := 1;

      while not Ada.Text_IO.End_Of_File(File) loop
         Ada.Text_IO.Get_Line(File, Line);

         declare
            Parts : constant Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.To_Unbounded_String(Line);
            Title, Genre, Platform : Ada.Strings.Unbounded.Unbounded_String;
            Duration, Rating : Integer;
            Separator_Pos : Integer := 0;
            Separator_Count : Integer := 0;
         begin
            for J in 1 .. Line'Length loop
               if Line(J) = '|' then
                  Separator_Count := Separator_Count + 1;
                  if Separator_Count = 1 then
                     Title := Ada.Strings.Unbounded.To_Unbounded_String(Line(1 .. J - 1));
                     Separator_Pos := J + 1;
                  elsif Separator_Count = 2 then
                     Genre := Ada.Strings.Unbounded.To_Unbounded_String(Line(Separator_Pos .. J - 1));
                     Separator_Pos := J + 1;
                  elsif Separator_Count = 3 then
                     Duration := Integer'Value(Line(Separator_Pos .. J - 1));
                     Separator_Pos := J + 1;
                  elsif Separator_Count = 4 then
                     Platform := Ada.Strings.Unbounded.To_Unbounded_String(Line(Separator_Pos .. J - 1));
                     Separator_Pos := J + 1;
                  elsif Separator_Count = 5 then
                     Rating := Integer'Value(Line(Separator_Pos .. J));
                  end if;
               end if;
            end loop;

            Movie_DB(Index) := (Title, Genre, Duration, Platform, Rating);
            Index := Index + 1;
         end;
      end loop;
      Ada.Text_IO.Close(File);
   end Load_Database;

   -- Genre-Based Recommendations
   procedure Recommend_By_Genre is
      Genre_Input : Ada.Strings.Unbounded.Unbounded_String;
      Found : Boolean := False;
   begin
      Ada.Text_IO.Put("Enter preferred genre: ");
      Ada.Text_IO.Get_Line(Genre_Input);
      Ada.Text_IO.New_Line;

      for Index in Movie_DB'Range loop
         if Movie_DB(Index).Genre = Genre_Input then
            Ada.Text_IO.Put_Line("Recommended Movie: " & Ada.Strings.Unbounded.To_String(Movie_DB(Index).Title));
            Found := True;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("No movies found in this genre.");
      end if;
   end Recommend_By_Genre;

   -- Duration Filtering
   procedure Recommend_By_Duration is
      Min_Duration, Max_Duration : Integer;
      Found : Boolean := False;
   begin
      Ada.Text_IO.Put("Enter minimum duration: ");
      Ada.Integer_Text_IO.Get(Min_Duration);
      Ada.Text_IO.Put("Enter maximum duration: ");
      Ada.Integer_Text_IO.Get(Max_Duration);
      Ada.Text_IO.New_Line;

      for Index in Movie_DB'Range loop
         if Movie_DB(Index).Duration >= Min_Duration and Movie_DB(Index).Duration <= Max_Duration then
            Ada.Text_IO.Put_Line("Recommended Movie: " & Ada.Strings.Unbounded.To_String(Movie_DB(Index).Title));
            Found := True;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("No movies found in this duration range.");
      end if;
   end Recommend_By_Duration;

   -- Platform-Based Filtering
   procedure Recommend_By_Platform is
      Platform_Input : Ada.Strings.Unbounded.Unbounded_String;
      Found : Boolean := False;
   begin
      Ada.Text_IO.Put("Enter streaming platform: ");
      Ada.Text_IO.Get_Line(Platform_Input);
      Ada.Text_IO.New_Line;

      for Index in Movie_DB'Range loop
         if Movie_DB(Index).Platform = Platform_Input then
            Ada.Text_IO.Put_Line("Recommended Movie: " & Ada.Strings.Unbounded.To_String(Movie_DB(Index).Title));
            Found := True;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("No movies found on this platform.");
      end if;
   end Recommend_By_Platform;

   -- Popularity-Based Filtering
   procedure Recommend_By_Popularity is
      Rating_Input : Integer;
      Found : Boolean := False;
   begin
      Ada.Text_IO.Put("Enter minimum rating (1-10): ");
      Ada.Integer_Text_IO.Get(Rating_Input);
      Ada.Text_IO.New_Line;

      for Index in Movie_DB'Range loop
         if Movie_DB(Index).Rating >= Rating_Input then
            Ada.Text_IO.Put_Line("Recommended Movie: " & Ada.Strings.Unbounded.To_String(Movie_DB(Index).Title));
            Found := True;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("No movies found with this rating.");
      end if;
   end Recommend_By_Popularity;

   -- Random Movie Generator
   procedure Random_Movie is
      Random : Ada.Numerics.Float_Random.Generator;
      Index  : Integer;
   begin
      Ada.Numerics.Float_Random.Reset(Random);
      Index := Integer(Ada.Numerics.Float_Random.Random(Random) * DB_Size) + 1;
      Ada.Text_IO.Put_Line("Random Movie: " & Ada.Strings.Unbounded.To_String(Movie_DB(Index).Title));
   end Random_Movie;

   -- Add Movie to Watchlist
   procedure Add_To_Watchlist is
      Movie_Title : Ada.Strings.Unbounded.Unbounded_String;
      Found       : Boolean := False;
   begin
      Ada.Text_IO.Put("Enter movie title to add to watchlist: ");
      Ada.Text_IO.Get_Line(Movie_Title);
      Ada.Text_IO.New_Line;

      for Index in Movie_DB'Range loop
         if Movie_DB(Index).Title = Movie_Title then
            Watchlist(Watchlist_Size + 1) := Movie_DB(Index);
            Watchlist_Size := Watchlist_Size + 1;
            Ada.Text_IO.Put_Line("Movie added to watchlist.");
            Found := True;
            exit;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("Movie not found in the database.");
      end if;
   end Add_To_Watchlist;

end Movie_DB;
