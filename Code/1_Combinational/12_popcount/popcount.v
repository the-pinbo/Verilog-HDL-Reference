module popcount (input[7:0] data_in, input en, output reg[4:0] data_out);
    integer i;

    always@(data_in, en)begin
        if(!en)
            data_out = 'bz;
        else begin
            data_out = 0;
            for(i=0; i<8; i=i+1)
                data_out = data_out + data_in[i];
        end
    end
    
endmodule