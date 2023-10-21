module comp_8(input[7:0] data_in1, data_in2, output eq, gt, lt);
    assign eq = data_in1==data_in2;
    assign gt = data_in1<data_in2;
    assign lt = data_in1>data_in2;
endmodule