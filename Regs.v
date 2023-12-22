module Regs (
    input             clk,
    input             RegWrite,
    input      [ 4:0] readReg1,
    input      [ 4:0] readReg2,
    input      [ 4:0] writeReg,
    input      [31:0] writeData_R,
    output reg [31:0] readData1_R,
    output reg [31:0] readData2_R,

    output [31:0] x0,
    output [31:0] x1,
    output [31:0] x2,
    output [31:0] x3,
    output [31:0] x4,
    output [31:0] x5,
    output [31:0] x6
);

    integer i;
    reg [31:0] Register[0:31];
    initial for (i = 0; i < 32; i = i + 1) Register[i] = {32{1'b0}};


    always @(posedge clk) begin
        if (RegWrite && (writeReg != 5'b00000)) Register[writeReg] <= writeData_R;
    end

    always @(readReg1, readReg2) begin
        readData1_R = Register[readReg1];
        readData2_R = Register[readReg2];
    end


    assign x0 = Register[0];
    assign x1 = Register[1];
    assign x2 = Register[2];
    assign x3 = Register[3];
    assign x4 = Register[4];
    assign x5 = Register[5];
    assign x6 = Register[6];

endmodule
