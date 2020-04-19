library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ID_Stage is
	generic(AWidth : integer := 12;
		DWidth : integer := 16);
	port(
		globalReset : in std_logic;
		-----Inputs from IF stage------
		IDinst : in std_logic_vector(15 downto 0); --The nextIDinstruction from memory
		PC_Val : in std_logic_vector(AWidth-1 downto 0); --The value of the program counter, required for B and BXIDinstructions
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
end ID_Stage;

architecture Behavioral of ID_Stage is
	component registerFile
		generic (DWidth : integer := 16;
			AWidth : integer := 3);
		port (ReadAddr1, ReadAddr2 : in std_logic_vector(Awidth-1 downto 0);
			WriteAddr : in std_logic_vector(Awidth-1 downto 0);
			DataIn : in std_logic_vector(Dwidth-1 downto 0);
			clk, we : in std_logic;
			DataOut1, DataOut2 : out std_logic_vector(Dwidth-1 downto 0)
			);
		end component;

	component IDCont port(
		CUin : in std_logic_vector(15 downto 0); --The nextIDinstruction from memory
		--The registers to being written to in the WB and Memory stages, required for data hazards
		--Bit 3 indicates whether there is a writeback being performed to a register or not
		regWBEX, regWBMEM : in std_logic_vector(3 downto 0);
		halt : in std_logic;

		CUout : out std_logic_vector(7 downto 0); --The output from the control unit, for immediates

		--RegisterControl
		RegASel : out std_logic_vector(2 downto 0); --Selects the register to output to A
		RegBSel : out std_logic_vector(2 downto 0); --Selects the register to output to B
		haltID : out std_logic
		);
	end component;

	signal halt : std_logic;
	signal reset : std_logic;
	signal RegASel, RegBSel : std_logic_vector(2 downto 0);
	signal AReg, BReg : std_logic_vector(15 downto 0); --The values of the "A" and "B" registers from register file
begin
	ID_CONT : IDCont port map(IDinst, regWBEX, regWBMEM, haltID, EXinst, RegASel, RegBSel, halt);
	--dataIn -> data to be written, RegInSel -> the register to be written too
	--RegASel -> the register that will output its value to output A, same thing with B
	--Reg_WR -> Determines whether or not the incoming data will be written
	RegBank : RegisterFile port map(RegASel, RegBSel, WriteSel, dataIn, clk, Reg_WR, AReg, BReg);
	resetOut <= reset or halt;
	haltIF <= halt;
process(IDinst, AReg, BReg, PC_Val)
begin
	--Determine the inputs to B
	case IDinst(15 downto 13) is
	when "100" =>
		B <= (15 downto 5 => '0') & IDinst(4 downto 0);
	when "000" =>
		B <= (15 downto 8 => '0') & IDinst(7 downto 0);
	when others => B <= BReg;
	end case;

	--Determine the inputs to A
	if(IDinst(15 downto 13) = "000") then
		A <= (DWidth-1 downto (AWidth) => '0') & PC_val;
	elsif(IDinst(15 downto 11) = "01010") then
		A <= (15 downto 8 => '0') & IDinst(7 downto 0);
	elsif(IDinst(15 downto 11) = "01011") then
		A <= IDinst(7 downto 0) & (7 downto 0 => '0');
	else
		A <= AReg;
	end if;
end process;

process(clk, IDinst, halt)
begin
	--Update theIDinstReg every clock cycle
	if(rising_edge(clk)) then
		if(halt = '0') then
			reset <= resetIn or globalReset;
		elsif(globalReset = '1') then
			reset <= '1';
		end if;
	end if;
end process;


end Behavioral;
