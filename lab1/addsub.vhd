library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity addsub IS
	PORT(
	addsub:IN std_logic;
	in0:IN std_logic;
	in1:IN std_logic;
	cin:IN std_logic;
	sum:OUT std_logic;
	cout:OUT std_logic
	);
end addsub;

architecture lab1 of addsub IS


begin 
	sum <= in0 XOR (in1 XOR addsub) XOR cin; 
	cout <= (in0 AND (in1 XOR addsub)) OR (cin AND (in0 XOR (in1 XOR addsub)));
end lab1;