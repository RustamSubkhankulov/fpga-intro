module uart_tx #(parameter CLK_FREQ = 50000000, parameter BAUDRATE = 9600, parameter DATA_WIDTH = 8) (

    /* Clocking signal */
    input wire clk,

    /* Start transmission signal */
    input wire start,
    
    /* Input data */
    input wire [DATA_WIDTH - 1:0]transmit_data,
    
    /* TX line */
    output reg line = 1'b1,

    /* Transmitter ready to work */
    output wire ready
);

/* 
 * Data read from input that 
 * is saved for transmission
 */
reg [DATA_WIDTH - 1:0]data = 0;

/* 
 * Current bit number in data
 * (initially in idle state) 
 */
reg [3:0]bit_num = DATA_WIDTH + 2;

/* Transmitter ready to work */
assign ready = idle;

/* 
 * Boolean flag indicating that 
 * the transmitter is in idle state 
 */
wire idle = (bit_num == DATA_WIDTH + 2);

/* Reset signal for divider */
reg reset = 0;

/* Clock divider */
clock_div #(.X(CLK_FREQ / BAUDRATE)) clk_div(
    .clk(clk), 
    .clk_divided(clk_divided),
    .reset(reset)
);

always @(posedge clk) begin
    
    /* We start if: 
     * - start == 1: input signal indicating there is data to transmit 
     * - idle == 1: transmitter is not busy
     */
    if (start && idle) begin 
        
        /* Save up data */
        data <= transmit_data;

        /* Reset divider counter */
        reset <= 1'b1;
        
        /* Start from the 0 bit of bata*/
        bit_num <= 4'h0;
        
        /* Start bit */
        line <= 1'b0;
    end else 

        /* No need to reset */
        reset <= 0;
end

always @(posedge clk_divided) begin
    
    line <= (bit_num <  DATA_WIDTH)? data[bit_num] : 1'b1;
    bit_num <= (bit_num == DATA_WIDTH + 2)? bit_num : bit_num + 4'h1;
end

endmodule
