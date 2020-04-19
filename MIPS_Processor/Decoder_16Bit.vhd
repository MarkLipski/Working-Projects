----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:03:29 10/29/2015 
-- Design Name: 
-- Module Name:    Decoder-8Bit - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity Decoder_16Bit is
	Port ( B : in UNSIGNED(3 downto 0);
           O : out UNSIGNED(15 downto 0));
end Decoder_16Bit;

architecture Behavioral of Decoder_16Bit is
begin
	process(B)
	begin
		for I in 0 to 15 loop
			if(I = B) then
				O(I) <= '1';
			else 
				O(I) <= '0';
			end if;
		end loop;
	end process;
end Behavioral;

