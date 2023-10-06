`timescale 1ps/1ps
`include "priority_encoder_loop.v"

module priority_encoder_tb;
    reg[3:0] din; wire[1:0] dout; wire zero;
    priority_encoder uut (din,dout,zero);

    integer  i;
    initial begin
        #5;
        for(i=0;i<16;i=i+1)begin
            din = i;
            #5;
        end
    end
    initial begin
        $display("Priority Encoder");
        $monitor("din=%b dout=%b zero=%b", din,dout,zero);
        $dumpfile("priority_encoder.vvp");
        $dumpvars(0,priority_encoder_tb);
    end
endmodule