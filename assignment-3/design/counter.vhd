LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter IS
	GENERIC (NBIT: INTEGER := 32;
				STEP: INTEGER := 1);
	PORT(
				clk : IN STD_LOGIC;
				rst_s : IN STD_LOGIC;
				asc : IN STD_LOGIC;
				preload : IN STD_LOGIC;
				din : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
				dout : OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0)
	);
END counter;

ARCHITECTURE behavior OF counter IS
BEGIN
		PROCESS(clk, rst_s, asc, preload)
			VARIABLE temp: STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
		BEGIN
			IF (clk'EVENT AND clk = '1') THEN
				IF (rst_s = '1')												
					temp := (OTHERS => '0');									--Reset the counter
				ELSIF (preload = '1') THEN										
					temp := din;												--Load din into counter register
				ELSIF (asc = '1') THEN											
					temp := std_logic_vector( to_integer(unsigned(temp)) + STEP);				--Count up
				ELSIF (asc = '0') THEN											
					temp := std_logic_vector( to_integer(unsigned(temp)) - STEP);				--Count down
				END IF;
			END IF;
			dout <= temp;
		END PROCESS;
END behavior;		