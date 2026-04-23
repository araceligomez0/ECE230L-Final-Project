// stopwatch.v
module stopwatch(
    input clk,
    input rst,
    input en,
    output reg [5:0] state //6-bits to represent the highest number 59
);

initial begin
    state <= 6'd0;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        state <= 6'd0;
    else if (en)
        state <= (state == 6'd59) ? 6'd0 : (state + 6'd1);
    else
        state <= state;
end

endmodule




