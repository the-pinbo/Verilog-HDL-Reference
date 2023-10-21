module bcd_adder(
	input [3:0]A,
	input [3:0]B,
	output [3:0]a,
	output [3:0]b,
	output [3:0]c,
	output [3:0]d,
	output [3:0]e,
	output [3:0]f,
	output [3:0]g,
	output [4:0]L
);

	wire [7:0]S;
	
	bcd_fourbit_adder mbcd(A, B, S, L);
	
	bcd_seven_segment_decoder aout(A, a[0], b[0], c[0], d[0], e[0], f[0], g[0]);
	bcd_seven_segment_decoder bout(B, a[1], b[1], c[1], d[1], e[1], f[1], g[1]);
	bcd_seven_segment_decoder lsn_out(S[3:0], a[2], b[2], c[2], d[2], e[2], f[2], g[2]);
	bcd_seven_segment_decoder msn_out(S[7:4], a[3], b[3], c[3], d[3], e[3], f[3], g[3]);
	
endmodule
