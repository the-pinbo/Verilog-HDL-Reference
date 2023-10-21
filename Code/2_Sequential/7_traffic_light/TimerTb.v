`include "Timer.v"
`timescale 1ps/1ps

module TimerTb;


    parameter t_PERIOD = 100;
    reg clk, reset;
    wire TS, TLH, TLN;

    // clock generation
    initial
        repeat(50) 
            #(t_PERIOD/2) clk <= ~clk;

    Timer #(.TS_VALUE(2), .TLH_VALUE(8), .TLN_VALUE(5)) 
    uut(clk, reset, TS, TLH, TLN);

    // file handling
    initial begin
        clk = 0; reset = 1;
        #(t_PERIOD*2);
        reset = 0;
        #(t_PERIOD*4+10);

    end

    initial begin
        $display("Traffic light timer");
        $monitor("At time %t, clk=%b, reset=%b, TS=%b , TLH=%b , TLN=%b \n",$time, clk, reset, TS, TLH, TLN);
        $dumpfile("Timer.vcd");
        $dumpvars(0,TimerTb);
    end

    



endmodule