`timescale 1ps/1ps
`include "comp_8.v"

module comp_8_tb;
    reg [7:0] data_in1, data_in2;
    wire eq,gt,lt;
    comp_8  dut(.data_in1(data_in1), .data_in2(data_in2), .eq(eq), .gt(gt), .lt(lt));
    
    initial begin
        data_in1 = 69; data_in2 = 96;
        #50;
        data_in1 = 99; data_in2 = 96;
        #50;
        data_in1 = 69; data_in2 = 69;
        #50;
    end

    initial begin
        $display("comparator");
        $monitor("At time %t, data_in1=%d, data_in2=%d, eq=%b, gt=%b, lt=%b\n",$time, data_in1, data_in2, eq, gt, lt);
        $dumpfile("comp_8.vcd");
        $dumpvars(0,comp_8_tb);
    end
endmodule
