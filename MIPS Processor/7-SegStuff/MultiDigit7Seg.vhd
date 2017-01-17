----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:04:54 02/01/2016 
-- Design Name: 
-- Module Name:    MultiDigit7Seg - Behavioral 
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

entity MultiDigit7Seg is
	Port ( data : in std_logic_vector(15 downto 0);
				clk : in std_logic;
           OutBit : out STD_LOGIC_VECTOR(7 downto 0);
			  ledSel : out std_logic_vector(3 downto 0));
end MultiDigit7Seg;

architecture Behavioral of MultiDigit7Seg is
	component Display_7Segment
		Port ( inBit : in std_logic_vector(3 downto 0);
           OutBit : out STD_LOGIC_VECTOR(6 downto 0));
	end component;
	type digitSize is array (natural range<>) of std_logic_vector(3 downto 0);
	signal digit : digitSize(3 downto 0);
	signal digitSel : std_logic_vector(3 downto 0);
	signal display7 : std_logic_vector(3 downto 0);
	signal clkDiv : unsigned(11 downto 0) := (others => '0');
begin
	
	LED : Display_7Segment port map(display7, OutBit(6 downto 0));
	ledSel <= digitSel;
	OutBit(7) <= '1';
process(digit, data, clk,digitSel)
begin
	--Assigns the values to the different signals based upon the button pressed
	digit(0) <= data(3 downto 0);
	digit(1) <= data(7 downto 4);
	digit(2) <= data(11 downto 8);
	digit(3) <= data(15 downto 12);
	
	if(rising_edge(clk)) then
		--Implement the clock divider
		clkDiv <= clkDiv + 1;
		if(clkDiv = "111111111111") then
			--Cycles between each digit
			if(digitSel = "1111") then
				digitSel <= "1110";
			elsif(digitSel = "1110") then
				digitSel <= "1101";
			elsif(digitSel = "1101") then
				digitSel <= "1011";
			elsif(digitSel = "1011") then
				digitSel <= "0111";
			else
				digitSel <= "1110";
			end if;
		end if;
	end if;
	
	--Corresponds each different set of signals with the corresponding digit
	if(digitSel = "0111") then
		display7 <= digit(0);
	elsif(digitSel = "1011") then
		display7 <= digit(1);
	elsif(digitSel = "1101") then
		display7 <= digit(2);
	elsif(digitSel = "1110") then
		display7 <= digit(3);
	else
		display7 <= "0000";
	end if;
	
end process;

end Behavioral;

