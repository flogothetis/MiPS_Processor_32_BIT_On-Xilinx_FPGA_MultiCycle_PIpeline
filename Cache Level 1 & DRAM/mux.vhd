
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity mux is
    Port ( input_0	 : in  STD_LOGIC_VECTOR (31 downto 0);
           input_1	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  input_2	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  input_3 : in  STD_LOGIC_VECTOR (31 downto 0);  
           select_mux : in STD_LOGIC_VECTOR (1 downto 0);  
           mux_out		 : out  STD_LOGIC_VECTOR (31 downto 0)
			 );
end mux;

architecture Behavioral of mux is

begin
	
	WITH select_mux select	
	--αναλόγα με το PC_sel δίνουμε την έξοδο του πολυπλέκτη

		mux_out<=	input_0 when "00",
					   input_1 when "01",
						input_2 when "10",
						input_3 when others;
						
end Behavioral;

