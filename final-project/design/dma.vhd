LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

GENERIC (ADDR_WIDTH: INTEGER := 32;
		 DATA_WIDTH: INTEGER := 32);

ENTITY dma is
	PORT(
		clk: IN STD_LOGIC;
		rst: IN STD_LOGIC;
		req: IN STD_LOGIC;
		addr: IN STD_LOGIC_VECTOR(ADDR_WIDTH DOWNTO 0);
		data: IN STD_LOGIC_VECTOR(DATA_WIDTH DOWNTO 0);
		ack: OUT STD_LOGIC;
		addr_o: OUT STD_LOGIC_VECTOR(ADDR_WIDTH DOWNTO 0);
		data_o: OUT STD_LOGIC_VECTOR(DATA_WIDTH DOWNTO 0)
		);
END dma;

ARCHITECTURE dma of dma is
	BEGIN
	PROCESS (clk, rst)
		VARIABLE bus_used: std_logic;
		BEGIN
			IF rst='1' THEN
				IF clk'EVENT and clk='1' and req='1' THEN
					ack <= '1';
					addr_o <= addr;
					data_o <= data;
				END IF
			END IF
	END PROCESS

END dma