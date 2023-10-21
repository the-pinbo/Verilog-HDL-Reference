`timescale 1ps/1ps
`include "lzero_count_2.v"

module lzero_count_tb;


    reg [7:0] data_in;
    wire[4:0] data_out;
    lzero_count  dut(.data_in(data_in), .data_out(data_out));
    
    initial begin
        data_in = 8'b0000_1000;
        #100;
        data_in = 8'b1000_1000;
        #100;
        data_in = 8'b0000_0000;
        #100;
    end

    initial begin
        $display("left zero count");
        $monitor("At time %t, data_in=%b, data_out=%d \n",$time, data_in, data_out);
        $dumpfile("lzero_count.vcd");
        $dumpvars(0,lzero_count_tb);
    end

endmodule