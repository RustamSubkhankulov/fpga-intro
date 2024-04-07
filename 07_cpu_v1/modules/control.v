module control(
    
    /* Current instruction encoding */
    input wire [31:0]instr,

    /* Immediate field encoded in instruction */
    output reg [11:0]imm12,
    
    /* Register file Write Enable */
    output reg rf_we,

    /* ALU immediate source operand flag */
    output reg alu_imm,
    
    /* ALU operation codes */
    output reg [2:0]alu_funct3,
    output reg [6:0]alu_funct7
);


/* Extract fields from instruction code */
wire [6:0]opcode = instr[6:0];

always @(*) begin
    
    /* funct3 and funct7 fiels for ALU */
    alu_funct3 <= instr[14:12];
    alu_funct7 <= instr[31:25];    

    case (opcode)

        7'b0010011: begin
            rf_we   = 1'b1;
            imm12   = instr[31:20];
            alu_imm = 1'b1;
        end

        7'b0110011: begin
            rf_we = 1'b1;
            alu_imm = 1'b0;
        end

        default: ;

    endcase
end

endmodule
