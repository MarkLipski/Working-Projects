----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:29:32 02/23/2016 
-- Design Name: 
-- Module Name:    DualPortRegFile - Behavioral 
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
use IEEE.std_logic_unsigned.all;

entity DualPortRegFile is
	generic (DWidth : integer := 16;
		AWidth : integer := 4);
	port (Addr1, Addr2 : in std_logic_vector(Awidth-1 downto 0); --Addrb functions as both a read and write address 
		DataIn : in std_logic_vector(Dwidth-1 downto 0);
		clk, we1, we2 : in std_logic;
		DataOut : out std_logic_vector(Dwidth-1 downto 0)
		);
end DualPortRegFile;

architecture Behavioral of DualPortRegFile is
	type regType is array (natural range <>) of std_logic_vector(Dwidth-1 downto 0);
	signal regBank : regType(2**Awidth-1 downto 0);
	signal DataOut1, DataOut2 : std_logic_vector(Dwidth-1 downto 0);
begin
process(clk, we1, we2, Addr1, Addr2, dataIn, dataOut1, dataOut2)
begin
	if(rising_edge(clk)) then
		--Creates the first set of inputs to the data
		if(we1 = '1') then
			regBank(conv_integer(Addr1)) <= DataIn;
			DataOut1 <= DataIn;
		else
			DataOut1 <= regBank(conv_integer(Addr1));
		end if;
		--Creates the second set of inputs to the data
		if(we2 = '1') then
			regBank(conv_integer(Addr2)) <= DataIn;
			DataOut2 <= DataIn;
		else
			DataOut2 <= regBank(conv_integer(Addr2));
		end if;
	end if;
	--Since address 1 is going to be used exclusively as a write line, the data out is always going to 
	--be selected based on the read address. However when both the read and write addresses are equivalent
	--the output is taken directly from the write address, as it's going to get the data directly from the
	--data in.
	if(Addr1 = Addr2 and we1 = '1') then
		DataOut <= DataIn;
	else
		DataOut <= DataOut2;
	end if;
end process;
		

end Behavioral;

