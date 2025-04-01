with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random;

package body Movie_Data is

   type Movie_Type is record
      Title     : String (1 .. 50);
      Genre     : String (1 .. 20);
      Duration  : String (1 .. 10);  -- e.g., "Short", "Medium", "Long"
      Popularity: String (1 .. 10);  -- e.g., "High", "Medium", "Low"
      Service   : String (1 .. 20);  -- e.g., "Netflix", "Disney+", etc.
   end record;

   Movies : constant array (1 .. 5) of Movie_Type := (
      (Title => "The Dark Knight", Genre => "Action", Duration => "Long", Popularity => "High", Service => "Netflix"),
      (Title => "Superbad", Genre => "Comedy", Duration => "Medium", Popularity => "Medium", Service => "Hulu"),
      (Title => "Shawshank Redemption", Genre => "Drama", Duration => "Long", Popularity => "High", Service => "HBO Max"),
      (Title => "The Conjuring", Genre => "Horror", Duration => "Medium", Popularity => "High", Service => "Amazon Prime"),
      (Title => "Interstellar", Genre => "Sci-Fi", Duration => "Long", Popularity => "High", Service => "Netflix")
   );

   Watchlist : array (1 .. 100) of String (1 .. 50);
   Watchlist_Count : Natural := 0;

   function Find_Movie (Genre, Duration, Popularity, Service : in String) return String is
   begin
      for M of Movies loop
         if M.Genre = Genre and M.Duration = Duration and M.Popularity = Popularity and M.Service = Service then
            return M.Title;
         end if;
      end loop;
      return "";
   end Find_Movie;

   function Find_Movie_By_Title (Title : in String) return String is
   begin
      for M of Movies loop
         if M.Title = Title then
            return M.Title;
         end if;
      end loop;
      return "";
   end Find_Movie_By_Title;

   procedure Add_Movie_To_Watchlist (Movie : in String) is
   begin
      if Watchlist_Count < 100 then
         Watchlist_Count := Watchlist_Count + 1;
         Watchlist(Watchlist_Count) := Movie;
      end if;
   end Add_Movie_To_Watchlist;

   procedure Remove_Movie_From_Watchlist (Movie : in String) is
      Removed : Boolean := False;
   begin
      for I in 1 .. Watchlist_Count loop
         if Watchlist(I) = Movie then
            for J in I .. Watchlist_Count - 1 loop
               Watchlist(J) := Watchlist(J + 1);
            end loop;
            Watchlist_Count := Watchlist_Count - 1;
            Removed := True;
            exit;
         end if;
      end loop;

      if not Removed then
         Put_Line("Movie not found in watchlist.");
      end if;
   end Remove_Movie_From_Watchlist;

   procedure Display_Watchlist is
   begin
      if Watchlist_Count = 0 then
         Put_Line("Watchlist is empty.");
      else
         for I in 1 .. Watchlist_Count loop
            Put_Line(Watchlist(I));
         end loop;
      end if;
   end Display_Watchlist;

   function Get_Random_Movie return String is
      Gen : Ada.Numerics.Float_Random.Generator;
      Index : Natural;
   begin
      Ada.Numerics.Float_Random.Reset(Gen);
      Index := Natural (Ada.Numerics.Float_Random.Random(Gen) * 5.0) + 1;
      return Movies(Index).Title;
   end Get_Random_Movie;

end Movie_Data;
