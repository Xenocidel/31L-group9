LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY ham1511_encode IS

  PORT(
         data_in : IN STD_LOGIC_VECTOR (11 DOWNTO 1);
   	     data_out : OUT STD_LOGIC_VECTOR (15 DOWNTO 1)
	  );
END ham1511_encode;

ARCHITECTURE Structural OF ham1511_encode IS
	SIGNAL p1, p2, p3, p4: STD_LOGIC;
	BEGIN
	p1 <= data_in(1) XOR
		  data_in(2) XOR
		  data_in(4) XOR
		  data_in(5) XOR
		  data_in(7) XOR
		  data_in(9) XOR
		  data_in(11);
	p2 <= data_in(1) XOR
		  data_in(3) XOR
		  data_in(4) XOR
		  data_in(6) XOR
		  data_in(7) XOR
		  data_in(10) XOR
		  data_in(11);
	p3 <= data_in(2) XOR
		  data_in(3) XOR
		  data_in(4) XOR
		  data_in(8) XOR
		  data_in(9) XOR
		  data_in(10) XOR
		  data_in(11);
	p4 <= data_in(5) XOR
		  data_in(6) XOR
		  data_in(7) XOR
		  data_in(8) XOR
		  data_in(9) XOR
		  data_in(10) XOR
		  data_in(11);
	--data_out <= p1 & p2 & data_in(1) & p3 & data_in(4 DOWNTO 2) & p4 & data_in(11 DOWNTO 5);
	
	data_out <= data_in(11 DOWNTO 5) & p4 & data_in(4 DOWNTO 2) & p3 & data_in(1) & p2 & p1; 

	
	
END Structural; 			