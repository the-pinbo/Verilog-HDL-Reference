//`include "TrafficLightController.v"
//`include "Timer.v"

module TrafficLightControllerTop 
#(
    parameter TS_VALUE = 2, 
    TLH_VALUE = 5, 
    TLN_VALUE = 4
)
(
    input wire clk, reset, C,
    output [1:0] highwayLights, // 00: Red, 01: Yellow, 10: Green
    output [1:0] nitkRoadLights // 00: Red, 01: Yellow, 10: Green 
);
    wire TS, TLH, TLN,ST;
    wire reset_timer;
    assign reset_timer = reset|ST;
    Timer #(.TS_VALUE(TS_VALUE), .TLH_VALUE(TLH_VALUE), .TLN_VALUE(TLN_VALUE)) 
    timer(clk, reset_timer, TS, TLH, TLN);
    TrafficLightController trafficController
    (clk, reset, C, TS, TLH, TLN, ST, highwayLights, nitkRoadLights);

endmodule
