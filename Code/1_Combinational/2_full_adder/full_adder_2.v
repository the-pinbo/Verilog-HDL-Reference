/* full adder using structural modelling (2 half adders) */

`include "half_adder.v"

module full_adder(input in_1, input in_2, input carry_in, output carry_out, output sum); 
    wire carry0,sum0,carry1;
    half_adder ha0(in_1,in_2,sum0,carry0), ha1(sum0,carry_in,sum,carry1);
    or or_carry(carry_out,carry0,carry1);
endmodule