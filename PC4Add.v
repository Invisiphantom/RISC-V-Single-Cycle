module PC4Add (
    input  [63:0] PC,
    output [63:0] PCPlus4
);
  assign PCPlus4 = PC + 4;
endmodule
