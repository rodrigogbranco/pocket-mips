entity tbclock_generator is
end;

architecture mixed of tbclock_generator is
	signal Halt : bit;
	signal Clk  : bit;
	signal init_clock : bit := '0';
begin
	m2 : entity work.clock_generator(behavioral)
	port map (Halt,Clk,init_clock);
	
	checking : process is
	begin
		init_clock <= '1' after 3 ns;
		Halt <= '1' after 9 ns;
		wait for 20 ns;
		report "Fim dos testes";
		wait;
	end process checking;
end;
