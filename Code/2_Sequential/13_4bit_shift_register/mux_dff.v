module mux_dff(input d0, d1, sel, clk, output reg q);
    always@(posedge clk)begin
        if(sel)
            q <= d1;
        else 
            q <= d0;
    end
endmodule