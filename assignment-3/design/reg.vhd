LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY reg IS
	GENERIC ( NBIT : INTEGER :=32);
	PORT (
		clk : IN std_logic ;
		rst_a : IN std_logic ; -- asynchronous reset
		rst_s : IN std_logic ; -- synchronous reset
		inc : IN std_logic ; -- increment
		we : IN std_logic ; -- write enable
		din : IN std_logic_vector (NBIT -1 downto 0); -- input data
		dout : OUT std_logic_vector (NBIT -1 downto 0) -- output data
		);
END reg;

ARCHITECTURE Structural OF reg IS
	
	BEGIN
	
END Structural;