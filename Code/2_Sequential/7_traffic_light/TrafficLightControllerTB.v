//`include "TrafficLightControllerTop.v"
`timescale 1ps/1ps

module TrafficLightControllerTB;


    parameter t_PERIOD = 100;
    reg clk, reset, C;
    wire[1:0] highwayLights, nitkRoadLights;
    wire ST;

    // clock generation
    initial
        repeat(50) 
            #(t_PERIOD/2) clk <= ~clk;

    TrafficLightControllerTop #(.TS_VALUE(2), .TLH_VALUE(8), .TLN_VALUE(5)) 
    uut(clk, reset, C, highwayLights, nitkRoadLights);

    // file handling
    initial begin
        clk = 0; reset = 1; C = 0;
        #(t_PERIOD*4);

        reset = 0;
        #(t_PERIOD*4+10);

        C = 1;
        #(t_PERIOD*10)

        C = 0;

        // TLH = 0; TS = 1;
        // #(t_PERIOD*4)

        // TS = 0; TLN = 1;
        // #(t_PERIOD*4)  

        // TLN = 0; TS = 1;
        // #(t_PERIOD*4); 
    end

    initial begin
        $display("Traffic light controller simulation");
        $monitor("At time %t, clk=%b, reset=%b, C=%b, highwayLights=%2b, nitkRoadLights=%2b\n",$time, clk, reset, C, highwayLights, nitkRoadLights);
//        $dumpfile("TrafficLightController.vcd");
//        $dumpvars(0,TrafficLightControllerTB);
    end

    



endmodule