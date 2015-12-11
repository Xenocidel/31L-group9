LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

LIBRARY work;
USE work.gen_array_pkg.ALL;

PACKAGE comp_pkg IS
	CONSTANT ADDR_WIDTH: INTEGER := 6;
	CONSTANT DATA_WIDTH: INTEGER := 32;
	CONSTANT in_num: INTEGER := 2;
	CONSTANT reg_width: INTEGER := 32;
	CONSTANT NSEL: INTEGER := 6;
	CONSTANT NBIT: INTEGER := 32; 
	--alu--
	COMPONENT alu IS
	PORT(
	alu_en: IN STD_LOGIC;
	clk: IN STD_LOGIC;
	data_reg : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	data_mux : IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	rst: IN STD_LOGIC;
	reg_imm: IN STD_LOGIC;
	opsel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	data_out: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	equal: OUT STD_LOGIC;
	carry: OUT STD_LOGIC;
	overflow : OUT STD_LOGIC );
	END COMPONENT;

	--sign extender--
	COMPONENT sign_extend IS
	PORT(
		sign_en : IN std_logic;
		rst: IN std_logic;
		input: IN std_logic_vector(14 downto 0); --from regfile
		output: OUT std_logic_vector(31 downto 0) --to muxn1
		);
	END COMPONENT;

	--mux--
	COMPONENT mux21 IS
	PORT (
mux_en: IN STD_LOGIC; 
D0 : IN std_logic_vector(31 DOWNTO 0) ;
D1 : IN std_logic_vector(31 DOWNTO 0);
A0 : IN std_logic ;
Y : OUT std_logic_vector(31 DOWNTO 0)
);
END COMPONENT; 
	--regfile
	COMPONENT regfile IS
	PORT (
reg_en: IN std_logic;
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
END comp_pkg;