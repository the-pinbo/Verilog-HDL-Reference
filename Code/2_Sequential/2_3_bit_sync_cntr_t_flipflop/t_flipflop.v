/*
negative edge triggered t flip-flop behavioral code with async reset
*/

module t_flipflop(input t, input clk, input clr_n, output reg q);
    always @(negedge clk or negedge clr_n) begin
        if(!clr_n)
            q <= 1'b0;
        else if(t)
            q <= ~q;
        else 
            q <= q;
    end
endmodule