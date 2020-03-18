library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 


--Entity
entity clock_enable_sw is
generic (
    g_NPERIOD : unsigned(16-1 downto 0)
);
port (
    clk_i          	: in  std_logic;
    srst_n_i       	: in  std_logic;
    ce_100Hz_i		: in std_logic;
    clock_enable_o 	: out std_logic
);
end entity clock_enable_sw;


--Architecture
architecture Behavioral of clock_enable_sw is
    signal s_count : unsigned(16-1 downto 0) := x"0000";
begin




    p_clk_enable : process(srst_n_i, ce_100Hz_i,clk_i, clock_enable_o)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                s_count <= (others => '0');   -- Clear all bits
                clock_enable_o <= '0';
            else
            	if ce_100Hz_i = '1' then
                    if s_count >= (g_NPERIOD-1) then
                        s_count <= (others => '0');
                        clock_enable_o <= '1';
                    else
                        s_count <= s_count + x"0001";
                        clock_enable_o <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process p_clk_enable;

end architecture Behavioral;
