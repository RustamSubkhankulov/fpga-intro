module alu(
    
    /* Two source operands */
    input [31:0]source1,
    input [31:0]source2,

    /* Operation opcode */
    input [2:0]oper,

    /* Result */
    output reg [31:0]res
);

always @(*) begin

    case(oper)
        3'b000:     res = source1 + source2;
        3'b111:     res = source1 & source2;
        3'b110:     res = source1 | source2;
        3'b100:     res = source1 ^ source2;
        default:    res = 0;
    endcase
end

endmodule
