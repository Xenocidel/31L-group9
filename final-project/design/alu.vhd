LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

GENERIC(DATA_WIDTH: INTEGER := 32);
		

ENTITY alu IS 
	PORT(
	clk: IN STD_LOGIC;
	data_reg : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	data_mux : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	rst: IN STD_LOGIC;
	opsel : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	data_out: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	equal: OUT STD_LOGIC;
	carry: OUT STD_LOGIC;
	overflow : OUT STD_LOGIC );
	END alu;
	
ARCHITECTURE Structural OF alu IS
	
	PROCESS (clk, rst)
		VARIABLE tmp : INTEGER RANGE -2**(DATA_WIDTH+1) to 2**(DATA_WIDTH+1);
		BEGIN
			IF clk'EVENT and clk = '1' and rst = '1' THEN --rst 1 means on
				data_out <= (OTHERS => '0');
				equal <= '0';
				carry <= '0';
				overflow <= '0';
				CASE opsel IS
					WHEN "0000" => --nothing
					WHEN "0001" => --add reg and mux/immediate
						tmp := to_integer(signed(data_reg) + signed(data_mux));
						IF tmp >= 2**DATA_WIDTH THEN
							overflow <= '1';
							carry <= '1';
							data_out <= (OTHERS => '0');
						ELSE
							data_out <= std_logic_vector(signed(data_reg) + signed(data_mux));
						END IF
					WHEN "0010" => --subtract reg and mux/immediate
						tmp := to_integer(signed(data_reg) - signed(data_mux));
						IF tmp < -2**DATA_WIDTH THEN
							overflow <= '1';
							carry <= '1';
							data_out <= (OTHERS => '0');
						ELSE
							data_out <= std_logic_vector(signed(data_reg) - signed(data_mux));
						END IF
					WHEN "0011" => --compare reg and mux/immediate
						IF signed(data_reg = data_mux THEN
							equal <= '1';
						ELSIF 
							carry <= '1'; --if reg > mux, then carry = 1. if mux < reg, then both equal and carry = 0.
						END IF
					WHEN "0101" => --AND reg and mux/immediate
					
					WHEN "0110" => --OR reg and mux/immediate
					
					WHEN "0111" => --NOT reg
					
					WHEN "1000" => --XOR reg and mux/immediate
					
					WHEN "1001" => --SLL reg mux/immediate number of places
					
					WHEN "1011" => --MOV reg/immediate to out
			END IF
	END PROCESS
END Structural;
