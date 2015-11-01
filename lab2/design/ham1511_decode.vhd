LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE IEEE.numeric_std.all;
use ieee.std_logic_arith.all;

ENTITY ham1511_decode IS

  PORT(
         data_in : IN STD_LOGIC_VECTOR (1 TO 15);
   	     data_out : OUT STD_LOGIC_VECTOR (1 TO 11)
	  );
END ham1511_decode;

ARCHITECTURE Structural OF ham1511_decode IS
	SIGNAL p1, p2, p3, p4: STD_LOGIC;
	SIGNAL data_temp: STD_LOGIC_VECTOR (1 TO 11);
	SIGNAL err_loc: integer;
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
	err_loc <= conv_integer(p1)*1 + conv_integer(p2)*2 + conv_integer(p3)*4 + conv_integer(p4)*8;
	data_temp <= data_in(3) & data_in(5 TO 7) & data_in(9 TO 15);
	data_out <= data_temp(1 TO 11) WHEN err_loc=0 OR err_loc=1 OR err_loc=2 OR err_loc=4 OR err_loc=8 ELSE
				data_temp(1 TO 10) & not(data_temp(11)) WHEN err_loc=11 ELSE
				data_temp(1 TO err_loc-1) & not(data_temp(err_loc)) & data_temp(err_loc+1 TO 11);


END Structural;