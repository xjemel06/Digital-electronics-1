--Testbench
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity testbench is
end testbench;


architecture test of testbench is

--Inputs & outputs

component top
port( clk_i : in std_logic;      --clock signal
	  SW15_CPLD : in std_logic;  --data_i 7
      SW11_CPLD : in std_logic;  --data_i 6
      SW7_CPLD : in std_logic;   --data_i 5
      SW3_CPLD : in std_logic;   --data_i 4
      SW14_CPLD : in std_logic;  --data_i 3
      SW10_CPLD : in std_logic;  --data_i 2
      SW6_CPLD : in std_logic;   --data_i 1
      SW2_CPLD : in std_logic;   --data_i 0
      BTN1 : in std_logic;		 --reset
      SW12_CPLD : in std_logic;  --power
      SW8_CPLD : in std_logic;   --baud rate
      SW4_CPLD : in std_logic;   --parity
      SW0_CPLD : in std_logic    --stop bits
      );
end component;

-- Signals for simulation
signal pwr_i : std_logic;                        -- power on/off
signal clk_i : std_logic;                        --input clock signal
signal srst_n_i :std_logic;                      -- reset
signal data_i : std_logic_vector(8-1 downto 0);  --data bits
signal parity_i : std_logic;                     -- parity even/odd
signal stopbits_i : std_logic;                   -- stopbits 1/2
signal bdrt_i : std_logic;                       -- baudrate switch
signal mux_o : std_logic;                        --output

begin

-- Assigning of signals to elements on boards

UUT: top port map ( clk_i => clk_i,      
	                SW2_CPLD => data_i(0),  --data_i 0
                    SW6_CPLD => data_i(1),  --data_i 1
                    SW10_CPLD => data_i(2),   --data_i 2
                    SW14_CPLD => data_i(3),   --data_i 3
                    SW3_CPLD => data_i(4),  --data_i 4
                    SW7_CPLD => data_i(5),  --data_i 5
                    SW11_CPLD => data_i(6),   --data_i 6
                    SW15_CPLD => data_i(7),   --data_i 7
                    BTN1 => srst_n_i,	 	 --reset
                    SW12_CPLD => pwr_i,      --power
                    SW8_CPLD => bdrt_i,      --baud rate
                    SW4_CPLD => parity_i,    --parity
                    SW0_CPLD => stopbits_i   --stop bits
                );


-- Setting of simulation parameters
--Signal generated for simulation
clk_sim: process
 begin
 while now < 5.5 MS loop
 	clk_i <= '0';
    wait for 0.5 us;     -- application of used frequency 1 MHz
 	clk_i <= '1';
    wait for 0.5 us;
 end loop;
 wait;
end process clk_sim;


-- Setting of simulation parameters

simulation:process
	begin
    	pwr_i <= '1';                   --power off
    	srst_n_i <= '1';                -- setting reset off
        wait until rising_edge(clk_i);
        wait for 5 uS;
		data_i <= "11111111";           -- data bits
        parity_i <= '0';                -- even parity
        stopbits_i <= '0';              -- one stop bit
        bdrt_i <= '1';                  -- setting slower bit rate
        pwr_i <= '0';                   -- turnig system on
        wait for 1.2 MS;
        srst_n_i <= '0';                -- reseting the system
        wait for 0.01 MS;
        srst_n_i <= '1';                -- setting reset off
        data_i <= "00000000";           -- data bits
        parity_i <= '1';                -- odd parity
        stopbits_i <= '1';              -- two stop bits
        bdrt_i <= '0';                  -- setting faster bitrate        
        wait for 3.5 MS;
        pwr_i <= '1';                   -- shutting system down
        wait;
	end process;

end test;
 
