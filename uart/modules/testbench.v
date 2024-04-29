`timescale 1 ns / 100 ps

module testbench();

/* Clock frequency */
parameter CLK_FREQ = 19200;

/* UART baudrate */
parameter BAUDRATE = 9600;

/* ROM address width in bits */
parameter ADDR_WIDTH = 5;

/* ROM data element size ib bits */
parameter DATA_WIDTH = 8;

/* Represents clock, initial value is 0 */
reg clk = 1'b0;

always begin

    /* Toggle clock every 1ns */
    #1 clk = ~clk;
end

/* Current data address */
wire [ADDR_WIDTH - 1:0]addr;

/* Data fetched from rom */
wire [DATA_WIDTH - 1:0]transmit_data;

/* Read-Only Memory fetcher */
rom_fetcher #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) rom_fetcher(
    .clk(clk),
    .next(uart_tx_start), 
    .addr(addr)
);

/* Read-Only Memory */
rom #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) rom(
    .clk(clk), 
    .addr(addr),
    .data(transmit_data)
);

/* UART transmitter start signal */
reg uart_tx_start = 1'b0;

/* UART transmitter tx line */
wire uart_tx_line;

/* UART transmitter is ready */
wire uart_tx_ready;

/* UART transmitter */
uart_tx #(.CLK_FREQ(CLK_FREQ), .BAUDRATE(BAUDRATE), .DATA_WIDTH(DATA_WIDTH)) uart_tx(
    .clk(clk), 
    .start(uart_tx_start), 
    .transmit_data(transmit_data),
    .line(uart_tx_line),
    .ready(uart_tx_ready)
);

always @(posedge clk) begin 
    
    /* 
     * Start transmission and iterate 
     * to next address in ROM whenever 
     * UART transmitter is ready 
     */
    uart_tx_start <= (uart_tx_ready)? 1'b1 : 1'b0;
end

initial begin
    
    /* Open for dump of signals */
    $dumpvars;
    
    /* Write to console */
    $display("Test started...");
    
    /* Stop simulation when all ROM contents are fetched*/
    #1024 $finish;
end

endmodule
