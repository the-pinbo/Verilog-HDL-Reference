/* 4 bit ripple carry adder */
`include "full_adder.v"
module adder_4bit(input[3:0]a, input[3:0] b, input cin, output cout, output[3:0] sum);

    wire [3:1] cint;
    full_adder fa0(a[0],b[0],cin,cint[1],sum[0]);
    full_adder fa1(a[1],b[1],cint[1],cint[2],sum[1]);
    full_adder fa2(a[2],b[2],cint[2],cint[3],sum[2]);
    full_adder fa3(a[3],b[3],cint[3],cout,sum[3]);

endmodule