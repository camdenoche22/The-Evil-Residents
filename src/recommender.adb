with Ada.Text_IO;
with Movie_DB;
with Ada.Integer_Text_IO;

package body Recommender is

   procedure Run is
      Choice : Integer;
   begin
      Movie_DB.Load_Database;
      
      loop
         Ada.Text_IO.Put_Line("Smart Media Recommender");
         Ada.Text_IO.Put_Line("1. Recommend by Genre");
         Ada.Text_IO.Put_Line("2. Recommend by Duration");
         Ada.Text_IO.Put_Line("3. Recommend by Platform");
         Ada.Text_IO.Put_Line("4. Recommend by Popularity");
         Ada.Text_IO.Put_Line("5. Random Recommendation");
         Ada.Text_IO.Put_Line("6. Exit");
         Ada.Text_IO.Put("Choose an option: ");
         Ada.Integer_Text_IO.Get(Choice);

         case Choice is
            when 1 => Movie_DB.Recommend_By_Genre;
            when 2 => Movie_DB.Recommend_By_Duration;
            when 3 => Movie_DB.Recommend_By_Platform;
            when 4 => Movie_DB.Recommend_By_Popularity;
            when 5 => Movie_DB.Random_Movie;
            when 6 => exit;
            when others => Ada.Text_IO.Put_Line("Invalid option. Try again.");
         end case;
      end loop;
   end Run;

end Recommender;
