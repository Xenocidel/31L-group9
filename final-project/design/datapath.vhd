LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE work.comp_pkg.ALL; 

ENTITY datapath is --MIPS datapath
	PORT(
		clk, reset: IN STD_LOGIC;
		memtoreg, pcsrc: IN STD_LOGIC;
		alusrc, regdst: IN STD_LOGIC;
		regwrite, jump: IN STD_LOGIC;
		alucontrol: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		zero: OUT STD_LOGIC;
		pc: BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
		instr: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		aluout, writedata: BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
		readdata: IN STD_LOGIC_VECTOR(31 DOWNTO 0));
END datapath;

ARCHITECTURE data_arc IS
	SIGNAL we, ri : STD_LOGIC;
	SIGNAL rs,rd,rt:STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL opcode: STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL imm_i: STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL mux_imm: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SUBTYPE vector IS STD_LOGIC_VECTOR (31 DOWNTO 0);
	TYPE matrix IS ARRAY (1 DOWNTO 0) OF vector; 
	SIGNAL regImm: matrix := ((others =>(others => '0')));
	SIGNAL data_mux, data_reg: STD_LOGIC_VECTOR(31 DOWNTO 0); 
	
	COMPONENT muxn1
		PORT(in_list: IN array_gen(1 DOWNTO 0); sel: IN INTEGER; Y: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)); 
	END COMPONENT; 

	maincontroller: controller port map(
	clk => clk,
	rst => reset,
	instr => instr,
	we => we,
	ri => ri,
	opcode => opcode,
	imm_i => imm_i,
	rs => rs,
	rd => rd,
	rt => rt
	);
	mux: muxn1 port map (
	in_list => regImm,
	sel => ri,
	Y => 
	)
	sign_extender: sign_extend port map(
	rst => '0',
	input => imm_i,
	output => regImm()
	);
	registers: regfile port map(
	clk => clk,
	rst_s => reset,
	we => '1',
	raddr_1 => rs,
	raddr_2 => rt,
	waddr => rd,
	rdata_1 => regImm(0),
	rdata_2 => regImm(0),
	
	)
	
	execute: alu port map(
	clk => clk,
	rst => '1',
	data_reg => 
	
	
	)
	
	
	
	
	
	
	
	