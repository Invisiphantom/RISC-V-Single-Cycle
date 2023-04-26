module ALUControl (
	input      [1:0] ALUOp      ,
	input            funct7     ,
	input      [2:0] funct3     ,
	output reg [3:0] ALU_control
);
	always @(*) begin
		case (ALUOp)
			2'b00 : ALU_control <= 4'b0010;
			2'b01 : ALU_control <= 4'b0110;
			2'b10 :
				case ({
							funct7, funct3
						})
					4'b0000 : ALU_control <= 4'b0010;  // add
					4'b1000 : ALU_control <= 4'b0110;  // sub
					4'b0100 : ALU_control <= 4'b0111;  // xor
					4'b0110 : ALU_control <= 4'b0001;  // or
					4'b0111 : ALU_control <= 4'b0000;  // and
					4'b0001 : ALU_control <= 4'b0011;  // sll
					4'b0101 : ALU_control <= 4'b1000;  // srl
					4'b1101 : ALU_control <= 4'b1010;  // sra
					4'b0010 : ALU_control <= 4'b0100;  // slt
					4'b0011 : ALU_control <= 4'b0101;  // sltu
					default : ALU_control <= 4'bxxxx;
				endcase
			2'b11 :
				casez ({
							funct7, funct3
						})
					4'bz000 : ALU_control <= 4'b0010;  // addi
					4'bz100 : ALU_control <= 4'b0111;  // xori
					4'bz110 : ALU_control <= 4'b0001;  // ori
					4'bz111 : ALU_control <= 4'b0000;  // andi
					4'b0001 : ALU_control <= 4'b0011;  // slli
					4'b0101 : ALU_control <= 4'b1000;  // srli
					4'b1101 : ALU_control <= 4'b1010;  // srai
					4'bz010 : ALU_control <= 4'b0100;  // slti
					4'bz011 : ALU_control <= 4'b0101;  // sltiu
					default : ALU_control <= 4'bxxxx;
				endcase
		endcase
	end
endmodule

