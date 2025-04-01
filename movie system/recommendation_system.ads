with Ada.Text_IO;        use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Streams.Stream_IO;
with GNATCOLL.HTTP;      use GNATCOLL.HTTP;

package body Recommendation_System is

   Watchlist : array (1 .. 100) of String := (others => "");
   Watchlist_Size : Natural := 0;

   procedure Initialize is
   begin
      Watchlist_Size := 0;
      Put_Line("Recommendation System Initialized.");
   end Initialize;

   procedure Add_To_Watchlist (Movie_Title : in String) is
   begin
      if Watchlist_Size < Watchlist'Length then
         Watchlist_Size := Watchlist_Size + 1;
         Watchlist(Watchlist_Size) := Movie_Title;
         Put_Line("Added to watchlist: " & Movie_Title);
      else
         Put_Line("Watchlist is full!");
      end if;
   end Add_To_Watchlist;

   procedure Remove_From_Watchlist (Movie_Title : in String) is
      Index : Natural := 0;
   begin
      for I in 1 .. Watchlist_Size loop
         if Watchlist(I) = Movie_Title then
            Index := I;
            exit;
         end if;
      end loop;

      if Index > 0 then
         for J in Index .. Watchlist_Size - 1 loop
            Watchlist(J) := Watchlist(J + 1);
         end loop;
         Watchlist_Size := Watchlist_Size - 1;
         Put_Line("Removed from watchlist: " & Movie_Title);
      else
         Put_Line("Movie not found in watchlist.");
      end if;
   end Remove_From_Watchlist;

   procedure Display_Watchlist is
   begin
      Put_Line("Your Watchlist:");
      for I in 1 .. Watchlist_Size loop
         Put_Line(Watchlist(I));
      end loop;
   end Display_Watchlist;

   function Fetch_From_API (URL : in String) return Unbounded_String is
      Response : GNATCOLL.HTTP.Response;
      API_Result : Unbounded_String := Null_Unbounded_String;
   begin
      Response := GNATCOLL.HTTP.Get (URL);
      if Response.Status_Code = 200 then
         API_Result := To_Unbounded_String (Response.Content);
         Put_Line("API Fetch Successful!");
      else
         Put_Line("API Fetch Failed. Status Code: " & Integer'Image(Response.Status_Code));
      end if;

      return API_Result;
   end Fetch_From_API;

   procedure Get_Recommendation
     (Genre : in String; Duration : in String; Popularity : in String; Service : in String) is
      API_URL : constant String :=
        "https://api.themoviedb.org/3/discover/movie?api_key=8aa33db0c10eb1f9078288faaa6c015b"
        & "&with_genres=" & Genre
        & "&sort_by=popularity.desc"
        & "&language=en-US";
      Response : Unbounded_String;
   begin
      Response := Fetch_From_API (API_URL);
      Put_Line("Recommendation Fetch Complete: " & To_String(Response));
   end Get_Recommendation;

   procedure Search_Movie (Movie_Title : in String) is
   begin
      Put_Line("Search functionality is not yet implemented.");
   end Search_Movie;

   procedure Random_Movie is
   begin
      Put_Line("Random movie generation is not yet implemented.");
   end Random_Movie;

end Recommendation_System;
