entity reg_file is
	port(
		ReadRegister1 : in bit_vector(1 downto 0);
		ReadRegister2 : in bit_vector(1 downto 0);
		WriteRegister : in bit_vector(1 downto 0);
		WriteData     : in bit_vector(7 downto 0);
		RegWrite      : in bit;
		Clk	      : in bit;
		ReadData1     : out bit_vector(7 downto 0);
		ReadData2     : out bit_vector(7 downto 0));
end reg_file;

architecture behavioral of reg_file is
	type regfile is array (3 downto 0) of bit_vector(7 downto 0);
	signal regs : regfile;
	subtype small is integer range 0 to 3;
begin
	process(ReadRegister1,ReadRegister2)
		variable temp : small;
		variable temp2 : small;
	begin
		temp := 0;
		temp2 := 0;
		for i in 0 to 1 loop
			if(ReadRegister1(i) = '1') then
				temp := temp + 2**i;
			end if;
			if(ReadRegister2(i) = '1') then
				temp2 := temp2 + 2**i;
			end if;
		end loop;

		ReadData1 <= regs(temp);
		ReadData2 <= regs(temp2);
	end process;

	process(Clk)
		variable temp : small;
	begin
		temp := 0;
		if(Clk'event and Clk = '1') then
			if(RegWrite = '1') then
				for i in 0 to 1 loop
					if(WriteRegister(i) = '1') then
						temp := temp + 2**i;
					end if;
				end loop;
				
				regs(temp) <= WriteData;
			end if;
		end if;
	end process;
end;
