module Mem (
    input             clk,
    input             MemRead,
    input             MemWrite,
    input      [ 2:0] funct3,
    input      [31:0] memAddr,
    input      [31:0] writeData_M,
    output reg [31:0] readData_M
);

    // 总共2048字节的内存空间
    parameter MEM_SIZE = 2048;
    reg [7:0] mem[0:MEM_SIZE - 1];

    always @(MemRead or MemWrite or memAddr or writeData_M) begin
        #1;  // 消除memAddr和memData的抖动
        if (MemRead == 1'b1) begin
            case (funct3)
                3'h0: readData_M <= {{(32 - 8) {mem[memAddr][7]}}, mem[memAddr]};  // lb
                3'h1: readData_M <= {{(32 - 16) {mem[memAddr][7]}}, mem[memAddr], mem[memAddr+1]};  // lh
                3'h2: readData_M <= {mem[memAddr], mem[memAddr+1], mem[memAddr+2], mem[memAddr+3]};  // lw
                3'h4: readData_M <= {{(32 - 8) {1'b0}}, mem[memAddr]};  // lbu
                3'h5: readData_M <= {{(32 - 16) {1'b0}}, mem[memAddr], mem[memAddr+1]};  // lhu
                default: readData_M <= {32{1'bx}};
            endcase
        end else if (MemWrite == 1'b1) begin
            case (funct3)
                3'h0: mem[memAddr] <= writeData_M[7:0];  // sb
                3'h1: {mem[memAddr], mem[memAddr+1]} <= writeData_M[15:0];  // sh
                3'h2: {mem[memAddr], mem[memAddr+1], mem[memAddr+2], mem[memAddr+3]} <= writeData_M;  // sw
                default: mem[memAddr] <= {32{1'bx}};
            endcase
        end
    end
endmodule
