entity alu is
	port(
		A : in bit_vector(7 downto 0);
		B: in bit_vector(7 downto 0);
		ALUOperation : in bit_vector(1 downto 0);
		Result : out bit_vector(7 downto 0);
		Zero : out bit
		);
end alu;

architecture behavioral of alu is
	signal asum : bit_vector(7 downto 0);
	signal bsum : bit_vector(7 downto 0);
	signal rsum : bit_vector(7 downto 0);

	signal aminus : bit_vector(7 downto 0);
	signal bminus : bit_vector(7 downto 0);
	signal rminus : bit_vector(7 downto 0); 
begin
	m0: entity work.adder(behavioral)
	port map(asum,bsum,rsum);

	m1: entity work.subtrator(behavioral)
	port map(aminus,bminus,rminus);

	process(A,B,ALUOperation)
	begin
		if (ALUOperation = "00") then
			asum <= A;
			bsum <= B;
		elsif (ALUOperation = "01") then
			aminus <= A;
			bminus <= B;
		end if;

		if (A = B) then
			Zero <= '1';
		else
			Zero <= '0';
		end if;
	end process;

	process(rsum,rminus)
	begin
		if(rsum'event) then
			Result <= rsum;
		elsif(rminus'event) then
			Result <= rminus;
		end if;
	end process;
end;
