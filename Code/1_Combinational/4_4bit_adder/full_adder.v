/* full adder using data flow assignment */

module full_adder(input in_1, input in_2, input carry_in, output carry_out, output sum);
    assign carry_out = (in_1&in_2)|(in_2&carry_in)|(carry_in&in_1);
    assign sum = in_1^in_2^carry_in; 
endmodule