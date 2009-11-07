entity tbreg_file is
end;

architecture mixed of tbreg_file is
		signal ReadRegister1 : bit_vector(1 downto 0);
		signal ReadRegister2 : bit_vector(1 downto 0);
		signal WriteRegister : bit_vector(1 downto 0);
		signal WriteData     : bit_vector(7 downto 0);
		signal RegWrite      : bit;
		signal Clk	      : bit;
		signal ReadData1     : bit_vector(7 downto 0);
		signal ReadData2     : bit_vector(7 downto 0);

		signal WriteHidden : bit;
		signal WhichHidden : bit;
		signal ReadHidden : bit_vector(7 downto 0);
		signal Ac_out : bit_vector(7 downto 0); 
		signal LW_SW : bit;

		signal Halt : bit;	
		signal init_clock : bit;
begin
	m1: entity work.reg_file(behavioral)
	port map(ReadRegister1,ReadRegister2,WriteRegister,WriteData,RegWrite,
		 Clk,ReadData1,ReadData2,WriteHidden,WhichHidden,ReadHidden,Ac_out);

	m2: entity work.clock_generator(behavioral)
	port map(Halt,Clk,init_clock);
	
	checking : process is
	begin
		wait for 1 ns;
		RegWrite <= '1';
		WriteData <= "10101010";
		WriteRegister <= "01";

		wait for 3 ns;
		RegWrite <= '0';
		ReadRegister1 <= "01";
		ReadRegister2 <= "00";

		wait for 5 ns;
		ReadRegister1 <= "00";
		ReadRegister2 <= "01";

		Halt <= '1';
		report ("Fim dos testes");
		wait;
	end process checking;
end;
