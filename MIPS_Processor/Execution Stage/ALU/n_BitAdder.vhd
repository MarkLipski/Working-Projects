library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity n_BitAdder is
	generic (N : integer := 16); --Default 16 bits
	port (A, B : in STD_LOGIC_VECTOR(N-1 downto 0);
		carryIn : in STD_LOGIC;
		Output : out STD_LOGIC_VECTOR(N-1 downto 0);
		carryOut : out STD_LOGIC);
end n_BitAdder;

architecture Behavioral of n_BitAdder is
	signal data, UA, UB, UC : unsigned(N downto 0);
begin
	UA <= '0' & unsigned(A);
	UB <= '0' & unsigned(B);
	UC <= (N downto 1 => '0') & carryIn;
	data <=  UA + UB + UC;
	Output <= std_logic_vector(data(N-1 downto 0));
	carryOut <= data(N);
end Behavioral;

