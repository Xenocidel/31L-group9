LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE work.comp_pkg.ALL; 

ENTITY controllermips IS 
	PORT (
		clk : IN STD_LOGIC;
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
SIGNAL preload: STD_LOGIC;
ATTRIBUTE ENUM_ENCODING  : STRING;
ATTRIBUTE ENUM_ENCODING of state IS "sequential";

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
		pr_counter: pc port map(
			clk => clk,
			rst_a => '1',
			preload => '0',
			din => (OTHERS => '0');
			dout => execute_instruct
			); 
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
			addr_o => address,
			data_o => instruction
			);
			instruct_mem : mem64x32 port map(
			a => address,
			d => instruction,
			oeb => '0',
			rwb => '0'
			);
			IF (rst = '0') THEN
				nx_state <= F;
			ELSE
				nx_state <= DMA;
			END IF;
		WHEN F =>
			IF (rst'EVENT and rst = '0') THEN
				preload <= '1';
			ELSE
				preload <= '0'; 
			END IF;
			pr_counter: pc port map(
			clk => clk,
			rst_a => '0',
			preload => preload,
			din => (OTHERS => '0');
			dout => execute_instruct
			); 
			instruct_mem : mem64x32 port map(
			a => address,
			d => execute_instruct,
			oeb => '1',
			rwb => '1'
			);
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
			nx_state <= E; 
		WHEN E =>
			mux: muxn1 port map (
			in_list => regImm,
			sel => ri,
			Y => data_mux
			);
			sign_extender: sign_extend port map(
			rst => '0',
			input => imm_i,
			output => regImm(1)
			);
			registers: regfile port map(
			clk => clk,
			rst_s => rst,
			we => we,
			raddr_1 => rs,
			raddr_2 => rt,
			waddr => rd,
			rdata_1 => data_reg,
			rdata_2 => regImm(0),
			wdata => wdata
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
			nx_state <= F; 
	
	END CASE;  
END PROCESS;

