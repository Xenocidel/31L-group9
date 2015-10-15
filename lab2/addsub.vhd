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
	sum <= ((in1 and not in0 and not cin) or (not in1 and not in0 and cin) or (in 1 and in0 and cin) or (not in1 and in0 and not cin));
	cout <= ((not addsub and in1) or (not in1 and in0 and not cin) or (addsub and cin and in0) or (addsub and not in1 and cin));
end lab1;