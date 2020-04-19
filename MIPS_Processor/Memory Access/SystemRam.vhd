----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:24 12/04/2015 
-- Design Name: 
-- Module Name:    SystemRam - Behavioral 
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

entity SystemRam is
	generic (AWidth : integer := 12;
		DWidth : integer := 16);
	port(WR_en : in std_logic; --Write = 1, read = 0
			clk : in std_logic;
			address1 : in std_logic_vector(AWidth-1 downto 0); --Used by program counter, cannot write to this line
			address2 : in std_logic_vector(AWidth-1 downto 0); --The second memory access data line, also write address
			dataIn : in std_logic_vector(DWidth-1 downto 0); --The data to write to memory
			dataOut1 : out std_logic_vector(DWidth-1 downto 0);
			dataOut2 : out std_logic_vector(DWidth-1 downto 0);
			LEDout : out std_logic_vector(DWidth-1 downto 0));
end SystemRam;

architecture Behavioral of SystemRam is
	type memoryCell is array(natural range<>) of std_logic_vector(DWidth-1 downto 0);
	signal data : memoryCell(0 to 2**AWidth-1) := (
		"0101000010000010", --MOV 130 into r0, A0
		"0110000100000000", --MOV r0 into r1, A1
		"1110001000100000", --ADD r0 to r1, store in r2, A2
		"1000101101001000", --LSR r2 by 8 and store in r3, A3
		"0101010000000111", --MOV 7 into R4, address of LED pointer, A4
		"0111111110000000", --MOV the LED pointer into R7, A5
		"0111001111101100", --Store R3 at the address of R7, A6
		"0000111111111111", --Address of the LED output, A7
		others => "0000000000000000");
	signal LEDReg : std_logic_vector(Dwidth-1 downto 0) := (others => '0');
begin

LEDOut <= LEDReg;

DataArray : process (data, WR_en, address1, address2, dataIn, clk)
begin
	if(clk'event and clk='1') then
		--Creates the first set of inputs to the data
		DataOut1 <= data(TO_INTEGER(unsigned(address1)));
		--Creates the second set of inputs to the data
		if(WR_en = '1') then
			data(TO_INTEGER(unsigned(address2))) <= DataIn;
			DataOut2 <= DataIn;
		else
			DataOut2 <= data(TO_INTEGER(unsigned(address2)));
		end if;
		
		if(WR_en = '1' and unsigned(address2) = 2**AWidth-1) then
			LEDReg <= DataIn;
		end if;
	end if;
end process;

end Behavioral;

