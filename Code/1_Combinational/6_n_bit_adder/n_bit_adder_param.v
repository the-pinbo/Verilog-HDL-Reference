// generic code for n bit adder using parameter

module n_bit_adder #(parameter N = 32) (a,b,cin,sum,cout);
    input[N-1:0] a,b;
    input cin;
    output reg [N-1:0] sum;
    output reg cout;
    reg[N:0] carry;
    integer i;
    always @(a or b or cin) begin
        carry[0] = cin;
        for(i = 0;i<N;i=i+1)begin
            sum[i] = a[i]^b[i]^carry[i];
            carry[i+1] = (a[i]&b[i])|(b[i]&carry[i])|(carry[i]&a[i]);
        end
        cout = carry[N];
    end
    
endmodule