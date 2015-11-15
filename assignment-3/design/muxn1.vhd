LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

GENERIC(NBIT: INTEGER :=32
		NSEL: INTEGER :=3);

ENTITY muxn1 IS
	PORT (
	input : IN std_logic_vector(NBIT-1 DOWNTO 0);
	opsel : IN STD_LOGIC_VECTOR (NSEL-1 DOWNTO 0);
	Y : OUT std_logic
	);
END mux81;

ARCHITECTURE Structural OF mux81 IS
	SIGNAL index : INTEGER;
BEGIN
	index <= to_integer(unsigned(opsel));
	Y <= (input(index));
END Structural;