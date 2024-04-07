module control(
    
    /* Current instruction encoding */
    input wire [31:0]instr,

    /* Immediate field encoded in instruction */
    output reg [11:0]imm12,
    
    /* Register file Write Enable */
    output reg rf_we,
    
    /* ALU operation code */
    output reg [2:0]alu_op
);


/* Extract fields from instruction code */
wire [6:0]opcode = instr[6:0];
wire [2:0]funct3 = instr[14:12];

always @(*) begin
    
    /* Zero at the start of each clock cycle */
    rf_we  = 1'b0;
    alu_op = 3'b0;
    imm12  = 12'b0;

    case (opcode)

        7'b0010011: begin
            rf_we = 1'b1;
            imm12 = instr[31:20];
            alu_op = funct3;
        end

        default: ;

    endcase
end

endmodule
