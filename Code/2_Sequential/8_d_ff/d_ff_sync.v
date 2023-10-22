module d_ff_sync (input clk, data_in, reset_n, output reg data_out);
    always@(posedge clk)begin
        if(!reset_n)
            data_out <= 0;
        else 
            data_out <= data_in;
    end
endmodule