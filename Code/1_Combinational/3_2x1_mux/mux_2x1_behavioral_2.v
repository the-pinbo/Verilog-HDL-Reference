/*
behavioral model of a 2x1 mux
*/

module mux_2x1(input[1:0] din, input s, output reg y);

    always @(din or s) begin
        y = din[s];
    end

endmodule