--Top

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

--Inputs & outputs

entity top is
port( clk_i : in std_logic;     --clock signal
	  SW15_CPLD : in std_logic; --data_i 0
      SW11_CPLD : in std_logic; --data_i 1
      SW7_CPLD : in std_logic;  --data_i 2
      SW3_CPLD : in std_logic;  --data_i 3
      SW14_CPLD :in std_logic;  --data_i 4
      SW10_CPLD :in std_logic;  --data_i 5
      SW6_CPLD :in std_logic;   --data_i 6
      SW2_CPLD :in std_logic;   --data_i 7
      BTN1 :in std_logic;		--reset
      SW12_CPLD :in std_logic;  --power
      SW8_CPLD :in std_logic;   --baud rate
      SW4_CPLD :in std_logic;   --parity
      SW0_CPLD :in std_logic   --stop bits
	 );
end entity top;

-- Assigning of signals to elements on boards

architecture Behavioral of top is
    signal s_en : std_logic;              --signal between clock_enable and multiplexer
    
begin

    sub_clock : entity work.clock_enable  --inputs and outputs in clock_enable
    port map( clk_i => clk_i,
              srst_n_i => BTN1 ,
              bdrt_i => SW8_CPLD,
              pwr_i => SW12_CPLD,
              clk_en_o => s_en            --synchronisig signal for multiplexer
             );
             
    sub_multiplexer: entity work.multiplexer    --inputs and outputs in multiplexer
    port map( clk_i => clk_i,
    		  data_i(0) => SW2_CPLD,
              data_i(1) => SW6_CPLD,
              data_i(2) => SW10_CPLD,
              data_i(3) => SW14_CPLD,
              data_i(4) => SW3_CPLD,
              data_i(5) => SW7_CPLD,
              data_i(6) => SW11_CPLD,
              data_i(7) => SW15_CPLD,
              srst_n_i => BTN1,
              parity_i => SW4_CPLD,
              stopbits_i => SW0_CPLD,
              clk_en_i => s_en
              );
    
end architecture Behavioral;
