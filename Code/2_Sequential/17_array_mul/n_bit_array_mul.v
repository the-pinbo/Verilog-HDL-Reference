`include "n_bit_pipo.v"

module n_bit_array_mul 
#(
    parameter N = 8
)
(
    input[N-1:0] data_in,
    input clk, clr_n, load_a, load_b,
    output [2*N-1:0] product,
    output reg done
);
    wire[N-1:0] a,b;
    n_bit_pipo #(.N(N))  pipo_a (.clk(clk), .clr_n(clr_n), .load(load_a), .d(data_in), .q(a)),
                pipo_b(.clk(clk), .clr_n(clr_n), .load(load_b), .d(data_in), .q(b));

    // to represent the partial addition of each level
    // parital product of i th level is partial_prod[N*(i+1)-1 : N*i]
    reg[N*N:0] partial_prod;
    reg[2*N-1:0] product_d;
    n_bit_pipo #(.N(2*N))  pipo_out(.clk(clk), .clr_n(clr_n), .load(done), .d(product_d), .q(product));

    // function to find the partial product
    function [N-1:0] f_partial_product(input[N-1:0] a, input b);
        f_partial_product = b?a:{N{1'b0}};
    endfunction

    // loop to generate the partial products in each row
    genvar gi;
    generate
        for (gi = 1; gi < N; gi = gi + 1) begin : gen_partial_prod
            always @(*) begin
                if (gi == 1) begin
                    done = 1'b0;
                    partial_prod[N:0] = {1'b0, f_partial_product(a, b[0])};
                end
                product_d[gi-1] = partial_prod[N*(gi-1)];
                partial_prod[N*(gi+1):N*gi] = f_partial_product(a,b[gi]) + partial_prod[N*gi:N*(gi - 1)+1];
                if (gi == N-1) begin
                    product_d[2*N-1:N-1] = partial_prod[N*(N+1):N*N];
                    done = 1'b1;
                end
            end
        end
    endgenerate




endmodule