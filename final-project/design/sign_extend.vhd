LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

GENERIC (in_bits: INTEGER := 15;
		 out_bits: INTEGER := 32);

ENTITY sign_extend is
	PORT(
		rst: IN std_logic;
		input: IN std_logic_vector(in_bits-1 downto 0);
		output: OUT std_logic_vector(out_bits-1 downto 0)
		);
END sign_extend;

ARCHITECTURE Structural of sign_extend is
BEGIN
	output <= (others => '0' & input(in_bits-1 downto 0)) WHEN rst='0' and input(in_bits-1)='0' ELSE
			  (others => '1' & input(in_bits-1 downto 0)) WHEN rst='0' and input(in_bits-1)='1' ELSE
			  (others => '0') WHEN rst='1';

END Structural