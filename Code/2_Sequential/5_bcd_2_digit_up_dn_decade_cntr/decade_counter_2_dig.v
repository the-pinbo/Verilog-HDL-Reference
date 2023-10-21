`include "decade_counter.v"
module decade_counter_2_dig(
	input count_up,
	input load,
	input resetn,
	input counter_on,
	input [7:0]data_in,
	input clk,
	output [7:0]count,
	output TC
);

	wire tc_int;
	decade_counter lsn(count_up,load,resetn,counter_on,data_in[3:0],clk,count[3:0],tc_int);
	decade_counter msn(count_up,load,resetn,tc_int,data_in[7:4],clk,count[7:4],TC);
endmodule

