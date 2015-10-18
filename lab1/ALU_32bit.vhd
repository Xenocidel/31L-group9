LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
ENTITY alu_32bit IS 
	PORT(
	A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	opsel : IN STD_LOGIC_VECTOR(2 DOWNTO 0); mode : IN STD_LOGIC;
	output1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	cout : OUT STD_LOGIC );
	END alu_32bit;
	
ARCHITECTURE Structural OF alu_32bit IS
	COMPONENT ALU_1bit
		PORT(A, B, mode, cin : IN STD_LOGIC; opsel : IN STD_LOGIC_VECTOR; output1, cout: OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL cin, optype : STD_LOGIC;
	SIGNAL coutbuff: STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	cin <=  NOT A(0) AND B(0) WHEN opsel = "001" ELSE
			'1' WHEN opsel = "100" OR opsel = "110" ELSE
			'0';
			
	optype <= '0' WHEN opsel = "000" or opsel = "100" or opsel = "110" ELSE
				'1';
	G1: FOR i IN 0 TO 31 GENERATE
		ALUX: ALU_1bit port map(A(i), B(i), mode, cin, opsel, output1(i), coutbuff(i));
		cin <= coutbuff(i); 
	END GENERATE G1;
	cout <= coutbuff(31); 
END Structural;
