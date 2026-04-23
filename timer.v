// timer.v
module timer(
    input clk,
    input rst,
    input en,
    input load,
    input [5:0] load_value,
    output reg [5:0] state
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