library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity sub_borrow IS
	PORT(
	in0:IN std_logic;
	in1:IN std_logic;
	cin:IN std_logic;
	diff:OUT std_logic;
	bout:OUT std_logic
	);
end sub_borrow;

architecture DataFlow of sub_borrow IS
begin
	diff<= ((in0 XOR in1)XOR cin);
	bout <= (NOT cin AND NOT in1 AND in0) OR (NOT cin AND in1 AND in0) OR (NOT cin AND in1 AND in0) OR (cin AND in0 AND in1);
end DataFlow;