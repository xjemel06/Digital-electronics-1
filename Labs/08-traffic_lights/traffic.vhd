------------------------------------------------------------------------
-- Library declaration
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration 
------------------------------------------------------------------------

entity traffic_lights is
port(
	-- INPUTS
	clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
	ce_2Hz_i : in std_logic;	-- clock enable - timing
    -- OUTPUTS
    lights_o  : out unsigned(6-1 downto 0)
    
    -- lights_o(5) - red traffic light 1
    -- lights_o(4) - yellow traffic light 1
    -- lights_o(3) - green traffic light 1
    
    
    -- lights_o(2) - red traffic light 2
    -- lights_o(1) - yellow traffic light 2
    -- lights_o(0) - green traffic light 2
);
end entity traffic_lights;

------------------------------------------------------------------------
-- Architecture declaration for stopwatch
------------------------------------------------------------------------
architecture Behavioral of traffic_lights is

type States is (RR0, GR1, YR2, RR3, RG4, RY5);

signal count: unsigned(4-1 downto 0);
constant c_5sec: unsigned(4-1 downto 0) := x"9"; -- using 2Hz
constant c_1sec: unsigned(4-1 downto 0) := x"1"; -- using 2Hz
signal s_state: States := RR0;

begin

------------------------------------------------------------------------
-- process traffic - changes s_state to match the desired algorithm
------------------------------------------------------------------------
  traffic: process(clk_i, srst_n_i)
  begin

  if srst_n_i = '0' then -- synchronous reset, active low
      count <= x"0";
      s_state <= RR0;
  elsif rising_edge(clk_i) and ce_2Hz_i = '1' then -- Rising clock edge + enable
      case s_state is
          when RR0 =>
              if count >= c_1sec then
                  s_state <= GR1;
                  count <= x"0";
              else
                  count <= count + '1';
              end if;
          when GR1 =>
              if count >= c_5sec then
                  s_state <= YR2;
                  count <= x"0";
              else
                  count <= count + '1';
              end if;
          when YR2 =>
              if count >= c_1sec then
                  s_state <= RR3;
                  count <= x"0";
              else
                  count <= count + '1';
              end if;
          when RR3 =>
              if count >= c_1sec then
                  s_state <= RG4;
                  count <= x"0";
              else
                  count <= count + '1';
              end if;
          when RG4 =>
              if count >= c_5sec then
                  s_state <= RY5;
                  count <= x"0";
              else
                  count <= count + '1';
              end if;
          when RY5 =>
              if count >= c_1sec then
                  s_state <= RR0;
                  count <= x"0";
              else
                  count <= count + '1';
              end if;
          when others =>
              s_state <= RR0;
              count <= x"0";
      end case;   
  end if;
  end process traffic;
------------------------------------------------------------------------
-- process assign_out - assigns output to each state of s_state
------------------------------------------------------------------------
  assign_out: process(s_state)
  begin
      case s_state is
          when RR0 => lights_o <= "011011";
          when GR1 => lights_o <= "110011";
          when YR2 => lights_o <= "101011";
          when RR3 => lights_o <= "011011";
          when RG4 => lights_o <= "011110";
          when RY5 => lights_o <= "011101";
          when others => lights_o <= "011011";
       end case;
  end process assign_out;
end architecture Behavioral;

