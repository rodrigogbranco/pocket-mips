entity clock_generator is
	port(
		Halt : in bit; -- Sinal de parada
		Clk  : out bit; -- Sinal de clock
		init_clock : in bit);
end clock_generator;

architecture behavioral of clock_generator is
	signal clock: bit; --Sinal auxiliar, coordena o clock
	signal canHalt : bit := '0'; --Sinal para parar o processamento
begin
	process
	begin
			--verifica se ainda é pra gerar clock
			if (canHalt = '0') then
				clock <= transport '1' after 1 ns; clock <= transport '0' after 2 ns;
				wait for 2 ns;
			else
				wait;
			end if;
	end process;

	process(clock,Halt)
	begin
		--verifica se o Halt ainda não foi acionado
		if(canHalt = '0') then
			--transporta o sinal de clock
			if(clock'event) then
				if(init_clock = '1') then
					Clk <= transport clock;
				end if;
			end if;

			--escalona o canHalt para o proximo ciclo, se necessário
			if(Halt'event and Halt = '1')	 then
				canHalt <= '1' after 2 ns;
			end if;
		end if;
	end process;
end;
