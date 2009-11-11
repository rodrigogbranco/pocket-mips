--library std;
--use std.textio.all;


entity instruction_memory is
	port(
		ReadAddress : in bit_vector(7 downto 0) := "11111111";
		Instruction : out bit_vector(7 downto 0);

		LoadMemory : in bit; 
		MemoryLoaded : out bit := '0');
end instruction_memory;

architecture behavioral of instruction_memory is
	type Memory is array(255 downto 0) of bit_vector(7 downto 0);
	signal mem : Memory;
begin
	process(ReadAddress)
		subtype small is integer range 0 to 255;
		variable temp : small := 0;
	begin
		if(ReadAddress'event) then
			--executar a busca de instrucoes
			temp := 0;
			for index in 0 to 7 loop
			      if (ReadAddress(index) = '1') then
				temp := temp + 2**index;
			      end if;
			end loop;

			Instruction <= mem(temp);
		end if;
	end process;

	process(LoadMemory)
		subtype small is integer range 0 to 255;
		subtype word is integer;
		type t_file is file of word;
		variable i				:	small;
		variable j				:	natural;
		--file instructions	:	t_file open read_mode is "source";
		file instructions : t_file;
		--variable linha		: line;
		variable memo		:	word;
		variable status : file_open_status;
	begin
		if(LoadMemory = '1') then
			--read file
			i:=0;
			j:=0;
			file_open(status,instructions,"source",read_mode);
		
			if(status /= open_ok) then
				report "fudeu";
			end if;
			
			while not endfile(instructions) loop
				--readline(instructions,linha);
				--read(linha,memo);
				--mem(i) <= memo;
				read(instructions,memo);
				report integer'image(memo);
				--mem(i) <= memo;
				--if(memo = '0') then
					--report "memo = 0";
				--elsif(memo = '1') then
					--report "memo = 1";
				--else
					--report "memo = null";
				--end if;
				--report "j = " & natural'image(j);
				--report "i = " & natural'image(i);
				--j:= (j+1) rem 8;
				--if(j = 0) then
					--i := i+1;
				--end if;
			end loop;
			--mem(0) <= "00111111";
			--mem(1) <= "00001000";
			--mem(2) <= "11111111";
			--memory is fully loaded
			MemoryLoaded <= '1';
		end if;
	end process;
end;
