module sign_ext(
    input [11:0]imm,

    output [31:0]ext_imm
);

/* Sign-extend. */
assign ext_imm = {{20{imm[11]}}, imm};

endmodule
