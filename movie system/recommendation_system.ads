package Recommendation_System is
   procedure Initialize;
   procedure Get_Recommendation (Genre : in String; Duration : in String; Popularity : in String; Service : in String);
   procedure Add_To_Watchlist (Movie : in String);
   procedure Display_Watchlist;
   procedure Remove_From_Watchlist (Movie : in String);
   procedure Search_Movie (Title : in String);
   procedure Random_Movie;
end Recommendation_System;
