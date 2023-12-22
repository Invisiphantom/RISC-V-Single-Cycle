module PC (
    input             clk,
    input      [31:0] PCnext,
    output reg [31:0] PCaddress
);

    initial PCaddress = {32{1'b0}};
    always @(posedge clk) begin
        PCaddress <= PCnext;
    end
endmodule
