module ImmGen (
    input      [31:0] instruction,
    output reg [31:0] imm
);

    wire [6:0] Opcode;
    assign Opcode = instruction[6:0];
    always @(*) begin
        case (Opcode)
            7'b0010011: imm <= {{(32 - 12) {instruction[31]}}, instruction[31:20]};  // I-type
            7'b0000011: imm <= {{(32 - 12) {instruction[31]}}, instruction[31:20]};  // Load
            7'b0100011: imm <= {{(32 - 12) {instruction[31]}}, instruction[31:25], instruction[11:7]};  // Store
            7'b1100011: imm <= {{(32 - 13) {instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};  // Branch
            7'b1101111: imm <= {{(32 - 21){instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};  // jal
            7'b1100111: imm <= {{(32 - 12) {instruction[31]}}, instruction[31:20]};  // jalr
            7'b0110111: imm <= {{instruction[31:12]}, {12{1'b0}}};  // lui
            7'b0010111: imm <= {{instruction[31:12]}, {12{1'b0}}};  // auipc
            default:    imm <= {32{1'bx}};
        endcase
    end
endmodule
