module mealy_1001 (
    input reset_n, input clk, input data_in, output reg data_out
);
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3;
    reg [2:0] present_state, next_state;

    // present state register
    always@(negedge reset_n or posedge clk) begin: L_PRESENT_STATE_REGISTER
        if(~reset_n)
            present_state <= S0;
        else 
            present_state <= next_state;
    end

    // Next state logic 
    always@(data_in or present_state) begin: L_NEXT_STATE_LOGIC
        next_state = S0;
        case(present_state)
            S0: next_state = data_in?S1:S0;
            S1: next_state = data_in?S1:S2;
            S2: next_state = data_in?S1:S3;
            S3: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output decoder 

    always@(data_in or present_state) begin
        data_out = 1'b0;
        case(present_state)
            S0: data_out = 1'b0;
            S1: data_out = 1'b0;
            S2: data_out = 1'b0;
            S3: data_out = data_in?1'b1:1'b0;
            default: data_out = 1'b0;
        endcase
    end

endmodule 