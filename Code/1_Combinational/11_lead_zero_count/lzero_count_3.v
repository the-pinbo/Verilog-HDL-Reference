module leading_zeros(
    input [7:0] x,
    output reg [3:0] y
);
    always @(x) begin
        casex(x)
            8'b00000000 : y = 4'b1000;
            8'b00000001 : y = 4'b0111;
            8'b0000001x : y = 4'b0110;
            8'b000001xx : y = 4'b0101;
            8'b00001xxx : y = 4'b0100;
            8'b0001xxxx : y = 4'b0011;
            8'b001xxxxx : y = 4'b0010;
            8'b01xxxxxx : y = 4'b0001;
            8'b1xxxxxxx : y = 4'b0000;
        endcase
    end
endmodule

