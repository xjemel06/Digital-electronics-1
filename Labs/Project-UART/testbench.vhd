library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity testbench is
end testbench;


architecture tb of testbench is
component top
port( clk_i : std_logic;      
	  SW15_CPLD : std_logic;  --data_i 0
      SW11_CPLD : std_logic;  --data_i 1
      SW7_CPLD : std_logic;   --data_i 2
      SW3_CPLD : std_logic;   --data_i 3
      SW14_CPLD : std_logic;  --data_i 4
      SW10_CPLD : std_logic;  --data_i 5
      SW6_CPLD : std_logic;   --data_i 6
      SW2_CPLD : std_logic;   --data_i 7
      BTN1 : std_logic;		--reset
      SW12_CPLD : std_logic;  --power
      SW8_CPLD : std_logic;   --baud rate
      SW4_CPLD : std_logic;   --parity
      SW0_CPLD : std_logic   --stop bits
      );

end component;

signal clk_i : std_logic;
signal srst_n_i :std_logic;
signal data_i : std_logic_vector(8-1 downto 0);
signal pwr_i : std_logic;
signal parity_i : std_logic;
signal stopbits_i : std_logic;
signal bdrt_i : std_logic;
signal mux_o : std_logic;

begin

UUT: top port map ( clk_i => clk_i,      
	                SW15_CPLD => data_i(0),  --data_i 0
                    SW11_CPLD => data_i(1),  --data_i 1
                    SW7_CPLD => data_i(2),   --data_i 2
                    SW3_CPLD => data_i(3),   --data_i 3
                    SW14_CPLD => data_i(4),  --data_i 4
                    SW10_CPLD => data_i(5),  --data_i 5
                    SW6_CPLD => data_i(6),   --data_i 6
                    SW2_CPLD => data_i(7),   --data_i 7
                    BTN1 => srst_n_i,	 	 --reset
                    SW12_CPLD => pwr_i,      --power
                    SW8_CPLD => bdrt_i,      --baud rate
                    SW4_CPLD => parity_i,    --parity
                    SW0_CPLD => stopbits_i   --stop bits
                );





clk_sim: process
 begin
 while now < 20 MS loop
 	clk_i <= '0';
    wait for 0.5 us;
 	clk_i <= '1';
    wait for 0.5 us;
 end loop;
 wait;
end process clk_sim;


simulation:process
	begin
    	srst_n_i <= '1';
        wait until rising_edge(clk_i);
		data_i <= "11110000";
        parity_i <= '0';
        stopbits_i <= '0';
        bdrt_i <= '0';
        pwr_i <= '0';
        wait for 1 MS;
        srst_n_i <= '0';
        wait for 0.1 MS;
        srst_n_i <= '1';
        data_i <= "10011111";
        parity_i <= '1';
        stopbits_i <= '1';
        bdrt_i <= '1';
        wait for 2 MS;
        pwr_i <= '1';
        wait;
	end process;

end tb;
 
