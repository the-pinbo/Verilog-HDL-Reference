`timescale 1ns / 1ps
module shiftre #(parameter N=8)(
    input [N-1:0] D,
    input load, shiftR, lin, clock,
    output reg [N-1:0] Q
    );
   
   integer k;
   
   always @(posedge clock)
    begin
       if (load) Q <= D;
          else if (shiftR)
             begin
                for (k = N-1; k > 0; k = k-1)
                  Q[k-1] <= Q[k];
                Q[N-1] <= lin; 
              end
    end   
    
endmodule
