module Registers (
	input             clk      ,
	input             RegWrite ,
	input      [ 4:0] ReadReg1 ,
	input      [ 4:0] ReadReg2 ,
	input      [ 4:0] WriteReg ,
	input      [63:0] WriteData,
	output reg [63:0] ReadData1,
	output reg [63:0] ReadData2,
	output     [63:0] x0       ,
	output     [63:0] x1       ,
	output     [63:0] x2       ,
	output     [63:0] x3       ,
	output     [63:0] x4       ,
	output     [63:0] x5       ,
	output     [63:0] x6
);
	reg [63:0] Register[31:0];
	initial begin
		Register[0] = 64'h0000_0000_0000_0000;
	end
	always @(posedge clk) begin
		if (RegWrite && (WriteReg != 5'b00000)) Register[WriteReg] <= WriteData;
	end
	always @(ReadReg1 ,ReadReg2) begin
		ReadData1 = Register[ReadReg1] ;
		ReadData2 = Register[ReadReg2];
	end


	assign x0 = Register[0];
	assign x1 = Register[1];
	assign x2 = Register[2];
	assign x3 = Register[3];
	assign x4 = Register[4];
	assign x5 = Register[5];
	assign x6 = Register[6];

endmodule
