with Ada.Text_I0; use Ada.Text_I0;
with Ada.Float_Text_I0; use Ada.Float_Text_I0;
with Ada.Interger_Text_I0; use Ada.Interger_Text_I0;

procedure Data_Types_Showcase is

Num_Int     : Integer := 42;
Price       : Float := 19.99;
Greeting    : String := "Hello, Ada!";
Is_Ada_Awesome : Boolean := True;

begin

Put_Line("Integer Operations:");
Put("Original Integer: ");
Put(Num_Int);
New_Line;

Num_Int := Num_Int + 10;
Put_Line("After addition (+10): " & Integer'Imagine(Num_Int));

Num_Int := Num_Int * 2;
Put_Line("After multiplication (*2): " & Integer'Image(Num_Int));
New_Line;

Put_Line("Flaot Operation:");
Put("Original Float: ");
Put(Price);
New_Line;

Price := Price + 5.5;
Put_Line("After addition (+5.5): " & Float'Image(Price));

Price := Price / 2.0;
Put_Line("After division (/2): " & Float'Image(Price));
New_Line;

Put_Line("String Operations:");
Put_Line("Original String: " & Greeting);

Greeting := Greeting & " Let's code!";
Put_Line("After concatenation: " & Greeting);

Put_Line("Substring (slice 1 to 5): " & Greeting(1..5));
New_Line;

Put_Line("Boolean Operation:");
Put_Line("Original Boolean: " & Boolean'Image(Is_Ada_Awesome));

Is_Ada_Awesome := not Is_Ada_Awesome;
Put_Line("After NOT operation: " & Boolean'Image(Is_Ada_Awesome));

Put_Line("Boolean AND (True and Is_Ada_Awesome); " & Boolean'Image(True and Is_Ada_Awesome));

end Data_Types_Showcase; 

