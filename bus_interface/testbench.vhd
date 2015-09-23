library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity testbench is
end entity testbench;

architecture test of testbench is
	signal clk : std_logic := '0';
	signal proc_address : unsigned(11 downto 0);
	signal proc_data : std_logic_vector(7 downto 0);
	signal proc_Rd : std_logic := '0';
	signal proc_Wt : std_logic := '0';

	signal mAddress : unsigned(19 downto 0);
	signal mDataIn, mDataOut : std_logic_vector(31 downto 0);
	signal mWrite : boolean;

	signal led : std_logic;
begin
	bus_i: entity work.bus_interface(bus_driver)
		port map (clk, proc_address, proc_data, proc_Rd, proc_Wt, mAddress, mDataIn, mDataOut, mWrite, led); 
	memory: entity work.sram(RTL)
		port map (clk, mAddress, mDataIn, mDataOut, mWrite);

	run: process(clk) is
	begin
		clk <= not clk after 5ns;
	end process run;
end architecture test;