LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY ham1511_encode IS

  PORT(
         data_in : IN STD_LOGIC_VECTOR (1 TO 11);
   	     data_out : OUT STD_LOGIC_VECTOR (1 to 15)
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
	data_out <= p1 & p2 & data_in(1) & p3 & data_in(2 TO 4) & p4 & data_in(5 TO 11);
	
END Structural; 			