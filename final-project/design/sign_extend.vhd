LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE IEEE.std_logic_arith.ALL;

ENTITY sign_extend is
	PORT(
		rst: IN std_logic;
		input: IN std_logic_vector(15 downto 0);
		output: OUT std_logic_vector(31 downto 0)
		);
END sign_extend;

ARCHITECTURE Structural of sign_extend is
BEGIN
	output <= (others => '0') WHEN rst='1' ELSE
			  (SXT(input, 32));

END Structural