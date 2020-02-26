----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:38 02/26/2020 
-- Design Name: 
-- Module Name:    half_adder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
------------------------------------------------------------------------
--
-- Half adder.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for half adder
------------------------------------------------------------------------
entity half_adder is
    port (b_i:     in  std_logic;
          a_i:     in  std_logic;
          carry_o: out std_logic;
          sum_o:   out std_logic);
end entity half_adder;

------------------------------------------------------------------------
-- Architecture declaration for half adder
------------------------------------------------------------------------
architecture Behavioral of half_adder is
begin

    sum_o <= a_i xor b_i;
    carry_o <= a_i and b_i;

end architecture Behavioral;