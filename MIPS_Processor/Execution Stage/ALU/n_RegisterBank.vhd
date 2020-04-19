library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity n_RegisterBank is
	generic( N : integer := 16;
	x : integer := 3);
	port(
		Data_In : in std_logic_vector(N-1 downto 0); -- Input Data
		in_Sel : in std_logic_vector(x-1 downto 0); -- Input Address
		out1_Sel : in std_logic_vector(x-1 downto 0); -- Output Address 1
		out2_Sel : in std_logic_vector(x-1 downto 0); -- Output Address 2
		Wr_En : in std_logic; -- Write Enable
		Clk : in std_logic;

		A : out std_logic_vector(N-1 downto 0); -- Output Data 1
		B : out std_logic_vector(N-1 downto 0) -- Output Data 2
	);
end entity n_RegisterBank;

architecture Behavioral of n_RegisterBank is
	type dataWidth is array (natural range<>) of std_logic_vector(N-1 downto 0);
	signal numReg : dataWidth(0 to (2 ** x)-1) := 
		("0101010101010101", others => "0000000000000000");
begin

	A <= std_logic_vector(numReg(TO_INTEGER(unsigned(out1_Sel))));
	B <= std_logic_vector(numReg(TO_INTEGER(unsigned(out2_Sel))));

	process(Clk)
	begin
		if(RISING_EDGE(Clk))then
			if(Wr_En = '1')then
				numReg(TO_INTEGER(unsigned(in_Sel))) <= Data_In;
			end if;
		end if;
	end process;
--------------------------------------------------------
end architecture Behavioral;