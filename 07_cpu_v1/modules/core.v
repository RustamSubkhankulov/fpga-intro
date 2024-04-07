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

/* 12-bit wide immediate from instruction encoding */
wire [11:0]imm12;

/* 3-bit wide alu operaion encoding */
wire [2:0]alu_op;

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
    .alu_op(alu_op)
);

/* Sign-extended immidiate value */
wire [31:0]imm32;

/* Sign-extension unit */
sign_ext sign_ext(.imm(imm12), .ext_imm(imm32));

/* ALU result */
wire [31:0]alu_result;

wire [31:0]alu_source1 = rf_rdata0;
wire [31:0]alu_source2 = imm32;

/* ALU */
alu alu(
    .source1(alu_source1), .source2(alu_source2),
    .oper(alu_op),
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
