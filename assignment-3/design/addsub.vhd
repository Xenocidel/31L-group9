library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

GENERIC (NBIT: INTEGER := 32);

entity addsub IS
	PORT(
	addsub:IN std_logic;
	in0:IN std_logic_vector(NBIT-1 downto 0);
	in1:IN std_logic_vector(NBIT-1 downto 0);
	cin:IN std_logic_vector(NBIT-1 downto 0);
	sum:OUT std_logic_vector(NBIT-1 downto 0);
	);
end addsub;

architecture Structural of addsub IS
begin
	PROCESS(in0)
	VARIABLE carry : std_logic_vector(NBIT-1 downto 0);
	begin
		carry := ((not addsub and in1) or (not in1 and in0 and not cin) or (addsub and cin and in0) or (addsub and not in1 and cin));
		if carry = OTHERS=>'0' then --if no wrap-around needed
			sum <= ((in1 and not in0 and not cin) or (not in1 and not in0 and cin) or (in1 and in0 and cin) or (not in1 and in0 and not cin));
		elsif addsub=1 then --wrap-around to negative if adding
			sum <= OTHERS=>'1'
		else --wrap-around to 0 if subtracting
			sum <= OTHERS=>'0'
		end if
	end
end Structural;