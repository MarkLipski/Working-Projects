--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:11:07 02/24/2016
-- Design Name:   
-- Module Name:   T:/ENGG 4540/CPU_MIPS/RAMTB.vhd
-- Project Name:  CPU_MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SystemRam
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
 
ENTITY RAMTB IS
END RAMTB;
 
ARCHITECTURE behavior OF RAMTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SystemRam
    PORT(
         WR_en : IN  std_logic;
         clk : IN  std_logic;
         address1 : IN  std_logic_vector(11 downto 0);
         address2 : IN  std_logic_vector(11 downto 0);
         dataIn : IN  std_logic_vector(15 downto 0);
         dataOut1 : OUT  std_logic_vector(15 downto 0);
         dataOut2 : OUT  std_logic_vector(15 downto 0);
         LEDout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal WR_en : std_logic := '0';
   signal clk : std_logic := '0';
   signal address1 : std_logic_vector(11 downto 0) := (others => '0');
   signal address2 : std_logic_vector(11 downto 0) := (others => '0');
   signal dataIn : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal dataOut1 : std_logic_vector(15 downto 0);
   signal dataOut2 : std_logic_vector(15 downto 0);
   signal LEDout : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SystemRam PORT MAP (
          WR_en => WR_en,
          clk => clk,
          address1 => address1,
          address2 => address2,
          dataIn => dataIn,
          dataOut1 => dataOut1,
          dataOut2 => dataOut2,
          LEDout => LEDout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
