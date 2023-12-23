module Regs (
    input         clk,
    input         RegWrite,
    input  [ 4:0] readReg1,
    input  [ 4:0] readReg2,
    input  [ 4:0] writeReg,
    input  [31:0] writeData_R,
    output [31:0] readData1_R,
    output [31:0] readData2_R,

    output [31:0] x0,
    output [31:0] ra,
    output [31:0] sp,
    output [31:0] gp,
    output [31:0] tp,
    output [31:0] t0,
    output [31:0] t1,
    output [31:0] t2,
    output [31:0] s0,
    output [31:0] s1,
    output [31:0] a0,
    output [31:0] a1,
    output [31:0] a2,
    output [31:0] a3,
    output [31:0] a4,
    output [31:0] a5,
    output [31:0] a6,
    output [31:0] a7
);

    integer i;
    reg [31:0] Register[0:31];
    initial begin
        for (i = 0; i < 32; i = i + 1) Register[i] <= {32{1'b0}};
        Register[2] <= 32'h700;  // 栈指针初始设置为0x700(1792)
    end

    always @(posedge clk) begin
        if (RegWrite && (writeReg != 5'b00000)) Register[writeReg] <= writeData_R;
    end

    assign readData1_R = Register[readReg1];
    assign readData2_R = Register[readReg2];


    assign x0 = Register[0];
    assign ra = Register[1];
    assign sp = Register[2];
    assign gp = Register[3];
    assign tp = Register[4];
    assign t0 = Register[5];
    assign t1 = Register[6];
    assign t2 = Register[7];
    assign s0 = Register[8];
    assign s1 = Register[9];
    assign a0 = Register[10];
    assign a1 = Register[11];
    assign a2 = Register[12];
    assign a3 = Register[13];
    assign a4 = Register[14];
    assign a5 = Register[15];
    assign a6 = Register[16];
    assign a7 = Register[17];

endmodule
