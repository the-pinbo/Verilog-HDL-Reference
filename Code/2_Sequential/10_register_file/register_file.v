module register_file #(
    parameter WORD_LEN = 8,
    ADDR_LEN = 4,
    REGISTER_COUNT = 2**ADDR_LEN

) (
    input clk, write_en,
    input [WORD_LEN-1:0] data_in,
    input [ADDR_LEN-1:0] read_addr_a, read_addr_b, write_addr,
    output [WORD_LEN-1:0] data_out_a, data_out_b
);
    
    reg [WORD_LEN-1:0] reg_file [REGISTER_COUNT-1:0];
    assign data_out_a = reg_file[read_addr_a];
    assign data_out_b = reg_file[read_addr_b];

    always @(posedge clk) begin
        if(write_en)
            reg_file[write_addr] <= data_in;
    end

endmodule