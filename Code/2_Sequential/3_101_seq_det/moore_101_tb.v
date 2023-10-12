`timescale 1ps/1ps
`include "moore_101.v"
module moore_101_tb;
    parameter t_PERIOD = 100;
    reg clk, reset_n, start, xin;
    wire y;
    integer data_file_in, data_file_out, scan_file; 
    moore_101 uut(reset_n, clk, xin, y);

    // file handling
    initial begin
        clk = 0; reset_n = 0; xin = 0; start = 0;
        #150 reset_n = 1;
        #200 start = 1;
        data_file_in = $fopen("./input_sequence.txt", "r");
        data_file_out = $fopen("./output_sequence.txt","w");
        $display("101 sequence detector simulation");
        $monitor("At time %t, clock=%b, data=%b, output=%b\n",$time, clk, xin, y);
        $dumpfile("moore_101.vcd");
        $dumpvars(0,moore_101_tb);
    end

    // clock generation
    initial
        forever #(t_PERIOD/2) clk <= ~clk;


    always @(posedge clk) begin
        if (start ==1) begin
            scan_file = $fscanf(data_file_in, "%b\n", xin);
            #50
            if(!$feof(data_file_in))
                $fwrite (data_file_out, "clock=%b, data=%b, output=%b\n", clk, xin, y);
            else begin
                $fwrite (data_file_out, "clock=%b, data=%b, output=%b\n", clk, xin, y);
                $fclose(data_file_in);
                $fclose(data_file_out);
                $finish;
            end
        end
    end
endmodule