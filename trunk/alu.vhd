entity alu is
	port(
		A 						: in bit_vector(7 downto 0);
		B							: in bit_vector(7 downto 0);
		ALUOperation 	: in bit_vector(1 downto 0);
		Result 				: out bit_vector(7 downto 0);
		Zero 					: out bit
		);
end alu;

architecture behavioral of alu is
	signal inputB 	: bit_vector(7 downto 0);
	signal ci			 	:	bit;
begin
	m0: entity work.adder(behavioral)
	port map(A,inputB,ci,Result);

	process(A,B,ci,ALUOperation)
	begin
		if (ALUOperation = "00") then
			inputB <= B;
			ci <= '0';
		elsif (ALUOperation = "01") then
			inputB <= not B;
			ci <= '1';
		end if;

		if (A = B) then
			Zero <= '1';
		else
			Zero <= '0';
		end if;
	end process;
end;
