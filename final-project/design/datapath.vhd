LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

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