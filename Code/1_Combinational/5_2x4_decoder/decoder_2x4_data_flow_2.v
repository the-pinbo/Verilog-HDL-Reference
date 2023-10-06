/* 
2x4 decoder using data flow modelling
*/
module decoder_2x4(input[1:0] in, input e, output[3:0] out);
    assign out = e?1<<in:0;
endmodule