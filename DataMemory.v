module DataMemory (
	input             clk      ,
	input             MemWrite ,
	input             MemRead  ,
	input      [63:0] address  ,
	input      [63:0] WriteData,
	output reg [63:0] ReadData
);
	reg [63:0] mem[511:0];
	always @(*) begin
		if (MemRead == 1'b1) ReadData <= mem[address];
		else if (MemWrite == 1'b1) mem[address] = WriteData;
	end
endmodule
