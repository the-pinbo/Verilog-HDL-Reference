/*
test bench for half adder code 
saved in half_adder_tb.v
*/
`timescale 1ns/1ns
`include "half_adder.v"

module half_adder_tb;
    reg a,b;
    wire sum,carry;
    half_adder half_adder_uut(.a(a),.b(b), .sum(sum),.carry(carry));

    initial begin
        $display("Half Adder Sumulation");
        $monitor("At time %t, a = %b , b = %b",$time, a, b);
        $dumpfile("half_adder.vcd");
        $dumpvars(0,half_adder_tb);

        a = 0; b = 0;
        #10;
        a = 0; b = 1;
        #10;
        a = 1; b = 0;
        #10;
        a = 1; b = 1;
        #10;

        $finish;
    end

endmodule