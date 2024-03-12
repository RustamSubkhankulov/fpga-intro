`timescale 1 ns / 100 ps

/* No inputs, no outputs */
module testbench();

/* Represents clock, initial value is 0 */
reg clk = 1'b0;

always begin
    /* Toggle clock every 1ns */
    #1 clk = ~clk;
end

/* Input signals for dfa */
reg in1 = 1'b0;
reg in2 = 1'b0;
reg in5 = 1'b0;

/* Wires for output signals of dfa */
wire out1;
wire out2;
wire out2x2;
wire soda;

/* Create instance of dfa module */
dfa dfa(.clk(clk), .in1(in1), .in2(in2), .in5(in5), 
        .out1(out1), .out2(out2), .out2x2(out2x2), .soda(soda));

initial begin
    /* Open for dump of signals */
    $dumpvars;

    /* Write to console */
    $display("Test started...");

    /* Stop simulation after 10ns */
    #10 $finish;
end

endmodule
