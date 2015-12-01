LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY maindec is --main control decoder
	PORT(
		op: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		memtoreg, memwrite: OUT STD_LOGIC;
		branch, alusrc: OUT STD_LOGIC;
		regdst, regwrite: OUT STD_LOGIC;
		jump: OUT STD_LOGIC;
		aluop: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END maindec;