module ALU_B(
    input ALUSrc,
    input [31:0] readData2_R,
    input [31:0] imm,
    output reg [31:0] aluB
);
    always @(*) begin
        if(ALUSrc == 1'b0) aluB = readData2_R;
        else aluB = imm;
    end
endmodule