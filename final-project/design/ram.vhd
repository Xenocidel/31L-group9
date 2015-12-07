library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
  port(
  addr : IN std_logic_vector (10 DOWNTO 0);
  rw : IN std_logic;
  csb : IN std_logic;
  oeb : IN std_logic;
  dataIO : INOUT std_logic_vector (31 DOWNTO 0));  
end ram;


architecture beh of ram is

component mem512x32
   port (
    a   : in    std_logic_vector(8 downto 0);   -- address bus
    d   : inout std_logic_vector(31 downto 0);  -- data bus
    rwb : in    std_logic;                      -- read/write_bar
    csb : in    std_logic;                  -- chip sel
    oeb: in std_logic);                 --output enable bar

end component;
signal sel,csb_b,oeb_b : std_logic_vector(3 downto 0);  -- <[comment]>
begin  -- beh
  with addr(10 downto 9) select
    sel <=
    "1110" when "00",
    "1101" when "01",
    "1011" when "10",
    "0111" when "11",
    "ZZZZ" when others;
  csb_gen: for i in 0 to 3 generate
      csb_b(i) <= sel(i) or csb;
      oeb_b(i) <= sel(i) or oeb;
    end generate;
  
  mem0 : mem512x32 port map (
    a   => addr(8 downto 0),
    d   => dataIO,
    rwb => rw,
    csb => csb_b(0),
    oeb => oeb_b(0));
  mem1 : mem512x32 port map (
    a   => addr(8 downto 0),
    d   => dataIO,
    rwb => rw,
    csb => csb_b(1),
    oeb => oeb_b(1));
  mem2 : mem512x32 port map (
    a   => addr(8 downto 0),
    d   => dataIO,
    rwb => rw,
    csb => csb_b(2),
    oeb => oeb_b(2));
  mem3 : mem512x32 port map (
    a   => addr(8 downto 0),
    d   => dataIO,
    rwb => rw,
    csb => csb_b(3),
    oeb => oeb_b(3));

  

end beh;
