----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:02 02/05/2016 
-- Design Name: 
-- Module Name:    WBCont - Behavioral 
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

entity WBCont is
	port(
		--The instruction to execute in the memory stage
		inst : in std_logic_vector(7 downto 0);
		
		haltMEM : out std_logic;
		dataSel : out std_logic; --Chooses between writing back data from the execution stage or the memory
		dataOut : out std_logic --In the event of branching protocols, you don't want to write anything to memory
	);
end WBCont;

architecture Behavioral of WBCont is

begin

haltMEM <= '0'; --Currently, no reason to halt memory stage, could be implemented at a later date
process(inst)
begin
	if(inst(7 downto 3) = "01110" or inst(7 downto 6) = "00") then
		dataOut <= '0';
	else
		dataOut <= '1';
	end if;
	
	--If dataSel = '0' data comes from memory, else comes from ALU
	case inst(7 downto 3) is
		when "01111" => dataSel <= '0';
		when others => dataSel <= '1';
	end case;
end process;

end Behavioral;

