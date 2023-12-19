module n_bit_adder 
#(
    parameter N = 8
) 
(
    input[N-1:0] a,b,
    input cin,
    output reg [N-1:0] sum,
    output reg cout
);
    always @(a or b or cin) begin
        {cout,sum} = a + b + cin;
    end
    
endmodule