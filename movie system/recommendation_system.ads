with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Recommendation_System is
   procedure Initialize;

   procedure Get_Recommendation
     (Genre    : in String;
      Duration : in String;
      Popularity : in String;
      Service  : in String);

   procedure Add_To_Watchlist (Movie_Title : in String);
   procedure Remove_From_Watchlist (Movie_Title : in String);
   procedure Display_Watchlist;
   procedure Search_Movie (Movie_Title : in String);
   procedure Random_Movie;
   function Fetch_From_API (URL : in String) return Unbounded_String;

end Recommendation_System;
