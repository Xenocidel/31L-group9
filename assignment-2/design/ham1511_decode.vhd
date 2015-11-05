LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE ieee.numeric_std.ALL; 

ENTITY ham1511_decode IS

  PORT(
         data_in : IN STD_LOGIC_VECTOR (15 DOWNTO 1);
   	     data_out : OUT STD_LOGIC_VECTOR (11 DOWNTO 1)
	  );
END ham1511_decode;

ARCHITECTURE Structural OF ham1511_decode IS
	SIGNAL p1, p2, p3, p4: STD_LOGIC;
	SIGNAL data_temp: STD_LOGIC_VECTOR (15 DOWNTO 1);
	SIGNAL syndrome: STD_LOGIC_VECTOR(4 DOWNTO 1); 
	
	BEGIN
	p1 <= data_in(1) XOR
		  data_in(3) XOR
		  data_in(5) XOR
		  data_in(7) XOR
		  data_in(9) XOR
		  data_in(11) XOR
		  data_in(13) XOR
		  data_in(15);
	p2 <= data_in(2) XOR
		  data_in(3) XOR
		  data_in(6) XOR
		  data_in(7) XOR
		  data_in(10) XOR
		  data_in(11) XOR
		  data_in(14) XOR
		  data_in(15);
	p3 <= data_in(4) XOR
		  data_in(5) XOR
		  data_in(6) XOR
		  data_in(7) XOR
		  data_in(12) XOR
		  data_in(13) XOR
		  data_in(14) XOR
		  data_in(15);
	p4 <= data_in(8) XOR
		  data_in(9) XOR
		  data_in(10) XOR
		  data_in(11) XOR
		  data_in(12) XOR
		  data_in(13) XOR
		  data_in(14) XOR
		  data_in(15);
	syndrome <= p4 & p3 & p2 & p1;
	--err_loc <= to_integer(unsigned(syndrome));


	data_temp <= data_in(15 DOWNTO 1) WHEN syndrome = "0000" OR syndrome = "0001" OR syndrome = "0010" OR syndrome = "0100" OR syndrome = "1000" ELSE
				not(data_in(15)) & data_in (14 DOWNTO 1) WHEN syndrome = "1111" ELSE
				data_in(15) & not(data_in(14)) & data_in(13 DOWNTO 1) WHEN syndrome = "1110" ELSE
				data_in(15 DOWNTO 14) & not(data_in(13)) & data_in(12 DOWNTO 1) WHEN syndrome = "1101" ELSE
				data_in(15 DOWNTO 13) & not(data_in(12)) & data_in(11 DOWNTO 1) WHEN syndrome = "1100" ELSE
				data_in(15 DOWNTO 12) & not(data_in(11)) & data_in(10 DOWNTO 1) WHEN syndrome = "1011" ELSE
				data_in(15 DOWNTO 11) & not(data_in(10)) & data_in(9 DOWNTO 1) WHEN syndrome = "1010" ELSE
				data_in(15 DOWNTO 10) & not(data_in(9)) & data_in(8 DOWNTO 1) WHEN syndrome = "1001" ELSE
				data_in(15 DOWNTO 8) & not(data_in(7)) & data_in(6 DOWNTO 1) WHEN syndrome = "0111" ELSE
				data_in(15 DOWNTO 7) & not(data_in(6)) & data_in(5 DOWNTO 1) WHEN syndrome = "0110" ELSE
				data_in(15 DOWNTO 6) & not(data_in(5)) & data_in(4 DOWNTO 1) WHEN syndrome = "0101" ELSE
				data_in(15 DOWNTO 4) & not(data_in(3)) & data_in(2 DOWNTO 1) WHEN syndrome = "0011";
	
	data_out <= data_temp(15 DOWNTO 9) & data_temp(7 DOWNTO 5) & data_temp(3); 
	
END Structural; 			