`timescale 1ns/1ns
`include "sop.v"
module sop_tb();
    reg [4:0]x;
    wire y;
    integer i = 0;
    sop dut (x,y);
    initial begin
        for(i = 0; i < 32; i = i + 1)begin
        x <= i;
        #50;
        end
    end
endmodule