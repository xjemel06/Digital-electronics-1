LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY testbench IS
END testbench;
 
ARCHITECTURE tb OF testbench IS 
 
    COMPONENT top_traffic
    PORT(
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    
	LED_o	 : out std_logic_vector(5 downto 0)
	);
    END COMPONENT;
    
	-- inputs
    signal clk_i    : std_logic;
    signal srst_n_i : std_logic;     
   -- outputs
	signal LED_o	: std_logic_vector(5 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   UUT: top_traffic PORT MAP (clk_i => clk_i,
                                srst_n_i => srst_n_i,
                                LED_o =>LED_o
   								);


	Clk_gen: process	-- NEW
  	begin
    	while Now < 5000 NS loop		-- NEW: DEFINE SIMULATION TIME
      		clk_i <= '0';
      		wait for 0.5 NS;
      		clk_i <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;

    -- Stimulus process
    stim_proc: process
    begin
        srst_n_i <= '1';
        wait for 500 NS;
        srst_n_i <= '0';
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        srst_n_i <= '1';
        wait;
    end process;

end tb;
