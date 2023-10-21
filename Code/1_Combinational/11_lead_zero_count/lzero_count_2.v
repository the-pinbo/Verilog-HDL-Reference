module lzero_count (input [0:7] data_in, output reg [4:0] data_out);
    integer i;
    always @(data_in) begin: L_COUNT_ZEROS
        data_out = 0;
        for(i = 0; i<8; i=i+1)begin
            if(data_in[i])
                disable L_COUNT_ZEROS;
            data_out = data_out + 1;
        end
    end
endmodule