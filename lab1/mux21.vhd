LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;

ENTITY mux21 IS
PORT (
D0 : IN std_logic ;
D1 : IN std_logic ;
A0 : IN std_logic ;
Y : OUT std_logic
);
END mux21;
ARCHITECTURE DataFlow OF mux21 IS

BEGIN
	Y <= D0 WHEN A0 = '0' ELSE
		 D1 WHEN A0 = '1'; 
	--(NOT A0 AND D0) OR 
	--(A0 AND D1);
END DataFlow;

