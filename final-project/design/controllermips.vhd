LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE work.comp_pkg.ALL; 

ENTITY controllermips IS 
	PORT (
		clk : IN STD_LOGIC;
		ack : OUT STD_LOGIC;
		req : IN STD_LOGIC; 
		addr: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		reset: IN STD_LOGIC
	); 
END;

ARCHITECTURE beh OF controllermips IS

TYPE state IS (DMA, F, D, E, S); 
SIGNAL pr_state, nx_state: state;
SIGNAL ack, req: STD_LOGIC;
SIGNAL execute_instruct STD_LOGIC_VECTOR(31 DOWNTO 0); 
SIGNAL address: STD_LOGIC_VECTOR(31 DOWNTO 0); 
SIGNAL instruction: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL address_out: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL program_counter: STD_LOGIC_VECTOR(5 DOWNTO 0);
ATTRIBUTE ENUM_ENCODING  : STRING;
ATTRIBUTE ENUM_ENCODING of state IS "sequential";

--Main Memory 64x32 instantiation in vhdl. Component Instantiation would lead to loading and storing to different memories. 
--Therefore, a substitution of a process is used instead to represent memory. 
subtype word is std_logic_vector(31 downto 0);
type mem is array (0 to 63) of word;
SIGNAL instruct_mem: mem; 
SIGNAL main_mem: mem; 

--RegFile Signals. Component instantiation leads to same issue as instruction/main memory.
SUBTYPE selRange IS INTEGER RANGE 0 TO INTEGER'HIGH;  
SIGNAL read_index1, read_index2, w_index: selRange;
SUBTYPE vector IS STD_LOGIC_VECTOR (31 DOWNTO 0);
TYPE matrix IS ARRAY (5 DOWNTO 0) OF vector; 
SIGNAL regN: matrix := ((others =>(others => '0'))); 

SIGNAL we, ri : STD_LOGIC;
SIGNAL rs,rd,rt:STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL opcode: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL imm_i: STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL mux_imm: STD_LOGIC_VECTOR(31 DOWNTO 0);
SUBTYPE vector IS STD_LOGIC_VECTOR (31 DOWNTO 0);
TYPE matrix IS ARRAY (1 DOWNTO 0) OF vector; 
SIGNAL regImm: matrix := ((others =>(others => '0')));
SIGNAL data_mux, data_reg: STD_LOGIC_VECTOR(31 DOWNTO 0); 
SIGNAL wdata : STD_LOGIC_VECTOR(31 DOWNTO 0); 
BEGIN

PROCESS(clk, rst)
BEGIN
	IF rst = '1' THEN
		pr_state <= DMA;
		program_counter <= (others => 0); 
	ELSIF (clk'EVENT clk = '0') THEN
		pr_state <= nx_state;
	END IF; 
END PROCESS;

PROCESS(clk, pr_state, rst)
BEGIN
	CASE pr_state IS
		WHEN DMA =>
			
				dma: dma port map(
				clk => clk,
				rst => reset,
				req => req,
				addr => addr(5 DOWNTO 0),
				data => data,
				ack => ack,
				addr_o => address_out,
				data_o => instruction
				);
				IF (req = '1') THEN
					main_mem(to_integer(unsigned(addr))) <= instruction; 
					instruct_mem(to_integer(unsigned(address_out))) <= instruction; 
				END IF; 
			IF (rst = '0') THEN
				nx_state <= F;
			ELSE
				nx_state <= DMA;
			END IF;
		WHEN F =>
			execute_instruct <= instruct_mem(to_integer(unsigned(program_counter))); 
			nx_state <= D;
		WHEN D =>
			decoder: controller port map(
			clk => clk,
			rst => reset,
			instr => execute_instruct,
			we => we,
			ri => ri,
			opcode => opcode,
			imm_i => imm_i,
			rs => rs,
			rd => rd,
			rt => rt
			);
			
			sign_extender: sign_extend port map(
			rst => '0',
			input => imm_i,
			output => regImm(1)
			);
			
			read_index1 <= to_integer(unsigned(rs));
			read_index2 <= to_integer(unsigned(rt));
			w_index <= to_integer(unsigned(waddr));
			
			PROCESS (clk)
			
			
			BEGIN
			IF (clk'EVENT AND clk = '1') THEN
			IF (rst_s = '1') THEN
				L_reset: FOR i IN 0 TO 2**NSEL-1 LOOP
					regN(i) <= (OTHERS => '0');
				END LOOP L_reset; 
			ELSE
				data_reg <= regN(read_index1);
				regImm(0) <= regN(read_index2); 
				
				IF (we = '1') THEN
					regN(w_index) <= wdata;
				
				END IF;
			END IF;
		END IF; 
			END PROCESS;
			
			nx_state <= E; 
		WHEN E =>
			mux: muxn1 port map (
			in_list => regImm,
			sel => ri,
			Y => data_mux
			);
			execute: alu port map(
			clk => clk,
			data_reg => data_reg,
			data_mux => data_mux,
			rst => rst,
			reg_imm => regImm(1),
			opsel => opcode,
			data_out => wdata
			);
			we <= '1'; 
			nx_state <= S;
		WHEN S =>
		
			PROCESS (clk)
			
			BEGIN
			IF (clk'EVENT AND clk = '1') THEN
			IF (rst_s = '1') THEN
				L_reset: FOR i IN 0 TO 2**NSEL-1 LOOP
					regN(i) <= (OTHERS => '0');
				END LOOP L_reset; 
			ELSE
				rdata_1 <= regN(read_index1);
				rdata_2 <= regN(read_index2); 
				
				IF (we = '1') THEN
					regN(w_index) <= wdata;
				
				END IF;
			END IF; 	
		END IF; 
			END PROCESS;
			nx_state <= F; 
	
	END CASE;  
END PROCESS;

