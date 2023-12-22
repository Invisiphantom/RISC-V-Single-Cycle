module RegWrite (
    input MemRead,
    input Jump,
    input JumpReg,
    input [31:0] aluResult,
    input [31:0] readData_M,
    input [31:0] PCincre,
    output reg [31:0] writeData_R
);

    always @(*) begin
        if (Jump | JumpReg) writeData_R <= PCincre;
        else if (MemRead) writeData_R <= readData_M;
        else writeData_R <= aluResult;
    end
endmodule
