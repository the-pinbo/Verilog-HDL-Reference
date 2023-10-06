/* 
2x4 decoder using data flow modelling
*/
module decoder_2x4(input[1:0] in, input e, output[3:0] out);
    assign out[0] = e&((~in[0])&(~in[1]));
    assign out[1] = e&((in[0])&(~in[1]));
    assign out[2] = e&((~in[0])&(in[1]));
    assign out[3] = e&((in[0])&(in[1]));
endmodule