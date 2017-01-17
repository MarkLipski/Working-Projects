----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:57 02/24/2016 
-- Design Name: 
-- Module Name:    n_BitLogic - Behavioral 
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

entity n_BitLogic is
	generic (DWidth : integer := 16);
	port(A, B : in std_logic_vector(DWidth-1 downto 0);
		sel : in std_logic_vector(1 downto 0);
		C : out std_logic_vector(DWidth-1 downto 0));
end n_BitLogic;

architecture Behavioral of n_BitLogic is

begin

process(sel, A, B)
begin
	case sel is
		when "00" => C <= A or B;
		when "01" => C <= A and B;
		when "10" => C <= A xor B;
		when others => C <= not A;
	end case;
end process;

end Behavioral;

