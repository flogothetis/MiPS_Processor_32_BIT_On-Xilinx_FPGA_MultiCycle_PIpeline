--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:21:18 05/14/2016
-- Design Name:   
-- Module Name:   C:/Users/manolis/Desktop/Ergastirio5_new/Lab6_organwsh/lab6/Test_lab6.vhd
-- Project Name:  lab6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lab6_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_lab6 IS
END Test_lab6;
 
ARCHITECTURE behavior OF Test_lab6 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lab6_top
    PORT(
         address : INOUT  std_logic_vector(12 downto 0);
         rst : IN  std_logic;
         clk : IN  std_logic;
         ready_bit : OUT  std_logic;
         memory_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

	--BiDirs
   signal address : std_logic_vector(12 downto 0);

 	--Outputs
   signal ready_bit : std_logic;
   signal memory_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lab6_top PORT MAP (
          address => address,
          rst => rst,
          clk => clk,
          ready_bit => ready_bit,
          memory_out => memory_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
      -- hold reset state for 100 ns.
     -- wait for 100 ns;	;
		rst<='1';
      wait for clk_period*10;

		rst<='0';
	
		
		address<="1111011110010";--tag=1111
										 --index=01111
										 --wo=00
										 --bo=10
		
		wait for clk_period*15;
		rst<='0';
	
		
		address<="1111011110010";
		
		wait for clk_period*2;
		rst<='0';

		address<="1111111110010";
		
		wait for clk_period*15;
		rst<='0';

		address<="1111111110010";
		
		
		wait for clk_period*2;
		rst<='0';
	
		
		address<="1111011110010";--tag=1111
										 --index=01111
										 --wo=00
										 --bo=10
		
      -- insert stimulus here 
	  wait for clk_period*20;
      wait;
   end process;

END;
