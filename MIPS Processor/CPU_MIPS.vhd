----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:35:53 02/10/2016 
-- Design Name: 
-- Module Name:    CPU_MIPS - Behavioral 
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

entity CPU_MIPS is
	generic(AWidth : integer := 11;
		DWidth : integer := 16);
	port(clk : in std_logic;
		reset : in std_logic;
		digit : out std_logic_vector(7 downto 0);
		digitSel : out std_logic_vector(3 downto 0)
		);
end CPU_MIPS;

architecture Behavioral of CPU_MIPS is
	--Need bypass for D, ability to halt pipeline should be useful
	component execute_Stage
		port(
			globalReset : in std_logic;
			A, B : in std_logic_vector(15 downto 0);
			inst : in std_logic_vector(7 downto 0);
			clk : in std_logic;
			resetIn, haltEX : in std_logic;	
			
			resetOut : out std_logic;
			C, D : out std_logic_vector(15 downto 0);
			GT_Out, LT_Out, EQU_Out : out std_logic;
			instOut : out std_logic_vector(7 downto 0);
			
			regWBEX : out std_logic_vector(3 downto 0);
			haltID : out std_logic
		);
	end component;
	
	--Add ability to halt pipeline
	component ID_Stage
		generic(AWidth : integer := 12;
			DWidth : integer := 16);
		port(
			globalReset : in std_logic;
			-----Inputs from IF stage------
			IDinst : in std_logic_vector(15 downto 0); --The next instruction from memory
			PC_Val : in std_logic_vector(AWidth-1 downto 0); --The value of the program counter, required for B and BX instructions
			-----Inputs from WB stage------
			Reg_WR : in std_logic; --If 1, then store the incoming dataIn in the chosen register
			dataIn : in std_logic_vector(15 downto 0);
			WriteSel : in std_logic_vector(2 downto 0);
			--Standard inputs
			clk, resetIN : in std_logic;
			-----Pipeline Control-----
			--The registers to being written to in the WB and Memory stages, required for data hazards
			--Bit 3 indicates whether there is a writeback being performed to a register or not
			regWBEX, regWBMEM : in std_logic_vector(3 downto 0); 
			haltID : in std_logic;
			
			--Outputs to EX stage
			resetOut : out std_logic; 
			A, B : out std_logic_vector(15 downto 0);
			EXinst : out std_logic_vector(7 downto 0);
			--Halt the IF stage
			haltIF : out std_logic
		);
	end component;
	
	--Add ability to halt pipeline, D output
	component Memory_Access
		generic(AWidth : integer := 12;
			DWidth : integer := 16);
		port(A, B : in std_logic_vector(DWidth-1 downto 0);
			inst : in std_logic_vector(7 downto 0);
			haltIF : in std_logic; --If 1, prevents fetching instructions
			clk : in std_logic;
			globalReset : in std_logic; --
			resetMem : in std_logic;
			
			--WB outputs
			C, D : out std_logic_vector(DWidth-1 downto 0); --The outputs to the writeback stage
			destReg : out std_logic_vector(2 downto 0); --The register to write back to
			WBSel, WB : out std_logic;
			resetWB : out std_logic;
			
			--ID outputs
			next_Inst : out std_logic_vector(DWidth-1 downto 0); --The next instruction retrieved from memory
			PC_Out : out std_logic_vector(AWidth-1 downto 0);
			regWBMEM : out std_logic_vector(3 downto 0);
			resetID : out std_logic;
			--Pipeline control
			haltEX : out std_logic;
			LEDOut : out std_logic_vector(DWidth-1 downto 0));
	end component;
	
	component WB_Stage
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
	end component;
	
	component MultiDigit7seg
		port ( data : in std_logic_vector(15 downto 0);
				clk : in std_logic;
           OutBit : out STD_LOGIC_VECTOR(7 downto 0);
			  ledSel : out std_logic_vector(3 downto 0));
	end component;
	-------Signal Declarations------(
	--Output line A, connect decode to execute to memory access
	signal EX_A, MEM_A, WB_A : std_logic_vector(15 downto 0);
	--Output line B, connect decode to execute to memory access
	signal B1, B2, B3 : std_logic_vector(15 downto 0);
	--LT, GT, EQU flags directly from ALU, control whether or not a branch occurs
	signal LT, GT, EQU : std_logic;
	--The first 8 bits of each instruction, propagated down pipeline
	signal inst1, inst2 : std_logic_vector(7 downto 0);
	--Continue bits used to halt the progression of the pipeline, if 1, halt stage
	signal haltEX, haltID, haltIF : std_logic := '0';
	
	signal regWBEX, regWBMEM : std_logic_vector(3 downto 0);
	signal resetCon : std_logic_vector(3 downto 0);
	
	
	signal PC_Val : std_logic_vector(AWidth-1 downto 0);
	signal WB1, WB2, WBSel : std_logic;
	signal destReg1, destReg2 : std_logic_vector(2 downto 0);
	signal next_Inst : std_logic_vector(15 downto 0);
	signal WB_Data : std_logic_vector(15 downto 0);
	signal LEDVal : std_logic_vector(DWidth-1 downto 0);
	----------------------------)
begin
	ID : ID_Stage
		generic map(AWidth, DWidth)
		port map(globalReset => reset, IDinst => next_inst, PC_Val => PC_Val, Reg_WR => WB2, dataIn => WB_Data, writeSel => destReg2, 
			clk => clk, resetIN => resetCon(0), resetOut => resetCon(1), A => EX_A, B => B1, EXinst => inst1, haltID => haltID,
			regWBEX => regWBEX, 	regWBMEM => regWBMEM, haltIF => haltIF);
		
	EX_Stage : execute_stage port map(reset, EX_A, B1, inst1, clk, resetCon(1), haltEX, 
		resetCon(2), MEM_A, B2, GT, LT, EQU, inst2, regWBEX, haltID);
	MEM_Stage : Memory_Access 
		generic map(AWidth, DWidth)
		port map(MEM_A, B2, inst2, haltIF, clk, reset, 
			resetCon(2), WB_A, B3, destReg1, WBSel, WB1, resetCon(3), next_inst, PC_Val, regWBMEM, resetCon(0), haltEX, LEDVal);
	WB : WB_Stage port map(reset, WB_A, B3, clk, WB1, WBSel, destReg1, resetCon(3), WB2, destReg2, WB_Data); 
	DigDisp_4 : MultiDigit7Seg port map(LEDVal, clk, digit, digitSel);
	
end Behavioral;

