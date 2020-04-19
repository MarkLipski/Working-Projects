--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:08:48 02/24/2016
-- Design Name:   
-- Module Name:   T:/ENGG 4540/CPU_MIPS/memTB.vhd
-- Project Name:  CPU_MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Memory_Access
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
 
ENTITY memTB IS
END memTB;
 
ARCHITECTURE behavior OF memTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Memory_Access
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         inst : IN  std_logic_vector(7 downto 0);
         cont : IN  std_logic;
         clk : IN  std_logic;
         resetPC : IN  std_logic;
         resetMem : IN  std_logic;
         C : OUT  std_logic_vector(15 downto 0);
         D : OUT  std_logic_vector(15 downto 0);
         destReg : OUT  std_logic_vector(2 downto 0);
         WBSel : OUT  std_logic;
         WB : OUT  std_logic;
         resetWB : OUT  std_logic;
         next_Inst : OUT  std_logic_vector(15 downto 0);
         PC_Out : OUT  std_logic_vector(7 downto 0);
         resetID : OUT  std_logic;
         LEDOut : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal inst : std_logic_vector(7 downto 0) := (others => '0');
   signal cont : std_logic := '0';
   signal clk : std_logic := '0';
   signal resetPC : std_logic := '0';
   signal resetMem : std_logic := '0';

 	--Outputs
   signal C : std_logic_vector(15 downto 0);
   signal D : std_logic_vector(15 downto 0);
   signal destReg : std_logic_vector(2 downto 0);
   signal WBSel : std_logic;
   signal WB : std_logic;
   signal resetWB : std_logic;
   signal next_Inst : std_logic_vector(15 downto 0);
   signal PC_Out : std_logic_vector(7 downto 0);
   signal resetID : std_logic;
   signal LEDOut : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Memory_Access PORT MAP (
          A => A,
          B => B,
          inst => inst,
          cont => cont,
          clk => clk,
          resetPC => resetPC,
          resetMem => resetMem,
          C => C,
          D => D,
          destReg => destReg,
          WBSel => WBSel,
          WB => WB,
          resetWB => resetWB,
          next_Inst => next_Inst,
          PC_Out => PC_Out,
          resetID => resetID,
          LEDOut => LEDOut
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
