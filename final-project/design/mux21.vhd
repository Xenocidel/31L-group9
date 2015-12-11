LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;

ENTITY mux21 IS
PORT (
mux_en: IN STD_LOGIC; 
D0 : IN std_logic_vector(31 DOWNTO 0) ;
D1 : IN std_logic_vector(31 DOWNTO 0);
A0 : IN std_logic ;
Y : OUT std_logic_vector(31 DOWNTO 0)
);
END mux21;
ARCHITECTURE DataFlow OF mux21 IS

BEGIN
	Y <= D0 WHEN A0 = '0' and mux_en = '1' ELSE
		 D1 WHEN A0 = '1' and mux_en = '1'; 
	--(NOT A0 AND D0) OR 
	--(A0 AND D1);
END DataFlow;

