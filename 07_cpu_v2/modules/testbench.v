`timescale 1 ns / 100 ps

module testbench();

/* Represents clock, initial value is 0 */
reg clk = 1'b1;

always begin

    /* Toggle clock every 1ns */
    #1 clk = ~clk;

end

/* Wire for divided clock signal from clk_div module */
wire clk_divided;

/* Clock divider */
clk_div #(.X(8)) clk_div(.clk(clk), .clk_divided(clk_divided));

initial begin
    
    /* Open for dump of signals */
    $dumpvars;
    
    /* Write to console */
    $display("Test started...");
    
    /* Stop simulation after 64ns */
    #64 $finish;

end

endmodule
