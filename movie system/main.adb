with Ada.Text_IO;                use Ada.Text_IO;
with Recommendation_System;

procedure Main is
   userGenre    : String (1 .. 100);
   userDuration : String (1 .. 100);
   userPop      : String (1 .. 100);
   userService  : String (1 .. 100);
   Last         : Natural;
   Choice       : Character;

begin
   Recommendation_System.Initialize;

   loop
      Put_Line("------------------------------------------------");
      Put_Line("Welcome to the Movie Recommendation System!");
      Put_Line("Select an option:");
      Put_Line("1. Get Movie Recommendation");
      Put_Line("2. Add Movie to Watchlist");
      Put_Line("3. Remove Movie from Watchlist");
      Put_Line("4. Display Watchlist");
      Put_Line("5. Search Movie (Coming Soon)");
      Put_Line("6. Generate Random Movie (Coming Soon)");
      Put_Line("7. Quit");
      Put("Enter your choice: ");
      Get(Choice);
      Skip_Line;
      
      case Choice is
         when '1' =>
            Put("What genre are you interested in?: ");
            Get_Line(userGenre, Last);
            Put_Line("Entered: " & userGenre(1..Last));

            Put("Preferred duration (in minutes)?: ");
            Get_Line(userDuration, Last);
            Put_Line("Entered: " & userDuration(1..Last));

            Put("Popularity preference (high/low)?: ");
            Get_Line(userPop, Last);
            Put_Line("Entered: " & userPop(1..Last));

            Put("Preferred streaming service (e.g., Netflix)?: ");
            Get_Line(userService, Last);
            Put_Line("Entered: " & userService(1..Last));
            
            Recommendation_System.Get_Recommendation(
               Genre    => userGenre(1..Last),
               Duration => userDuration(1..Last),
               Popularity => userPop(1..Last),
               Service  => userService(1..Last)
            );
            
         when '2' =>
            Put("Enter movie title to add to watchlist: ");
            Get_Line(userGenre, Last); -- Using userGenre variable for simplicity
            Recommendation_System.Add_To_Watchlist(userGenre(1..Last));
            
         when '3' =>
            Put("Enter movie title to remove from watchlist: ");
            Get_Line(userGenre, Last);
            Recommendation_System.Remove_From_Watchlist(userGenre(1..Last));
            
         when '4' =>
            Recommendation_System.Display_Watchlist;

         when '5' =>
            Put_Line("Search functionality is not implemented yet.");
            
         when '6' =>
            Put_Line("Random movie generation is not implemented yet.");
            
         when '7' =>
            exit;
            
         when others =>
            Put_Line("Invalid choice. Please try again.");
      end case;
      
      Put_Line("------------------------------------------------");
   end loop;
   
   Put_Line("Thank you for using the Movie Recommendation System!");
end Main;

