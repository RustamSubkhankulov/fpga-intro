module alu(
    
    /* Two register source operands */
    input wire [31:0]reg_source1,
    input wire [31:0]reg_source2,

    /* Immidiate source operand */
    input wire [31:0]imm_source,

    /* ALU immediate source operand flag */
    input wire imm,

    /* Operation opcode */
    input wire [2:0]oper,

    /* Result */
    output reg [31:0]res
);

reg [31:0]source2 = 0;

always @(*) begin    

    source2 = (imm)? imm_source : reg_source2;

    case(oper)
        3'b000:     res = reg_source1 + source2;
        3'b111:     res = reg_source1 & source2;
        3'b110:     res = reg_source1 | source2;
        3'b100:     res = reg_source1 ^ source2;
        default:    res = 0;
    endcase
end

endmodule
