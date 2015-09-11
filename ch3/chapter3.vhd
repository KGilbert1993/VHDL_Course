-- Problem 10: Limiter
entity limiter is
	port( data_in, lower, upper : in integer;
		  data_out              : out integer;
		  out_of_limits			: out bit);
end entity limiter;

architecture behav of limiter is
begin
	controller: process(data_in, upper, lower)
	begin
		out_of_limits <= '0';
		if (data_in > upper) then
			data_out <= upper;
			out_of_limits <= '1';
		elsif (data_in < lower) then
			data_out <= lower;
			out_of_limits <= '1';
		else
			data_out <= data_in;
		end if;
	end process controller;
end architecture behav;	