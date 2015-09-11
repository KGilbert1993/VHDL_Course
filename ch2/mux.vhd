-- single bit MUX
entity mux is
	port( a, b, sel : in bit; z : out bit);
end entity mux;

architecture behav of mux is
begin
	z <= b when sel = '1' else a;
end architecture behav; 


-- 4 bit MUX built from single bit MUX entity
library IEEE;
use IEEE.std_logic_1164.all;
entity mux4 is
	port( a, b : in bit_vector(3 downto 0);
		  sel  : in bit; 
		  y    : out bit_vector(3 downto 0) );
end entity mux4;

architecture struct of mux4 is
	signal sA, sB, sZ : bit_vector(3 downto 0);
	signal sSel : bit;
begin
	mux0: entity work.mux(behav)
		port map (a(0), b(0), sel, y(0));
	mux1: entity work.mux(behav)
		port map (a(1), b(1), sel, y(1));
	mux2: entity work.mux(behav)
		port map (a(2), b(2), sel, y(2));
	mux3: entity work.mux(behav)
		port map (a(3), b(3), sel, y(3));
	
end architecture struct;

-- Basic single bit MUX testbench
entity testbench is
end entity testbench;

architecture test_mux of testbench is
	signal sA, sB, sSel, sZ : bit;
begin
	dut: entity work.mux(behav)
		port map ( sA, sB, sSel, sZ);

	stimulus : process is
	begin
		sA <= '1';
		sB <= '0';
		sSel <= '0';

		assert sZ = '0'
			report "Output incorrect"; 
		
		wait for 1 ns;
		sSel <= '1';

		assert sZ = '1'
			report "Output incorrect";
		wait for 1 ns;
	end process stimulus;
end architecture test_mux;