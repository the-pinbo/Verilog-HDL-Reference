// generic code for n bit adder using + operator 

module n_bit_adder #(parameter N = 32) (a,b,cin,sum,cout);
    input[N-1:0] a,b;
    input cin;
    output reg [N-1:0] sum;
    output reg cout;
    always @(a or b or cin) begin
        {cout,sum} = a + b + cin;
    end
    
endmodule