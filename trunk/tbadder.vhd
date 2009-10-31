entity tbadder is
end;

architecture mixed of tbadder is	
	signal A : bit_vector(7 downto 0);
	signal B : bit_vector(7 downto 0);
	signal Sum  : bit_vector(7 downto 0);
begin
	m1: entity work.adder(behavioral)
	port map(A,B,Sum);
	
	
	checking : process is
	begin
		A <= transport "00000101" after 1 ns;
		B <= transport "00000011" after 1 ns;
		A <= transport "00000001" after 2 ns;
		B <= transport "00000010" after 3 ns;
		report ("Fim dos testes");
		wait;
	end process checking;
end;
