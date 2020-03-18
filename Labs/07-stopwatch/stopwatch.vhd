library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity stopwatch is
port(
    clk_i    	: in  std_logic;
    cnt_en_i 	: in  std_logic;
    ce_100Hz_i	: in  std_logic;
    srst_n_i 	: in  std_logic;    
    
    hth_l_o : out std_logic_vector(4-1 downto 0);
    hth_h_o : out std_logic_vector(4-1 downto 0);
    sec_l_o : out std_logic_vector(4-1 downto 0);
    sec_h_o : out std_logic_vector(4-1 downto 0)
	);
end entity stopwatch;



architecture Behavioral of stopwatch is
    signal s_cnt0 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt1 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt2 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt3 : unsigned(4-1 downto 0) := (others => '0');
    signal s_en  : std_logic;
begin

    CLK_EN_0 : entity work.clock_enable_sw
        generic map(g_NPERIOD => x"0064")
        port map(clk_i => clk_i,
                srst_n_i => srst_n_i,
                ce_100Hz_i => ce_100Hz_i,
                clock_enable_o => s_en);

    
    
    p_counter : process (clk_i, cnt_en_i, srst_n_i, s_en, s_cnt0, s_cnt1, s_cnt2, s_cnt3)
    begin
    	if rising_edge(clk_i) then
        	if srst_n_i = '0' then
            	s_cnt0 <= (others=> '0');
                s_cnt1 <= (others=> '0');
                s_cnt2 <= (others=> '0');
                s_cnt3 <= (others=> '0') ;               
            elsif cnt_en_i = '1' then
            	if s_en = '1' then
            		if s_cnt0 = "1001" then
                    	s_cnt0 <= (others => '0');
                        if s_cnt1 = "1001" then
                    		s_cnt1 <= (others => '0');
                        	if s_cnt2 = "1001" then
                                s_cnt2 <= (others => '0');
								if s_cnt3 = "0101" then
                                    s_cnt3 <= (others => '0');
                                else
                                    s_cnt3 <= s_cnt3 + "0001";
                                end if;
                            else
                                s_cnt2 <= s_cnt2 + "0001";
                            end if;
                    	else
                    		s_cnt1 <= s_cnt1 + "0001";
                        end if;
                    else
                    	s_cnt0 <= s_cnt0 + "0001";
                    end if;
                end if;    
        	end if;
    	end if;
    end process p_counter;
    
    
	p_connect : process (s_cnt0, s_cnt1, s_cnt2, s_cnt3, hth_l_o, hth_h_o, sec_l_o, sec_h_o)
	begin
        hth_l_o <= std_logic_vector(s_cnt0);
        hth_h_o <= std_logic_vector(s_cnt1);
        sec_l_o <= std_logic_vector(s_cnt2);
        sec_h_o <= std_logic_vector(s_cnt3);   
    end process p_connect;
end architecture Behavioral;
