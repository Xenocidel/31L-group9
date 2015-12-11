LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY work; 
USE work.comp_pkg.ALL;
USE work.gen_array_pkg.ALL;  

ENTITY controllermips IS 
	PORT (
		clk : IN STD_LOGIC;
		addr: IN INTEGER;
		instruction: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		reset: IN STD_LOGIC;
		instruct_out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
	); 
END;

ARCHITECTURE beh OF controllermips IS

TYPE state IS (DMA, F, D, E, S); 
SIGNAL pr_state, nx_state: state;
SIGNAL execute_instruct : STD_LOGIC_VECTOR(31 DOWNTO 0); 
SIGNAL address_out: STD_LOGIC_VECTOR(5 DOWNTO 0);
ATTRIBUTE ENUM_ENCODING  : STRING;
ATTRIBUTE ENUM_ENCODING of state: TYPE IS "sequential";

--Main Memory 64x32 instantiation in vhdl. Component Instantiation would lead to loading and storing to different memories. 
--Therefore, a substitution of a process is used instead to represent memory. 
subtype word is std_logic_vector(31 downto 0);
type mem is array (0 to 63) of word;
SIGNAL instruct_mem: mem; 
SIGNAL main_mem: mem; 

SIGNAL we: STD_LOGIC;
SIGNAL ri: STD_LOGIC;
SIGNAL rs,rd,rt:STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL opcode: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL imm_i: STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL mux_imm: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL regImm: array_gen (1 DOWNTO 0) := ((others =>(others => '0')));
SIGNAL data_mux, data_reg: STD_LOGIC_VECTOR(31 DOWNTO 0); 
SIGNAL wdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
 

--Enable Signals
SIGNAL alu_en, sign_en, mux_en, reg_en: STD_LOGIC := '0'; 
BEGIN

PROCESS(clk, reset)
BEGIN
	IF (reset = '1') THEN
		alu_en <= '0';
		sign_en <= '0';
		mux_en <= '0';
		reg_en <= '0';
		pr_state <= DMA;
	ELSIF (clk'EVENT and clk = '0') THEN
		pr_state <= nx_state;
	END IF;
END PROCESS;

PROCESS(clk, pr_state, reset)
VARIABLE program_counter : INTEGER; 
BEGIN
	CASE pr_state IS
		WHEN DMA =>
			IF (clk'EVENT and clk = '1') THEN
				main_mem(addr) <= instruction; 
				instruct_mem(addr) <= instruction;
			END IF;
			IF (reset = '0') THEN
				nx_state <= F;
			ELSE
				nx_state <= DMA;
			END IF;
			program_counter := 0; 
		WHEN F =>
			alu_en <= '0';
			sign_en <= '0';
			mux_en <= '0';
			reg_en <= '0';
			execute_instruct <= instruct_mem(program_counter);
			instruct_out <= instruct_mem(program_counter); 
			nx_state <= D;
		WHEN D =>
			ri <= execute_instruct(31);
			rs <= execute_instruct(30 DOWNTO 25);
			rd <= execute_instruct(24 DOWNTO 19);
			opcode <= execute_instruct(18 DOWNTO 15);
			rt <= execute_instruct(14 DOWNTO 9);
			imm_i <= execute_instruct(14 DOWNTO 0);
				
				
			mux_en <= '1';
			sign_en <= '1';
			reg_en <= '1';
			we <= '0';
			nx_state <= E; 
		WHEN E =>
			alu_en <= '1'; 
			nx_state <= S;
		WHEN S =>
			reg_en <= '1';
			we <= '1';
			data_out <= wdata; 
			program_counter := program_counter + 1;
			nx_state <= F; 
	
	END CASE;  
	END PROCESS;
	
	mux: mux21 port map (
			mux_en => mux_en,
			D0 => regImm(0),
			D1 => regImm(1),
			A0 => ri,
			Y => data_mux
			);
	execute: alu port map(
			alu_en => alu_en,
			clk => clk,
			data_reg => data_reg,
			data_mux => data_mux,
			rst => reset,
			reg_imm => ri,
			opsel => opcode,
			data_out => wdata
			);
	sign_extender: sign_extend port map(
			sign_en => sign_en,
			rst => '0',
			input => imm_i,
			output => regImm(1)
			);
	FileReg: regfile port map(
			reg_en => reg_en,
			clk =>clk,
			rst_s => reset,
			we => we,
			raddr_1 => rs,
			raddr_2 => rt,
			waddr => rd,
			rdata_1 => data_reg,
			rdata_2 => regImm(0),
			wdata => wdata
			);
END beh; 

