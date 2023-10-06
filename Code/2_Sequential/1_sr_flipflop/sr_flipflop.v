/*
Verilog data-flow modelling for SR Flip-Flop
saved in sr_flipflop.v 
*/

`timescale 1ns/1ns

module sr_flipflop(s,r,clk,q,q_n);
    input s,r,clk;
    output reg q,q_n;

    always @(posedge clk) begin
       if(s & ~r)begin
            q <= 1'b1; q_n <= 1'b0;
       end
       else if(~s & r)begin
            q <= 1'b0; q_n <= 1'b1;
       end
       else begin
            q <= q; q_n <= q_n;
       end
    end
endmodule