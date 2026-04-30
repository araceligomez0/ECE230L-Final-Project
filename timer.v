module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output reg [5:0] state     //6-bits to represent the highest number 59
);

//Simulate starting state of all 0
initial begin
    state <= 6'd0;
end

//On positive edge of clock or reset pusle
always @(posedge clk or posedge rst) begin
    
		//If reset is active, set state to all 0
		if (rst)
        state <= 6'd0;

		//If load is active, set state to load value
    else if (load)
        state <= load_value;

		//Else if enable is active, count down.
    else if (en)
        state <= (state == 6'd0) ? 6'd0 : (state - 6'd1);
    
		//If neither load or enable are active, state remains the same.
		else
        state <= state;
end

endmodule
