module uart_tx #(parameter CLK_FREQ = 50000000, parameter BAUDRATE = 9600, parameter DATA_WIDTH = 8) (

    /* Clocking signal */
    input wire clk,

    /* Start transmission signal */
    input wire start,
    
    /* Input data to be transmitted */
    input wire [DATA_WIDTH - 1:0]data,
    
    /* TX line */
    output reg line = 1'b1,

    /* Transmitter ready to work */
    output wire ready
);

/* 
 * Current bit number in data
 * (initially in idle state) 
 */
reg [3:0]bit_num = 4'hF;

/* Transmitter ready to work */
assign ready = !start && (bit_num == 4'hF);

/* 
 * Boolean flag indicating that 
 * the transmitter is in idle state 
 */
wire idle = (bit_num == 4'hF);

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
        
        /* Reset divider counter */
        reset <= 1;
        
        /* Start from the 0 bit of bata*/
        bit_num <= 4'h0;
        
        /* Start bit */
        line <= 1'b0;
    end else 

        /* No need to reset */
        reset <= 0;
end

always @(posedge clk_divided) begin
    
    case (bit_num)

        /* Transmit next bit */
        4'h0: begin bit_num <= 4'h1; line <= data[0]; end
        4'h1: begin bit_num <= 4'h2; line <= data[1]; end
        4'h2: begin bit_num <= 4'h3; line <= data[2]; end
        4'h3: begin bit_num <= 4'h4; line <= data[3]; end
        4'h4: begin bit_num <= 4'h5; line <= data[4]; end
        4'h5: begin bit_num <= 4'h6; line <= data[5]; end
        4'h6: begin bit_num <= 4'h7; line <= data[6]; end
        4'h7: begin bit_num <= 4'h8; line <= data[7]; end

        /* Stop bit */
        4'h8: begin bit_num <= 4'h9; line <= 1'b1;    end
        
        /* Idle state */
        default: begin bit_num <= 4'hF; end
    
    endcase

    /* line <= data[bit_num]; */
    /* bit_num <= (bit_num == 4'h9)? 4'hF : bit_num + 4'h1; */
end

endmodule
