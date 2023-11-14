`include "mux_dff.v"
module shift4(input clk, load, write_3, input[3:0] data_in, output [3:0] data_out);

    mux_dff stage3(write_3, data_in[3], load, clk, data_out[3]);
    mux_dff stage2(data_out[3], data_in[2], load, clk, data_out[2]);
    mux_dff stage1(data_out[2], data_in[1], load, clk, data_out[1]);
    mux_dff stage0(data_out[1], data_in[0], load, clk, data_out[0]);

endmodule