with Ada.Text_IO; use Ada.Text_IO;
with Recommendation_System;

procedure Main is
   API_Link : constant String := "https://api.themoviedb.org/3/discover/movie";
   API_Key  : constant String := "8aa33db0c10eb1f9078288faaa6c015b";

   userChoice : Character;
   userGenre  : String (1 .. 100);
   userDuration : String (1 .. 100);
   userPop : String (1 .. 100);
   userService : String (1 .. 100);
   userMovie : String (1 .. 100);
   Last : Natural;

begin
   Recommendation_System.Initialize;
   
   loop
      Put_Line("------------------------------------------------");
      Put_Line("Welcome to the Movie Recommendation System!");
      Put_Line("API Link: " & API_Link);
      Put_Line("API Key: " & API_Key);
      Put_Line("------------------------------------------------");

      Put_Line("Select an option:");
      Put_Line("1. Get a Movie Recommendation");
      Put_Line("2. Add a Movie to Watchlist");
      Put_Line("3. Remove a Movie from Watchlist");
      Put_Line("4. Display Watchlist");
      Put_Line("5. Search for a Movie by Title");
      Put_Line("6. Generate a Random Movie Suggestion");
      Put_Line("7. Exit");
      Put("Enter choice (1-7): ");
      Get(userChoice);
      Skip_Line;

      case userChoice is
         when '1' =>
            Put("Enter Genre (e.g., Action, Comedy, Drama): ");
            Get_Line(userGenre, Last);
            userGenre := userGenre(1 .. Last);

            Put("Enter Duration (Short, Medium, Long): ");
            Get_Line(userDuration, Last);
            userDuration := userDuration(1 .. Last);

            Put("Enter Popularity (High, Medium, Low): ");
            Get_Line(userPop, Last);
            userPop := userPop(1 .. Last);

            Put("Enter Streaming Service (e.g., Netflix, Hulu): ");
            Get_Line(userService, Last);
            userService := userService(1 .. Last);

            Recommendation_System.Get_Recommendation(userGenre, userDuration, userPop, userService, API_Link, API_Key);

         when '2' =>
            Put("Enter the movie title to add to your watchlist: ");
            Get_Line(userMovie, Last);
            userMovie := userMovie(1 .. Last);

            Recommendation_System.Add_To_Watchlist(userMovie);

         when '3' =>
            Put("Enter the movie title to remove from your watchlist: ");
            Get_Line(userMovie, Last);
            userMovie := userMovie(1 .. Last);

            Recommendation_System.Remove_From_Watchlist(userMovie);

         when '4' =>
            Recommendation_System.Display_Watchlist;

         when '5' =>
            Put("Enter the movie title to search: ");
            Get_Line(userMovie, Last);
            userMovie := userMovie(1 .. Last);

            Recommendation_System.Search_Movie(userMovie);

         when '6' =>
            Recommendation_System.Random_Movie;

         when '7' =>
            Put_Line("Exiting the system. Goodbye!");
            exit;

         when others =>
            Put_Line("Invalid choice! Please enter a number between 1 and 7.");
      end case;

      Put_Line("");
   end loop;
end Main;


