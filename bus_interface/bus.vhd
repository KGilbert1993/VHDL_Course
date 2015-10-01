library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity bus_interface is
	generic (
    	kAddressLength : positive := 20;
    	kDataLength : positive := 32
    );

	port( -- Processor connections
		bClk     : in std_logic;
		bAddress : in unsigned(11 downto 0);
		bData    : inout std_logic_vector(7 downto 0);
		bRd      : in std_logic;
		bWt      : in std_logic;

 		  -- SRAM connections
		sAddress : out  unsigned ( kAddressLength - 1 downto 0 );
    	sDataIn  : out  std_logic_vector ( kDataLength - 1 downto 0 );
    	sDataOut : in std_logic_vector ( kDataLength - 1 downto 0 );
    	sWrite   : out boolean;	

		  -- LED and Debug registers
		LED		 : out std_logic
	);
end entity bus_interface;

architecture bus_driver of bus_interface is
	signal debug_reg : std_logic_vector(7 downto 0);
begin
	LED <= debug_reg(0);
	sAddress(kAddressLength - 1 downto 12) <= to_unsigned(0, kAddressLength-12);	-- Unused memory, pull to ground
	sDataIn(kDataLength - 1 downto 8) <= std_logic_vector(to_unsigned(0,kDataLength-8));
	proc: process(bClk) is
	begin
		if rising_edge(bClk) then
			sAddress(11 downto 0) <= bAddress(11 downto 0);	
			if bWt = '1' then
				sWrite <= true; 
				sDataIn(7 downto 0) <= bData(7 downto 0);
			else 
				sWrite <= false;
				bData(7 downto 0) <= sDataOut(7 downto 0);
			end if;
			if bAddress = 1024 then
				debug_reg <= bData;
			end if;
		end if;	
	end process proc;
end architecture bus_driver;


