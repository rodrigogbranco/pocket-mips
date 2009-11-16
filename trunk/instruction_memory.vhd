library std;
use std.textio.all;


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
		--subtype small is integer range 0 to 255;
		subtype palavra is bit_vector(7 downto 0);
		--type t_arquivo is file of text;
		variable i						:	natural;
		variable a						:	natural;
		file instrucoes				:	text;
		variable nome_arquivo	:	string(1 to 20);
		variable linha				: line;
		variable linha2				:	line;
		variable valor				:	palavra;
		variable estado				: file_open_status := name_error;
	begin
		if(LoadMemory = '1') then
			--read file
			i := 0;
			a := 1;
			while estado /= open_ok loop
				write(linha2,string'("Insira o nome do arquivo:"));
				writeline(output,linha2);
				readline(input,linha);
				if(linha'length < nome_arquivo'length) then
					read(linha,nome_arquivo(1 to linha'length));
				else
					readline(input,linha);
				end if;
				--Abertura do arquivo
				file_open(estado,instrucoes,nome_arquivo,read_mode);
				--Excecoes lancadas durante a abertura do arquivo
				if(estado /= open_ok) then
					if(estado = name_error) then
						write(linha2,string'("Arquivo "&nome_arquivo&" não encontrado, verifique se o nome foi digitado corretamente"));
					end if;
					if(estado = mode_error) then
						write(linha2,string'("Nao foi possivel abrir o arquivo "&nome_arquivo&" em modo de leitura"));
					end if;
					if(estado = status_error) then
						write(linha2,string'("O arquivo "&nome_arquivo&" ja se encontra em uso"));
					end if;
					writeline(output,linha2);
				end if;
			end loop;
			while not endfile(instrucoes) loop
				--Leitura da linha do arquivo
				readline(instrucoes,linha);
				--Leitura da variavel linha
				read(linha,valor);
				mem(i) <= valor;
				i := i + 1;
			end loop;
			--mem(0) <= "00111111";
			--mem(1) <= "00001000";
			--mem(2) <= "11111111";
			--memory is fully loaded
			MemoryLoaded <= '1';
		end if;
	end process;
end;
