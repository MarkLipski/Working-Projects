----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:17:18 02/05/2016 
-- Design Name: 
-- Module Name:    Execute_Stage - Behavioral 
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

entity Execute_Stage is
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
end Execute_Stage;

architecture Behavioral of Execute_Stage is
	component EXCont
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
	end component;
	
	--16 bit ALU
	component ALU
		port (A,B : in  STD_LOGIC_VECTOR(15 downto 0);
			  ALUen : in std_logic;
           opSel : in std_logic_vector(2 downto 0);
			  C : out STD_LOGIC_VECTOR(15 downto 0);
			  GT, LT, EQU : out STD_LOGIC);
	end component;
	
	--16 Bit barrel shifter
	component BarrelShifter
		generic (N : integer := 4);
		port (A : in std_logic_vector((N * N) - 1 downto 0);
			B : in std_logic_vector(N-1 downto 0);
			opSel : in std_logic_vector(1 downto 0);
			O : out std_logic_vector((N * N)-1 downto 0));
	end component;
	
	--16 Bit Multiplier
	component Multiplier
		generic (N : integer := 16);
		port (A, B: in std_logic_vector(N-1 downto 0);
			multEn : in std_logic;
			multOut : out std_logic_vector(N-1 downto 0)
		);
	end component;

	--SIGNALS--
	signal REG_A, REG_B : std_logic_vector(15 downto 0);
	signal ALU_OP_Sel : std_logic_vector(2 downto 0);
	signal BS_OP_Sel : std_logic_vector(1 downto 0);
	signal ALU_Out, BS_Out, Mult_Out : std_logic_vector(15 downto 0);
	signal reset : std_logic;
	signal BSEn, ALUen, MultEn : std_logic;
	signal UPFlags : std_logic;
	signal GT, LT, EQU : std_logic;
	signal GTReg, LTReg, EQUReg : std_logic;
	signal instReg : std_logic_vector(7 downto 0);
begin
	EX_ALU : ALU port map (REG_A, REG_B, ALUen, ALU_OP_Sel, ALU_Out, GT, LT, EQU);
	EX_BS : BarrelShifter port map (REG_A, REG_B(3 downto 0), BS_OP_Sel, BS_Out); 
	EX_Cont : EXCont port map (instReg, reset, BSEn, BS_OP_Sel, ALUen, ALU_OP_Sel, UPFlags, MultEn, regWBEX);
	EX_MULT : Multiplier port map (REG_A, REG_B, MULTen, Mult_Out);
	resetOut <= reset or haltEX;
	instOut <= instReg;
	haltID <= haltEX;
	D <= REG_B;
process (instReg, REG_A, ALU_Out, Mult_Out, BS_Out)
begin
	case instReg(7 downto 5) is
		when "100" => 
			C <= BS_Out;
		when "110" => 
			C <= mult_Out;
		when "111" | "000" => 
			C <= ALU_Out;
		when others => 
			C <= REG_A;
	end case;
end process;

GT_Out <= GTReg;
LT_Out <= LTReg;
EQU_Out <= EQUReg;

process (GT, LT, EQU, clk, UPFlags, GTReg, LTReg, EQUReg)
begin
	if(rising_edge(clk) and UPFlags = '1') then
		GTReg <= GT;
		LTReg <= LT;
		EQUReg <= EQU;
	end if;
end process;

process (inst, clk, haltEX, globalReset)
begin
	if(rising_edge(clk)) then
		if(haltEX = '0') then
			instReg <= inst;
			REG_A <= A;
			REG_B <= B;
			reset <= resetIn or globalReset;
		elsif(globalReset = '1') then
			reset <= '1';
		end if;
	end if;
end process;
end Behavioral;

