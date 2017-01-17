----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:42:34 02/05/2016 
-- Design Name: 
-- Module Name:    IFCont - Behavioral 
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

entity IFCont is
	port(
	--Program Counter Control
	PCsel : out std_logic; --Controls which component inputs to the PC, ALU or memory
	PCload : out std_logic; --If the load is true, update PC 
	PCIncr : out std_logic --Controls when the PC increments
	);
end IFCont;

architecture Behavioral of IFCont is

begin


end Behavioral;

