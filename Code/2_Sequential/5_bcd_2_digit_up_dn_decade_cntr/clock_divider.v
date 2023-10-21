module clock_divider(
	input clk, 
	output divclk
);

	reg [26:0] divcntr = 'b0;
	
	always @(posedge clk) 
		divcntr <= divcntr + 1;
		
	assign divclk = divcntr[1];
	
endmodule