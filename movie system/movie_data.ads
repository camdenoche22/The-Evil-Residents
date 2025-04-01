with Ada.Text_IO;        use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNATCOLL.HTTP;      use GNATCOLL.HTTP;
with GNATCOLL.JSON;      use GNATCOLL.JSON;

package Movie_Data is

   function Find_Movie (Genre : in String; Duration : in String; Popularity : in String; Service : in String) return String;
   procedure Add_Movie_To_Watchlist (Movie : in String);
   procedure Remove_Movie_From_Watchlist (Movie : in String);
   procedure Display_Watchlist;

end Movie_Data;
