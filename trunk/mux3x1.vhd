entity mux3x1 is
	port(
		A : in bit_vector(7 downto 0);
		B : in bit_vector(7 downto 0);
		C : in bit_vector(7 downto 0);
		selector : in bit_vector(1 downto 0);
		Result : out bit_vector(7 downto 0));
end mux3x1;

architecture behavioral of mux3x1 is
begin
	process(A,B,C,selector)
	begin
		if (selector = "00") then
			Result <= A;
		elsif (selector = "01") then
			Result <= B;
		elsif (selector = "10") then
			Result <= C;
		end if;
	end process;
end;
