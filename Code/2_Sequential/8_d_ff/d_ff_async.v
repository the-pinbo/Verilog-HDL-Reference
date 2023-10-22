module d_ff_async(input data_in, input clk, input reset_n, output reg q);

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)
            q <= 0;
        else 
            q <= data_in;
    end

endmodule 