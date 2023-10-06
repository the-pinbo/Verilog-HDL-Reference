// behavioral model of priority encoder 

module priority_encoder(input[3:0] din, output reg[1:0] dout, output reg zero);
    always @(din) begin
        zero = 0;
        casex(din)
            4'b1xxx: dout = 2'd3;
            4'b01xx: dout = 2'd2;
            4'b001x: dout = 2'd1;
            4'b0001: dout = 2'd0;
            default:begin 
                dout = 2'bz;
                zero = 1;
            end
        endcase
    end
endmodule