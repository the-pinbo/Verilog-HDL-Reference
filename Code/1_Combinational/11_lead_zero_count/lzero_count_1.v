module lzero_count (input [0:7] data_in, output reg [4:0] data_out);
    integer i;
    always @(data_in) begin
        data_out = 0;
        for(i = 0; (i<8&&(!data_in[i])); i=i+1)begin
            data_out = data_out + 1;
        end
    end
endmodule