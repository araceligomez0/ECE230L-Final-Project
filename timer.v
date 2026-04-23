//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state     //6-bits to represent the highest number 59
);

initial begin
    state <= 6'd0;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        state <= 6'd0;
    else if (load)
        state <= load_value;
    else if (en)
        state <= (state == 6'd0) ? 6'd0 : (state - 6'd1);
    else
        state <= state;
end

endmodule
