`include "n_bit_pipo.v"
module n_bit_array_mul 
#(
    parameter N = 8
)
(
    input [N-1:0] data_in,
    input clk, clr_n, load_a, load_b,
    output [2*N-1:0] product,
    output reg done
);
    wire [N-1:0] a, b;
    wire [N-1:0] partial_product [N-1:0];
    reg [2*N-1:0] sum [N-1:0];

    n_bit_pipo #(.N(N)) pipo_a (.clk(clk), .clr_n(clr_n), .load(load_a), .d(data_in), .q(a)),
                 pipo_b (.clk(clk), .clr_n(clr_n), .load(load_b), .d(data_in), .q(b));

    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin
            assign partial_product[i] = a & {N{b[i]}};
        end
    endgenerate

    // Sum the partial products
    integer j;
    always @(posedge clk or negedge clr_n) begin
        if (!clr_n) begin
            done <= 0;
            sum[0] <= 0;
            for (j = 1; j < N; j = j + 1) begin
                sum[j] <= 0;
            end
        end else if (load_a || load_b) begin
            sum[0] <= partial_product[0];
            for (j = 1; j < N; j = j + 1) begin
                sum[j] <= sum[j-1] + (partial_product[j] << j);
            end
            done <= 1'b1;
        end
    end

    // Output assignment
    assign product = sum[N-1];

endmodule
