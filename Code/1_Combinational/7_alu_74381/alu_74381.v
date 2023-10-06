/* alu 74381 behavioral */

module alu_74381(input[2:0] s, input[3:0] a,input[3:0]  b,output reg f);
    always @(s or a or b) begin
        case(s)
            3'b0:f = 4'b0;
            1:f = b-a;
            2:f = a-b;
            3:f = a+b;
            4:f = a^b;
            5:f = a|b;
            6:f = a&b;
            7:f = 4'b1111;
        endcase
    end
endmodule