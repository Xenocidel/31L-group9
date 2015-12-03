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
	
	type reg_to_array is array (2**NSEL-1 downto 0) of std_logic_vector(NBIT-1 downto 0); 
	SIGNAL regarray : reg_to_array;
	
	BEGIN
		PROCESS (clk)
		VARIABLE --Something here, I think it was a temporary variable used for writing
		BEGIN
			if (clk'EVENT AND clk='1' and rst_s='1') then
				for i in (2**NSEL-1 downto 0) loop
					regarray(i) <= (OTHERS=>'0')
				end loop;
			elsif clk'event and clk='1' then
				--Code
			end	if;
		end process;
	
END Structural;