/*
half adder code 
saved in half_adder.v
*/

module half_adder(a,b,sum,carry);
    input a,b;
    output sum,carry;
    assign sum = a^b;
    assign carry = a&b;
endmodule