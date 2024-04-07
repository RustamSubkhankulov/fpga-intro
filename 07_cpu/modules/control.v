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
    output reg [6:0]alu_funct7,

    /* Write to memory enable signal */
    output reg mem_we,

    /* Access width for memory control unit */
    output wire [1:0]mem_access_width,

    /* Halt, stop processor (ebreak opcode actually) */
    output reg halt
);

/* Extract fields from instruction code */
wire [6:0]opcode = instr[6:0];

/* Access width for store instructions */
assign mem_access_width = instr[13:12];

initial begin
    halt = 1'b0;
end

always @(*) begin
    
    rf_we  = 1'b0;
    mem_we = 1'b0;
    
    imm12  = 12'b0;    
    alu_funct3 <= instr[14:12];
    alu_funct7 <= instr[31:25];

    case (opcode)

        /* I-type */
        7'b0010011: begin
            rf_we   = 1'b1;
            imm12   = instr[31:20];
            alu_imm = 1'b1;
        end

        /* R-type */
        7'b0110011: begin
            rf_we   = 1'b1;
            alu_imm = 1'b0;
        end

        /* S-type */
        7'b0100011: begin
            imm12 = {instr[31:25],instr[11:7]};
            alu_imm = 1'b1;
            mem_we  = 1'b1;
            alu_funct3 <= 3'b0; // ADDI to ALU
            alu_funct7 <= 7'b0;
        end

        /* ebreak */
        7'b1110011: begin
            halt = 1'b1;
        end

        default: ;

    endcase
end

endmodule
