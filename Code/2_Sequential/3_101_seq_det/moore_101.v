
module moore_101(input reset_n, input clk, input xin, output reg y);

    localparam [2:0] INIT = 0, S1 = 1, S2 = 2, S3 = 3;

    reg[2:0] current_state, next_state;

    // Present state registers
    always @(posedge clk or negedge reset_n) begin: L_PRESENT_STATE_REGISTERS
        if(!reset_n)
            current_state <= INIT;
        else
            current_state <= next_state;
    end

    // Next state decoder (combinational block)
    always @(current_state or xin) begin: L_NEXT_STATE_DECODER
        next_state = INIT;
        case (current_state)
            INIT: next_state = xin?S1:INIT;
            S1: next_state = xin?S1:S2;
            S2: next_state = xin?S3:INIT;
            S3: next_state = xin?S1:S2;
            default: next_state = INIT;
        endcase
    end

    // Output decoder (combinational block)
    always@(current_state)begin: L_OUTPUT_DECODER
        y = 1'b0;
        case(current_state)
            INIT: y = 1'b0;
            S1: y = 1'b0;
            S2: y = 1'b0;
            S3: y = 1'b1;
        endcase
    end

endmodule

