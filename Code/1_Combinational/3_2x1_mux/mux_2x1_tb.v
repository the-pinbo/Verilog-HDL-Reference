// test bench for a 2x1 multiplexer 

`timescale 1ps/1ps
// `include "mux_2x1_data_flow.v"
`include "mux_2x1_behavioral_2.v"

module mux_2x1_tb;

    integer i;
    reg[1:0] din;
    reg s;
    wire y;
    mux_2x1 mux(din,s,y);
    initial begin
        for(i = 0;i<8;i=i+1)begin
            {s,din} = i;
            #5;
        end
    end

    initial begin
        $display("2x1 mux");
        $monitor("din=%b s=%b y=%b",din,s,y);
        $dumpfile("mux2x1.vcd");
        $dumpvars(0,mux_2x1_tb);
    end

endmodule