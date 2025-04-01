with Ada.Text_IO;        use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNATCOLL.HTTP;      use GNATCOLL.HTTP;
with GNATCOLL.JSON;      use GNATCOLL.JSON;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Movie_Data is

   Watchlist : array (1 .. 100) of String := (others => "");
   Watchlist_Size : Natural := 0;

   function Get_API_Response (URL : String) return String is
      Response : String := "";
      Client   : HTTP.Client;
      Request  : HTTP.Request;
      Response_Body : HTTP.Response;
   begin
      Request.Set_URL (URL);
      Client.Send_Request (Request, Response_Body);
      Response := Response_Body.Body;
      return Response;
   end Get_API_Response;

   function Find_Movie (Genre : in String; Duration : in String; Popularity : in String; Service : in String) return String is
      API_URL : String := "https://api.themoviedb.org/3/discover/movie?api_key=8aa33db0c10eb1f9078288faaa6c015b";
      Response : String;
      JSON : JSON.Object;
      Movies : JSON.Array;
      Movie_Title : String := "";
   begin
      -- Build the query URL based on the user's preferences
      API_URL := API_URL & "&with_genres=" & Genre & "&with_runtime=" & Duration & "&sort_by=" & Popularity;

      -- Fetch API response
      Response := Get_API_Response(API_URL);
      
      -- Parse JSON response
      JSON := GNATCOLL.JSON.Parse (Response);
      Movies := JSON.Get_Array ("results");
      
      -- Check if there are any movies matching the criteria
      if Movies.Length > 0 then
         -- Get the first movie title
         Movie_Title := Movies.Get_Object (1).Get_String ("title");
      end if;

      return Movie_Title;
   end Find_Movie;

   procedure Add_Movie_To_Watchlist (Movie : in String) is
   begin
      if Watchlist_Size < 100 then
         Watchlist (Watchlist_Size + 1) := Movie;
         Watchlist_Size := Watchlist_Size + 1;
      else
         Put_Line ("Watchlist is full.");
      end if;
   end Add_Movie_To_Watchlist;

   procedure Remove_Movie_From_Watchlist (Movie : in String) is
   begin
      for Index in 1 .. Watchlist_Size loop
         if Watchlist (Index) = Movie then
            for I in Index .. Watchlist_Size - 1 loop
               Watchlist (I) := Watchlist (I + 1);
            end loop;
            Watchlist (Watchlist_Size) := "";
            Watchlist_Size := Watchlist_Size - 1;
            exit;
         end if;
      end loop;
   end Remove_Movie_From_Watchlist;

   procedure Display_Watchlist is
   begin
      Put_Line ("Your Watchlist:");
      for Index in 1 .. Watchlist_Size loop
         Put_Line (Watchlist (Index));
      end loop;
   end Display_Watchlist;

end Movie_Data;
