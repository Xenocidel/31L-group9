LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY counter IS
	GENERIC(NBIT : INTEGER := 32;
			STEP : INTEGER := 1);
	PORT (
		clk : IN std_logic ;
		rst_s : IN std_logic ; -- synchronous reset
		asc : IN std_logic ; -- ascending (if it is ’0’, count descending )
		preload : IN std_logic ; -- read din as the counting seed
		din : IN std_logic_vector (NBIT -1 downto 0);
		dout : OUT std_logic_vector (NBIT -1 downto 0)
		);
END counter ;

ARCHITECTURE Structural OF counter IS
	
	BEGIN
	
END Structural;