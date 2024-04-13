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
reg [31:0]instr = 32'h13; // NOP initially

/* Program counter register */
reg [31:0]pc = 32'hFFFFFFFF;

/* Current branch is taken */
wire branch_taken;

/* Branch target address */
reg [31:0]pc_target = 0;

/* Next program counter value */
wire [31:0]pc_next = (pc == last_pc) ? pc : pc_target;

/* Halt signal to stop the processor */
wire halt;

always @(posedge clk) begin
    
    if (branch_taken) 
        pc_target = pc + (imm32 >> 2);

    else if (jump) begin
        if (alu_funct3 == 0) begin
            pc_target = (rf_rdata0 + imm32) >> 2;
        end 
        else begin
            pc_target = pc + (imm32 >> 2);
        end
    end 
    else begin
        pc_target = pc + 1;
    end

    /* Step to next instruction */
    if (!halt) begin
        pc = pc_next;
        instr = instr_data;
    end else
        instr = 32'h13; // NOP

    // $strobe("CPUv1: [%h] %h \n", pc, instr);

end

/* Next instruction address is next PC value */
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

/* ALU immediate source operand flag */
wire alu_imm;

/* 12-bit wide immediate from instruction encoding */
wire [11:0]imm12;

/* ALU operaion encoding */
wire [2:0]alu_funct3;
wire [6:0]alu_funct7;

/* Memory write enable signal */
wire mem_we;

/* Access width for memory control unit */
wire [1:0]mem_access_width;

/* Current instruction is jump */
wire jump;

/* 
 * Control unit 
 * Based on current instruction,
 * returns imm12, WE control signal
 * for register file and ALU operation
 * encoding
 */
control control(
    .instr(instr),
    .alu_result(alu_result),
    .imm12(imm12),
    .rf_we(rf_we),
    .alu_imm(alu_imm), .alu_funct3(alu_funct3), .alu_funct7(alu_funct7),
    .mem_we(mem_we), .mem_access_width(mem_access_width),
    .halt(halt),
    .branch_taken(branch_taken),
    .jump(jump)
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

/* 
 * For now, all instructions write their 
 * result back to register file 
 */
reg [31:0]rf_wdata;
initial rf_wdata = alu_result;

always @(posedge clk) begin
    rf_wdata = (jump)? pc + 1 : alu_result;
end

wire [4:0]rf_waddr = rd;

/* Write enable signal for register file */
wire rf_we;

/* Register file */
regf regf(
    .clk(clk),
    .raddr0(rf_raddr0), .rdata0(rf_rdata0),
    .raddr1(rf_raddr1), .rdata1(rf_rdata1),
    .waddr(rf_waddr), .wdata(rf_wdata), .we(rf_we)
);

/* Memory control unit */
mem_ctl mem_ctl(
    .clk(clk),
    .addr(alu_result),
    .data(rf_rdata1),
    .we(mem_we),
    .access_width(mem_access_width)
);

endmodule
