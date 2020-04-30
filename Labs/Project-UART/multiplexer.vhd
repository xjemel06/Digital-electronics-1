-- Multplexing signals 

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
 
--Inputs & outputs
entity multiplexer is

-- Setting of constants
generic ( g_sbit1 : unsigned(3 downto 0) := "1010";
		  g_sbit2 : unsigned(3 downto 0) := "1011"
          );
         

 port( clk_i :in std_logic;                        --input clock signal
       srst_n_i: in std_logic;                     --synchronous reset
       clk_en_i: in std_logic;                     --clock signal from enable
 	   data_i : in std_logic_vector(8-1 downto 0); --data bits
       parity_i : in std_logic;                    --parity even/odd,0/1
       stopbits_i : in std_logic;  				   --number of stop bits 1/2,0/1
 	   mux_o: out std_logic                        --output
 		);
        
end entity multiplexer;        

-- Internal signal        
        
architecture Behavioral of multiplexer is
     signal s_bits: unsigned(4-1 downto 0) := "0000";  --number of output bits
     signal s_parity: std_logic;
begin

--Process of synchronisation and 
 p_bits: process(clk_i)                              --number of bits
 begin
 	if rising_edge(clk_i) then                       --synchronising proces with clk_i
    	if srst_n_i = '0' then                       -- reseting of signl
            s_bits <= "0000";
        elsif clk_en_i = '1' then
        	s_bits <= s_bits + 1;
        	if stopbits_i = '0' then                 -- declaration of length of bit word
            	if s_bits = g_sbit1 then             -- one stop bit
                	s_bits <= "0000";
                end if;
            elsif stopbits_i = '1' then
            	if s_bits = g_sbit2 then             -- two stop bits
                	s_bits <= "0000";
                end if;
            end if;
        end if;
     end if;
 end process p_bits;
 
 --Process for declaration of parity bit
 p_par: process(clk_i)                      --declaration of parity bit
 begin
 	if rising_edge(clk_i) then
    	if srst_n_i = '0' then
            s_parity <= '0';
        elsif clk_en_i = '1' then
            	s_parity <= ((((((((parity_i xor data_i(0)) xor data_i(1)) xor data_i(2)) 									  xor data_i(3))xor data_i(4)) xor data_i(5)) xor											data_i(6)) xor data_i(7));
        end if;
 	end if;
 end process p_par;

 --Process of multiplexer
 p_mux: process(s_bits)                    --multiplexing all data on output
 begin
	case s_bits is
        when "0000" =>
            mux_o <= '0';            --start bit
        when "0001" =>
            mux_o <= data_i(0);      -- data bit LSB        
        when "0010" =>
            mux_o <= data_i(1);      -- data bit
        when "0011" =>
            mux_o <= data_i(2);      -- data bit
        when "0100" =>
            mux_o <= data_i(3);      -- data bit
        when "0101" =>
            mux_o <= data_i(4);      -- data bit
        when "0110" =>
            mux_o <= data_i(5);      -- data bit
        when "0111" =>
            mux_o <= data_i(6);      -- data bit
        when "1000" =>
            mux_o <= data_i(7);      -- data bit MSB
        when "1001" => 
            mux_o <= s_parity;       -- parity bit
        when "1010" =>
            mux_o <= '1';            -- stop bit
        when "1011" =>
            mux_o <= '1';            -- stop bit
        when others =>
            mux_o <= '1';
  		end case;
 end process p_mux; 	
end architecture Behavioral;
