library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is 
end ram_tb;


architecture beh of ram_tb is
component ram
  port(
  addr : IN std_logic_vector (10 DOWNTO 0);
  rw : IN std_logic;
  csb : IN std_logic;
  oeb : IN std_logic;
  dataIO : INOUT std_logic_vector (31 DOWNTO 0));  
end component;

signal addr_tb :std_logic_vector(10 downto 0);
signal dataIO_tb: std_logic_vector(31 downto 0);
signal rw_tb,csb_tb,oeb_tb : std_logic;

begin  -- beh
  ram1: ram port map (
    addr => addr_tb,
    rw => rw_tb,
    csb => csb_tb,
    oeb => oeb_tb,
    dataIO => dataIO_tb);

  tb: process 
  begin 
   addr_tb <= ('0','0','1','0','1',others=>'0');
   rw_tb <= '0';
   csb_tb <= '1';
   oeb_tb <= '0';
   wait for 10 ns;
   rw_tb <= '1';
   csb_tb <= '0';
   oeb_tb <= '1';
   wait for 10 ns;
   rw_tb <='0';
   dataIO_tb <= "00000000111111110000000011111111";
   wait for 10 ns;
   addr_tb <= ('1','0','1','0','1',others =>'0');
   wait for 10 ns;
   dataIO_tb <= "11111111111111110000000000000000";
   wait for 10 ns;
   csb_tb <= '1';
   wait for 10 ns;
   dataIO_tb <= (others=>'Z');
   wait for 10 ns;
   rw_tb<='1';
   wait for 10 ns;
   csb_tb <='0';
   wait for 10 ns;
   addr_tb <= ('0','0','1','0','1',others =>'0');
   wait for 10 ns;
   oeb_tb <='0';
   wait for 10 ns;
   addr_tb <= ('1','0','1','0','1',others =>'0');
   wait for 10 ns;
   assert false report "done" severity failure;
  end process;
end beh;

