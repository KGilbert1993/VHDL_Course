library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity processor is
	port( BusClk   : out std_logic;
		  bAddress : out unsigned (11 downto 0);
          bData    : inout std_logic_vector(7 downto 0);
          bRd	   : out std_logic;
	      bWt      : out std_logic;
end entity processor;
