module sequence_detector(
	input x,
	input clk,
	input resetn,
	output reg Y,
	output reg Z
);

	parameter [3:0]s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7, s8 = 8;
	
	reg [3:0]present_state, next_state;
	reg y, z;
	
	// State Transition
	always @(negedge clk or negedge resetn)
	if(~resetn)
		present_state <= s0;
	else
		present_state <= next_state;
		
	// Registered output	
	always @(negedge clk)
		begin
			Y <= y;
			Z <= z;
		end
		
		
		
	// Next State Decoder
	always @(present_state, x)
		case(present_state)
			s0 : if(x == 0) begin next_state = s2; {y, z} = 2'b00; end else begin next_state = s1; {y, z} = 2'b00; end
			s1 : if(x == 0) begin next_state = s3; {y, z} = 2'b00; end else begin next_state = s1; {y, z} = 2'b00; end
			s2 : if(x == 0) begin next_state = s2; {y, z} = 2'b00; end else begin next_state = s4; {y, z} = 2'b00; end
			s3 : if(x == 0) begin next_state = s2; {y, z} = 2'b00; end else begin next_state = s5; {y, z} = 2'b10; end
			s4 : if(x == 0) begin next_state = s3; {y, z} = 2'b00; end else begin next_state = s6; {y, z} = 2'b01; end
			s5 : if(x == 0) begin next_state = s3; {y, z} = 2'b00; end else begin next_state = s6; {y, z} = 2'b01; end
			s6 : if(x == 0) begin next_state = s7; {y, z} = 2'b00; end else begin next_state = s6; {y, z} = 2'b00; end
			s7 : if(x == 0) begin next_state = s7; {y, z} = 2'b00; end else begin next_state = s8; {y, z} = 2'b00; end
			s8 : if(x == 0) begin next_state = s7; {y, z} = 2'b00; end else begin next_state = s6; {y, z} = 2'b01; end
			default : begin next_state = s0; {y, z} = 2'b00; end
		endcase
		
endmodule
