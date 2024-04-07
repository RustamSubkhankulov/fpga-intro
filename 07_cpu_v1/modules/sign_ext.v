module sign_ext(
    
    /* 12-bit wide input */
    input [11:0]imm,

    /* 32-bit wide output */
    output [31:0]ext_imm
);

/* Sign-extend */
assign ext_imm = {{20{imm[11]}}, imm};

endmodule
