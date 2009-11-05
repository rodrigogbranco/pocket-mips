entity andport is
	port(
		A : in bit;
		B : in bit;
		Result : out bit);
end andport;

architecture behavioral of andport is
begin
	process(A,B)
	begin
		Result <= A and B;
	end process;
end;
