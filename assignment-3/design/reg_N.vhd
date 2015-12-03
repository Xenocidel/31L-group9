LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg_N IS

GENERIC ( NBIT : INTEGER :=32);

PORT (
clk : IN std_logic ;
rst_a : IN std_logic ; -- asynchronous reset
rst_s : IN std_logic ; -- synchronous reset
inc : IN std_logic ; -- increment
we : IN std_logic ; -- write enable
din : IN std_logic_vector (NBIT -1 downto 0); -- input data
dout : OUT std_logic_vector (NBIT -1 downto 0) -- output data
);

END reg_N;

ARCHITECTURE Behavioral OF reg_N IS


SIGNAL dhold : std_logic_vector(NBIT - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

	PROCESS(clk, rst_a)
	BEGIN
		IF (rst_a = '1') THEN
			dout <= (OTHERS => '0');
			dhold <= (OTHERS => '0');
		ELSIF (clk'EVENT AND clk = '1') THEN
			IF (rst_s = '1') THEN
				dout <= (OTHERS => '0');
				dhold <= (OTHERS => '0');
			ELSIF (we = '1' AND inc = '0') THEN
					dout <= din;
					dhold <= din;
			ELSIF (we = '1' AND inc = '1') THEN
				dout <= std_logic_vector(unsigned(din) + 1);
				dhold <= std_logic_vector(unsigned(din) + 1);
			ELSIF (we = '0' AND inc = '1') THEN
				dout <= std_logic_vector(unsigned(dhold) +1);
				dhold <= std_logic_vector(unsigned(dhold) +1);
			ELSE
				dout <= dhold; 
			END IF;
		END IF;
	END PROCESS;

END Behavioral; 
 
