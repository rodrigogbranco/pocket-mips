entity tbpc_register is
end;

architecture mixed of tbpc_register is	
	signal Halt : bit;
	signal Clk : bit;
	signal NewPC  : bit_vector(7 downto 0);
	signal CurrentPC :bit_vector(7 downto 0);
	signal init_clock : bit;
begin
	m1: entity work.clock_generator(behavioral)
	port map(Halt,Clk,init_clock);
	
	m2 : entity work.pc_register(behavioral)
	port map (Clk,NewPC,CurrentPC);
	
	checking : process is
	begin
		NewPC <= transport "00000001" after 6 ns;
		NewPC <= transport "00000010" after 10 ns;
		NewPC <= transport "00000011" after 14 ns;
		NewPC <= transport "00000100" after 18 ns;
		Halt <= '1' after 20 ns;
		report ("Fim dos testes");
		wait;
	end process checking;
end;
