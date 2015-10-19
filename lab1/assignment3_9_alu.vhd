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
	cin <=  '1' WHEN opsel = "100" OR opsel = "110" OR opsel = "011" ELSE
			'0';
			
	ALUXBASE : ALU_1bit port map(A(0), B(0), mode, cin, opsel, output1(0), coutbuff(0));
	
	G1: FOR i IN 1 TO 31 GENERATE
		
		ALUX: ALU_1bit port map(A(i), B(i), mode, coutbuff(i-1), opsel, output1(i), coutbuff(i));
	END GENERATE G1;
	
	cout <= coutbuff(31);	
END Structural;
