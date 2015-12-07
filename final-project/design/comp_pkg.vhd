LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

PACKAGE comp_pkg IS
	--mips--
	COMPONENT controller IS
	PORT(
		clk, rst: IN STD_LOGIC;
		instr: IN STD_LOGIC_VECTOR(31 DOWNTO 0); --from instruction memory
		we: OUT STD_LOGIC; --goes to regfile
		ri: OUT STD_LOGIC; --goes to muxn1
		rs, rd, rt: OUT STD_LOGIC_VECTOR(5 DOWNTO 0); --goes to regfile
		opcode: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --goes to ALU
		imm_i: OUT STD_LOGIC_VECTOR(14 DOWNTO 0) --goes to sign extender
		);
	END COMPONENT; 
	--alu--
	COMPONENT alu IS
	PORT(
	clk: IN STD_LOGIC;
	data_reg : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	data_mux : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	rst: IN STD_LOGIC;
	reg_imm: IN STD_LOGIC;
	opsel : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	data_out: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	equal: OUT STD_LOGIC;
	carry: OUT STD_LOGIC;
	overflow : OUT STD_LOGIC );
	END COMPONENT;
	--dma--
	COMPONENT dma is
	PORT(
		clk: IN STD_LOGIC;
		rst: IN STD_LOGIC;
		req: IN STD_LOGIC;
		addr: IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
		data: IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		ack: OUT STD_LOGIC;
		addr_o: OUT STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
		data_o: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
		);
	END COMPONENT;
	--instruction memory (cache)--
	COMPONENT ram IS
	port(
  addr : IN std_logic_vector (10 DOWNTO 0);
  rw : IN std_logic;
  csb : IN std_logic;
  oeb : IN std_logic;
  dataIO : INOUT std_logic_vector (31 DOWNTO 0));
	END COMPONENT; 
	--pc--
	COMPONENT counter IS
	PORT(
				clk : IN STD_LOGIC;
				rst_a : IN STD_LOGIC;
				preload : IN STD_LOGIC;
				din : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
				dout : OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0)
	);
	END COMPONENT;
	--sign extender--
	COMPONENT sign_extend IS
	PORT(
		rst: IN std_logic;
		input: IN std_logic_vector(15 downto 0); --from regfile
		output: OUT std_logic_vector(31 downto 0) --to muxn1
		);
	END COMPONENT;
	--regfile--
	COMPONENT regfile IS
	PORT (
clk : IN std_logic ;
rst_s : IN std_logic ; -- synchronous reset
we : IN std_logic ; -- write enable
raddr_1 : IN std_logic_vector (NSEL -1 DOWNTO 0); --from controller rs
raddr_2 : IN std_logic_vector (NSEL -1 DOWNTO 0); --from controller rt
waddr : IN std_logic_vector (NSEL -1 DOWNTO 0); -- from controller rd
rdata_1 : OUT std_logic_vector (NBIT -1 DOWNTO 0); --to ALU data_reg
rdata_2 : OUT std_logic_vector (NBIT -1 DOWNTO 0); --to mux input(1)
wdata : IN std_logic_vector (NBIT -1 DOWNTO 0) --from ALU data_out
);
	END COMPONENT; 
	--mux--
	COMPONENT muxn1 IS
	PORT (
	input : IN reg_to_array; --0 from sign extender, 1 from regfile
	opsel : IN STD_LOGIC_VECTOR (NSEL-1 DOWNTO 0);
	Y : OUT std_logic_vector (NSEL-1 DOWNTO 0));
	END COMPONENT; 
END comp_pkg;