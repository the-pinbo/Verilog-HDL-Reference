/*
behavioral model of a 2x1 mux using if else
*/

module mux_2x1(input[1:0] din, input s, output reg y);

    always @(din or s) begin
        if(s==0)
            y = din[0];
        else if(s==1)
            y = din[1];
        else 
            y = 1'bz;
    end

endmodule