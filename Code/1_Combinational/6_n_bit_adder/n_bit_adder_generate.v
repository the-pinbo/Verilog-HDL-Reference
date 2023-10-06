// create an n bit adder using generate statement 

module n_bit_adder #(parameter N = 32)(a,b,c,s,co);

    input[N-1:0] a,b;
    input c;
    output[N-1:0] s;
    output co;
    genvar i;
    wire c_int[N:0];
    assign c_int[0] = c;
    assign co = c_int[N];
    generate
        for(i = 0;i<N;i=i+1)begin:add_bit
            full_adder fa(a[i],b[i],c_int[i],c_int[i+1],s[i]);
        end

    endgenerate

endmodule


module full_adder(a,b,cin,cout,sum);
    input a,b,cin;
    output cout,sum;
    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(cin&a);
endmodule