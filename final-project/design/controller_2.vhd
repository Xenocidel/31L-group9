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
					instr_type <= instr(31);
					rs <= instr(30 DOWNTO 25);
					rd <= instr(24 DOWNTO 19);
					opcode <= instr(18 DOWNTO 15);
					rt <= instr(14 DOWNTO 9);
					imm <= instr(14 DOWNTO 0);
					reg_memory: regfile port map (clk, '0', '0', rs, rt, rd, reg_out1, reg_out2, alu_out);
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
					reg_memory2: regfile port map (clk, '0', '1', rs, rt, rd, reg_out1, reg_out2, alu_out);
					pcount := std_logic_vector((unsigned(pcount)) + to_unsigned(1, 6));
					nx_state <= B;
			END CASE;	
		END IF;	
	END PROCESS;
	
	
END Behavioral;