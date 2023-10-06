/*
test bench for 3 bit synchronous counter
*/

`timescale 1ps/1ps
`include "sync_cntr.v"

module sync_cntr_tb;

    reg clk;
    reg clear_n;
    wire[2:0] q;

    sync_cntr cntr_uut(clear_n,clk,q);

    initial begin
        clk = 1;
        forever
            #1 clk = ~clk;
    end

    initial begin
        $monitor("q = %b", q);
    end

    initial begin
        $display("3 bit synchronous counter simulation");
        $dumpfile("sync_cntr.vcd");
        $dumpvars(0,sync_cntr_tb);
    end

    initial begin
        clear_n = 0;
        #2 
        clear_n = 1;
        #24
        clear_n = 0;
        #2
        $finish;
    end

endmodule
