---------------- Reg: ---------------- 
-- Kataxwrhths poy pernaei sthn exodo thn eisodo otan 
-- to WE=1
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
    Port ( rst:in std_logic;
	       DATA : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Reg;

architecture Behavioral of Reg is

signal dedomena_1 : STD_LOGIC_VECTOR (31 downto 0);

begin

Process(CLK)
begin
if (rst='1') then
  dedomena_1<="00000000000000000000000000000000" ;
  else 
	if (CLK'EVENT AND CLK='1') THEN
		if(WrEn='1') then 
			dedomena_1<= DATA;
		ELSE
			dedomena_1 <= dedomena_1;
		end if;
	END IF;
	end if;
end process;	
	Dout <=dedomena_1;
end Behavioral;

