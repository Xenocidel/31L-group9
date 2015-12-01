LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY controller is --single cycle control decoder
	PORT(
		op, funct: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		zero: IN STD_LOGIC;
		memtoreg, memwrite: OUT STD_LOGIC;
		pcsrc, alusrc: OUT STD_LOGIC;
		regdst, regwrite: OUT STD_LOGIC;
		jump: OUT STD_LOGIC;
		alucontrol: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END controller;