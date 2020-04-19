----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:49 02/09/2016 
-- Design Name: 
-- Module Name:    WB_Stage - Behavioral 
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

entity WB_Stage is
	port(
		globalReset : in std_logic;
		A, B : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		en, WBSel : in std_logic;
		RegSelIn : in std_logic_vector(2 downto 0);
		resetWB : in std_logic;
		
		WB : out std_logic;
		RegSelOut : out std_logic_vector(2 downto 0);
		C : out std_logic_vector(15 downto 0)
	);
end WB_Stage;

architecture Behavioral of WB_Stage is
signal A_REG : std_logic_vector(15 downto 0);
signal en_delay, WBSel_delay : std_logic;
signal RegSelDel : std_logic_vector(2 downto 0);
signal controlSig : std_logic_vector(4 downto 0);
signal reset : std_logic;

begin
	WB <= en_delay and not(reset);
	RegSelOut <= RegSelDel;
	
process(A_Reg, B, WBSel_delay)
begin
	if(WBSel_delay = '1') then
		C <= A_Reg;
	else
		C <= B;
	end if;
end process;

process(en, WBSel, RegSelIn, WBSel_delay, en_delay, regSelDel, A, B, A_Reg, clk)
begin
	if(rising_edge(clk)) then
		en_delay <= en;
		WBSel_delay <= WBSel;
		RegSelDel <= RegSelIn;
		A_Reg <= A;
	end if;
	if(rising_edge(clk)) then
		reset <= globalReset or resetWB;
	end if;
end process;
end Behavioral;

