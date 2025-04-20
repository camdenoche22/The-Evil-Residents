with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors; use Ada.Containers;
with Ada.Numerics.Discrete_Random;

procedure test is
   type Movie_Record is record
      Title: Unbounded_String;
      Genre: Unbounded_String;
      Duration: Long_Integer;
      Service: Unbounded_String;
      Rating: Float;
   end record;

   type Index is range 1..10;

   type Movies_Array is 
   array(Index) of Movie_Record;

   Movies : Movies_Array := 
   ((
   Title => To_Unbounded_String("The Godfather"),
   Genre => To_Unbounded_String("Drama"),
   Duration => 175, 
   Service => To_Unbounded_String("Prime Video"),
   Rating => 9.2
   ),

   (
   Title => To_Unbounded_String("The Lord of the Rings: The Return of the King"),
   Genre => To_Unbounded_String("Action"),
   Duration => 201,
   Service => To_Unbounded_String("Prime Video"),
   Rating => 9.0
   ),

   (
   Title => To_Unbounded_String("Forrest Gump"),
   Genre => To_Unbounded_String("Epic"),
   Duration => 144,
   Service => To_Unbounded_String("Prime Video"),
   Rating => 8.8
   ),

   (
   Title => To_Unbounded_String("Inception"),
   Genre => To_Unbounded_String("Action"),
   Duration => 148,
   Service => To_Unbounded_String("Prime Video"),
   Rating => 8.8
   ),

   (
   Title => To_Unbounded_String("A Minecraft Movie"),
   Genre => To_Unbounded_String("Action"),
   Duration => 191,
   Service => To_Unbounded_String("In Theaters"),
   Rating => 5.9
   ),

   (
   Title => To_Unbounded_String("Sinners"),
   Genre => To_Unbounded_String("Drama"),
   Duration => 137,
   Service => To_Unbounded_String("In Theaters"),
   Rating => 8.2
   ),

   (
   Title => To_Unbounded_String("Snow White"),
   Genre => To_Unbounded_String("Fairy Tale"),
   Duration => 109,
   Service => To_Unbounded_String("In Theaters"),
   Rating => 1.6
   ),

   (
   Title => To_Unbounded_String("Anora"),
   Genre => To_Unbounded_String("Comedy"),
   Duration => 109,
   Service => To_Unbounded_String("Hulu"),
   Rating => 7.5
   ),

   (
   Title => To_Unbounded_String("Death of a Unicorn"),
   Genre => To_Unbounded_String("Comedy"),
   Duration => 107,
   Service => To_Unbounded_String("In Theaters"),
   Rating => 6.3
   ),

   (
   Title => To_Unbounded_String("Test"),
   Genre => To_Unbounded_String("Comedy"),
   Duration => 109,
   Service => To_Unbounded_String("Hulu"),
   Rating => 7.5
   

   ));

   procedure FindGenre is
      GenreChoice : String(1..100);
      Last: Natural;
   begin
         New_Line;
         Put_Line("Enter a Genre: ");
         Get_Line(GenreChoice, Last);
         declare
            package Genres_Vectors is new Ada.Containers.Vectors(Natural, Movie_Record);
            use Genres_Vectors;
            Genres : Vector;
         begin
            for I in Movies'Range loop
               if To_String(Movies(I).Genre) = GenreChoice(1..Last) then
                  Genres.Append(Movies(I));
               end if;
            end loop;

            if not Genres.Is_Empty then
               declare 
                  subtype Random_Index is Positive range 1..Positive(Genres.Last_Index);
                  package Index is new 
                     Ada.Numerics.Discrete_Random(Random_Index);
                  use Index;
                  G : Generator;
                  RanIndex : Random_Index;
               begin 
                  Reset(G);
                  RanIndex := Random(G);
                  New_Line;
                  Put_Line(To_String(Genres(RanIndex).Title));
               end;
            else 
               Put_Line("No movies found.");
            end if;
         end;
   end FindGenre;

   procedure FindDuration is
   begin
      Put_line("test");
   end FindDuration;

   procedure FindPop is 
   begin
      Put_line("test");
   end FindPop;

   procedure FindSS is
      SSChoice : String(1..100);
      Last: Natural;
      Found : Boolean := False;
   begin
      New_Line;
      Put_Line("Enter a Streaming Service: ");
      Get_Line(SSChoice, Last);
      declare
         package SS_Vectors is new Ada.Containers.Vectors(Natural, Movie_Record);
         use SS_Vectors;
         SS : Vector;
      begin
         for I in Movies'Range loop
            if To_String(Movies(I).Service) = SSChoice(1..Last) then
               SS.Append(Movies(I));
            end if;
         end loop;

         if not SS.Is_Empty then
            declare 
               subtype Random_Index is Positive range 1..Positive(SS.Last_Index);
               package Index is new 
                  Ada.Numerics.Discrete_Random(Random_Index);
               use Index;
               G : Generator;
               RanIndex : Random_Index;
            begin 
               Reset(G);
               RanIndex := Random(G);
               New_Line;
               Put_Line(To_String(SS(RanIndex).Title));
            end;
         else 
            Put_Line("No movies found.");
         end if;
      end;
   end FindSS;

   
   procedure menu is
      Choice : Integer;
      GenreChoice : String(1..100);
      RecMovie : String(1..100);
      Last: Natural;
      Found : Boolean := False;
   begin
      loop
      New_Line;
      Put_Line("~~~~MOVIE RECOMMENDATION SYSTEM~~~~~");
      New_Line;
      Put_line("1. Find a movie that fits your interest");
      Put_line("2. Find a Movie based on Genre");
      Put_line("3. Find a Movie based on Duration");
      Put_line("4. Find a Movie based on Popularity");
      Put_Line("5. Find a Movie based on Streaming Service");
      Put_line("6. Watchlist");
      Put_line("7. Search");
      Put_Line("8. Exit");
      New_Line;
      Put_Line("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      New_Line;
      Get(Choice);
      Skip_Line;

      case Choice is
         when 1 =>
            Put_Line("One");
         when 2 =>
            declare
               GenreMenu : Boolean := False;
               UserChoice : Integer;
            begin
               while not GenreMenu loop
                  New_Line;
                  Put_Line("~~~Find your movie based on Genre~~~");
                  New_Line;
                  Put_Line("1. List of movies with Genre");
                  Put_Line("2. Random movie with Genre");
                  Put_Line("3. Go back to menu");
                  Get(UserChoice);
                  Skip_Line;

                  case UserChoice is
                     when 1 =>
                        New_Line;
                        Put_Line("Enter a Genre: ");
                        Get_Line(GenreChoice, Last);
                        New_Line;
                        Put_Line("List of movies: ");
                        for I in Movies'Range loop
                           if To_String(Movies(I).Genre) = GenreChoice(1..Last) then
                              Put_Line(To_String(Movies(I).Title));
                              Found := True;
                           end if;   
                        end loop;
                           if not Found then 
                              Put_Line("No Movies found");
                              end if;
                     when 2 =>
                        FindGenre;
                     when 3 =>
                        GenreMenu := True;
                     when others =>
                        Put_Line("Enter a valid option");
                     end case;
               end loop;
            end;
         when 3 => 
            Put_Line("Three");
         when 4 =>
            Put_Line("Four");
         when 5 =>
            declare
               SSMenu : Boolean := False;
               UserChoice : Integer;
               SSChoice : String(1..100);
            begin
               while not SSMenu loop
                  New_Line;
                  Put_Line("~~~Find your movie based on Streaming Service~~~");
                  New_Line;
                  Put_Line("1. List of movies with Streaming Service");
                  Put_Line("2. Random movie with Streaming Service");
                  Put_Line("3. Go back to menu");
                  Get(UserChoice);
                  Skip_Line;

                  case UserChoice is
                     when 1 =>
                        New_Line;
                        Put_Line("Enter a Service: ");
                        Get_Line(SSChoice, Last);
                        New_Line;
                        Put_Line("List of movies: ");
                        for I in Movies'Range loop
                           if To_String(Movies(I).Service) = SSChoice(1..Last) then
                              Put_Line(To_String(Movies(I).Title));
                              Found := True;
                           end if;   
                        end loop;
                           if not Found then 
                              Put_Line("No Movies found");
                              end if;
                     when 2 =>
                        FindSS;
                     when 3 =>
                        SSMenu := True;
                     when others =>
                        Put_Line("Enter a valid option");
                     end case;
               end loop;
            end;
         when 6 =>
            Put_Line("Six");
         when 7 =>
            Put_Line("Goodbye!");
            return;
         when others =>
            Put_Line("Enter a valid choice!");
         exit;
      end case;
   end loop;
   end menu;

begin
   menu;
end test;