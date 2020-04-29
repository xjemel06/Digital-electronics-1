-- Generating signal

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;


--Inputs & outputs
--  1 MHz
entity clock_enable is
generic ( g_rates : unsigned(16-1 downto 0) := x"0341"; --1200 bps low
          g_ratef : unsigned(16-1 downto 0) := x"0034" --19200 bps high
         );

port (	 clk_i : in std_logic;       -- input clock signal
 		 bdrt_i : in std_logic;      -- baudrate switch
         srst_n_i : in std_logic;    -- synchronous reset
         pwr_i : in std_logic;       -- switch on/off active in 0
         clk_en_o : out std_logic    -- output from clock enable
         );
         
end entity clock_enable;

-- Internal signal

architecture Behavioral of clock_enable is
 signal s_cnt: unsigned(16-1 downto 0) := x"0000";
 
 begin
  p_clock : process (clk_i)
  begin
  	if rising_edge(clk_i) then         --raising edge triggers process
    	if pwr_i = '0' then             --turnig process on by switch
        	if srst_n_i = '0' then      --control for reseting of program
            	s_cnt <= (others => '0');
            	clk_en_o <= '0';
            elsif bdrt_i = '0' then            --setting of slower baud rate
            	if s_cnt >= (g_rates-'1') then
            	 	s_cnt <= (others => '0');
                 	clk_en_o <= '1';
             	else
               	 	s_cnt <= s_cnt + x"0001";
                	clk_en_o <= '0';
                end if;
             elsif bdrt_i = '1' then
             	if s_cnt >= (g_ratef-'1') then
            	 	s_cnt <= (others => '0');
                 	clk_en_o <= '1';
             	else
               	 	s_cnt <= s_cnt + x"0001";
                	clk_en_o <= '0';
                end if;
             end if;
        end if;
     end if; 
        
  end process p_clock;

end architecture Behavioral;



