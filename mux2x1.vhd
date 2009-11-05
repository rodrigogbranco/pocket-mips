entity mux2x1 is
	port(
		A : in bit_vector(7 downto 0);
		B : in bit_vector(7 downto 0);
		selector : in bit;
		Result : out bit_vector(7 downto 0));
end mux2x1;

architecture behavioral of mux2x1 is
begin
	process(selector)
	begin
		if (selector = '0') then
			Result <= A;
		else
			Result <= B;
		end if;
	end process;
end;
