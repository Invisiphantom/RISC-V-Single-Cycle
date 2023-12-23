module PC (
    input             clk,
    input      [31:0] PCnext,
    output reg [31:0] PCaddress
);

    // 将main函数设置为指定入口函数
    reg [31:0] PCinitial[0:0]; // $readmemh()要求必须是memory类型
    initial begin
        $readmemh("/home/ethan/RISC-V-Single-Cycle/ROM-PC.bin", PCinitial);
        PCaddress = PCinitial[0];
    end
    
    always @(posedge clk) begin
        PCaddress <= PCnext;
    end
endmodule
