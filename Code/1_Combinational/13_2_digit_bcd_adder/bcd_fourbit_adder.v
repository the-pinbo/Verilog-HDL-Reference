module bcd_fourbit_adder(
	input [3:0]A,
	input [3:0]B,
	output [7:0]S,
	output [4:0]L
);

	wire [4:0]T;
	wire gt_9, not_needed;
	
	fourbit_adder add1(A, B, 1'b0, T[3:0], T[4]);
	assign L = T;
	
	assign gt_9 = T[4] | T[3]&T[2] | T[1]&T[3];
	
	fourbit_adder add2({1'b0, gt_9, gt_9, 1'b0}, T[3:0], 1'b0, S[3:0], not_needed);
	
	assign S[7:4] = {3'b000, gt_9};
	
endmodule
