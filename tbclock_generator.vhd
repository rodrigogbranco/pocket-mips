entity tbclock_generator is
end;

architecture mixed of tbclock_generator is
	signal Halt : bit;
	signal Clk  : bit;
begin
	m2 : entity work.clock_generator(behavioral)
	port map (Halt,Clk);
	
	checking : process is
	begin
		Halt <= '1' after 9 ns;
		wait for 20 ns;
		report "Fim dos testes";
		wait;
	end process checking;
end;
