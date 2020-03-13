LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver_7seg
    PORT(
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    data0_i  : in  std_logic_vector(4-1 downto 0);  -- Input values
    data1_i  : in  std_logic_vector(4-1 downto 0);
    data2_i  : in  std_logic_vector(4-1 downto 0);
    data3_i  : in  std_logic_vector(4-1 downto 0);
    dp_i     : in  std_logic_vector(4-1 downto 0);  -- Decimal points
    
    dp_o     : out std_logic;                       -- Decimal point
    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
	);
    END COMPONENT;
    
	-- inputs
   signal 	clk_i 	 : std_logic := '0';
   signal 	srst_n_i : std_logic := '0';
   signal   data0_i  : std_logic_vector(4-1 downto 0) := "0000";
   signal   data1_i  : std_logic_vector(4-1 downto 0) := "0011";
   signal   data2_i  : std_logic_vector(4-1 downto 0) := "0001";
   signal   data3_i  : std_logic_vector(4-1 downto 0) := "0100";
   signal 	dp_i     : std_logic_vector(4-1 downto 0) := "1101";
   
   -- outputs
   signal   dp_o     : std_logic;                
   signal   seg_o    : std_logic_vector(7-1 downto 0);
   signal 	dig_o    : std_logic_vector(4-1 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   UUT: driver_7seg PORT MAP (clk_i => clk_i,
   							dp_i => dp_i,
   							srst_n_i => srst_n_i,
                            data0_i => data0_i,
                            data1_i => data1_i,
                            data2_i => data2_i,
                            data3_i => data3_i,
                            dp_o => dp_o,
                            seg_o => seg_o,
                            dig_o => dig_o);


	Clk_gen: process	-- NEW
  	begin
    	while Now < 500 NS loop		-- NEW: DEFINE SIMULATION TIME
      		clk_i <= '0';
      		wait for 5 NS;
      		clk_i <= '1';
      		wait for 5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;

    -- Stimulus process
    stim_proc: process
    begin
        srst_n_i <= '1';
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        srst_n_i <= '0';
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        srst_n_i <= '1';
        wait;
    end process;

end;
