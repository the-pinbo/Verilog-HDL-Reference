`timescale 1ps/1ps
`include "decoder_2x4_data_flow_2.v"

module decoder_2x4_tb;

    reg[1:0] in;reg e;
    wire[3:0] out;
    decoder_2x4 uut(in,e,out);

    integer i;

    initial begin
        for(i=0;i<8;i=i+1)begin
            {e,in} <= i;
            #5;
        end
    end

    initial begin
        $display("Decoder sumulation");
        $monitor("e=%b in=%b out=%b",e,in,out);
        $dumpfile("decoder_2x4.vcd");
        $dumpvars(0,decoder_2x4_tb);
    end

endmodule