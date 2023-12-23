module PCNext (
    input [31:0] PCaddress,
    input [31:0] PCincre,
    input Halt,

    input Cnd,
    input Jump,
    input JumpReg,
    input [31:0] imm,
    input [31:0] aluResult,
    output reg [31:0] PCnext
);

    always @(*) begin
        if (JumpReg == 1'b1) PCnext <= aluResult;
        else if (Cnd | Jump == 1'b1) PCnext <= PCaddress + imm;
        else if (Halt == 1'b1) PCnext <= PCaddress;
        else PCnext <= PCincre;
    end
endmodule
