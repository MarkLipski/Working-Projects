----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:02 11/15/2015 
-- Design Name: 
-- Module Name:    programCounter - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity programCounter is
	generic(AWidth : integer := 11;
		DWidth : integer := 16);
	port(ld, clk, haltPC, reset : in STD_LOGIC;
		dataIn : in std_logic_vector(AWidth-1 downto 0);
		dataOut : out std_logic_vector(AWidth-1 downto 0));
end programCounter;

architecture Behavioral of programCounter is
	signal data : std_logic_vector(AWidth-1 downto 0) := (others => '0');
	signal incrData : unsigned(Awidth-1 downto 0);
	signal incr : unsigned(AWidth-1 downto 0);
begin

dataOut <= std_logic_vector(incrData);
incr <= (AWidth-1 downto 1 => '0') & (not(haltPC or reset));
incrData <= unsigned(data) + incr;

process (incr, clk, ld, dataIn)
begin
	if(rising_edge(clk)) then 
		if(reset = '1') then
			data <= (others => '0');
		elsif(ld = '1') then
			data <= dataIn;
		else
			data <= std_logic_vector(incrData);
		end if;
	end if;
	
end process;

end Behavioral;

