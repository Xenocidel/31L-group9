package Common is
	TYPE reg_to_array is array (2**NSEL-1 DOWNTO 0) of std_logic_vector(NBIT-1 DOWNTO 0);
end Common

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.Common.all;

ENTITY muxn1 IS
	GENERIC(NBIT: INTEGER :=32;
			NSEL: INTEGER :=3);
	PORT (
	input : IN reg_to_array;
	opsel : IN STD_LOGIC_VECTOR (NSEL-1 DOWNTO 0);
	Y : OUT std_logic_vector (NSEL-1 DOWNTO 0));
END muxn1;

ARCHITECTURE Structural OF muxn1 IS
	SIGNAL index : INTEGER;

BEGIN
	index <= to_integer(unsigned(opsel));
	Y <= (input(index));
END Structural;