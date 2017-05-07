library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity cache is
port ( clk : in std_logic;
we : in std_logic;
addr : in std_logic_vector(4 downto 0);
din : in std_logic_vector(132  downto 0);
dout : out std_logic_vector(132 downto 0));
end cache;
architecture syn of cache is
---------------------------------------------------
type TRam is array(31 downto 0) of std_logic_vector(132 downto 0);
impure function init_bram (ram_file_name : in string) return TRam is
file ramfile : text is in ram_file_name;
variable line_read : line;
variable ram_to_return : TRam;
begin
  for i in 0 to 31 loop
  readline(ramfile, line_read);
  read(line_read, ram_to_return(i));
  end loop;
return ram_to_return;
end function;
signal Ram : TRam := init_bram("cache.data");
--------------------------------------------------------
begin
process (clk)
begin
if clk'event and clk = '1' then
if we = '1' then
RAM(conv_integer(addr)) <= din;
end if;
dout<= RAM(conv_integer(addr)) ;
end if;
end process; 
end syn;






