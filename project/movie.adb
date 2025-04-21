with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Numerics.Discrete_Random;

procedure Movie_Recommendation is
   package ASU renames Ada.Strings.Unbounded;
   use Ada.Containers;

   type Movie_Record is record
      Title    : ASU.Unbounded_String;
      Genre    : ASU.Unbounded_String;
      Duration : Integer;
      Service  : ASU.Unbounded_String;
      Rating   : Integer;
   end record;

   package Movie_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Movie_Record);

   Movies : Movie_Vectors.Vector;
   Watchlist : Movie_Vectors.Vector;
   User_History : Movie_Vectors.Vector;

   procedure Load_Movies is
   begin
      Movies.Append((ASU.To_Unbounded_String("Inception"), ASU.To_Unbounded_String("Sci-Fi"), 148, ASU.To_Unbounded_String("Netflix"), 9));
      Movies.Append((ASU.To_Unbounded_String("Titanic"), ASU.To_Unbounded_String("Romance"), 195, ASU.To_Unbounded_String("Hulu"), 10));
      Movies.Append((ASU.To_Unbounded_String("The Matrix"), ASU.To_Unbounded_String("Action"), 136, ASU.To_Unbounded_String("Amazon Prime"), 9));
      Movies.Append((ASU.To_Unbounded_String("The Shawshank Redemption"), ASU.To_Unbounded_String("Drama"), 142, ASU.To_Unbounded_String("HBO Max"), 10));
      Movies.Append((ASU.To_Unbounded_String("The Godfather"), ASU.To_Unbounded_String("Crime"), 175, ASU.To_Unbounded_String("Paramount"), 10));
   
      Movies.Append((ASU.To_Unbounded_String("Die Hard"), ASU.To_Unbounded_String("Action"), 132, ASU.To_Unbounded_String("Amazon Prime"), 9));
      Movies.Append((ASU.To_Unbounded_String("Mad Max: Fury Road"), ASU.To_Unbounded_String("Action"), 120, ASU.To_Unbounded_String("HBO Max"), 10));
      Movies.Append((ASU.To_Unbounded_String("Gladiator"), ASU.To_Unbounded_String("Action"), 155, ASU.To_Unbounded_String("Netflix"), 9));
      Movies.Append((ASU.To_Unbounded_String("John Wick"), ASU.To_Unbounded_String("Action"), 101, ASU.To_Unbounded_String("Peacock"), 8));

      Movies.Append((ASU.To_Unbounded_String("Superbad"), ASU.To_Unbounded_String("Comedy"), 113, ASU.To_Unbounded_String("Netflix"), 8));
      Movies.Append((ASU.To_Unbounded_String("The Hangover"), ASU.To_Unbounded_String("Comedy"), 100, ASU.To_Unbounded_String("HBO Max"), 9));
      Movies.Append((ASU.To_Unbounded_String("Step Brothers"), ASU.To_Unbounded_String("Comedy"), 98, ASU.To_Unbounded_String("Amazon Prime"), 7));
      Movies.Append((ASU.To_Unbounded_String("Anchorman"), ASU.To_Unbounded_String("Comedy"), 94, ASU.To_Unbounded_String("Hulu"), 8));

      Movies.Append((ASU.To_Unbounded_String("The Exorcist"), ASU.To_Unbounded_String("Horror"), 122, ASU.To_Unbounded_String("HBO Max"), 10));
      Movies.Append((ASU.To_Unbounded_String("Hereditary"), ASU.To_Unbounded_String("Horror"), 127, ASU.To_Unbounded_String("Amazon Prime"), 9));
      Movies.Append((ASU.To_Unbounded_String("A Nightmare on Elm Street"), ASU.To_Unbounded_String("Horror"), 91, ASU.To_Unbounded_String("Netflix"), 8));
      Movies.Append((ASU.To_Unbounded_String("The Conjuring"), ASU.To_Unbounded_String("Horror"), 112, ASU.To_Unbounded_String("Hulu"), 9));

      Movies.Append((ASU.To_Unbounded_String("The Lord of the Rings: The Fellowship of the Ring"), ASU.To_Unbounded_String("Fantasy"), 178, ASU.To_Unbounded_String("Netflix"), 10));
      Movies.Append((ASU.To_Unbounded_String("Harry Potter and the Sorcerer's Stone"), ASU.To_Unbounded_String("Fantasy"), 152, ASU.To_Unbounded_String("HBO Max"), 9));
      Movies.Append((ASU.To_Unbounded_String("Pan's Labyrinth"), ASU.To_Unbounded_String("Fantasy"), 118, ASU.To_Unbounded_String("Amazon Prime"), 9));
      Movies.Append((ASU.To_Unbounded_String("The Dark Crystal"), ASU.To_Unbounded_String("Fantasy"), 93, ASU.To_Unbounded_String("Peacock"), 7));

      Movies.Append((ASU.To_Unbounded_String("Gone Girl"), ASU.To_Unbounded_String("Mystery"), 149, ASU.To_Unbounded_String("Hulu"), 9));
      Movies.Append((ASU.To_Unbounded_String("Se7en"), ASU.To_Unbounded_String("Mystery"), 127, ASU.To_Unbounded_String("HBO Max"), 10));
      Movies.Append((ASU.To_Unbounded_String("Shutter Island"), ASU.To_Unbounded_String("Mystery"), 138, ASU.To_Unbounded_String("Netflix"), 9));
      Movies.Append((ASU.To_Unbounded_String("The Sixth Sense"), ASU.To_Unbounded_String("Mystery"), 107, ASU.To_Unbounded_String("Amazon Prime"), 9));

      Movies.Append((ASU.To_Unbounded_String("Toy Story"), ASU.To_Unbounded_String("Animation"), 81, ASU.To_Unbounded_String("Disney+"), 9));
      Movies.Append((ASU.To_Unbounded_String("Shrek"), ASU.To_Unbounded_String("Animation"), 90, ASU.To_Unbounded_String("Netflix"), 8));
      Movies.Append((ASU.To_Unbounded_String("Finding Nemo"), ASU.To_Unbounded_String("Animation"), 100, ASU.To_Unbounded_String("Disney+"), 9));
      Movies.Append((ASU.To_Unbounded_String("Spider-Man: Into the Spider-Verse"), ASU.To_Unbounded_String("Animation"), 117, ASU.To_Unbounded_String("Amazon Prime"), 10));

      Movies.Append((ASU.To_Unbounded_String("Psycho"), ASU.To_Unbounded_String("Thriller"), 109, ASU.To_Unbounded_String("Peacock"), 10));
      Movies.Append((ASU.To_Unbounded_String("Fight Club"), ASU.To_Unbounded_String("Thriller"), 139, ASU.To_Unbounded_String("HBO Max"), 9));
      Movies.Append((ASU.To_Unbounded_String("Black Swan"), ASU.To_Unbounded_String("Thriller"), 108, ASU.To_Unbounded_String("Hulu"), 8));
      Movies.Append((ASU.To_Unbounded_String("No Country for Old Men"), ASU.To_Unbounded_String("Thriller"), 122, ASU.To_Unbounded_String("Netflix"), 9));

      Movies.Append((ASU.To_Unbounded_String("13th"), ASU.To_Unbounded_String("Documentary"), 100, ASU.To_Unbounded_String("Netflix"), 9));
      Movies.Append((ASU.To_Unbounded_String("Won't You Be My Neighbor?"), ASU.To_Unbounded_String("Documentary"), 94, ASU.To_Unbounded_String("HBO Max"), 8));
      Movies.Append((ASU.To_Unbounded_String("Free Solo"), ASU.To_Unbounded_String("Documentary"), 100, ASU.To_Unbounded_String("Disney+"), 9));
      Movies.Append((ASU.To_Unbounded_String("Making a Murderer"), ASU.To_Unbounded_String("Documentary"), 468, ASU.To_Unbounded_String("Netflix"), 9));
   end Load_Movies;

   procedure Display_Movie(Movie : Movie_Record) is
   begin
      Ada.Text_IO.Put_Line("Title: " & ASU.To_String(Movie.Title));
      Ada.Text_IO.Put_Line("Genre: " & ASU.To_String(Movie.Genre));
      Ada.Text_IO.Put_Line("Duration: " & Integer'Image(Movie.Duration) & " minutes");
      Ada.Text_IO.Put_Line("Service: " & ASU.To_String(Movie.Service));
      Ada.Text_IO.Put_Line("Rating: " & Integer'Image(Movie.Rating));
      Ada.Text_IO.New_Line;
   end Display_Movie;

   procedure Genre_Filter(Genre : String) is
      Found: Boolean := False;
   begin
      for Movie of Movies loop
         if ASU.To_String(Movie.Genre) = Genre then
            Found := True;
            Display_Movie(Movie);
         end if;
      end loop;
      if not Found then
         Ada.Text_IO.Put_Line("No movies found");
      end if;
   end Genre_Filter;

   procedure Duration_Filter(Min, Max : Integer) is
      Found : Boolean := False;
   begin
      for Movie of Movies loop
         if Movie.Duration >= Min and Movie.Duration <= Max then
            Found := True;
            Display_Movie(Movie);
         end if;
      end loop;
      if not Found then
         Ada.Text_IO.Put_Line("No Movies found");
      end if;
   end Duration_Filter;

   procedure Service_Filter(Service : String) is
      Found : Boolean := False;
   begin
      for Movie of Movies loop
         if ASU.To_String(Movie.Service) = Service then
            Found := True;
            Display_Movie(Movie);
         end if;
      end loop;
      if not Found then
         Ada.Text_IO.Put_Line("No Movies found.");
      end if;
   end Service_Filter;

   procedure Popularity_Filter(Threshold : Integer) is
      Found : Boolean := False;
   begin
      for Movie of Movies loop
         if Movie.Rating >= Threshold then
            Found := True;
            Display_Movie(Movie);
         end if;
      end loop;
      if not Found then
         Ada.Text_IO.Put_Line("No movies found.");
      end if;
   end Popularity_Filter;

   procedure Add_To_Watchlist(Title : String) is
      Found : Boolean := False;
   begin
      for Movie of Movies loop
         if ASU.To_String(Movie.Title) = Title then
            Watchlist.Append(Movie);
            Found := True;
            Ada.Text_IO.Put_Line("Added to watchlist: " & Title);
            exit;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("Movie not found: " & Title);
      end if;
   end Add_To_Watchlist;

   procedure Display_Watchlist is
   begin
      if Watchlist.Is_Empty then
         Ada.Text_IO.Put_Line("Watchlist is empty.");
      else
         Ada.Text_IO.Put_Line("Your Watchlist: ");
         for Movie of Watchlist loop
            Display_Movie(Movie);
         end loop;
      end if;
   end Display_Watchlist;

   procedure Add_To_History(Title : String) is
      Found : Boolean := False;
   begin
      for Movie of Movies loop
         if ASU.To_String(Movie.Title) = Title then
            User_History.Append(Movie);
            Found := True;
            Ada.Text_IO.Put_Line("Added to history: " & Title);
            exit;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("Movie not found: " & Title);
      end if;
   end Add_To_History;

   procedure Suggest_Based_On_History is
      type Genre_Count_Type is array (Natural range <>) of Natural;
      Genre_Counts : Genre_Count_Type(0..Natural(Movies.Length) - 1) := (others => 0);
      Most_Common_Genre : ASU.Unbounded_String := ASU.Null_Unbounded_String;
      Max_Count : Natural := 0;
   begin
      for History_Movie of User_History loop
         for I in 0..Natural(Movies.Length) - 1 loop
            if ASU."="(Movies(I).Genre, History_Movie.Genre) then
               Genre_Counts(I) := Genre_Counts(I) + 1;
               if Genre_Counts(I) > Max_Count then
                  Max_Count := Genre_Counts(I);
                  Most_Common_Genre := History_Movie.Genre;
               end if;
               exit;
            end if;
         end loop;
      end loop;

      if ASU.Length(Most_Common_Genre) > 0 then
         Ada.Text_IO.Put_Line("Based on your history, you might like these movies: ");
         Genre_Filter(ASU.To_String(Most_Common_Genre));
      else
         Ada.Text_IO.Put_Line("Not enough history to make suggestions.");
      end if;
   end Suggest_Based_On_History;

   procedure Search_Movie(Title : String) is
      Found : Boolean := False;
   begin
      for Movie of Movies loop
         if ASU.To_String(Movie.Title) = Title then
            Display_Movie(Movie);
            Found := True;
            exit;
         end if;
      end loop;

      if not Found then
         Ada.Text_IO.Put_Line("Movie not found: " & Title);
      end if;
   end Search_Movie;

   procedure Random_Movie is
      package Random is new Ada.Numerics.Discrete_Random(Natural);
      Gen : Random.Generator;
      Index : Natural;
   begin
      Random.Reset(Gen);
      Index := Random.Random(Gen) mod Natural(Movies.Length);
      Display_Movie(Movies(Index));
   end Random_Movie;

   procedure Get_User_Input is
   Choice : Integer;
   Input : String(1..100);
   Last : Natural;
   Min_Duration, Max_Duration : Integer;
   begin
      Load_Movies;
      loop
         Ada.Text_IO.New_Line;
         Ada.Text_IO.Put_Line("------Welcome to the Movie Recommendation System------");
         Ada.Text_IO.New_Line;
         Ada.Text_IO.Put_Line("Menu: ");
         Ada.Text_IO.Put_Line("1. Filter by Genre");
         Ada.Text_IO.Put_Line("2. Filter by Duration");
         Ada.Text_IO.Put_Line("3. Filter by Streaming Service");
         Ada.Text_IO.Put_Line("4. Filter by Popularity");
         Ada.Text_IO.Put_Line("5. Add to Watchlist");
         Ada.Text_IO.Put_Line("6. Display Watchlist");
         Ada.Text_IO.Put_Line("7. Add to History");
         Ada.Text_IO.Put_Line("8. Get Suggestions Based on History");
         Ada.Text_IO.Put_Line("9. Search for a Movie");
         Ada.Text_IO.Put_Line("10. Get Random Movie");
         Ada.Text_IO.Put_Line("11. Exit");
         Ada.Text_IO.Put("Enter your choice: ");
         Ada.Text_IO.New_Line;
         begin
            Ada.Integer_Text_IO.Get(Choice);
            Ada.Text_IO.Skip_Line; 

      case Choice is
         when 1 =>
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put_Line("----Genre Filter---");
            Ada.Text_IO.Put("Enter genre: ");
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Get_Line(Input, Last);
            Ada.Text_IO.Put_Line("-------------------");
            Genre_Filter(Input(1..Last));
         when 2 =>
            Ada.Text_IO.Put_Line("----Filter By Movie Duration----");
            Ada.Text_IO.Put("Enter minimum duration: ");
            Ada.Integer_Text_IO.Get(Min_Duration);
            Ada.Text_IO.Skip_Line; 
            Ada.Text_IO.Put("Enter maximum duration: ");
            Ada.Integer_Text_IO.Get(Max_Duration);
            Ada.Text_IO.Put_Line("--------------------------------");
            Ada.Text_IO.Skip_Line; 
            Duration_Filter(Min_Duration, Max_Duration);
         when 3 =>
            Ada.Text_IO.Put_Line("----Filter By Streaming Service----");
            Ada.Text_IO.Put("Enter streaming service: ");
            Ada.Text_IO.Get_Line(Input, Last);
            Ada.Text_IO.Put_Line("------------------------------------");
            Service_Filter(Input(1..Last));
         when 4 =>
            Ada.Text_IO.Put_Line("----Movie Rating----");
            loop
               Ada.Text_IO.Put("Enter minimum rating: ");
               begin
                  Ada.Integer_Text_IO.Get(Min_Duration);
                  Ada.Text_IO.Put_Line("--------------------");
                  Ada.Text_IO.Skip_Line; 
                  Popularity_Filter(Min_Duration);
                  exit;
               exception 
                  when Ada.Text_IO.DATA_ERROR => 
                     Ada.Text_IO.Put_Line("Please enter a valid integer");
                     Ada.Text_IO.Skip_Line; 
               end;
            end loop;
         when 5 =>
            Ada.Text_IO.Put_Line("----Movie Watchlist----");
            Ada.Text_IO.Put("Enter movie title to add to watchlist: ");
            Ada.Text_IO.Get_Line(Input, Last);
            Ada.Text_IO.Put_Line("-----------------------");
            Add_To_Watchlist(Input(1..Last));
         when 6 =>
            Display_Watchlist;
         when 7 =>
            Ada.Text_IO.Put_Line("----Movie History----");
            Ada.Text_IO.Put("Enter movie title to add to history: ");
            Ada.Text_IO.Get_Line(Input, Last);
            Ada.Text_IO.Put_Line("---------------------");
            Add_To_History(Input(1..Last));
         when 8 =>
            Suggest_Based_On_History;
         when 9 =>
            Ada.Text_IO.Put_Line("----Movie Search----");
            Ada.Text_IO.Put("Enter movie title to search: ");
            Ada.Text_IO.Get_Line(Input, Last);
            Ada.Text_IO.Put_Line("-------------------");
            Search_Movie(Input(1..Last));
         when 10 =>
            Random_Movie;
         when 11 =>
            Ada.Text_IO.Put_Line("Goodbye!");
            exit;
         when others =>
            Ada.Text_IO.Put_Line("Please enter a valid choice");
      end case;
      exception
            when Ada.Text_IO.DATA_ERROR =>
               Ada.Text_IO.Put_Line("Please enter a valid integer choice");
               Ada.Text_IO.Skip_Line; 
         end;
   end loop;
end Get_User_Input;

begin
   Get_User_Input;
end Movie_Recommendation;
