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
		PROCESS (clk, rst_a)
		VARIABLE temp: std_logic_vector(NBIT-1 downto 0); 
		BEGIN
			if rst_a='1' then
				dout <= OTHERS=>'0';
			elsif clk'event and clk='1' then
				if rst_s='1' then
					dout <= OTHERS=>'0';
				elsif inc='1' and we='1' then
					temp:=dout+'1';
					dout <= temp;
				elsif we='1' then
					dout <= din;
				end if
			end	if
	
END Structural;