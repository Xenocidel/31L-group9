LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY ALU_1bit IS

  PORT(
         A : IN STD_LOGIC ;
   	     B : IN STD_LOGIC ;
	 opsel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	  mode : IN STD_LOGIC ;
	  cin : IN STD_LOGIC; 
	output1 : OUT STD_LOGIC ;
	  cout : OUT STD_LOGIC
	  );
END ALU_1bit;

ARCHITECTURE Structural OF ALU_1bit IS
	COMPONENT mux81
		PORT (D0, D1, D2, D3, D4, D5, D6, D7 : IN STD_LOGIC; opsel : IN STD_LOGIC_VECTOR (2 DOWNTO 0); Y : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT mux21
		PORT (D0, D1, A0 : IN STD_LOGIC; Y : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT addsub
		PORT (addsub, in0, in1, cin : IN STD_LOGIC; sum, cout : OUT STD_LOGIC);
	END COMPONENT;
	
--	COMPONENT sub_borrow
--		PORT (in0, in1, cin : IN STD_LOGIC; diff, bout : OUT STD_LOGIC);
--	END COMPONENT;
	
	SIGNAL optype, b0, art0, art1, art2, art3, art4, art5, art6, art7, log0, log1, log2, log3, log4, log5, log6, log7, cout0, cout1, cout2, cout3, cout4, cout5, cout6, choice1, choice2 : STD_LOGIC;

BEGIN
	--cin <=  NOT A AND B WHEN opsel = "001" ELSE
		--	'1' WHEN opsel = "100" OR opsel = "110" ELSE
			--'0';
			
	optype <= '0' WHEN opsel = "000" or opsel = "100" or opsel = "110" or opsel = "101" ELSE
				'1';

	addop: addsub port map (optype, A, B, cin, art0, cout0);
	subopborrow: addsub port map (optype, A, B, cin, art1, cout1);
	art2 <= A;
	subop: addsub port map (optype, A, B, cin, art3, cout2);
	increment: addsub port map (optype, A, '0', cin, art4, cout3);
	decrement: addsub port map (optype, A, '1', cin, art5, cout4);
	add_increment: addsub port map (optype, A, B, cin, art6, cout5);
	log0 <= A AND B;
	log1 <= A OR B;
	log2 <= A XOR B;
	log3 <= NOT A;
	log4 <= cin;
	cout6 <= A;
	
	outputselectart: mux81 port map(art0, art1, art2, art3, art4, art5, art6, '0', opsel, choice1);
	outputselectlog: mux81 port map(log0, log1, log2, log3, '0', log4, '0', '0', opsel, choice2);
	
	finaloutputselect: mux21 port map(choice1, choice2, mode, output1);
	
	cout <= cout0 WHEN mode = '0' AND opsel = "000" ELSE
			cout1 WHEN mode = '0' AND opsel = "001" ELSE
			cout2 WHEN mode = '0' AND opsel = "011" ELSE
			cout3 WHEN mode = '0' AND opsel = "100" ELSE
			cout4 WHEN mode = '0' AND opsel = "101" ELSE
			cout5 WHEN mode = '0' AND opsel = "110" ELSE
			cout6 WHEN mode = '1' AND opsel = "101" ELSE
			'0';
END Structural; 			