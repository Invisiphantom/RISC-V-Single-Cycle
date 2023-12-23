module Branch (
    input            Branch,
    input            zero,
    input            s_less,
    input            u_less,
    input      [2:0] funct3,
    output reg       Cnd
);
/*
 beq : funct3==000 && zero==1      bne : funct3==001 && zero==0
 blt : funct3==100 && s_less==1    bge : funct3==101 && s_less==0
 bltu: funct3==110 && u_less==1    bgeu: funct3==111 && u_less==0
*/

    always @(*) begin
        if (Branch == 1'b1)
            case (funct3[2:1])
                2'b00:   Cnd <= funct3[0] ^ zero;
                2'b10:   Cnd <= funct3[0] ^ s_less;
                2'b11:   Cnd <= funct3[0] ^ u_less;
                default: Cnd <= 1'bx;
            endcase
        else Cnd <= 1'b0;
    end
endmodule
