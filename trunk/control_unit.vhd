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

		WriteHidden : out bit;
		WhichHidden : out bit;
		isHidden : out bit;
		LW_SW : out bit;
		init_clock : out bit := '0';

		LoadMemory : out bit := '0'; --aux, to load memory
		MemoryLoaded : in bit --the memory is loaded
		);
end control_unit;

architecture behavioral of control_unit is
begin

	process(Op,Func,MemoryLoaded)
	begin
		if(MemoryLoaded = '0') then
			LoadMemory <= '1';
		elsif(MemoryLoaded'event and MemoryLoaded = '1') then
			init_clock <= '1' after 1 ns;
			--Halt <= '1' after 6 ns;
		else
			if(Op'event or Func'event) then
				case Op is
					--Type R instructions
					when "000" => --ADD
						report "ADD " & "";
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '0'; --Don't read from memory
						MemWrite <= '0'; --Don't write on memory
						MemToReg <= '0'; -- Don't load from memory
						Branch <= '0'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "01"; --Register
						ALUOp <= "00"; --Add
						WriteHidden <= '1'; --It will write in AC or BC
						WhichHidden <= '0'; --Choose AC
						isHidden <= '0'; --Choose Ac or BC for read
						LW_SW <= '0'; -- Load/Store Operation
					
					when "010" => --SUB
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '0'; --Don't read from memory
						MemWrite <= '0'; --Don't write on memory
						MemToReg <= '0'; -- Don't load from memory
						Branch <= '0'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "01"; --Register
						ALUOp <= "01"; --Add
						WriteHidden <= '1'; --It will write in AC or BC
						WhichHidden <= '0'; --Choose AC
						isHidden <= '0'; --Choose Ac or BC for read
						LW_SW <= '0'; -- Load/Store Operation

					when "110" =>  --CHOOSE
						case Func is
							when "00" => --MTA
								RegDst <= '0'; --??? We aren't using this signal
								RegWrite <= '0'; --Don't write on normal registers
								MemRead <= '0'; --Don't read from memory
								MemWrite <= '0'; --Don't write on memory
								MemToReg <= '0'; -- Don't load from memory
								Branch <= '0'; --Don't do the branch
								InvZero <= '0'; --??? We aren't using this signal
								ALUSrc <= "00"; --Zero Value
								ALUOp <= "00"; --Add
								WriteHidden <= '1'; --It will write in AC or BC
								WhichHidden <= '0'; --Choose AC
								isHidden <= '0'; --Choose Ac or BC for read
								LW_SW <= '0'; -- Load/Store Operation
					
							when "01" => --MTB
								RegDst <= '0'; --??? We aren't using this signal
								RegWrite <= '0'; --Don't write on normal registers
								MemRead <= '0'; --Don't read from memory
								MemWrite <= '0'; --Don't write on memory
								MemToReg <= '0'; -- Don't load from memory
								Branch <= '0'; --Don't do the branch
								InvZero <= '0'; --??? We aren't using this signal
								ALUSrc <= "00"; --Zero Value
								ALUOp <= "00"; --Add
								WriteHidden <= '1'; --It will write in AC or BC
								WhichHidden <= '1'; --Choose BC
								isHidden <= '0'; --Choose Ac or BC for read
								LW_SW <= '0'; -- Load/Store Operation
							when others => --nop
								RegDst <= '0'; --??? We aren't using this signal
								RegWrite <= '0'; --Don't write on normal registers
								MemRead <= '0'; --Don't read from memory
								MemWrite <= '0'; --Don't write on memory
								MemToReg <= '0'; -- Don't load from memory
								Branch <= '0'; --Don't do the branch
								InvZero <= '0'; --??? We aren't using this signal
								ALUSrc <= "00"; --Zero Value
								ALUOp <= "00"; --Add
								WriteHidden <= '0'; --It will NOT write in AC or BC
								WhichHidden <= '0'; --Choose BC
								isHidden <= '0'; --Choose Ac or BC for read
								LW_SW <= '0'; -- Load/Store Operation
						end case;
					when "111" => --CHOOSE
						ALUOp <= "00"; --add
						case Func is
							when "00" => --MFA
								RegDst <= '0'; --??? We aren't using this signal
								RegWrite <= '1'; --Write on normal registers
								MemRead <= '0'; --Don't read from memory
								MemWrite <= '0'; --Don't write on memory
								MemToReg <= '0'; -- Don't load from memory
								Branch <= '0'; --Don't do the branch
								InvZero <= '0'; --??? We aren't using this signal
								ALUSrc <= "00"; --Zero Value
								ALUOp <= "00"; --Add
								WriteHidden <= '0'; --It will NOT write in AC or BC
								WhichHidden <= '0'; --Choose AC
								isHidden <= '0'; --Choose Ac or BC for read
								LW_SW <= '0'; -- Load/Store Operation
							when "01" => --MFB
								RegDst <= '0'; --??? We aren't using this signal
								RegWrite <= '1'; --Write on normal registers
								MemRead <= '0'; --Don't read from memory
								MemWrite <= '0'; --Don't write on memory
								MemToReg <= '0'; -- Don't load from memory
								Branch <= '0'; --Don't do the branch
								InvZero <= '0'; --??? We aren't using this signal
								ALUSrc <= "00"; --Zero Value
								ALUOp <= "00"; --Add
								WriteHidden <= '0'; --It will NOT write in AC or BC
								WhichHidden <= '1'; --Choose BC
								isHidden <= '0'; --Choose Ac or BC for read
								LW_SW <= '0'; -- Load/Store Operation
							when "11" => --HALT
								report "HALT";
								Halt <= '1';
							when others => --nop
								RegDst <= '0'; --??? We aren't using this signal
								RegWrite <= '0'; --Don't write on normal registers
								MemRead <= '0'; --Don't read from memory
								MemWrite <= '0'; --Don't write on memory
								MemToReg <= '0'; -- Don't load from memory
								Branch <= '0'; --Don't do the branch
								InvZero <= '0'; --??? We aren't using this signal
								ALUSrc <= "00"; --Zero Value
								ALUOp <= "00"; --Add
								WriteHidden <= '0'; --It will NOT write in AC or BC
								WhichHidden <= '0'; --Choose BC
								isHidden <= '0'; --Choose Ac or BC for read
								LW_SW <= '0'; -- Load/Store Operation
						end case;
					--Type I instructions
					when "001" => --ADDI
						report "ADDI" & "";
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '0'; --Don't read from memory
						MemWrite <= '0'; --Don't write on memory
						MemToReg <= '0'; -- Don't load from memory
						Branch <= '0'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "10"; --Sign Extend
						ALUOp <= "00"; --Add
						WriteHidden <= '1'; --It will write in AC or BC
						WhichHidden <= '0'; --Choose AC
						isHidden <= '0'; --Choose Ac or BC for read
						LW_SW <= '0'; -- Load/Store Operation
					when "100" => --LW
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '1'; --Read from memory
						MemWrite <= '0'; --Don't write on memory
						MemToReg <= '1'; -- Load from memory
						Branch <= '0'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "01"; --Register
						ALUOp <= "00"; --Add
						WriteHidden <= '1'; --It will write in AC or BC
						WhichHidden <= '0'; --Choose AC
						isHidden <= '0'; --Choose Ac or BC for read
						LW_SW <= '1'; -- Load/Store Operation
					when "101" => --SW
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '0'; --Don't read from memory
						MemWrite <= '1'; --Write on memory
						MemToReg <= '0'; -- Don't load from memory
						Branch <= '0'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "01"; --Register
						ALUOp <= "00"; --Add
						WriteHidden <= '0'; --It will NOT write in AC or BC
						WhichHidden <= '0'; --Choose AC
						isHidden <= '0'; --Choose Ac or BC for read
						LW_SW <= '1'; -- Load/Store Operation

					--Type J instructions
					when "011" => --BEQ
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '0'; --Don't read from memory
						MemWrite <= '0'; --Don't write on memory
						MemToReg <= '0'; -- Don't load from memory
						Branch <= '1'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "01"; --Register
						ALUOp <= "01"; --Sub
						WriteHidden <= '0'; --It will NOT write in AC or BC
						WhichHidden <= '0'; --Choose AC
						isHidden <= '1'; --Choose Ac or BC for read
						LW_SW <= '0'; -- Load/Store Operation

					--Others
					when others => --NOP
						RegDst <= '0'; --??? We aren't using this signal
						RegWrite <= '0'; --Don't write on normal registers
						MemRead <= '0'; --Don't read from memory
						MemWrite <= '0'; --Don't write on memory
						MemToReg <= '0'; -- Don't load from memory
						Branch <= '0'; --Don't do the branch
						InvZero <= '0'; --??? We aren't using this signal
						ALUSrc <= "00"; --Zero Value
						ALUOp <= "00"; --Add
						WriteHidden <= '0'; --It will NOT write in AC or BC
						WhichHidden <= '0'; --Choose BC
						isHidden <= '0'; --Choose Ac or BC for read
						LW_SW <= '0'; -- Load/Store Operation
				end case;
			end if;
		end if;
	end process;
end;
