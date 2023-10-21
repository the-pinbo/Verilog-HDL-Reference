module bcd_seven_segment_decoder(
	input [3:0]x,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g
);

	assign a = ~(x[3] | x[2]&x[0] | x[1] | ~x[2] & ~x[0]);
	assign b = ~(~x[2] | ~x[1] & ~x[0] | x[1] & x[0]);
	assign c = ~(~x[1] | x[0] | x[2]);
	assign d = ~(x[3] | ~x[2]&~x[0] | ~x[2] & x[1] | x[2] & ~x[1] & x[0] | x[1] & ~x[0]);
	assign e = ~((~x[2] | x[1]) & ~x[0]);
	assign f = ~(x[3] | x[2] & ~x[0] | ~x[1] & ~x[0] | x[2] & ~x[1]);
	assign g = ~(~x[2] & x[1] | x[2] & ~x[1] | x[3] | x[2] & ~x[0]);
	
endmodule