module sop(input [4:0]x, output reg f);
    always @(*) begin
    if(x == 0 || x == 2 || x == 3 || x == 4 || x == 8 || x == 21 || x == 22 || x == 29 || x == 31)
        f = 1;
    else
        f = 0;
    end
endmodule