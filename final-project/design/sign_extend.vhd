LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE IEEE.NUMERIC_STD.ALL;

ENTITY sign_extend is
	PORT(
		sign_en : IN std_logic;
		rst: IN std_logic;
		input: IN std_logic_vector(14 downto 0); --from regfile
		output: OUT std_logic_vector(31 downto 0) --to muxn1
		);
END sign_extend;

ARCHITECTURE Structural of sign_extend is
BEGIN
	output <= std_logic_vector(resize(signed(input), 32)) WHEN rst='0' and sign_en = '1';

END Structural;