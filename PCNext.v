module PCNext (
    input [31:0] PCaddress,
    input [31:0] PCincre,
    input Halt,

    input Cnd,     // Branch
    input Jump,    // jal
    input JumpReg, // jalr
    input [31:0] imm,
    input [31:0] aluResult,
    output reg [31:0] PCnext
);

    always @(*) begin
        if (JumpReg == 1'b1) PCnext <= aluResult; // jalr
        else if (Jump | Cnd == 1'b1) PCnext <= PCaddress + imm; // jal or branch
        else if (Halt == 1'b1) PCnext <= PCaddress; // halt
        else PCnext <= PCincre; // normal PC+=4
    end
endmodule
