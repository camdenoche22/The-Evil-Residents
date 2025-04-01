package Movie_Data is
   procedure Add_Movie_To_Watchlist (Movie : in String);
   procedure Remove_Movie_From_Watchlist (Movie : in String);
   procedure Display_Watchlist;
   function Find_Movie (Genre, Duration, Popularity, Service : in String) return String;
   function Find_Movie_By_Title (Title : in String) return String;
   function Get_Random_Movie return String;
end Movie_Data;
