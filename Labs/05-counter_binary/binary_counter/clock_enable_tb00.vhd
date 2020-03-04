--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:20:26 03/04/2020
-- Design Name:   
-- Module Name:   /home/lab661/Documents/xjemel06/Digital-electronics-1/Labs/05-counter_binary/binary_counter/clock_enable_tb00.vhd
-- Project Name:  binary_counter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clock_enable
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
 
ENTITY clock_enable_tb00 IS
END clock_enable_tb00;
 
ARCHITECTURE behavior OF clock_enable_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_enable
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         clock_enable_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '1';

 	--Outputs
   signal clock_enable_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
   constant clock_enable_o_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_enable PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          clock_enable_o => clock_enable_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
--   clock_enable_o_process :process
--   begin
--		clock_enable_o <= '0';
--		wait for clock_enable_o_period/2;
--		clock_enable_o <= '1';
--		wait for clock_enable_o_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      srst_n_i <= '0';
      wait for 100 ns;	
      srst_n_i <= '1';

      wait for clk_i_period*10;
      srst_n_i <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
