LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

GENERIC (ADDR_WIDTH: INTEGER := 6;--64 addresses possible
		 DATA_WIDTH: INTEGER := 32);

ENTITY dma is
	PORT(
		clk: IN STD_LOGIC;
		rst: IN STD_LOGIC;
		req: IN STD_LOGIC;
		addr: IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
		data: IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		ack: OUT STD_LOGIC;
		addr_o: OUT STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
		data_o: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
		);
END dma;

ARCHITECTURE dma of dma is
	BEGIN--hard coded to take in one main memory. an actual dma may have an array of addr and data ins and will need to check if bus_used.
	PROCESS (clk, rst)
		VARIABLE bus_used: std_logic;
		BEGIN
			IF rst='1' THEN--off when reset is 0
				IF clk'EVENT and clk='1' and req='1' THEN
					ack <= '1';--main memory will send data once acknowledge signal is received
					bus_used := '1';
					addr_o <= addr;--forward addr and data to instruction memory
					data_o <= data;
				ELSIF clk'EVENT and clk='1' and req='0' THEN
					ack <= '0';
					bus_used := '0';
				END IF;
			END IF;
	END PROCESS;

END dma