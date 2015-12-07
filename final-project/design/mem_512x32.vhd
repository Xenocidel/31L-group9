library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mem512x32 is
  
  port (
    a   : in    std_logic_vector(8 downto 0);   -- address bus
    d   : inout std_logic_vector(31 downto 0);  -- data bus
    rwb : in    std_logic;                      -- read/write_bar
    csb : in    std_logic;                  -- chip sel
    oeb: in std_logic);                 --output enable bar

end mem512x32;


architecture beh of mem512x32 is
subtype word is std_logic_vector(31 downto 0);
type mem is array (0 to 511) of word;
begin  -- beh
  -- purpose: <[description]>
  memory_handle: process (a,d,rwb,csb,oeb)
    variable mem1:mem;
    begin
      if(csb='1' or (csb='0' and oeb='1' and rwb='1')) then
        d<=(others=>'Z');
      elsif csb='0' and oeb='0' and rwb='1' then
        d<=mem1(to_integer(unsigned(a)));
      elsif csb='0' and rwb ='0' then
        mem1(to_integer(unsigned(a))):= d;
      end if;
    end process;

end beh;

