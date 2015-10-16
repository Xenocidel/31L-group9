library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity mux4to1 IS
	PORT(
	in0:IN std_logic;
	in1:IN std_logic;
	in2:IN std_logic;
	in3:IN std_logic;
	sel0:IN std_logic;
	sel1:IN std_logic;
	f:OUT std_logic
	);
end mux4to1;

architecture lab1 of mux4to1 IS
begin
	f <= ((not(sel1) and not(sel0) and in0) or (not(sel1) and sel0 and in1) or (sel1 and not(sel0) and in2) or (sel1 and sel0 and in3));
end lab1;