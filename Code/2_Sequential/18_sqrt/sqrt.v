
module sqrt (
    input[5:0] data_in,
    input start, reset, clk,
    output reg[2:0] result, output reg done 
);
    localparam[1:0] WAIT=0, S1=1, S2=2, S3=3;
    reg[1:0] present_state=WAIT, next_state=WAIT;

    reg[5:0] num, num_temp;
    integer cnt = 0, i_odd = 1;

    // Present state register
    always @(posedge clk or posedge reset) begin: L_PRESENT_STATE_REGISTER
        if(reset) begin
            present_state <= WAIT;
        end else begin
            present_state <= next_state;
        end
    end


    // Next state logic
    always@(*) begin:L_NEXT_STATE_LOGIC
        casex(present_state)
            WAIT: next_state = start?S1:WAIT;
            S1: next_state = num>num_temp?S2:S3;
            S2: next_state = num>num_temp?S2:S3;
            S3: next_state = start?S1:S3;
            default: next_state = WAIT;
        endcase
    end

    // Output decoder 
    always@(present_state) begin:L_OUTPUT_DECODER
        casex(present_state)
            WAIT: begin
                done = 'bz;
                result = 'bz;
            end
            S1: begin
                num = data_in;
                cnt = 0;
                i_odd = 1;
                num_temp = num - i_odd;
            end
            S2: begin
                num = num_temp;
                i_odd = i_odd + 2;
                cnt = cnt + 1;
                num_temp = num - i_odd;
            end
            S3: begin
                done = 'b1;
                result = cnt;
            end
            default:begin
                done = 'bz;
                result = 'bz;
                num = 'bz;
                cnt = 'bz;
                i_odd = 'bz;
                num_temp = 'bz;
            end
        endcase
    end
    
endmodule