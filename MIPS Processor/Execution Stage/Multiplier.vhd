----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:07:45 02/09/2016 
-- Design Name: 
-- Module Name:    Multiplier - Behavioral 
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

entity Multiplier is
	generic (N : integer := 16);
	port (A, B: in std_logic_vector(N-1 downto 0);
	multEn : in std_logic;
	multOut : out std_logic_vector(N-1 downto 0)
	);
	
end Multiplier;

architecture Behavioral of Multiplier is
	--Start of Signal Definitions
	signal result : std_logic_vector(2*N-1 downto 0);
	signal input1, input2 : unsigned(N-1 downto 0);
begin
	
	result <= std_logic_vector(input1 * input2);	
	multOut <= result(N-1 downto 0);
	
process(multEn, A, B, input1, input2)
begin
	if(multEn = '1') then
		input1 <= unsigned(A);
		input2 <= unsigned(B);
	else
		input1 <= (others => '0');
		input2 <= (others => '0');
	end if;
end process;
end Behavioral;