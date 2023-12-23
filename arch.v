module arch (
    input clk
);

    wire [31:0] PCnext;
    wire [31:0] PCaddress;
    PC u_PC (
        .clk      (clk),
        .PCnext   (PCnext),
        .PCaddress(PCaddress)
    );

    wire [31:0] PCincre;
    PCIncre u_PCIncre (
        .PCaddress(PCaddress),
        .PCincre  (PCincre)
    );

    wire Halt;
    wire Cnd;
    wire Jump;
    wire JumpReg;
    wire [31:0] imm;
    wire [31:0] aluResult;
    PCNext u_PCNext (
        .PCaddress(PCaddress),
        .PCincre  (PCincre),
        .Halt     (Halt),
        .Cnd      (Cnd),
        .Jump     (Jump),
        .JumpReg  (JumpReg),
        .imm      (imm),
        .aluResult(aluResult),
        .PCnext   (PCnext)
    );

    wire [31:0] instruction;
    InstMem u_InstMem (
        .PCaddress  (PCaddress),
        .instruction(instruction)
    );

    wire RegWrite;
    wire ALUSrc;
    wire [1:0] ALUOp;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire Lui;
    wire Auipc;
    Control u_Control (
        .Opcode  (instruction[6:0]),
        .RegWrite(RegWrite),
        .ALUSrc  (ALUSrc),
        .ALUOp   (ALUOp),
        .MemRead (MemRead),
        .MemWrite(MemWrite),
        .Branch  (Branch),
        .Jump    (Jump),
        .JumpReg (JumpReg),
        .Lui     (Lui),
        .Auipc   (Auipc),
        .Halt    (Halt)
    );

    wire [31:0] writeData_R;
    wire [31:0] readData1_R;
    wire [31:0] readData2_R;
    Regs u_Regs (
        .clk        (clk),
        .RegWrite   (RegWrite),
        .readReg1   (instruction[19:15]),
        .readReg2   (instruction[24:20]),
        .writeReg   (instruction[11:7]),
        .writeData_R(writeData_R),
        .readData1_R(readData1_R),
        .readData2_R(readData2_R)
    );

    ImmGen u_ImmGen(
    	.instruction (instruction ),
        .imm         (imm         )
    );
    

    wire [3:0] aluControl;
    ALUControl u_ALUControl (
        .ALUOp     (ALUOp),
        .funct7_30 (instruction[30]),
        .funct3    (instruction[14:12]),
        .aluControl(aluControl)
    );

    wire [31:0] aluA;
    ALU_A u_ALU_A (
        .Lui        (Lui),
        .Auipc      (Auipc),
        .readData1_R(readData1_R),
        .PCaddress  (PCaddress),
        .aluA       (aluA)
    );

    wire [31:0] aluB;
    ALU_B u_ALU_B (
        .ALUSrc     (ALUSrc),
        .readData2_R(readData2_R),
        .imm        (imm),
        .aluB       (aluB)
    );

    wire zero, s_less, u_less;
    ALU u_ALU (
        .aluControl(aluControl),
        .aluA      (aluA),
        .aluB      (aluB),
        .aluResult (aluResult),
        .zero      (zero),
        .s_less    (s_less),
        .u_less    (u_less)
    );


    Branch u_Branch (
        .Branch(Branch),
        .zero  (zero),
        .s_less(s_less),
        .u_less(u_less),
        .funct3(instruction[14:12]),
        .Cnd   (Cnd)
    );

    wire [31:0] readData_M;
    Mem u_Mem (
        .clk        (clk),
        .MemRead    (MemRead),
        .MemWrite   (MemWrite),
        .funct3     (instruction[14:12]),
        .memAddr    (aluResult),
        .writeData_M(readData2_R),
        .readData_M (readData_M)
    );


    RegWrite u_RegWrite (
        .MemRead    (MemRead),
        .Jump       (Jump),
        .JumpReg    (JumpReg),
        .aluResult  (aluResult),
        .readData_M (readData_M),
        .PCincre    (PCincre),
        .writeData_R(writeData_R)
    );
endmodule


module arch_tb;
    reg clk;

    arch arch_inst (.clk(clk));

    initial begin
        repeat (100) begin
            clk = 0;
            #5;
            clk = 1;
            #5;
        end
        $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
