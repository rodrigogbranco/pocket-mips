entity system is
end system;

architecture behavioral of system is
	--DataPath
	signal mem_instr_out : bit_vector(7 downto 0); --sinal que vem da memoria de instrucoes e vai para UC, REG_FILE e SIGN_EXTEND
	signal sign_ext_out : bit_vector(7 downto 0); --saida da SIGN_EXTEND
	signal reg_out1 : bit_vector(7 downto 0); --saida 1 do REG_FILE
	signal reg_out2 : bit_vector(7 downto 0); --saida 2 do REG_FILE
	signal hidden_out : bit_vector(7 downto 0); --saida com AC ou BC do REG_FILE
	signal mux_reg_sign_out :bit_vector(7 downto 0); --saida do mux com Zero, Reg ou Sign Extend
	signal mux_reg_hidden_out : bit_vector(7 downto 0); --saida com Reg ou Ac ou Bc
	signal alu_out : bit_vector(7 downto 0); --saida da Alu
	signal data_mem_out : bit_vector(7 downto 0); --saida da data memory
	signal mux_mem_reg_write : bit_vector(7 downto 0); --saida do mux com Alu out ou Data memory out
	signal zero_out : bit; --saida Zero da Alu
	signal branch_out : bit; --saida And de Zero e Branch
	signal adder_out : bit_vector(7 downto 0); -- saida do adder do PC
	signal zero_value : bit_vector(7 downto 0) := "00000000"; --valor constante Zero, para Alu
	signal one_value : bit_vector(7 downto 0) := "00000001"; --valor constant Um, para PC
	signal mux_branch_out : bit_vector(7 downto 0); -- saida mux com Adder PC ou AC
	signal pc_out : bit_vector(7 downto 0); --sport map(alu_out,data_mem_out,MemToReg,mux_mem_reg_write);aida PC

	--Control Unit signals
	signal RegDst : bit;
	signal RegWrite : bit;
	signal MemRead : bit;
	signal MemWrite : bit;
	signal MemToReg : bit;
	signal Branch : bit;
	signal InvZero : bit;
	signal Halt : bit;
	signal ALUSrc : bit_vector(1 downto 0);
	signal ALUOp : bit_vector(1 downto 0);

	signal WriteHidden : bit;
	signal WhichHidden : bit;
	signal ReadHidden : bit_vector(7 downto 0);
	signal isHidden : bit; 
	signal LW_SW : bit;
	signal init_clock : bit;

	signal Clk : bit;

	signal Ac_out : bit_vector(7 downto 0);	

	signal loadmemory : bit; --controle de carga de memoria entre a UC e instr memory (inicio)
	signal memoryloaded : bit; --controle de carga de memoria entre a UC e instr memory (fim)
begin
	m : entity work.clock_generator(behavioral)
	port map(Halt,Clk,init_clock);
	
	m0 : entity work.instruction_memory(behavioral)
	port map(pc_out,mem_instr_out,loadmemory,memoryloaded);

	m1 : entity work.reg_file(behavioral)
	port map(mem_instr_out(4 downto 3),mem_instr_out(2 downto 1),mem_instr_out(4 downto 3),mux_mem_reg_write,
		RegWrite,Clk,reg_out1,reg_out2,WriteHidden,WhichHidden,ReadHidden,Ac_out,LW_SW);

	m2 : entity work.sign_extend(behavioral)
	port map(mem_instr_out(4 downto 0),sign_ext_out);

	m3 : entity work.mux2x1(behavioral)
	port map(alu_out,data_mem_out,MemToReg,mux_mem_reg_write);

	m4 : entity work.mux3x1(behavioral)
	port map(zero_value,reg_out2,sign_ext_out,ALUSrc,mux_reg_sign_out);

	m5 : entity work.mux2x1(behavioral)
	port map(ReadHidden,reg_out1,isHidden,mux_reg_hidden_out);

	m6 : entity work.alu(behavioral)
	port map(mux_reg_hidden_out,mux_reg_sign_out,ALUOp,alu_out,zero_out);

	m7 : entity work.data_memory(behavioral)
	port map(alu_out,Ac_out,MemRead,MemWrite,Clk,data_mem_out);

	m8 : entity work.andport(behavioral)
	port map(Branch,zero_out,branch_out);

	m9 : entity work.mux2x1(behavioral)
	port map(adder_out,Ac_out,branch_out,mux_branch_out);

	m10 : entity work.pc_register(behavioral)
	port map(Clk,mux_branch_out,pc_out);

	m11: entity work.adder(behavioral)
	port map(one_value,pc_out,adder_out);

	m12 : entity work.control_unit(behavioral)
	port map(mem_instr_out(7 downto 5),mem_instr_out(1 downto 0),RegDst,RegWrite,MemRead,MemWrite,MemToReg,Branch,
		InvZero,Halt,ALUSrc,ALUOp,WriteHidden,WhichHidden,isHidden,LW_SW,init_clock,loadmemory,memoryloaded);	
end;
