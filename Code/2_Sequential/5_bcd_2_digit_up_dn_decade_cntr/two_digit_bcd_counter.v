`include "clock_divider.v"
`include "bcd_seven_segment_decoder.v"
`include "decade_counter_2_dig.v"

module two_digit_bcd_counter(
	input count_up,
	input load,
	input resetn,
	input counter_on,
	input [7:0]data_in,
	input clk,
	output TC,
	output [1:0]a,
	output [1:0]b,
	output [1:0]c,
	output [1:0]d,
	output [1:0]e,
	output [1:0]f,
	output [1:0]g
);
	wire divclk;
	wire [7:0]count;
	
	clock_divider divide(clk, divclk);
	decade_counter_2_dig dec(count_up, load, resetn, counter_on, data_in, divclk, count, TC);
	bcd_seven_segment_decoder msn(count[7:4], a[1], b[1], c[1], d[1], e[1], f[1], g[1]);
	bcd_seven_segment_decoder lsn(count[3:0], a[0], b[0], c[0], d[0], e[0], f[0], g[0]);
	
endmodule