library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Memory_Access is
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
end Memory_Access;

architecture Behavioral of Memory_Access is
	component MEMCont
		port(
			--The instruction to execute in the memory stage
			inst : in std_logic_vector(7 downto 0);
			reset : in std_logic;
			haltMEM : in std_logic;

			--RAM Control
			RW_RAM : out std_logic; --Controls whether the system memory is outputting or inputting
			W_PC : out std_logic; --Controls whether the PC increments or takes loads a new value
			regWBMEM : out std_logic_vector(3 downto 0); --The registers being written too
			halt : out std_logic
		);
	end component;

	component WBCont
		port(
			--The instruction to execute in the memory stage
			inst : in std_logic_vector(7 downto 0);

			haltMEM : out std_logic;
			dataSel : out std_logic; --Chooses between writing back data from the execution stage or the memory
			dataOut : out std_logic --In the event of branching protocols, you don't want to write anything to memory
		);
	end component;

	component SystemRam
		generic (AWidth : integer := 8;
			DWidth : integer := 16);
		port(WR_en : in std_logic; --Write = 1, read = 0
				clk : in std_logic;
				address1 : in std_logic_vector(AWidth-1 downto 0); --Used by program counter, cannot write to this line
				address2 : in std_logic_vector(AWidth-1 downto 0); --The second memory access data line, also write address
				dataIn : in std_logic_vector(DWidth-1 downto 0); --The data to write to memory
				dataOut1 : out std_logic_vector(DWidth-1 downto 0);
				dataOut2 : out std_logic_vector(DWidth-1 downto 0);
				LEDout : out std_logic_vector(DWidth-1 downto 0));
	end component;

	component programCounter
		generic(AWidth : integer := 11;
			DWidth : integer := 16);
		port(ld, clk, haltPC, reset : in STD_LOGIC;
			dataIn : in std_logic_vector(AWidth-1 downto 0);
			dataOut : out std_logic_vector(AWidth-1 downto 0));
	end component;

	signal reset, resetPC : std_logic;
	signal temp : std_logic;
	--Used to get data from the memory as well as being output to line A
	signal PC_Val : std_logic_Vector(AWidth-1 downto 0);
	signal haltMEM, halt : std_logic;
	signal REG_A : std_logic_vector(15 downto 0);
	signal REG_B : std_logic_vector(15 downto 0);
	signal W_PC, RW_RAM : std_logic;
	signal RAM_Out : std_logic_vector(15 downto 0);
	signal instReg : std_logic_vector(7 downto 0);
begin
	RAM : SystemRam
		generic map(AWidth, DWidth)
		port map(RW_RAM, clk, PC_VAL, REG_A(AWidth-1 downto 0), REG_B, next_Inst, RAM_Out, LEDOut);
	MEM_CONT : MemCont port map(instReg, reset, haltMEM, RW_RAM, W_PC, regWBMEM, halt);
	WB_Cont : WBCont port map(instReg, haltMEM, WBSel, WB);
	C <= REG_A;
	D <= RAM_Out;
	haltEX <= halt;
	resetWB <= reset;

	resetID <= globalReset;
	temp <= globalReset;
	--PC related segments
	PC : programCounter
		generic map(AWidth, DWidth)
		port map(W_PC, clk, haltIF, resetPC, A(AWidth-1 downto 0), PC_Val);
	destReg <= instReg(2 downto 0);

--Delays the outputs from the executioin stage
process (inst, clk, globalReset)
begin
	if(rising_edge(clk)) then
		if(globalReset = '1') then
			reset <= globalReset;
		else
			instReg <= inst;
			REG_A <= A;
			REG_B <= B;
			reset <= resetMEM or globalReset;
		end if;
	end if;
end process;

--Holding the reset state an extra clock cycle
process (clk, resetPC, globalReset)
begin
	if(rising_edge(clk)) then
		if(globalReset = '1') then
			resetPC <= '1';
		elsif(resetPC = '1') then
			resetPC <= globalReset;
		end if;
	end if;
end process;
end Behavioral;
