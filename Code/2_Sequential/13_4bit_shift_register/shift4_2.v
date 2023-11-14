module shift4(input clk, load, write_3, input[3:0] data_in, output reg [3:0] data_out);

    always@(posedge clk) begin
        if(load)
            data_out <= data_in;
        else begin
            data_out <= {write_3, data_out[3:1]};
        end
    end

endmodule