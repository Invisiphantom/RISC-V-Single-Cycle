module PC (
	input             clk      ,
	input             PCrst    ,
	input      [63:0] PCnext   ,
	output reg [63:0] PCaddress
);

	always @ (posedge clk) begin
		if(PCrst == 1'b1)
			PCaddress <= {64{1'b0}};
	end
	always @(posedge clk) begin
		PCaddress <= PCnext;
	end
endmodule
