with Ada.Text_IO; use Ada.Text_IO;
with Movie_Data;

package body Recommendation_System is

   procedure Initialize is
   begin
      Put_Line("------------------------------------------------");
      Put_Line("Welcome to the Movie Recommendation System!");
      Put_Line("------------------------------------------------");
   end Initialize;

   procedure Get_Recommendation (Genre : in String; Duration : in String; Popularity : in String; Service : in String) is
      Movie : String := Movie_Data.Find_Movie(Genre, Duration, Popularity, Service);
   begin
      if Movie /= "" then
         Put_Line("Recommended Movie: " & Movie);
      else
         Put_Line("No recommendations found based on your criteria.");
      end if;
   end Get_Recommendation;

   procedure Add_To_Watchlist (Movie : in String) is
   begin
      Movie_Data.Add_Movie_To_Watchlist(Movie);
      Put_Line(Movie & " has been added to your watchlist.");
   end Add_To_Watchlist;

   procedure Remove_From_Watchlist (Movie : in String) is
   begin
      Movie_Data.Remove_Movie_From_Watchlist(Movie);
      Put_Line(Movie & " has been removed from your watchlist.");
   end Remove_From_Watchlist;

   procedure Display_Watchlist is
   begin
      Movie_Data.Display_Watchlist;
   end Display_Watchlist;

   procedure Search_Movie (Title : in String) is
      Movie : String := Movie_Data.Find_Movie_By_Title(Title);
   begin
      if Movie /= "" then
         Put_Line("Movie Found: " & Movie);
      else
         Put_Line("No movie found with the title: " & Title);
      end if;
   end Search_Movie;

   procedure Random_Movie is
      Movie : String := Movie_Data.Get_Random_Movie;
   begin
      Put_Line("Random Movie Suggestion: " & Movie);
   end Random_Movie;

end Recommendation_System;
