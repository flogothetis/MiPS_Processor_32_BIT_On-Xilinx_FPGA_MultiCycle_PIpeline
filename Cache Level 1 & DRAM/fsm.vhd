library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsm is
    Port ( address  : in  STD_LOGIC_VECTOR (12 downto 0);
	         
           hit_miss_bit : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
			  wr_en_Union :  out  STD_LOGIC;
			  wr_en_reg0 : out  STD_LOGIC;
			  wr_en_reg1 : out  STD_LOGIC;
			  wr_en_reg2 : out  STD_LOGIC;
			  wr_en_reg3 : out  STD_LOGIC;
			  out_address : out  STD_LOGIC_VECTOR (10 downto 0);
           wr_en_cache : out  STD_LOGIC;
 
           ready_bit : out  STD_LOGIC);
end fsm;

architecture Behavioral of fsm is

TYPE State is (Reset,s0,s1,s2,s3,s4,s5);
signal st: State; 
signal i : STD_LOGIC_VECTOR (2 downto 0);



begin
	process 
		begin
		WAIT UNTIL clk'EVENT AND clk='1';
		
		if (rst ='1') then
			st <= Reset;
		else
			case st is
			when Reset =>
				st<=s0;
			when s0 =>
				i<="000";
				if (hit_miss_bit='1') then
					st<=s1;
				else
					st<=s2;
				end if;
			when s1 =>
					st<=s0;
			when s2 =>
				if (i="100") then
					st<=s4;
				else
					st<=s3;
				end if;
			when s3 =>
				i<=i+1;
				st<=s2;
			when s4 =>
				st<=s5;
			when s5 =>
				st<=s1;
			end case;
			
		end if; 
			
	end process;
	
	with st select
		
		
		out_address<=address(12 downto 4)&i(1 downto 0) when s2,
					address(12 downto 4)&i(1 downto 0) when others;
	 				
		wr_en_Union<='1' when st=s4 else
						'0' ;
				
		wr_en_cache<='1' when st=s4 else
						'0';
		
		wr_en_reg0 <= '1' when i="00" and st=s3 else 
							'0';	
		wr_en_reg1 <= '1' when i="01" and st=s3 else 
							'0';	
	
		wr_en_reg2 <= '1' when i="10" and st=s3 else 
							'0';	
	
		wr_en_reg3 <= '1' when i="11" and st=s3 else 
							'0';	
	  
		ready_bit <= '1' when st=s1 else 
							'0';	



end Behavioral;

