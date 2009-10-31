entity tbsign_extend is
end;

architecture mixed of tbsign_extend is	
		signal DataIn5 :  bit_vector(4 downto 0);
		signal DataOut8  : bit_vector(7 downto 0);
begin
	m2 : entity work.sign_extend(behavioral)
	port map (DataIn5,DataOut8);
	
	checking : process is
	begin
		DataIn5 <= transport "00000" after 1 ns;
		DataIn5 <= transport "00001" after 2 ns;
		DataIn5 <= transport "10100" after 3 ns;
		DataIn5 <= transport "10001" after 4 ns;
		DataIn5 <= transport "11111" after 5 ns;
		DataIn5 <= transport "10101" after 6 ns;
		report ("Fim dos testes");
		wait for 2 ns;
		wait;
	end process checking;
end;
