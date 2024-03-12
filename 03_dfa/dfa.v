module dfa(
  
  /* Clocking signal */
  input wire clk,

  /* Signals for 1,2 and 5 coins inserted */
  input wire in1,
  input wire in2,
  input wire in5,

  /* Output for change: 1, 2 and 2 times 2 coins */
  output wire out1,
  output wire out2,
  output wire out2x2,

  /* Output for soda */
  output wire soda
);

/* Current state */
reg [2:0]S = 0;

assign out1 = (S[0] & in5) | (S[2] & in2);
assign out2 = S[1] & in5;
assign out2x2 = S[2] & in5;

assign soda = in5 | (S[2] & (in1|in2)) | S[0] & S[1] & in2; 

always @(posedge clk) begin

  S[0] <= (~S[2] & ~S[0] &  in1) 
        | (~S[1] &  S[0] & ~in1 & ~in5) 
        | ( S[1] &  S[0] & ~in1 & ~in2 & ~in5);

  S[1] <= (~S[2] & ~S[1] &  in2)
        | (~S[1] &  S[0] &  in1 & ~in2 & ~in5)
        | (S[1]  & ~S[0] & ~in2 & ~in5)
        | (S[1]  &  S[0] & ~in1 & ~in2 & ~in5);

  S[2] <= (S[1] & ~S[0]  & in2)
        | (S[1] &  S[0]  & in1)
        | (S[2] & ~in1 & ~in2 & ~in5);
end

endmodule