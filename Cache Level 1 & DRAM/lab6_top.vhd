
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lab6_top is
    Port ( address : in  STD_LOGIC_VECTOR (12 downto 0);
			  rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
           ready_bit : out  STD_LOGIC;
           memory_out : out  STD_LOGIC_VECTOR (31 downto 0));
end lab6_top;

architecture Behavioral of lab6_top is

component Reg is
    Port ( rst:in std_logic;
	       DATA : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Unio_registers_32bit is
    Port ( reg0 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg1 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg3 : in  STD_LOGIC_VECTOR (31 downto 0);
           union_enable : in  STD_LOGIC;
			  tag : in STD_LOGIC_VECTOR (3 downto 0);
           out_union : out  STD_LOGIC_VECTOR (132 downto 0));
end component;

component cache is
port ( clk : in std_logic;
	we : in std_logic;
	addr : in std_logic_vector(4 downto 0);
	din : in std_logic_vector(132  downto 0);
	dout : out std_logic_vector(132 downto 0));
end component;

component control_hit_miss is
    Port ( tag_cache : in  STD_LOGIC_VECTOR (3 downto 0);
           tag : in  STD_LOGIC_VECTOR (3 downto 0);
           valid_bit : in  STD_LOGIC;
           hit_miss_out : out  STD_LOGIC);
end component;

component dmem is
port ( clk : in std_logic;
we : in std_logic;
addr : in std_logic_vector(10 downto 0);
din : in std_logic_vector(31  downto 0);
dout : out std_logic_vector(31 downto 0));
end component;


component fsm is
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
end component;


component mux is
    Port ( input_0	 : in  STD_LOGIC_VECTOR (31 downto 0);
           input_1	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  input_2	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  input_3 : in  STD_LOGIC_VECTOR (31 downto 0);  
           select_mux : in STD_LOGIC_VECTOR (1 downto 0);  
           mux_out		 : out  STD_LOGIC_VECTOR (31 downto 0)
			 );
end component;

signal tmp_wr_en_reg0,tmp_wr_en_reg1,tmp_wr_en_reg2,tmp_wr_en_reg3 ,
		 tmp_hit_miss_out,tmp_en_Union,tmp_wr_en_cache,tmp_ready_bit: std_logic;
signal tmp_out_reg0,tmp_out_reg1,tmp_out_reg2,tmp_out_reg3,
		 tmp_dmem_out: STD_LOGIC_VECTOR (31 downto 0);
signal tmp_out_union,tmp_cache_out : STD_LOGIC_VECTOR (132 downto 0);
signal tmp_out_address : STD_LOGIC_VECTOR (10 downto 0); 
begin

reg0: Reg port map(
      rst=>rst,
	       DATA =>tmp_dmem_out,
           WrEn =>tmp_wr_en_reg0,
           CLK =>clk,
           Dout =>tmp_out_reg0 );
			  
reg1: Reg port map(
      rst=>rst,
	       DATA =>tmp_dmem_out,
           WrEn =>tmp_wr_en_reg1,
           CLK =>clk,
           Dout =>tmp_out_reg1 );
			  
reg2: Reg port map(
      rst=>rst,
	       DATA =>tmp_dmem_out,
           WrEn =>tmp_wr_en_reg2,
           CLK =>clk,
           Dout => tmp_out_reg2);
			  
reg3: Reg port map(
      rst=>rst,
	       DATA =>tmp_dmem_out,
           WrEn =>tmp_wr_en_reg3,
           CLK =>clk,
           Dout => tmp_out_reg3);			  


hit_miss: control_hit_miss Port map( 
			tag_cache =>tmp_cache_out(131 downto 128),
         tag => address(12 downto 9),
         valid_bit =>tmp_cache_out(132 ),
         hit_miss_out =>tmp_hit_miss_out );
			
			
f_s_m: fsm Port map(
		     address => address,
           hit_miss_bit =>tmp_hit_miss_out ,
			  clk => clk,
			  rst => rst,
			  wr_en_Union => tmp_en_Union,
			  wr_en_reg0 =>tmp_wr_en_reg0,
			  wr_en_reg1 =>tmp_wr_en_reg1,
			  wr_en_reg2 =>tmp_wr_en_reg2,
			  wr_en_reg3 =>tmp_wr_en_reg3,
			  out_address => tmp_out_address,
           wr_en_cache => tmp_wr_en_cache,
           ready_bit => tmp_ready_bit  );

union_reg: Unio_registers_32bit Port map(
			 reg0 =>tmp_out_reg0,
           reg1 =>tmp_out_reg1,
           reg2 =>tmp_out_reg2,
           reg3=>tmp_out_reg3,
           union_enable=>tmp_en_Union,
			  tag=> address(12 downto 9),
           out_union =>tmp_out_union);


cache_memory: cache port map( 
		clk => clk ,
		we => tmp_wr_en_cache,
		addr =>address(8 downto 4), -----index
		din => tmp_out_union,
		dout =>tmp_cache_out);

d_memory: dmem port map ( 
	clk => clk,
	we =>'0'  ,
	addr => tmp_out_address,
	din =>"00000000000000000000000000000000" ,
	dout => tmp_dmem_out);

Mux1 : mux Port map (
		input_0	=>tmp_cache_out(31 downto 0),
      input_1	=>tmp_cache_out(63 downto 32),
		input_2	=>tmp_cache_out(95 downto 64),
		input_3 => tmp_cache_out(127 downto 96) ,
      select_mux =>  address(3 downto 2),--word offset
      mux_out	=>	memory_out);
		
ready_bit<=tmp_ready_bit;
end Behavioral;

