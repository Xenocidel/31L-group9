LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE work.comp_pkg.ALL;

ENTITY controller_2 is
	PORT(
		clk, rst: IN STD_LOGIC;
		);
END controller_2;

Architecture Behavioral of controller_2 IS

	--Universal
	SIGNAL instr: STD_LOGIC_VECTOR(31 DOWNTO 0); --from instruction memory
	SIGNAL instr_type: STD_LOGIC;
	SIGNAL rs: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL rd: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL opcode: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rt: STD_LOGIC_VECTOR(5 DOWNTO 0);
	--I Type
	SIGNAL imm: STD_LOGIC_VECTOR(14 DOWNTO 0);
	--ALU
	SIGNAL equal, carry, overflow: STD_LOGIC;
	--Regfile
	SUBTYPE selRange IS INTEGER RANGE 0 TO INTEGER'HIGH;  
	SIGNAL read_index1, read_index2, w_index: selRange;
	SUBTYPE vector IS STD_LOGIC_VECTOR (NBIT -1 DOWNTO 0);
	TYPE matrix IS ARRAY (2**NSEL-1 DOWNTO 0) OF vector; 
	SIGNAL regN: matrix := ((others =>(others => '0'))); 
	--FSM
	TYPE state is (A,B,C,D,E);
	SIGNAL pr_state, nx_state : state;
	
BEGIN

	PROCESS (clk, rst)
	BEGIN
		IF rst = '1' THEN
			pr_state <= A;
		ELSIF (clk'EVENT and clk = '0') THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;

	PROCESS (clk, rst)
	VARIABLE pcount: STD_LOGIC_VECTOR(5 DOWNTO 0); --counter 
	VARIABLE reg_out1, reg_out2: STD_LOGIC_VECTOR(31 DOWNTO 0);  --regfile outputs
	VARIABLE sign_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE alu_in, alu_out: STD_LOGIC_VECTOR(31 DOWNTO 0);  --ALU output
	BEGIN	
		
		IF (clk'EVENT and clk = '1') THEN
			CASE pr_state IS
				WHEN A =>
					--Use DMA to fill Instruction Memory
					pcount := OTHERS => '0';	--initialize counter to 0 
					nx_state <= B;
				WHEN B =>	--Use program counter to get instruction from memory
					instr_memory: mem64x32 port map(pcount, instr, '1', '1'); --send address to instruction memory
					nx_state <= C;
				WHEN C =>	--Decode instruction and send addresses to regfile
					instr_type <= instr(31);			--Register or Immediate bit
					rs <= instr(30 DOWNTO 25);			--1st register address
					rd <= instr(24 DOWNTO 19);			--Write destination
					opcode <= instr(18 DOWNTO 15);		--Function 
					rt <= instr(14 DOWNTO 9);			--2nd register address
					imm <= instr(14 DOWNTO 0);			--Immediate value 
					read_index1 <= to_integer(unsigned(rs));
					read_index2 <= to_integer(unsigned(rt));
					w_index <= to_integer(unsigned(rd));
					reg_out1 := regN(read_index1);
					reg_out2 := regN(read_index2);
					sign: sign_extend port map ('0', imm, sign_out);
					nx_state <= D;
				WHEN D =>	--Choose if register or immediate and send to ALU	
					IF instr_type = '0' THEN
						alu_in := reg_out2;
					ELSIF instr_type = '1' THEN
						alu_in := sign_out;
					END IF;
					funct: alu port map (clk, reg_out1, alu_in, rst, instr_type, opcode, alu_out, equal, carry, overflow);
					nx_state <= E;
				WHEN E =>	--Write ALU output into regfile
					regN(w_index) <= alu_out;
					pcount := std_logic_vector((unsigned(pcount)) + to_unsigned(1, 6));
					nx_state <= B;
			END CASE;	
		END IF;	
	END PROCESS;
	
	
END Behavioral;