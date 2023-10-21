module decade_counter(
	input count_up,
	input load,
	input resetn,
	input counter_on,
	input [3:0]data_in,
	input clk,
	output reg [3:0]count,
	output TC
);

	always @(negedge resetn or posedge clk)
	begin
		if(~resetn)
			count <= 4'b0000;
		else if(load)
			count <= data_in;
		else if(counter_on)
		begin
			if(count_up)
				if(count == 9)
					count <= 0;
				else
					count <= count + 1;
			else
				if(count == 0)
					count <= 9;
				else
					count <= count - 1;
		end
		else
			count <= count;
	end
	
	assign TC = (resetn) && (counter_on) && (~load) && ((~count_up && count == 4'b0000) || (count_up && count == 4'b1001));
	
endmodule