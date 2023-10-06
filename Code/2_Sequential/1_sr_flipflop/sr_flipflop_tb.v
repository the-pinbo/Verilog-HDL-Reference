/*
test bench for sr_flipflop.v
saved file in sr_flipflop_tb.v
*/

`timescale 1ns/1ns

`include "sr_flipflop.v"

module sr_flipflop_tb;
    reg s_in,r_in,clk_in;
    wire q_out, q_n_out;
    integer i;
    sr_flipflop sr_flipflop_1(s_in,r_in,clk_in,q_out,q_n_out);

    initial begin
        clk_in = 1;
    end

    initial begin
        $display("sr flip-flop simulation");
        $monitor("At time %t, s_in = %b | r_in = %b | q_out = %b | q_n_out = %b",$time, s_in, r_in,q_out,q_n_out);
        $dumpfile("sr_flipflop.vcd");
        $dumpvars(0,sr_flipflop_tb);
    end

    always begin
        repeat(10)
            #1 clk_in = ~clk_in;
    end

    initial begin
        #1
        {s_in,r_in} = 2'b1_0;
        #1 
        {s_in,r_in} = 2'b1_1;
        #1 
        {s_in,r_in} = 2'b0_1;
        #1 
        {s_in,r_in} = 2'b1_1;
        #1 
        {s_in,r_in} = 2'b0_0;
        #1 
        $finish;
    end


endmodule