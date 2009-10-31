entity data_memory is
	port(
		Address : in bit_vector(7 downto 0);
		WriteData : in bit_vector(7 downto 0);
		MemRead : in bit;
		MemWrite : in bit;
		Clk : in bit;
		ReadData : out bit_vector(7 downto 0));
end data_memory;

architecture behavioral of data_memory is
	type Memory is array(255 downto 0) of bit_vector(7 downto 0);
	signal mem : Memory;
begin
	process(Clk)
		subtype small is integer range 0 to 255;
		variable temp : small := 0;
	begin
		if(Clk'event and Clk = '1') then
			temp := 0;
			for index in 0 to 7 loop
			      if (Address(index) = '1') then
				temp := temp + 2**index;
			      end if;
			end loop;

			if(MemRead = '1' and MemWrite = '0') then
				ReadData <= mem(temp);
			elsif (MemWrite = '1' and MemRead = '0') then
				mem(temp) <= WriteData;
			end if;	
		end if;
	end process;
end;
