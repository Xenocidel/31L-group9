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
	
	SIGNAL tmp: std_logic := 0;
	
	process(clk, rst_s)
		--if rst_s is 1
		--	set dout to 0
		--else proceed to increment
		--	if tmp is 0
		--		if preload is 0
		--			set din to 0
		--		if asc is 1
		--			set dout to step
		--		else
		--			use addsub to set dout to din-step
		--	else
		--		if asc is 1
		--			use addsub to set dout to din+step
		--		if asc is 0
		--			use addsub to set dout to din-step
		--set tmp to 1
	
END Structural;