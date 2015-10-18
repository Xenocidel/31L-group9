LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY mux81 IS
PORT (
D0 : IN std_logic ;
D1 : IN std_logic ;
D2 : IN std_logic ;
D3 : IN std_logic ;
D4 : IN std_logic;
D5 : IN std_logic;
D6 : IN std_logic;
D7 : IN std_logic;
opsel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--A0 : IN std_logic ;
--A1 : IN std_logic ;
--A2 : IN std_logic;
Y : OUT std_logic
);
END mux81;
ARCHITECTURE DataFlow OF mux81 IS

BEGIN
	Y <= D0 WHEN opsel = "000" ELSE
		 D1 WHEN opsel = "001" ELSE
		 D2 WHEN opsel = "010" ELSE
		 D3 WHEN opsel = "011" ELSE
		 D4 WHEN opsel = "100" ELSE
		 D5 WHEN opsel = "101" ELSE
		 D6 WHEN opsel = "110" ELSE
		 D7 WHEN opsel = "111";
	--(NOT A0 AND NOT A1 AND NOT A2 AND D0) OR 
	--(NOT A0 AND NOT A1 AND A2 AND D1) OR 
	--(NOT A0 AND A1 AND NOT A2 AND D2) OR 
	--(NOT A0 AND A1 AND A2 AND D3) OR
	--(A0 AND NOT A1 AND NOT A2 AND D0) OR 
	--(A0 AND NOT A1 AND A2 AND D1) OR 
	--(A0 AND A1 AND NOT A2 AND D2) OR 
	--(A0 AND A1 AND A2 AND D3);
END DataFlow;