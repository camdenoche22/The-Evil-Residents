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

   type Index is range 1..9;

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

   ));

   procedure menu is
   Choice : Integer;
   GenreChoice : String(1..100);
   RecMovie : String(1..100);
   Last: Natural;
   Found : constant Boolean := False;
   begin
      loop
      Put_line("1. Recommend a Movie");
      Put_line("2. Find a Movie based on Genre");
      Put_line("3. Find a Movie based on Duration");
      Put_line("4. Find a Movie based on Popularity");
      Put_line("5. Watchlist");
      Put_line("6. Search");
      Put_Line("7. Exit");
      Get(Choice);
      Skip_Line;

      case Choice is
         when 1 =>
            Put_Line("One");
         when 2 =>
            Put_Line("Enter a Genre: ");
            Get_Line(GenreChoice, Last);
            for I in Movies'Range loop
               if To_String(Movies(I).Genre) = GenreChoice(1..Last) then
                 if not Found then
                     Put_Line("Your movie based on the genre: " & GenreChoice(1..Last));
                     Put_Line(To_String(Movies(I).Title));
                  end if;
               end if;
            if Found then 
               Put_Line("No Movies found");
            end if;
            end loop;
         when 3 => 
            Put_Line("Three");
         when 4 =>
            Put_Line("Four");
         when 5 =>
            Put_Line("Five");
         when 6 =>
            Put_Line("Six");
         when 7 =>
            Put_Line("Goodbye!");
            exit;
         when others =>
            Put_Line("Wrong");
         exit;
      end case;
   end loop;
   end menu;

begin
   menu;
end test;