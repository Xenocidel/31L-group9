LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE IEEE.NUMERIC_STD.ALL;

ENTITY regfile IS

GENERIC ( NBIT : INTEGER := 32;
NSEL : INTEGER := 6);

PORT (
reg_en: IN std_logic;
clk : IN std_logic ;
rst_s : IN std_logic ; -- synchronous reset
we : IN std_logic ; -- write enable
raddr_1 : IN std_logic_vector (NSEL -1 DOWNTO 0); --from controller rs
raddr_2 : IN std_logic_vector (NSEL -1 DOWNTO 0); --from controller rt
waddr : IN std_logic_vector (NSEL -1 DOWNTO 0); -- from controller rd
rdata_1 : OUT std_logic_vector (NBIT -1 DOWNTO 0); --to ALU data_reg
rdata_2 : OUT std_logic_vector (NBIT -1 DOWNTO 0); --to mux input(1)
wdata : IN std_logic_vector (NBIT -1 DOWNTO 0) --from ALU data_out
);

END regfile ;

ARCHITECTURE Behavioral OF regfile IS

	SUBTYPE selRange IS INTEGER RANGE 0 TO INTEGER'HIGH;  
	SIGNAL read_index1, read_index2, w_index: selRange;
	SUBTYPE vector IS STD_LOGIC_VECTOR (NBIT -1 DOWNTO 0);
	TYPE matrix IS ARRAY (2**NSEL-1 DOWNTO 0) OF vector; 
	SIGNAL regN: matrix := ((others =>(others => '0'))); 
	
BEGIN 
	
	read_index1 <= to_integer(unsigned(raddr_1));
	read_index2 <= to_integer(unsigned(raddr_2));
	w_index <= to_integer(unsigned(waddr));
	
	PROCESS (clk)
	
	
	BEGIN
	IF (clk'EVENT AND clk = '1' and reg_en = '1') THEN
	IF (rst_s = '1') THEN
		L_reset: FOR i IN 0 TO 2**NSEL-1 LOOP
			regN(i) <= (OTHERS => '0');
		END LOOP L_reset; 
	ELSE
		rdata_1 <= regN(read_index1);
		rdata_2 <= regN(read_index2); 
		
		IF (we = '1') THEN
			regN(w_index) <= wdata;
		
		END IF;
	END IF; 	
END IF; 
	END PROCESS;


END Behavioral;
