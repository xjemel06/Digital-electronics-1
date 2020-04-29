-- Multplexing signals 

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
 
--Inputs & outputs
entity multiplexer is

generic ( g_sbit1 : unsigned(3 downto 0) := "1010";
		  g_sbit2 : unsigned(3 downto 0) := "1011"
          );
         

 port( clk_i :in std_logic;                        --input clock signal
       srst_n_i: in std_logic;                     --synchronous reset
       clk_en_i: in std_logic;                     --clock signal from enable
 	   data_i : in std_logic_vector(8-1 downto 0); --data bits
       parity_i : in std_logic;                    --parity even/odd,0/1
       stopbits_i : in std_logic;  				   --number of stop bits 1/2,1/0
 	   mux_o: out std_logic                        --output
 		);
        
end multiplexer;        

-- Internal signal        
        
architecture Behavioral of multiplexer is
     signal s_bits: unsigned(4-1 downto 0) := x"0";  --number of output bits
     signal s_parity_o: std_logic;
begin

 p_par: process(clk_i,parity_i)                      --declaration of parity bit
 begin
 	if rising_edge(clk_i) then
    	if srst_n_i = '0' then
            s_parity_o <= '0';
        elsif clk_i = '1' then
        	if parity_i = '0' then
            	s_parity_o <= ((((((((parity_i xor data_i(0)) xor data_i(1)) xor 									   data_i(2)) xor data_i(3)) xor data_i(4)) 									  xor data_i(5)) xor data_i(6)) xor 											  data_i(7));
            end if;
        end if;
 	end if;
 end process p_par;

 p_bits: process(clk_i)                              --number of bits
 begin
 	if rising_edge(clk_i) then
    	if srst_n_i = '0' then
            s_bits <= (others => '0');
        	mux_o <= '0';
        elsif clk_en_i = '1' then
        	if stopbits_i = '0' then
            	if s_bits = g_sbit1 then
                	s_bits <= x"0";
                else
        			s_bits <= s_bits + 1;
                end if;
            elsif stopbits_i = '1' then
            	if s_bits = g_sbit2 then
                	s_bits <= x"0";
                else
        			s_bits <= s_bits + 1;
                end if;
            end if;
        end if;
     end if;
 end process p_bits;


 p_mux: process(s_bits)                             --puting all bits together
 begin
 	case s_bits is
 	when x"0" =>
    	mux_o <= '0';
    when x"1" =>
    	mux_o <= data_i(0);                         --start bit
    when x"2" =>
    	mux_o <= data_i(1);                         -- data bits
    when x"3" =>
    	mux_o <= data_i(2);
    when x"4" =>
    	mux_o <= data_i(3);
    when x"5" =>
    	mux_o <= data_i(4);
    when x"6" =>
    	mux_o <= data_i(5);
    when x"7" =>
    	mux_o <= data_i(6);
    when x"8" =>
    	mux_o <= data_i(7);
    when x"9" =>
    	mux_o <= s_parity_o;                        -- parity bit
    when x"A" =>
    	mux_o <= '1';                               -- stop bit
    when x"B" =>
    	mux_o <= '1';                               -- stop bit
    when others =>
     	mux_o <= '1';
    end case;
   end process p_mux; 	
end architecture Behavioral;
