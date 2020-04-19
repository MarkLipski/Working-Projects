----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:33:07 02/05/2016 
-- Design Name: 
-- Module Name:    EXCont - Behavioral 
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

entity EXCont is
	port(
		--The instruction to execute in the execution stage
		inst : in std_logic_vector(7 downto 0);
		reset : in std_logic;
		
		--Barrel Shifter Control
		BarrelEn : out std_logic; --Controls whether the BS is active
		BarrelOp : out std_logic_vector(1 downto 0); --Determines the operation of the barrel shifter
		
		--ALU Control
		ALUen : out std_logic;
		ALUOpSel : out std_logic_vector(2 downto 0);
		UPFlags : out std_logic; --Update the flags from the ALU results
		
		--Mult Control
		MultEn : out std_logic;
		
		regWBEX : out std_logic_vector(3 downto 0)
	);
end EXCont;

architecture Behavioral of EXCont is

begin

regWBEX(2 downto 0) <= inst(2 downto 0);
process(inst, reset)
begin
	--Barrel Shifter, Multiplier and ALU enable control
	case inst(7 downto 5) is
		when "100" => 
			BarrelEn <= '1';
			ALUen <= '0';
			MultEn <= '0';
		when "110" => 
			BarrelEn <= '0';
			ALUen <= '0';
			MultEn <= '1';
		when "111" | "000" => 
			BarrelEn <= '0';
			ALUen <= '1';
			MultEn <= '0';
		when others => 
			BarrelEn <= '0';
			ALUen <= '0';
			MultEn <= '0';
	end case;
	
	--Barrel shifter operation control
	BarrelOP <= inst(4 downto 3);
	
	--Control the ALU operation, 000 is pass through
	if(inst(6) = '1') then
		ALUOpSel <= inst(5 downto 3);
	else
		ALUOpSel(2) <= '0';
		ALUOpSel(1 downto 0) <= inst(5 downto 4);
	end if;
		
	case inst(7 downto 5) is
		when "111" => UPFlags <= inst(4);
		when others => UPFlags <= '0';
	end case;
	
	if(inst(7 downto 6) = "00" or inst(7 downto 3) = "01110") then
		regWBEX(3) <= '0';
	else
		regWBEX(3) <= not reset;
	end if;
		
end process;
	
	
		
	

end Behavioral;

