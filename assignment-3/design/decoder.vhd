LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity decoder IS
	GENERIC (NSEL: INTEGER :=3);
	PORT(
		input:IN std_logic_vector(NSEL-1 DOWNTO 0);
		output:OUT std_logic_vector(2**NSEL-1 DOWNTO 0)
	);
end decoder;

architecture Structural of decoder IS
	SIGNAL index : INTEGER;
begin
	index <= to_integer(unsigned(input));
	output <= (OTHERS=>'0');
	output(index) <= '1';
end Structural;
