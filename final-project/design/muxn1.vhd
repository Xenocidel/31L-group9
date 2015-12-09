LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

package gen_array_pkg is
	CONSTANT W: INTEGER := 32;
	subtype gen_vec is std_logic_vector(W-1 DOWNTO 0);
	type array_gen is array(natural range <>) of gen_vec;
end gen_array_pkg;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

LIBRARY work;
USE work.gen_array_pkg.ALL; 

ENTITY muxn1 IS

GENERIC(in_num : INTEGER := 8; reg_width : INTEGER := 32); 

PORT ( 
in_list: IN array_gen (in_num -1 DOWNTO 0); 
sel: IN INTEGER; 
Y : OUT STD_LOGIC_VECTOR (reg_width -1 DOWNTO 0) 
);

END muxN1;

ARCHITECTURE DataFlow OF muxn1 IS
	SUBTYPE reg_input IS STD_LOGIC_VECTOR(reg_width -1 DOWNTO 0); 
	TYPE regselect IS ARRAY (in_num -1  DOWNTO 0) OF reg_input;
	SIGNAL choice: regselect; 
	
BEGIN
	G1: FOR i in 0 to in_num -1 GENERATE
		choice(i)<= in_list(i);
	END GENERATE G1; 
	
	Y <= choice(sel);

END DataFlow; 