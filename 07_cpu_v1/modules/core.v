module core(
    
    /* Input clocking signal */
    input wire clk,
    
    /* Current instruction input */
    input wire [31:0]instr_data,
    
    /* Value of PC that represents end of incstruction stream */
    input wire [31:0]last_pc,

    /* Next instruction address */
    output wire [31:0]instr_addr
);

/* Current instruction */
wire [31:0]instr = instr_data;

/* Program counter register */
reg [31:0]pc = 32'hFFFFFFFF;

/* Next program counter value */
wire [31:0]pc_next = (pc == last_pc) ? pc : pc + 1;

always @(posedge clk) begin
    
    /* Step to next instruction */
    pc <= pc_next;
    $strobe("CPUv1: [%h] %h \n", pc, instr);

end

/* Next insutrction address is next PC value */
assign instr_addr = pc_next;

/* Register destination */
wire [4:0]rd = instr[11:7];

/* Two register sources */
wire [4:0]rs1 = instr[19:15];
wire [4:0]rs2 = instr[24:20];

/* 
 * Register source operands addresses 
 * in register file are rs1 and rs2
 */
wire [4:0]rf_raddr0 = rs1;
wire [4:0]rf_raddr1 = rs2;

/* 
 * For now, all instructions write their 
 * result back to register file 
 */
wire [31:0]rf_wdata = alu_result;
wire [4:0]rf_waddr = rd;

/* Write enable signal for register file */
wire rf_we;

/* ALU immediate source operand flag */
wire alu_imm;

/* 12-bit wide immediate from instruction encoding */
wire [11:0]imm12;

/* ALU operaion encoding */
wire [2:0]alu_funct3;
wire [6:0]alu_funct7;

/* 
 * Control unit 
 * Based on current instruction,
 * returns imm12, WE control signal
 * for register file and ALU operation
 * encoding
 */
control control(
    .instr(instr),
    .imm12(imm12),
    .rf_we(rf_we),
    .alu_imm(alu_imm), .alu_funct3(alu_funct3), .alu_funct7(alu_funct7)
);

/* Sign-extended immidiate value */
wire [31:0]imm32;

/* Sign-extension unit */
sign_ext sign_ext(.imm(imm12), .ext_imm(imm32));

/* ALU result */
wire [31:0]alu_result;

/* ALU */
alu alu(
    .reg_source1(rf_rdata0), .reg_source2(rf_rdata1),
    .imm_source(imm32),
    .imm(alu_imm),
    .funct3(alu_funct3), .funct7(alu_funct7),
    .res(alu_result)
);

/* Register values read from register file */
wire [31:0]rf_rdata0;
wire [31:0]rf_rdata1;

/* Register file */
regf regf(
    .clk(clk),
    .raddr0(rf_raddr0), .rdata0(rf_rdata0),
    .raddr1(rf_raddr1), .rdata1(rf_rdata1),
    .waddr(rf_waddr), .wdata(rf_wdata), .we(rf_we)
);

endmodule
