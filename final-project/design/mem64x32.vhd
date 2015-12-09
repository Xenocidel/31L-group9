ibrary ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mem64x32 is
  
  port (
    a   : in    std_logic_vector(5 downto 0);   -- address bus
    d   : inout std_logic_vector(31 downto 0);  -- data bus
    rwb : in    std_logic;                      -- read/write_bar
    oeb: in std_logic);                 --output enable bar

end mem64x32;


architecture beh of mem64x32 is
subtype word is std_logic_vector(31 downto 0);
type mem is array (63 downto 0) of word;
begin  -- beh
  -- purpose: <[description]>
  memory_handle: process (a,d, rwb, oeb)
    variable mem1:mem;
    begin
      if oeb='1' and rwb='1' then
        d<=mem1(to_integer(unsigned(a)));
      elsif rwb ='0' then
        mem1(to_integer(unsigned(a))):= d;
      end if;
    end process;

end beh;