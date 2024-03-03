module neg(
    input [31:0]x,

    output [31:0]minus_x
);

/* 
 * Get negative value based on formula:
 * -x = ~x + 1
 */
assign minus_x = ~x + 1;

endmodule
