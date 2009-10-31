entity adder1b is
	port(
		A : in bit;
		B : in bit;
		carryIn : in bit;
		carryOut : out bit;
		Sum : out bit);
end adder1b;

architecture behavioral of adder1b is
begin
	process(A,B,carryIn)
	begin
		Sum <= (A xor B) xor carryIn;
		carryOut <= (A and B) or (A and carryIn) or (B and carryIn);
	end process;
end;
