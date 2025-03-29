with Ada.Text_IO; use Ada.Text_IO;

--movie api link with key
--https://api.themoviedb.org/3/discover/movie?api_key=8aa33db0c10eb1f9078288faaa6c015b
--apikey=8aa33db0c10eb1f9078288faaa6c015b
procedure Main is
   userGenre: String (1..100);
   userDuration: String (1..100);
   userPop: String (1..100);
   userService: String(1..100);
   Last: Natural;

begin
   loop
      Put_Line("------------------------------------------------");
      Put_Line("Welcome to the Movie Recommedation System!");
      Put("What genre are you interested in?: ");
      Get_Line(userGenre, Last);
      Put_Line("Entered: " & userGenre(1..Last));
      Put_Line("------------------------------------------------");
      exit;
   end loop;
end Main;
