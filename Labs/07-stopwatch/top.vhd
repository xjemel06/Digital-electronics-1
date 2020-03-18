library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
port(
    clk_i    	: in  std_logic;
    cnt_en_i 	: in  std_logic;
    ce_100Hz_i	: in  std_logic;
    srst_n_i 	: in  std_logic;    
    dp_i     : in  std_logic_vector(4-1 downto 0);  -- Decimal points
    
    dp_o     : out std_logic;                       -- Decimal point
    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
    );
end entity top;


architecture Behavioral of top is
    signal s_0 : std_logic_vector(4-1 downto 0) := (others => '0');
    signal s_1 : std_logic_vector(4-1 downto 0) := (others => '0');
    signal s_2 : std_logic_vector(4-1 downto 0) := (others => '0');
    signal s_3 : std_logic_vector(4-1 downto 0) := (others => '0');
begin



    STOP_WATCH : entity work.stopwatch
        --generic map(g_NPERIOD => x"0064")   -- x"0064"
        port map(clk_i => clk_i,
                srst_n_i => srst_n_i,
                ce_100Hz_i => ce_100Hz_i,
                cnt_en_i =>cnt_en_i,
                hth_l_o => s_0,
                hth_h_o => s_1,
                sec_l_o => s_2,
                sec_h_o => s_3);
            
                
                
    SEG_DRIVER : entity work.driver_7seg
        --generic map(g_NPERIOD => x"0064")   -- x"0064"
        port map(clk_i => clk_i,
                srst_n_i => srst_n_i,
                dp_i => dp_i,
                dp_o => dp_o,
                seg_o => seg_o,
                dig_o => dig_o,
                data0_i => s_0,
                data1_i => s_1,
                data2_i => s_2,
                data3_i => s_3);  

    
    
end architecture Behavioral;    
