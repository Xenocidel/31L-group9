LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

GENERIC(DATA_WIDTH: INTEGER := 32);
		

ENTITY alu IS 
	PORT(
	clk: IN STD_LOGIC;
	data_reg : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	data_mux : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	rst: IN STD_LOGIC;
	reg_imm: IN STD_LOGIC;
	opsel : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	data_out: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	equal: OUT STD_LOGIC;
	carry: OUT STD_LOGIC;
	overflow : OUT STD_LOGIC );
	END alu;
	
ARCHITECTURE Structural OF alu IS
	
	PROCESS (clk, rst)
		VARIABLE tmp : INTEGER;
		VARIABLE tmp2 : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		BEGIN
			IF clk'EVENT and clk = '1' and rst = '0' THEN --rst 1 means on
				data_out <= (OTHERS => '0');
				equal <= '0';
				carry <= '0';
				overflow <= '0';
				CASE opsel IS
					WHEN "0000" => --nothing
					WHEN "0001" => --add reg and mux/immediate
						tmp := to_integer(signed(data_reg)) + to_integer(signed(data_mux));
						IF tmp >= (2**DATA_WIDTH-1) THEN		--max value of a signed vector with DATA_WIDTH bits
							overflow <= '1';
							carry <= '1';
							data_out <= (OTHERS => '0');
						ELSIF tmp < -(2**DATA_WIDTH-1) THEN		--min value of a signed vector with DATA_WIDTH bits
							overflow <= '1';
							carry <= '1';
							data_out <= (OTHERS => '0');	
						ELSE
							data_out <= std_logic_vector(signed(data_reg) + signed(data_mux));
						END IF
					WHEN "0010" => --subtract reg and mux/immediate
						tmp := to_integer(signed(data_reg)) - to_integer(signed(data_mux));
						IF tmp >= (2**DATA_WIDTH-1) THEN		--same conditions as addition
							overflow <= '1';
							carry <= '1';
							data_out <= (OTHERS => '0');
						ELSIF tmp < -(2**DATA_WIDTH-1) THEN		
							overflow <= '1';
							carry <= '1';
							data_out <= (OTHERS => '0');	
						ELSE
							data_out <= std_logic_vector(signed(data_reg) - signed(data_mux));
						END IF
					WHEN "0011" => 								--compare reg and mux/immediate
						IF signed(data_reg = data_mux) THEN
							equal <= '1';
						ELSIF signed(data_reg > data_mux) THEN
							carry <= '1'; 						--if reg > mux, then carry = 1 if mux < reg, then both equal and carry = 0.
						END IF
					WHEN "0101" => --AND reg and mux/immediate
						data_out <= data_reg AND data_mux;
					WHEN "0110" => --OR reg and mux/immediate
						data_out <= data_reg OR data_mux;
					WHEN "0111" => --NOT reg
						data_out <= NOT data_reg;
					WHEN "1000" => --XOR reg and mux/immediate
						data_out <= data_reg XOR data_mux;
					WHEN "1001" => --SLL reg mux/immediate number of places
						tmp := to_integer(signed(data_mux));
						tmp2 := data_reg;
						IF tmp > 0 THEN
							tmp2(0) := data_reg;
							L1: FOR i IN 1 TO tmp LOOP			--shift by tmp to the left
								tmp2(i) := tmp2(i-1)(DATA_WIDTH-2 DOWNTO 0) & '0';
								END LOOP L1;
							data_out <= tmp2(tmp);	
						ELSIF tmp < 0 THEN
							tmp2(tmp-1) := data_reg;
							L2: FOR i IN tmp TO -1 LOOP			--shift by tmp to the right
								tmp2(i) := '0' & tmp2(i-1)(DATA_WIDTH-1 DOWNTO 1);
								END LOOP L2;
							data_out <= tmp2(-1);
						ELSE
							data_out <= tmp2;
						END IF
					WHEN "1011" => --MOV reg/immediate to out
						IF reg_imm = '0' THEN					--reg_imm checks if register or immediate instruction
							data_out <= data_reg;
						ELSIF reg_imm = '1' THEN
							data_out <= data_mux;
						END IF	
				END CASE		
			END IF
	END PROCESS
END Structural;
