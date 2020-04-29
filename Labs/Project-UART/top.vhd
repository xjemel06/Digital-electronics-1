--Top

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

--Inputs & outputs

entity top is
port( clk_i : std_logic;
	  SW15_CPLD : std_logic;  --data_i 0
      SW11_CPLD : std_logic;  --data_i 1
      SW7_CPLD : std_logic;   --data_i 2
      SW3_CPLD : std_logic;   --data_i 3
      SW14_CPLD : std_logic;  --data_i 4
      SW10_CPLD : std_logic;  --data_i 5
      SW6_CPLD : std_logic;   --data_i 6
      SW2_CPLD : std_logic;   --data_i 7
      BTN1 : std_logic;		  --reset
      SW12_CPLD : std_logic;  --power
      SW8_CPLD : std_logic;   --baud rate
      SW4_CPLD : std_logic;   --parity
      SW0_CPLD : std_logic    --stop bits
	 );
end entity top;

architecture Behavioral of top is
	
    signal s_en : std_logic;
    
begin

    sub_clock : entity work.clock_enable
    port map( clk_i => clk_i,
              srst_n_i => BTN1 ,
              bdrt_i => SW8_CPLD,
              pwr_i => SW12_CPLD,
              clk_en_o => s_en
             );
             
    sub_multiplexer: entity work.multiplexer
    port map( clk_i => clk_i,
    		  data_i(0) => SW15_CPLD,
              data_i(1) => SW11_CPLD,
              data_i(2) => SW7_CPLD,
              data_i(3) => SW3_CPLD,
              data_i(4) => SW14_CPLD,
              data_i(5) => SW10_CPLD,
              data_i(6) => SW6_CPLD,
              data_i(7) => SW2_CPLD,
              srst_n_i => BTN1,
              parity_i => SW4_CPLD,
              stopbits_i => SW0_CPLD,
              clk_en_i => s_en
              );
    
end architecture Behavioral;
