/*
data flow model of a 2x1 mux (Prioritized logic)
*/

module mux_2x1(input[1:0] din, input s, output y);
    assign y = (s==1'b1)?din[1]:(s==1'b0)?din[0]:1'bz;//Prioritized logic
endmodule