`timescale 1ps/1ps
`include "n_bit_adder_operator.v"

module n_bit_adder_tb#(parameter N = 16)();
    reg[N-1:0] a, b;
    reg cin;
    wire[N-1:0] sum;
    wire cout;
    
    n_bit_adder #(.N(N)) adder(a,b,cin,sum,cout);

    initial begin
        $display("N bit adder");
        $monitor("a=%b b=%b c=%b sum=%b cout=%b",a,b,cin,sum,cout);
        $dumpfile("n_bit_adder.vcd");
        $dumpvars(0,n_bit_adder_tb);
    end


    initial begin
        a = 'b10; b = 'b0; cin = 0;
        #5

        a = 'b0; b = 'b10; cin = 0;
        #5

        a = 'b10; b = 'b10; cin = 0;
        #5

        a = 'hffff_ffff; b = 'hffff_ffff; cin = 0;
        #5

        a = 'hffff_ffff; b = 'hffff_ffff; cin = 1;
        #5

        a = 0; b = 0; cin = 0;
        #5;
    end

endmodule