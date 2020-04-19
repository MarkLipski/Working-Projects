--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:04:35 02/24/2016
-- Design Name:   
-- Module Name:   T:/ENGG 4540/CPU_MIPS/ALUTB.vhd
-- Project Name:  CPU_MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALUTB IS
END ALUTB;
 
ARCHITECTURE behavior OF ALUTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         ALUen : IN  std_logic;
         opSel : IN  std_logic_vector(2 downto 0);
         C : OUT  std_logic_vector(15 downto 0);
         GT : OUT  std_logic;
         LT : OUT  std_logic;
         EQU : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal ALUen : std_logic := '0';
   signal opSel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal C : std_logic_vector(15 downto 0);
   signal GT : std_logic;
   signal LT : std_logic;
   signal EQU : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          ALUen => ALUen,
          opSel => opSel,
          C => C,
          GT => GT,
          LT => LT,
          EQU => EQU
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a <= "0000100100100001";
		ALUen <= '1';
		opSel <= "000";
		wait for 15 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
