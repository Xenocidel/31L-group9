LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY sign_extend is
	PORT(
		rst: IN std_logic;
		input: IN std_logic_vector(15 downto 0); --from regfile
		output: OUT std_logic_vector(31 downto 0) --to muxn1
		);
END sign_extend;

ARCHITECTURE Structural of sign_extend is
BEGIN
	output <= std_logic_vector(resize(signed(input), 32)) WHEN rst='0';

END Structural;