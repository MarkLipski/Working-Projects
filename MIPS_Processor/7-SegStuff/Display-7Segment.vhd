----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:20:52 10/29/2015 
-- Design Name: 
-- Module Name:    Display-7Segment - Behavioral 
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


entity Display_7Segment is
	Port ( inBit : in std_logic_vector(3 downto 0);
           OutBit : out STD_LOGIC_VECTOR(6 downto 0));
end Display_7Segment;

architecture Behavioral of Display_7Segment is
signal Sig : UNSIGNED(15 downto 0);
component Decoder_16Bit
	port (B : in UNSIGNED(3 downto 0);
			  O : out UNSIGNED(15 downto 0));
end component;
begin
	g : Decoder_16Bit port Map(unsigned(inBit), Sig);
	OutBit(0) <= Sig(1) or Sig(4) or Sig(11) or Sig(13);
	OutBit(1) <= Sig(5) or Sig(6) or Sig(11) or Sig(12) or Sig(14) or Sig(15);
	OutBit(2) <= Sig(2) or Sig(12) or Sig(14) or Sig(15);
	OutBit(3) <= Sig(1) or Sig(4) or Sig(7) or Sig(9) or Sig(10) or Sig(15);
	OutBit(4) <= Sig(1) or Sig(3) or Sig(4) or Sig(5) or Sig(7) or Sig(9);
	OutBit(5) <= Sig(1) or Sig(2) or Sig(3) or Sig(7) or Sig(13);
	OutBit(6) <= Sig(0) or Sig(1) or Sig(7) or Sig(12);
end Behavioral;

