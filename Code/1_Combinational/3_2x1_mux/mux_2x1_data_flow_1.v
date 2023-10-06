/*
data flow model of a 2x1 mux
*/

module mux_2x1(input[1:0] din, input s, output y);

    assign y = ((~s)&din[0])|((s)&din[1]); 

endmodule