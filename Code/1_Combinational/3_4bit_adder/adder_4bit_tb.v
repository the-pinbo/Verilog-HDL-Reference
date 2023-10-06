/* test bench for 4 bit adder */

`timescale 1ns/1ns
`include "adder_4bit.v"

module adder_4bit_tb;
    reg cin;
    reg[3:0] a,b;
    wire cout;
    wire[3:0] sum;
    adder_4bit adder_uut(a,b,cin,cout,sum);

    integer i;
    initial begin
        for(i=0;i<512;i=i+1)begin
            {cin,a,b} <= i;
            #5;
        end
    end

    initial begin
        $display("4 bit adder simulation");
        $monitor("cin=%b a=%b b=%b cout=%b sum=%b",cin,a,b,cout,sum);
        $dumpfile("adder_4bit.vcd");
        $dumpvars(0,adder_4bit_tb);
    end

endmodule