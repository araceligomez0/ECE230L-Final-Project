module stopwatch(
    input clk,
    input rst,
    input en,
    output reg [5:0] state //6-bits to represent the highest number 59
);

//Simulate an all 0 state
initial begin
    state <= 6'd0;
end

//On either the Positive edge of clock or reset
always @(posedge clk or posedge rst) begin
  
		//If reset is active, set state to all 0
    if (rst)
        state <= 6'd0;

		//Otherwise, If enabled, count up on clock pulse
    else if (en)
        state <= (state == 6'd59) ? 6'd0 : (state + 6'd1);
    
		//If not enabled, state stays the same
		else
        state <= state;
end

endmodule




