library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_hit_miss is
    Port ( tag_cache : in  STD_LOGIC_VECTOR (3 downto 0);
           tag : in  STD_LOGIC_VECTOR (3 downto 0);
           valid_bit : in  STD_LOGIC;
           hit_miss_out : out  STD_LOGIC);
end control_hit_miss;

architecture Behavioral of control_hit_miss is

signal sub   : STD_LOGIC :='0';

begin

    sub <= '1' when tag_cache - tag = 0 else
		'0';
	hit_miss_out<=  sub and valid_bit;

end Behavioral;

