entity subtrator1b is
	port(
		A : in bit;
		B : in bit;
		carryIn : in bit;
		carryOut : out bit;
		Sum : out bit);
end subtrator1b;

architecture behavioral of subtrator1b is
begin
	process(A,B,carryIn)
	begin
		Sum <= A xor B xor carryIn;
		carryOut <= ((not A and B) or ((not A or B) and carryIn));
	end process;
end;
