LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY regfile IS
	GENERIC(NBIT : INTEGER := 32;
			NSEL : INTEGER := 3);
	PORT (
		clk : IN std_logic ;
		rst_s : IN std_logic ; -- synchronous reset
		we : IN std_logic ; -- write enable
		raddr_1 : IN std_logic_vector (NSEL -1 DOWNTO 0); -- read address 1
		raddr_2 : IN std_logic_vector (NSEL -1 DOWNTO 0); -- read address 2
		waddr : IN std_logic_vector (NSEL -1 DOWNTO 0); -- write address
		rdata_1 : OUT std_logic_vector (NBIT -1 DOWNTO 0); -- read data 1
		rdata_2 : OUT std_logic_vector (NBIT -1 DOWNTO 0); -- read data 2
		wdata : IN std_logic_vector (NBIT -1 DOWNTO 0) -- write data 1
		);
END regfile ;

ARCHITECTURE Structural OF regfile IS
	
	SIGNAL dec_out : std_logic_vector(2**NSEL-1 downto 0);
	type reg_to_array is array (2**NSEL-1 downto 0) of std_logic_vector(NBIT-1 downto 0); 
	SIGNAL mux_in : reg_to_array;

	component reg
	port (clk, rst_a, rst_s, inc, we: IN std_logic ;
		din : IN std_logic_vector (NBIT -1 downto 0);
		dout : OUT std_logic_vector (NBIT -1 downto 0));
	end component;
	
	component decoder
	port (input: IN std_logic_vector(NSEL-1 downto 0);
		  output: OUT std_logic_vector(2**NBIT-1 downto 0));
	end component
	
	BEGIN
	
	--Writing
	decode: decoder port map (waddr, dec_out);
	reg_array: FOR i in (2**NSEL-1 downto 0) GENERATE
		REG(i): reg port map (clk, '0', rst_s, dec_out(i) AND we, wdata, mux_in(i));
	end generate
	
	--Reading
	
	
END Structural;