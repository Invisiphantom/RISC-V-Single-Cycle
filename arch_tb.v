`timescale 1ns / 1ns
module arch_tb ();
	reg clk  ;
	reg PCrst;

	initial begin
		clk = 1'b0;
		forever
			#10 clk = ~clk;
	end

	initial begin
		#5 PCrst = 1'b1;
		#15 PCrst = 1'b0;
	end

	initial begin
		#1000 $finish;
	end




	reg  [63:0] PCnext   ;
	wire [63:0] PCaddress;
	PC u_PC (
		.clk      (clk      ),
		.PCrst    (PCrst    ),
		.PCnext   (PCnext   ),
		.PCaddress(PCaddress)
	);


	wire [31:0] Instruction;
	InstructionMemory u_InstructionMemory (
		.pc_address (PCaddress  ),
		.instruction(Instruction)
	);


	wire [63:0] PCPlus4;
	PC4Add u_PC4Add (
		.PC     (PCaddress),
		.PCPlus4(PCPlus4  )
	);


	wire [63:0] ShiftImm;
	wire [63:0] PCSum   ;
	wire [63:0] ExImm   ;
	ShiftLeft1 u_ShiftLeft1 (
		.In (ExImm   ),
		.out(ShiftImm)
	);


	PCAdd u_PCAdd (
		.PCaddress(PCaddress),
		.ShiftImm (ShiftImm ),
		.PCSum    (PCSum    )
	);

	wire Zero       ;
	wire s_Less     ;
	wire u_Less     ;
	wire Jump       ;
	wire Branch     ;
	wire Branch_jump;
	BranchJudge u_BranchJudge (
		.zero       (Zero              ),
		.s_less     (s_Less            ),
		.u_less     (u_Less            ),
		.Branch     (Branch            ),
		.funct3     (Instruction[14:12]),
		.Branch_jump(Branch_jump       )
	);
	always @(*) begin
		PCnext = (Branch_jump == 1'b0 && Jump == 1'b0) ? PCPlus4 : PCSum;
	end



	wire       ALUSrc  ;
	wire       MemtoReg;
	wire       RegWrite;
	wire       MemRead ;
	wire       MemWrite;
	wire [1:0] ALUOp   ;
	Control u_Control (
		.Opcode  (Instruction[6:0]),
		.ALUSrc  (ALUSrc          ),
		.MemtoReg(MemtoReg        ),
		.RegWrite(RegWrite        ),
		.MemRead (MemRead         ),
		.MemWrite(MemWrite        ),
		.Branch  (Branch          ),
		.Jump    (Jump            ),
		.ALUOp   (ALUOp           )
	);


	wire [63:0] ReadData1;
	wire [63:0] ReadData2;
	wire [63:0] WriteData;
	Registers u_Registers (
		.clk      (clk               ),
		.RegWrite (RegWrite          ),
		.ReadReg1 (Instruction[19:15]),
		.ReadReg2 (Instruction[24:20]),
		.WriteReg (Instruction[11:7] ),
		.WriteData(WriteData         ),
		.ReadData1(ReadData1         ),
		.ReadData2(ReadData2         )
	);


	ImmGen u_ImmGen (
		.In (Instruction[31:0]),
		.Out(ExImm            )
	);


	wire [3:0] ALU_control;
	ALUControl u_ALUControl (
		.ALUOp      (ALUOp             ),
		.funct7     (Instruction[30]   ),
		.funct3     (Instruction[14:12]),
		.ALU_control(ALU_control       )
	);


	wire [63:0] ALU1;
	wire [63:0] ALU2;
	assign ALU1 = ReadData1;
	assign ALU2 = (ALUSrc == 0) ? ReadData2 : ExImm;



	wire [63:0] ALU_result;
	ALU u_ALU (
		.ALU_control(ALU_control),
		.A1         (ALU1       ),
		.A2         (ALU2       ),
		.Y          (ALU_result ),
		.zero       (Zero       ),
		.s_less     (s_Less     ),
		.u_less     (u_Less     )
	);


	wire [63:0] MemData;
	DataMemory u_DataMemory (
		.clk      (clk       ),
		.MemWrite (MemWrite  ),
		.MemRead  (MemRead   ),
		.address  (ALU_result),
		.WriteData(ReadData2 ),
		.ReadData (MemData   )
	);
	assign WriteData = (MemtoReg == 0) ? ALU_result : MemData;



	initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
	end
endmodule