module ALUControl (
    input      [1:0] ALUOp,
    input            funct7_30,
    input      [2:0] funct3,
    output reg [3:0] aluControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: aluControl <= 4'b0010;  // add
            2'b01: aluControl <= 4'b0110;  // sub
            2'b10:  // R-type
            case ({
                funct7_30, funct3
            })
                4'b0000: aluControl <= 4'b0010;  // add
                4'b1000: aluControl <= 4'b0110;  // sub
                4'b0100: aluControl <= 4'b0111;  // xor
                4'b0110: aluControl <= 4'b0001;  // or
                4'b0111: aluControl <= 4'b0000;  // and
                4'b0001: aluControl <= 4'b0011;  // sll
                4'b0101: aluControl <= 4'b1000;  // srl
                4'b1101: aluControl <= 4'b1010;  // sra
                4'b0010: aluControl <= 4'b0100;  // slt
                4'b0011: aluControl <= 4'b0101;  // sltu
                default: aluControl <= 4'bxxxx;
            endcase
            2'b11:  // I-type
            casez ({
                funct7_30, funct3
            })
                4'bz000: aluControl <= 4'b0010;  // addi
                4'bz100: aluControl <= 4'b0111;  // xori
                4'bz110: aluControl <= 4'b0001;  // ori
                4'bz111: aluControl <= 4'b0000;  // andi

                4'b0001: aluControl <= 4'b0011;  // slli imm[0:4]
                4'b0101: aluControl <= 4'b1000;  // srli imm[0:4]
                4'b1101: aluControl <= 4'b1010;  // srai imm[0:4]

                4'bz010: aluControl <= 4'b0100;  // slti
                4'bz011: aluControl <= 4'b0101;  // sltiu
                default: aluControl <= 4'bxxxx;
            endcase
        endcase
    end
endmodule
