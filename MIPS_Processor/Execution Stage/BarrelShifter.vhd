----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:10:07 11/13/2015 
-- Design Name: 
-- Module Name:    BarrelShifter - Behavioral 
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
use IEEe.numeric_std.all;

--opSel : "11" Rotate, "10" LSL, "01" LSR
entity BarrelShifter is
	generic (N : integer := 4);
	port (A : in std_logic_vector((N * N) - 1 downto 0);
		B : in std_logic_vector(N-1 downto 0);
		opSel : in std_logic_vector(1 downto 0);
		O : out std_logic_vector((N * N)-1 downto 0));
end BarrelShifter;

architecture Behavioral of BarrelShifter is
begin 
	
process(A, B, opSel)
begin
		if(opSel = "01") then
			O <= to_stdlogicvector(to_bitVector(A) srl to_integer(unsigned(B)));
		elsif(opSel = "10") then
			O <= to_stdlogicvector(to_bitVector(A) sll to_integer(unsigned(B))); 
		else
			O <= to_stdlogicvector(to_bitVector(A) ROL to_integer(unsigned(B)));
		end if;
end process;
end Behavioral;

