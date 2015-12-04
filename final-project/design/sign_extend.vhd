LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY sign_extend is
	PORT(
		rst: IN std_logic;
		input: IN std_logic_vector(15 downto 0);
		output: OUT std_logic_vector(31 downto 0)
		);
END sign_extend;

ARCHITECTURE Structural of sign_extend is
BEGIN
	output <= ("000000000000000000" & input(15 downto 0)) WHEN rst='0' and input(in_bits-1)='0' ELSE
			  (others => "1111111111111111111" & input(15 downto 0)) WHEN rst='0' and input(in_bits-1)='1' ELSE
			  (others => '0') WHEN rst='1';

END Structural