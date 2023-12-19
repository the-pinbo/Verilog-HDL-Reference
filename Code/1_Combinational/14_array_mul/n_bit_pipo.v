module n_bit_pipo #(
    parameter N = 8
) (
    input clk, clr_n, load,
    input [N-1:0] d,
    output reg [N-1:0] q
);
    always @(posedge clk or negedge clr_n) begin
        if (!clr_n)
            q <= 0;
        else if (load)
            q <= d;
    end
endmodule