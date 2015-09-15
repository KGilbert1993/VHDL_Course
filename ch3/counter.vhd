-- Problem 12, Chapter 3
-- 11 September 2015

library IEEE;
use IEEE.std_logic_1164.all;
entity counter is
	port( clk 	    : in std_logic;
	 	  count_out : out natural);
end entity counter;

architecture behav of counter is
begin
	controller: process(clk) is
		variable count : natural := 15; 
	begin
		if rising_edge(clk) then
			count_out <= count;
			count := count - 1;
			if count = 0 then
				count := 15;
			end if;
		end if;
	end process controller;
end architecture behav;

-- Problem 13, Chapter 3
-- 14 September 2015
library IEEE;
use IEEE.std_logic_1164.all;

entity load_counter is
	port( clk, load	: in std_logic;
		  data_in	: in natural;
		  count_out : out natural);
end entity load_counter;

architecture behav of load_counter is
begin
	controller: process(clk, load) is
		variable count : natural := 16;
	begin
		if rising_edge(clk) and load = '0' then
			count := count - 1;
			count_out <= count;
			if count = 0 then
				count := 16;
			end if;
		elsif load = '1' then
			count := data_in;
			count_out <= count;
		end if;
	end process controller;
end architecture behav;

