`timescale 1 ns / 100 ps

/* No inputs, no outputs */
module testbench();

/* Represents clock, initial value is 0 */
reg clk = 1'b0;

always begin
    /* Toggle clock every 1ns */
    #1 clk = ~clk;
end

/* Create instance of dfa module */
dfa dfa();

initial begin
    /* Open for dump of signals */
    $dumpvars;

    /* Write to console */
    $display("Test started...");

    /* Stop simulation after 64ns */
    #64 $finish;
end

endmodule
