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
	signal HALT : boolean := false;
begin
	bus_i: entity work.bus_interface(bus_driver)
		port map (clk, proc_address, proc_data, proc_Rd, proc_Wt, mAddress, mDataIn, mDataOut, mWrite, led); 
	memory: entity work.sram(RTL)
		port map (clk, mAddress, mDataIn, mDataOut, mWrite);

	test: process is
	begin
		proc_address <= x"001";
		proc_data <= x"01";
		proc_Wt <= '1';
		proc_Rd <= '0';
		
		wait for 20 ns;
	
		proc_address <= x"002";
		proc_data <= x"02";
		
		wait for 20 ns;

		proc_address <= x"001";
		proc_Wt <= '0';
		proc_Rd <= '1';

		wait for 15 ns;

		assert proc_data = x"01"
			report "FAILED readback at address 0x1"
			severity warning;
			
		proc_address <= x"002";
		
		wait for 15 ns;

		assert proc_data = x"02"
			report "FAILED readback at address 0x2"
			severity warning;

		proc_address <= x"400";
		proc_data <= x"FF";
		proc_Wt <= '1';
		proc_Rd <= '0';
		
		wait for 15 ns;
		
		assert led = '1'
			report "FAILED to set LED from debug register"
			severity warning;

		HALT <= true;
	end process test;

	run: process(clk) is
	begin
		if HALT then
			clk <= not clk after 5 ns;
		else
			clk <= '0';
		end if;
	end process run;
end architecture test;