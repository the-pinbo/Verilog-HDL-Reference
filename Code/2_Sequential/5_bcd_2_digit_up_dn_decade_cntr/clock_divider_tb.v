`timescale 1ns/1ns
`include "clock_divider.v"

module clock_divider_tb;

    reg clk;
    wire clk_div;
    initial begin
        clk = 0;
        $monitor("clk = %b | clk_div = %b", clk,clk_div);
        repeat(100) begin
            clk = ~clk;
            #5;
        end
        $display("Finish simulation");
    end
    clock_divider clock_divider_1(clk,clk_div);

endmodule