module top 
(
    input clk,           // 100 MHz
    input btnC,          // reset
    input [15:0] sw,     // switches
    output [15:0] led,    //LEDs
    output [3:0] an,     //Outputs for 7-segment display
    output [6:0] seg     //Outputs for 7-segment display
);

/******** DO NOT MODIFY ********/
wire clk_1Hz;       //Generate Internal 1Hz Clock
wire btnC_1Hz;     //Stretch load signal

//If running simulation, output clock frequency is 100MHz, else 1Hz
`ifndef SYNTHESIS
    assign clk_1Hz = clk;
`else
    clk_div #(.INPUT_FREQ(100_000_000), .OUTPUT_FREQ(1)) clk_div_1Hz 
    (.iclk(clk) , .rst(btnC) , .oclk(clk_1Hz));
`endif

// Check stopwatch/timer frequency
initial begin
`ifndef SYNTHESIS
    $display("Stopwatch/Timer Frequency set to 100MHz");
`else
    $display("Stopwatch/Timer Frequency set to 1Hz");
`endif
end

//Seven Segment Display Interface
seven_segment_inf seven_segment_inf_inst (.clk(clk), .rst(btnC), .count(count) , .anode(an), .segs(seg));
/********************************/

wire [5:0] count;

// Control signals
wire mode   = sw[0];        // 0 = stopwatch, 1 = timer
wire run    = sw[1];        // 0 = pause, 1 = run
wire load   = sw[2];        // 1 = load timer with load_value
wire [5:0] load_value = sw[15:10];

wire sw_en;
wire tm_en;
wire [5:0] stopwatch_state;
wire [5:0] timer_state;

assign sw_en = (~mode) & run;
assign tm_en = mode & run;

// count shown on seven segment display
assign count = mode ? timer_state : stopwatch_state;


assign led = {timer_state, 1'b0, stopwatch_state, 3'b000};

// Stopwatch Module Instance
stopwatch stopwatch_inst (
    .clk(clk_1Hz),
    .rst(btnC),
    .en(sw_en),
    .state(stopwatch_state)
);

// Timer Module Instance
timer timer_inst (
    .clk(clk_1Hz),
    .rst(btnC),
    .en(tm_en),
    .load(load),
    .load_value(load_value),
    .state(timer_state)
);




endmodule
