entity control_unit is
	port(
		Op : in bit_vector(2 downto 0);
		Func : in bit_vector(1 downto 0);
		RegDst : out bit;
		RegWrite : out bit;
		MemRead : out bit;
		MemWrite : out bit;
		MemToReg : out bit;
		Branch : out bit;
		InvZero : out bit;
		Halt : out bit;
		ALUSrc : out bit_vector(1 downto 0);
		ALUOp : out bit_vector(1 downto 0);

		LoadMemory : out bit; --aux, to load memory
		MemoryLoaded : in bit --the memory is loaded
		);
end control_unit;

architecture behavioral of control_unit is
begin

	process(Op,Func)
	begin
		

		if(Op'event or Func'event) then
			case Op is
				--Type R instructions
				when "000" => --ADD
					ALUOp <= "00"; --add
					RegDst <= '1';
					ALUSrc <= "00";
					MemToReg <= '0';
					RegWrite <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '0';
					
				when "010" => --SUB
					ALUOp <= "01"; --sub
					RegDst <= '1';
					ALUSrc <= "00";
					MemToReg <= '0';
					RegWrite <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '0';

				when "110" =>  --MTA
					ALUOp <= "00"; --add
				when "111" => --CHOOSE
					ALUOp <= "00"; --add
					case Func is
						when "00" => --MFA
						when "01" => --MFB
						when "11" => --HALT
							Halt <= '1';
						when others => --nop
					end case;
				--Type I instructions
				when "001" => --ADDI
					ALUOp <= "00"; --add
				when "100" => --LW
					ALUOp <= "00"; --add
				when "101" => --SW
					ALUOp <= "00"; --add

				--Type J instructions
				when "011" => --BEQ
					ALUOp <= "01"; --sub

				--Others
				when others => --NOP
					ALUOp <= "11"; --sub
			end case;
		end if;
	end process;

	process(MemoryLoaded)
	begin
		if(MemoryLoaded = '1') then
			Halt <= '0';
		end if;
	end process;

	process
	begin
		Halt <= '1';
		LoadMemory <= '1';
		wait;
	end process;
end;
