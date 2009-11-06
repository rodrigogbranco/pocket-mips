entity pc_register is
	port(
		Clk  : in bit; -- Sinal de clock
		NewPC : in bit_vector(7 downto 0) := "11111111"; --Sinal entrada de PC Novo 
		CurrentPC : out bit_vector(7 downto 0) := "11111111"); --Sinal de saida do PC
end pc_register;

architecture behavioral of pc_register is
begin
	process(Clk)
	begin
		if(Clk'event and Clk = '1') then
				CurrentPC <= NewPC;
		end if;
	end process;
end;
