library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity RegisterFile is
	generic (DWidth : integer := 16;
		AWidth : integer := 3);
	port (ReadAddr1, ReadAddr2 : in std_logic_vector(Awidth-1 downto 0);
		WriteAddr : in std_logic_vector(Awidth-1 downto 0);
		DataIn : in std_logic_vector(Dwidth-1 downto 0);
		clk, we : in std_logic;
		DataOut1, DataOut2 : out std_logic_vector(Dwidth-1 downto 0)
		);
end RegisterFile;

architecture Behavioral of RegisterFile is
	component DualPortRegFile is
		generic (DWidth : integer := 16;
			AWidth : integer := 3);
		port (Addr1, Addr2 : in std_logic_vector(Awidth-1 downto 0); --Addrb functions as both a read and write address 
			DataIn : in std_logic_vector(Dwidth-1 downto 0);
			clk, we1, we2 : in std_logic;
			DataOut : out std_logic_vector(Dwidth-1 downto 0)
			);
	end component;
begin
	--Make a virtual tri port register file that uses the hardware's dual port block ram
	--Uses two dual-port register files with synchronized dataIn, clk, write enable and write address inputs
	--This allows the two different block ram pieces to have identical data, and both blocks of
	--data can have a unique read address, hence creating a virtual tri-port register file.
	AddrABlock : DualPortRegFile port map(WriteAddr, ReadAddr1, DataIn, clk, we, '0', DataOut1);
	AddrBBlock : DualPortRegFile port map(WriteAddr, ReadAddr2, DataIn, clk, we, '0', DataOut2);
end Behavioral;

