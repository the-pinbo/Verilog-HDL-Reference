/* 
3 bit synchronous counter 
*/

`include "t_flipflop.v"

module sync_cntr(input clear_n, input clk, output [2:0] q);

    t_flipflop t_ff0(1'b1,clk,clear_n,q[0]);
    t_flipflop t_ff1(q[0],clk,clear_n,q[1]);
    t_flipflop t_ff2(q[0]&q[1],clk,clear_n,q[2]);

endmodule