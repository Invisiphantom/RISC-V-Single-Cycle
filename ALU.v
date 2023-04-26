module ALU (
	input      [   3:0] ALU_control,
	input      [64-1:0] A1         ,
	input      [64-1:0] A2         ,
	output reg [64-1:0] Y          ,
	output              zero       ,
	output              s_less     ,
	output              u_less
);
	always @(*) begin
		case (ALU_control)
			4'b0010 : Y = A1 + A2;  // add
			4'b0110 : Y = A1 - A2;  // sub
			4'b0111 : Y = A1 ^ A2;  // xor
			4'b0001 : Y = A1 | A2;  // or
			4'b0000 : Y = A1 & A2;  // and
			4'b0011 : Y = A1 << A2; // sll
			4'b1000 : Y = A1 >> A2; // srl
			4'b1010 : Y = A1 >>> A2;// sra
			4'b0100 : begin  		// slt
				if ((~A1 + 1) < (~A2 + 1)) Y = 1;
				else Y = 0;
			end
			4'b0101 : begin  		// sltu
				if (A1 < A2) Y = 1;
				else Y = 0;
			end
			default : Y = {64{1'bx}};
		endcase

	end
	wire signed   s_Y;
	wire unsigned u_Y;
	assign s_Y    = Y;
	assign u_Y    = Y;
	assign zero   = (Y == {64{1'b0}}) ? 1'b1 : 1'b0;
	assign s_less = (s_Y < 0) ? 1'b1 : 1'b0;
	assign u_less = (u_Y < 0) ? 1'b1 : 1'b0;
endmodule
