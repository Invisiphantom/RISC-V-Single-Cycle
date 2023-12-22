module PCIncre(
    input [31:0] PCaddress,
    output [31:0] PCincre
);

    assign PCincre = PCaddress + 4;
endmodule