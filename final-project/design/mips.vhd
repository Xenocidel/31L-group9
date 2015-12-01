LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY mips is --single cycle MIPS processor
	PORT(
		clk, reset: IN STD_LOGIC;
		pc: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		instr: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		memwrite: OUT STD_LOGIC;
		aluout, writedata: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		readdata: IN STD_LOGIC_VECTOR(31 DOWNTO 0));
END mips;