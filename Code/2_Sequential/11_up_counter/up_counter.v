module up_counter(input[3:0] data_in, input clk, enable, load, reset_n, output reg [3:0] data_out );

    always @(posedge clk or negedge reset_n)begin
        if(!reset_n)
            data_out <= 'b0;
        else if(enable)
            data_out <= data_out + 1;
        else if(load)
            data_out <= data_in;
    end

endmodule