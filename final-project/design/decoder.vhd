LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY decoder is
	PORT(
		clk, rst: IN STD_LOGIC;
		instr: IN STD_LOGIC_VECTOR(31 DOWNTO 0); --from instruction memory
		we: OUT STD_LOGIC; --goes to regfile
		ri: OUT STD_LOGIC; --goes to muxn1
		rs, rd, rt: OUT STD_LOGIC_VECTOR(5 DOWNTO 0); --goes to regfile
		opcode: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --goes to ALU
		imm_i: OUT STD_LOGIC_VECTOR(14 DOWNTO 0) --goes to sign extender
		);
END decoder;

Architecture Behavioral of decoder IS

	--Universal
	SIGNAL INSTRUCTION_TYPE: STD_LOGIC;
	SIGNAL REGISTER_SOURCE_ADDRESS: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL REGISTER_DESTINATION_ADDRESS: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL FUNCTION_CODE: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL REGISTER_TEMP_ADDRESS: STD_LOGIC_VECTOR(5 DOWNTO 0);
	--R Type
	SIGNAL R_IMMEDIATE_VALUE: STD_LOGIC_VECTOR(8 DOWNTO 0);
	--I Type
	SIGNAL I_IMMEDIATE_VALUE: STD_LOGIC_VECTOR(14 DOWNTO 0);
	
	BEGIN
		
	
	PROCESS (clk, rst)
	BEGIN
		IF rst = '0' THEN --rst low means on
		INSTRUCTION_TYPE <= instr(31);
		REGISTER_SOURCE_ADDRESS <= instr(30 DOWNTO 25);
		REGISTER_DESTINATION_ADDRESS <= instr(24 DOWNTO 19);
		FUNCTION_CODE <= instr(18 DOWNTO 15);
		IF (INSTRUCTION_TYPE='0') THEN --R Type
			REGISTER_TEMP_ADDRESS <= instr(14 DOWNTO 9);
			R_IMMEDIATE_VALUE <= instr(8 DOWNTO 0); --imm_r not used for anything
		ELSIF (INSTRUCTION_TYPE='1') THEN --I Type
			I_IMMEDIATE_VALUE <= instr(14 DOWNTO 0);
		END IF;
			IF clk'EVENT and clk='1' THEN
				rs <= REGISTER_SOURCE_ADDRESS;
				rd <= REGISTER_DESTINATION_ADDRESS;
				rt <= REGISTER_TEMP_ADDRESS;
				ri <= INSTRUCTION_TYPE;
				opcode <= FUNCTION_CODE;
				we <= '0'; --read
			ELSIF clk'EVENT and clk='1' THEN
				opcode <= (OTHERS => '0');
				we <= '0'; --read
			END IF;
		ELSIF rst = '1' and clk'EVENT and clk = '1' THEN
			we <= '1'; --write
		END IF;
	END PROCESS;
END Behavioral;