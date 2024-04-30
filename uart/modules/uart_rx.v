module uart_rx #(
    parameter CLK_FREQ = 50000000, 
    parameter BAUDRATE = 9600, 
    parameter DATA_WIDTH = 8, 
    parameter STOP_BIT_SIZE = 1)
(
    /* Clocking signal */
    input wire clk,
    
    /* RX line */
    input wire line,

    /* Output data */
    output reg [DATA_WIDTH - 1:0]receive_data = 0,

    /* Receiver got value */
    output reg ready = 1'b0
);

/* Temp storage for data received from the line */
reg [DATA_WIDTH - 1:0]data = 0;

/* 
 * Current bit number in data
 * (initially in idle state) 
 */
reg [3:0]bit_num = DATA_WIDTH + 2;

/* Clock divider */
clock_div #(.X(CLK_FREQ / BAUDRATE)) clk_div(
    .clk(clk), 
    .clk_divided(clk_divided),
    .reset(!active && prev && !line)
);

/* 
 * Receiver is in active 
 * state - in process of receiving data 
 */
reg active = 1'b0;

/* Previous line value */
reg prev = 1'b0;

always @(posedge clk) begin
    
    /* We catched start bit */
    if (!active && prev && !line) begin 

        /* Go to active state */
        active <= 1'b1;

        /* Start from the 0 bit of data */
        bit_num <= 4'h0;
    end

    if (!ready && active && bit_num == DATA_WIDTH + 2) begin

        /* Set ready flag if we just read stop bit */
        ready <= 1'b1;

        /* Output read received data */
        receive_data <= data;

        /* Go to idle state */
        active <= 1'b0;
    end else 
        ready <= 1'b0;

    prev <= line;
end

always @(posedge clk_divided) begin
    
    if (active) begin
        
        /* Read next bit of data */    
        if (bit_num && bit_num < DATA_WIDTH + 1)
            data[bit_num - 1] <= line;

        /* Iterate to next bit */
        bit_num <= (bit_num == DATA_WIDTH + 2)? bit_num : bit_num + 1'b1;
    end
end

endmodule
