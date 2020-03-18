library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for hex to seven-segment decoder
------------------------------------------------------------------------
entity hex_to_7seg is
    port (hex_i: in  std_logic_vector(4-1 downto 0);
          seg_o: out std_logic_vector(7-1 downto 0));
end entity hex_to_7seg;

------------------------------------------------------------------------
-- Architecture declaration for hex to seven-segment decoder
------------------------------------------------------------------------
architecture Behavioral of hex_to_7seg is
begin

    --------------------------------------------------------------------
    --         a
    --       -----          a: seg_o(6)
    --    f |     | b       b: seg_o(5)
    --      |  g  |         c: seg_o(4)
    --       -----          d: seg_o(3)
    --    e |     | c       e: seg_o(2)
    --      |     |         f: seg_o(1)
    --       -----          g: seg_o(0)
    --         d
    --------------------------------------------------------------------
    seg_o <= "0000001" when (hex_i = "0000") else   -- 0
             "1001111" when (hex_i = "0001") else   -- 1
	     "0010010" when (hex_i = "0010") else   -- 2
             "0000110" when (hex_i = "0011") else   -- 3
             "1001100" when (hex_i = "0100") else   -- 4
	     "0100100" when (hex_i = "0101") else   -- 5
             "0100000" when (hex_i = "0110") else   -- 6
	     "0001111" when (hex_i = "0111") else   -- 7
             "0000000" when (hex_i = "1000") else   -- 8
             "0000100" when (hex_i = "1001") else   -- 9
	     "0001000" when (hex_i = "1010") else   -- A
             "1100000" when (hex_i = "1011") else   -- B
	     "1110010" when (hex_i = "1100") else   -- C
             "1000010" when (hex_i = "1101") else   -- D
             "0110000" when (hex_i = "1110") else   -- E
             "0111000";                             -- F

end architecture Behavioral;
