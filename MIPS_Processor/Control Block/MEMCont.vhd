----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:08:01 02/05/2016 
-- Design Name: 
-- Module Name:    MEMCont - Behavioral 
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

entity MEMCont is
	port(
		--The instruction to execute in the memory stage
		inst : in std_logic_vector(7 downto 0);
		reset : in std_logic;
		haltMEM : in std_logic;
		
		--RAM Control
		RW_RAM : out std_logic; --Controls whether the system memory is outputting or inputting
		W_PC : out std_logic; --Controls whether the PC increments or takes loads a new value
		regWBMEM : out std_logic_vector(3 downto 0);
		halt : out std_logic
	);


end MEMCont;

architecture Behavioral of MEMCont is

begin
halt <= '0'; --Memory stage never voluntarily halts previous stages
regWBMEM(2 downto 0) <= inst(2 downto 0);
process(inst, reset)
begin
	case inst(7 downto 3) is
		when "01110" => RW_RAM <= '1';
		when others => RW_RAM <= '0';
	end case;
	
	case inst(7 downto 6) is
		when "00" => W_PC <= not reset;
		when others => W_PC <= '0';
	end case;
	
	if(inst(7 downto 6) = "00" or inst(7 downto 3) = "01110") then
		regWBMEM(3) <= '0';
	else
		regWBMEM(3) <= not reset;
	end if;
end process;
end Behavioral;

