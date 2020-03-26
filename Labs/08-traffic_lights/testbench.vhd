-- Code your testbench here
-----------------------------------------------------------------------------------library declaration
---------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

----------------------------------------------------------------------------------- Entity declaration
---------------------------------------------------------------------------------

entity testbench is
--empty
end testbench;

architecture tb of testbench is
  -- DUT component
  component traffic_lights is
  port(
	-- INPUTS
	clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
	ce_2Hz_i : in std_logic;	-- clock enable -- timing
    -- OUTPUTS
    lights_o  : out unsigned(6-1 downto 0)
    
    -- lights_o(5) - red traffic light 1
    -- lights_o(4) - yellow traffic light 1
    -- lights_o(3) - green traffic light 1
    
    
    -- lights_o(2) - red traffic light 2
    -- lights_o(1) - yellow traffic light 2
    -- lights_o(0) - green traffic light 2
  );
  end component;
  --INPUTS
  signal clk_in   	: std_logic := '0'; 
  signal srst_n_in 	: std_logic := '0';   
  signal ce_2Hz_in	: std_logic := '0';
  
  --OUTPUT
  signal lights_out	: unsigned(6-1 downto 0 );
  
  BEGIN
	UUT: traffic_lights port map(
      clk_i => clk_in,
      srst_n_i => srst_n_in,
      ce_2Hz_i => ce_2Hz_in,
      lights_o => lights_out 
    );
	
   -- Clock process definitions
	Clk_gen: process	
  	begin
    	while Now < 500 nS loop
      		clk_in <= '0';
      		wait for 0.5 NS;
      		clk_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;
    
    Clk_2Hz_gen: process	
  	begin
    	while Now < 500 nS loop
      		ce_2Hz_in <= '0';
      		wait for 0.5 NS;
      		ce_2Hz_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_2Hz_gen;
   
   -- Stimulus process
   stim_proc: process
   begin	
   	  
      srst_n_in <= '1';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      srst_n_in <= '0';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      srst_n_in <= '1';
      
      wait;
   end process;
end tb;
