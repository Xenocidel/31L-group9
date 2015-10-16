LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY alu_32bit IS 
	PORT(
	A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	opsel : IN STD_LOGIC_VECTOR(2 DOWNTO 0); mode : IN STD_LOGIC;
	output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	cout : OUT STD_LOGIC );
	END alu_32bit;
	
ARCHITECTURE Structural OF alu_32bit IS
	SIGNAL m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12: STD_LOGIC;
BEGIN
	--Minterms here
END Structural;
