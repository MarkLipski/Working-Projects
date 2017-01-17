----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:02:39 10/15/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A,B : in  STD_LOGIC_VECTOR(15 downto 0);
			  ALUen : in std_logic;
           opSel : in std_logic_vector(2 downto 0);
			  C : out STD_LOGIC_VECTOR(15 downto 0);
			  GT, LT, EQU : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

	component n_BitAdder
		generic(N : integer := 16);
		port (A, B : in STD_LOGIC_VECTOR(N-1 downto 0);
		carryIn : in STD_LOGIC;
		Output : out STD_LOGIC_VECTOR(N-1 downto 0);
		carryOut : out STD_LOGIC);
	end component; 
	
	component n_BitLogic
		generic (DWidth : integer := 16);
		port(A, B : in std_logic_vector(DWidth-1 downto 0);
			sel : in std_logic_vector(1 downto 0);
			C : out std_logic_vector(DWidth-1 downto 0));
	end component;
	
	signal adderOut, logicOut : std_logic_vector(15 downto 0);
	signal adderB : std_logic_vector(15 downto 0);
	signal carryOut : std_logic;
begin
	adder : n_BitAdder port map(A, adderB, opSel(0), adderOut, carryOut);
	logic : n_BitLogic port map(A, B, opSel(1 downto 0), logicOut);
process(A, B, adderOut, logicOut, opSel, carryOut)
begin
	--If multiply calculation is not complete set complete flag to false
	if(opSel(2) = '1') then
		C <= adderOut;
	else
		C <= logicOut;
	end if;
	
	--Flags
	GT <= carryOut;
	LT <= not carryOut;
	if(A = B) then
		EQU <= '1';
	else 
		EQU <= '0';
	end if;
end process;
	
process(B, adderB, opSel)
begin
	if(opSel(0) = '1') then 
		adderB <= not B;
	else
		adderB <= B;
	end if;
end process;
	
end Behavioral;

