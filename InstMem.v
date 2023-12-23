module InstMem #(
    parameter MEM_SIZE = 2048
) (
    input  [31:0] PCaddress,
    output [31:0] instruction
);

    reg [31:0] inst_mem[0:MEM_SIZE / 4 - 1];

    // 使用绝对路径
    initial $readmemh("/home/ethan/RISC-V-Single-Cycle/ROM.bin", inst_mem);

    // 从内存中读取指令
    assign instruction[31:0] = inst_mem[PCaddress[31:2]];
endmodule
