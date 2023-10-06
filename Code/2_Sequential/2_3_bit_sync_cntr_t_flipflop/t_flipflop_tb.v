/* 
test bench for a t flip-flop 
*/ 
`timescale 1ps/1ps
`include "t_flipflop.v"

module t_flipflop_tb;

    reg clk = 0;
    reg t_in,clr_n_in;
    wire q_out;
    t_flipflop t_ff_1(.t(t_in),.clk(clk),.clr_n(clr_n_in),.q(q_out));

    initial begin
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        $display("t flip-flop simulation");
        $monitor("At time %t, clk = %b | t_in = %b | clr_n = %b | q_out = %b",$time, clk, t_in, clr_n_in, q_out);
        $dumpfile("t_flipflop.vcd");
        $dumpvars(0,t_flipflop_tb);
    end

    initial begin
        clr_n_in = 0;
        #2 
        clr_n_in = 1; t_in = 0;
        #2 
        #2 
        #2
        t_in = 1;
        #2
        #2
        #2 
        t_in = 0;
        #2
        #2 
        t_in = 1;
        #2
        clr_n_in = 0;
        #2;
        ;
        $finish;
    end


endmodule