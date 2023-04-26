module PCAdd (
    input  [63:0] PCaddress,
    input  [63:0] ShiftImm,
    output [63:0] PCSum
);
  assign PCSum = PCaddress + ShiftImm;
endmodule

