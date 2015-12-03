LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;

ENTITY aludec is --ALU control decoder
	PORT(
		funct: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		aluop: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		alucontrol: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END aludec;