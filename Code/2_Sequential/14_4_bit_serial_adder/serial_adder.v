`timescale 1ns / 1ps
`include "fulladder.v"
`include "shiftre.v"
`include "dff.v"

module serial_adder(ain, bin, reset_n, clock, start, sum, done);
    
    parameter bit_width = 8, bit_widthm1 = 7, size=4;
    input [bit_width-1:0] ain, bin;
    input reset_n, clock, start;
    output [bit_width-1:0] sum;
    output reg done;
    
    wire [bit_width-1:0] QA, QB;
    reg [size-1:0] count_d, count_q;
    wire sum_fa, cout_fa, cin_fa;
    reg load, ShR;
    
    localparam S0=2'b00, S1=2'b01, S2=2'b10, S3 =2'b11;
    reg [1:0] cp_fsm_d, cp_fsm_q;
    
    shiftre #(bit_width) regA (ain,load,ShR,1'b0, clock, QA);
    shiftre #(bit_width) regB (bin,load,ShR,1'b0, clock, QB);
    shiftre #(bit_width) regSum ({bit_width{1'b0}},load,ShR,sum_fa, clock, sum);
    
    fulladder fa (QA[0], QB[0], cin_fa, sum_fa, cout_fa);
    dff carryff (cout_fa,load,clock,cin_fa);
       
  always @(posedge clock or negedge reset_n)
    begin
      if (reset_n==0) 
        begin
         cp_fsm_q <= S0; count_q <= {size{1'b0}};
         end
      else
        begin
          cp_fsm_q <= cp_fsm_d; count_q = count_d;
        end
    end
    
    always @(*)
    begin
      cp_fsm_d = cp_fsm_q; ShR = 1'b0; done = 1'b0; load = 1'b0; count_d = count_q;
    
         case (cp_fsm_q)
            S0: begin if (start == 1'b1) cp_fsm_d = S1; end
            S1: begin load = 1'b1; count_d = bit_widthm1; cp_fsm_d = S2; end
            S2: begin ShR = 1'b1; count_d = count_q - 1; if (count_q == 1'b0) cp_fsm_d = S3; end
            S3: begin
                 done = 1'b1; 
                   if (start == 1'b0) cp_fsm_d = S0;
                 end  
            default: cp_fsm_d = S0;
        endcase
     end
endmodule
