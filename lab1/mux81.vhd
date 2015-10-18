LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;

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
A0 : IN std_logic ;
A1 : IN std_logic ;
A2 : IN std_logic;
Y : OUT std_logic
);
END mux81;
ARCHITECTURE DataFlow OF mux81 IS

BEGIN
	Y <= (NOT A0 AND NOT A1 AND NOT A2 AND D0) OR 
	(NOT A0 AND NOT A1 AND A2 AND D1) OR 
	(NOT A0 AND A1 AND NOT A2 AND D2) OR 
	(NOT A0 AND A1 AND A2 AND D3) OR
	(A0 AND NOT A1 AND NOT A2 AND D0) OR 
	(A0 AND NOT A1 AND A2 AND D1) OR 
	(A0 AND A1 AND NOT A2 AND D2) OR 
	(A0 AND A1 AND A2 AND D3);
END DataFlow;