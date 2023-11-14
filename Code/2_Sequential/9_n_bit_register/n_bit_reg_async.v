module n_bit_reg_async 
#(
    parameter N = 8
) 
(
    input CLK, CLR_N, LOAD,
    input [N-1:0] D, 
    output reg [N-1:0] Q
);

    always @(posedge CLK or negedge CLR_N) begin
        if(!CLR_N)
            Q <= 'b0;
        else if(LOAD) 
            Q <= D;
        else
            Q <= Q;
        
    end

endmodule