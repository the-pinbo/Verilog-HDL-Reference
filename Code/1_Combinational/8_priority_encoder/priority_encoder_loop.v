// behavioral model of priority encoder 

module priority_encoder(input[3:0] din, output reg[1:0] dout, output reg zero);
    integer i;
    
    always @(din)begin
        dout = 2'bz;
        zero = 1;
        for(i=3;i>=0;i=i-1)begin:priority_check
            if(din[i])begin
                dout = i;
                zero = 0;
                disable priority_check;
            end
        end
    end
endmodule