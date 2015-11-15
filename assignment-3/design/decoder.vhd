library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

GENERIC (NBIT: INTEGER :=32
		 NSEL: INTEGER :=3);

entity decoder IS
	PORT(
	input:IN std_logic_vector(NSEL-1 DOWNTO 0);
	output:OUT std_logic_vector(NBIT-1 DOWNTO 0);
	);
end decoder;

architecture Structural of encoder IS
	SIGNAL index : INTEGER;
begin
	index <= to_integer(unsigned(input));
	output <= (index=>'1', OTHERS=>'0');
end Structural;
