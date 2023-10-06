/* test bench for full adder */
`timescale 1ns/1ns
`include "full_adder_2.v"

module full_adder_tb;
    reg cin,a,b;
    wire cout,sum;
    full_adder fa_uut(a,b,cin,cout,sum);

    integer i;
    initial begin
        for(i=0;i<8;i=i+1)begin
            {cin,a,b} <= i;
            #5;
        end
    end

    initial begin
        $display("Full Adder sumulatio");
        $monitor("cin=%b a=%b b=%b cout=%b sum=%b",cin,a,b,cout,sum);
        $dumpfile("full_adder.vcd");
        $dumpvars(0,full_adder_tb);
    end

endmodule