// top.v
module top 
(
    input clk,
    input btnC,
    input [15:0] sw,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg
);

/******** DO NOT MODIFY ********/
wire clk_1Hz;
wire btnC_1Hz;

`ifndef SYNTHESIS
    assign clk_1Hz = clk;
`else
    clk_div #(.INPUT_FREQ(100_000_000), .OUTPUT_FREQ(1)) clk_div_1Hz 
    (.iclk(clk) , .rst(btnC) , .oclk(clk_1Hz));
`endif

initial begin
`ifndef SYNTHESIS
    $display("Stopwatch/Timer Frequency set to 100MHz");
`else
    $display("Stopwatch/Timer Frequency set to 1Hz");
`endif
end

seven_segment_inf seven_segment_inf_inst (.clk(clk), .rst(btnC), .count(count) , .anode(an), .segs(seg));
/********************************/

wire [5:0] count;

wire mode   = sw[0];
wire run    = sw[1];
wire load   = sw[2];
wire [5:0] load_value = sw[15:10];

wire sw_en;
wire tm_en;
wire [5:0] stopwatch_state;
wire [5:0] timer_state;

assign sw_en = (~mode) & run;
assign tm_en = mode & run;

assign count = mode ? timer_state : stopwatch_state;

assign led[15:10] = timer_state;
assign led[9]     = 1'b0;
assign led[8:3]   = stopwatch_state;
assign led[2:0]   = 3'b000;

stopwatch stopwatch_inst (
    .clk(clk_1Hz),
    .rst(btnC),
    .en(sw_en),
    .state(stopwatch_state)
);

timer timer_inst (
    .clk(clk_1Hz),
    .rst(btnC),
    .en(tm_en),
    .load(load),
    .load_value(load_value),
    .state(timer_state)
);

endmodule