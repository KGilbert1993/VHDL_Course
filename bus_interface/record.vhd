-- Problem 8, Chapter 4
-- 15 September 2015
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

type test_stimulus is record
	stimulus : std_logic_vector(2 downto 0);
	delay    : integer;
	response : std_logic_vectro(7 downto 0);
end record test_stimulus; 