module TrafficLightController(
    input wire clk, reset, C, TS, TLH, TLN,
    output reg ST,
    output reg [1:0] highwayLights, // 00: Red, 01: Yellow, 10: Green
    output reg [1:0] nitkRoadLights // 00: Red, 01: Yellow, 10: Green
);

    parameter GREEN = 2'b10;
    parameter YELLOW = 2'b01;
    parameter RED = 2'b00;

    localparam NH_ON=2'b00, NH_ALERT=2'b01, NITK_ON=2'b10, NITK_ALERT=2'b11;
    reg [1:0] present_state=0, next_state=0;

    // Present state register
    always @(posedge clk or posedge reset) begin: L_PRESENT_STATE_REGISTER
        if(reset) begin
            present_state <= NH_ON;
        end else begin
            present_state <= next_state;
        end
    end

    // Next state logic
    always@(present_state or C or TLH or TLN or TS) begin:L_NEXT_STATE_LOGIC
        casex(present_state)
            NH_ON: next_state = C&&TLH?NH_ALERT:NH_ON;
            NH_ALERT: next_state = TS?NITK_ON:NH_ALERT;
            NITK_ON: next_state = !C||TLN?NITK_ALERT:NITK_ON;
            NITK_ALERT: next_state = TS?NH_ON:NITK_ALERT;
            default: next_state = NH_ON;
        endcase
    end

    // Output decoder 
    always@(present_state) begin:L_OUTPUT_DECODER
        casex(present_state)
            NH_ON: begin 
                highwayLights = GREEN;
                nitkRoadLights = RED;
                ST = C&&TLH;
            end 
            NH_ALERT: begin     
                highwayLights = YELLOW;
                nitkRoadLights = RED;
                ST = TS;
            end 
            NITK_ON: begin 
                highwayLights = RED;
                nitkRoadLights = GREEN;
                ST = TLN||!C;
            end 
            NITK_ALERT: begin 
                highwayLights = RED;
                nitkRoadLights = YELLOW;
                ST = TS;
            end
            default: begin
                highwayLights = 2'b11;
                nitkRoadLights = 2'b11;
                ST = 0;
            end
        endcase
    end

endmodule
