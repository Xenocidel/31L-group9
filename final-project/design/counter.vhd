LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter IS
	GENERIC (NBIT: INTEGER := 32;
				STEP: INTEGER := 4);
	PORT(
				clk : IN STD_LOGIC;
				rst_a : IN STD_LOGIC;
				preload : IN STD_LOGIC;
				din : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
				dout : OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0)
	);
END counter;

ARCHITECTURE Behavioral OF counter IS
BEGIN
		PROCESS(clk, rst_a)
			VARIABLE temp: STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
		BEGIN
			IF (rst_a = '1') THEN												
					temp := (OTHERS => '0');--Reset the counter. Used when instruction memory is refreshed.
			END IF
			IF (clk'EVENT AND clk = '1') THEN
				IF (preload = '1') THEN										
					temp := din;--Load din into counter register. Used for jump/branch statements.
				ELSE											
					temp := std_logic_vector((unsigned(temp)) + to_unsigned(STEP, NBIT));--Point to next instruction by counting up 4 bytes
				END IF
			END IF;
			dout <= temp;
		END PROCESS;
END Behavioral;		