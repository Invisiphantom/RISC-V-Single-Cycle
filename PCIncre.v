module PCIncre(
    input [31:0] PCaddress,
    output [31:0] PCincre
);
    // 将PCincre赋值为PC的下一个地址
    assign PCincre = PCaddress + 4;
endmodule