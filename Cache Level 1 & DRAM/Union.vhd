----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:23 03/31/2016 
-- Design Name: 
-- Module Name:    Unio_registers_32bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Unio_registers_32bit is
    Port ( reg0 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg1 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg3 : in  STD_LOGIC_VECTOR (31 downto 0);
           union_enable : in  STD_LOGIC;
			  tag : in STD_LOGIC_VECTOR (3 downto 0);
           out_union : out  STD_LOGIC_VECTOR (132 downto 0));
end Unio_registers_32bit;

architecture Behavioral of Unio_registers_32bit is

begin

with union_enable select 

   out_union <='1' & tag & reg3 & reg2 &reg1 &reg0 when '1' ,
	
	             (others =>'0') when others ;

end Behavioral;

