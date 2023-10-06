/*
behavioral model of a 2x1 mux using if else
*/

module mux_2x1(input[1:0] din, input s, output reg y);

    always @(din or s) begin
        case (s)
            1'b0: y = din[0];
            1'b1: y = din[1];
            default: y = 1'bz;
        endcase
    end

endmodule