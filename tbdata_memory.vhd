entity tbdata_memory is
end;

architecture mixed of tbdata_memory is	
		signal Address : bit_vector(7 downto 0);
		signal WriteData : bit_vector(7 downto 0);
		signal MemRead : bit;
		signal MemWrite : bit;
		signal Clk : bit;
		signal Halt : bit;
		signal ReadData : bit_vector(7 downto 0);
begin
	m1: entity work.data_memory(behavioral)
	port map(Address,WriteData,MemRead,MemWrite,Clk,ReadData);

	m2: entity work.clock_generator(behavioral)
	port map(Halt,Clk);
	
	checking : process is
	begin
		Address <= transport "11111110" after 2 ns;
		WriteData <= transport "10101010" after 2 ns;
		MemWrite <= transport '1' after 2 ns;

		Address <= transport "11111111" after 6 ns;
		WriteData <= transport "11111111" after 6 ns;
		MemWrite <= transport '1' after 4 ns;

		MemWrite <= transport '0' after 10 ns;
		MemRead <= transport '1' after 10 ns;
		Address <= transport "11111110" after 10 ns;

		MemWrite <= transport '0' after 14 ns;
		MemRead <= transport '1' after 14 ns;
		Address <= transport "11111111" after 14 ns;

		Halt <= '1' after 25 ns;
		wait for 25 ns;
		report ("Fim dos testes");
		wait;
	end process checking;
end;
