module ALU_A (
    input Lui,
    input Auipc,
    input [31:0] readData1_R,
    input [31:0] PCaddress,
    output reg [31:0] aluA
);
    always @(*) begin
        if (Lui == 1'b1) aluA = {32{1'b0}};  // lui [rd=0+(imm<<12)]
        else if (Auipc == 1'b1) aluA = PCaddress;  // auipc [rd=PC+(imm<<12)]
        else aluA = readData1_R;  // rs1
    end
endmodule
