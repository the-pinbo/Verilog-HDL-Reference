module up_down_decade_cntr(input clk, load, reset, counter_on, count_up, input [3:0] data_in, output reg TC, output reg [3:0] count);

    always @(posedge clk or posedge reset)begin
        if(reset)
            count <= 4'b0000;
        else if(load)
            count <= data_in;
        else if(counter_on) begin
            if(count_up)begin
                if(count == 9)
                    count <= 4'b0000;
                else
                    count <= count + 1;
            end else begin
                if(count == 0)
                    count <= 4'b1001;
                else
                    count <= count - 1;
            end
        end
    end

    always@(count or count_up) begin
        if(count_up && count == 9)
            TC = 1'b1;
        else if(!count_up && count == 0)
            TC = 1'b1;
        else 
            TC = 1'b0;
            
    end


endmodule