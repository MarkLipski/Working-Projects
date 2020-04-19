----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:51 02/05/2016 
-- Design Name: 
-- Module Name:    IDCont - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDCont is
	port(
		CUin : in std_logic_vector(15 downto 0); --The next instruction from memory
		--The registers to being written to in the WB and Memory stages, required for data hazards
		--Bit 3 indicates whether there is a writeback being performed to a register or not
		regWBEX, regWBMEM : in std_logic_vector(3 downto 0); 
		halt : in std_logic;
		
		CUout : out std_logic_vector(7 downto 0); --The output from the control unit, for immediates
		
		--RegisterControl
		RegASel : out std_logic_vector(2 downto 0); --Selects the register to output to A
		RegBSel : out std_logic_vector(2 downto 0); --Selects the register to output to B
		haltID : out std_logic
	);
end IDCont;

architecture Behavioral of IDCont is

begin
	RegASel <= CUin(7 downto 5);
	RegBSel <= CUin(4 downto 2);
	CUout <= CUin(15 downto 8);
process(CUin, regWBEX, regWBMEM, halt)
begin
	--Data hazard stuff, bit 3 indicates whether a register is actually being written to
	if(regWBEX(3) = '1') and (CUin(7 downto 5) = regWBEX(2 downto 0) or CUin(4 downto 2) = regWBEX(2 downto 0)) then
		haltID <= '1';
	elsif(regWBMEM(3) = '1') and (CUin(7 downto 5) = regWBMEM(2 downto 0) or CUin(4 downto 2) = regWBMEM(2 downto 0)) then
		haltID <= '1';
	else
		haltID <= halt;
	end if;
end process;
end Behavioral;

