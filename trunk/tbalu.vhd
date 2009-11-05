entity tbalu is
end;

architecture mixed of tbalu is	
	signal A : bit_vector(7 downto 0);
	signal B : bit_vector(7 downto 0);
	signal ALUOperation  : bit_vector(1 downto 0);
	signal Result : bit_vector(7 downto 0);
	signal Zero : bit;
begin
	m1: entity work.alu(behavioral)
	port map(A,B,ALUOperation,Result,Zero);
	
	
	checking : process is
	begin
		A <= "00000001" after 1 ns;
		B <= "00000011" after 1 ns;
		ALUOperation <= "00" after 1 ns;
		wait for 1 ns;
		A <= "00000100" after 1 ns;
		B <= "00000001" after 1 ns;
		ALUOperation <= "01" after 1 ns;
		wait for 3 ns;
		report ("Fim dos testes");
		wait;
	end process checking;
end;
