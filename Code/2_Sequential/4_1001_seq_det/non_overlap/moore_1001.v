

module moore_1001(input reset_n,input clk,input data_in,output reg data_out);

    localparam[2:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg[2:0] next_state, current_state;

    // Present state register logic
    always@(posedge clk or negedge reset_n) begin: L_PRESENT_STATE_REGISTERS
        if(!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic 
    always@(current_state or data_in) begin: L_NEXT_STATE_DECODER
        next_state = S0;
        case(current_state)
            S0: next_state = data_in?S1:S0;
            S1: next_state = data_in?S1:S2;
            S2: next_state = data_in?S1:S3;
            S3: next_state = data_in?S4:S0;
            S4: next_state = data_in?S1:S0;
            default: next_state = S0;
        endcase
    end


    // Output decoder logic
    always@(current_state) begin: L_OUTPUT_DECODER
        case(current_state)
            S0: data_out = 1'b0;
            S1: data_out = 1'b0;
            S2: data_out = 1'b0;
            S3: data_out = 1'b0;
            S4: data_out = 1'b1;
        endcase
    end



endmodule