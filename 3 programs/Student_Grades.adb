with Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Text_IO;
use Ada.Integer_Text_IO;

procedure Student_Grades is
   -- Define a record (struct) to store student data
   type Student is record
      Name  : String(1..20);
      Grade : Integer;
   end record;

   -- Define an array to hold multiple students
   type Student_Array is array (1..3) of Student;

   -- Declare an array of students
   Students : Student_Array := (
      (Name => "Alice               ", Grade => 85),
      (Name => "Bob                 ", Grade => 45),
      (Name => "Charlie             ", Grade => 72)
   );

begin
   -- Iterate over the student array using a for loop
   for I in Students'Range loop
      Put_Line("Student: " & Students(I).Name);
      Put("Grade: ");
      Put(Students(I).Grade, Width => 3);
      
      -- If-Else control structure to check pass/fail status
      if Students(I).Grade >= 50 then
         Put_Line(" - Passed");
      else
         Put_Line(" - Failed");
      end if;
   end loop;
end Student_Grades;
