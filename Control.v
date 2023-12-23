module Control (
    input      [6:0] Opcode,
    output           RegWrite,
    output           ALUSrc,    // 0:rs2 1:imm
    output     [1:0] ALUOp,     // 00:add 01:sub 10:R-type 11:I-type
    output           MemRead,   // Load
    output           MemWrite,  // Store
    output           Branch,    // Branch
    output           Jump,      // jal
    output           JumpReg,   // jalr
    output           Lui,       // lui
    output           Auipc,     // auipc
    output reg       Halt       // halt
);

    initial Halt = 1'b0;
    reg [10:0] control;
    assign {RegWrite, ALUSrc, ALUOp[1:0], MemRead, MemWrite, Branch, Jump, JumpReg, Lui, Auipc} = control[10:0];
    always @(*) begin
        case (Opcode)
            7'b0110011: control <= 11'b10_10_0000000;  // R-type
            7'b0010011: control <= 11'b11_11_0000000;  // I-type
            7'b0000011: control <= 11'b11_00_1000000;  // Load  
            7'b0100011: control <= 11'b01_00_0100000;  // Store
            7'b1100011: control <= 11'b00_01_0010000;  // Branch
            7'b1101111: control <= 11'b1x_xx_0001000;  // jal
            7'b1100111: control <= 11'b11_00_0000100;  // jalr
            7'b0110111: control <= 11'b11_00_0000010;  // lui
            7'b0010111: control <= 11'b11_00_0000001;  // auipc
            default: begin
                Halt <= 1'b1; // 遇到非法指令就停机
                control <= 11'bxxxxxxxxxxx;
            end
        endcase
    end
endmodule
