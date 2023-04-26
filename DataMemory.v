module DataMemory (
	input             clk      ,
	input             MemWrite ,
	input             MemRead  ,
	input      [63:0] address  ,
	input      [63:0] WriteData,
	output reg [63:0] ReadData
);
	reg [63:0] mem1[511:0];
	always @(clk, MemRead, MemWrite) begin
		if (MemRead == 1'b1) ReadData <= mem1[address];
		else if (MemWrite == 1'b1) mem1[address] = WriteData;
	end
endmodule
