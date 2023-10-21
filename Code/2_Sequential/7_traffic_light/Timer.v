module Timer (
    input clk, reset,
    output reg TS, TLH, TLN
);

    reg [31:0] counter; // 32-bit counter

    // Assuming the clock frequency is 1Hz (one tick per second)
    parameter TS_VALUE = 2; // 1 seconds
    parameter TLH_VALUE = 5; // 8 seconds
    parameter TLN_VALUE = 4; // 5 seconds

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 32'b1;
            TS <= 1'b0;
            TLH <= 1'b0;
            TLN <= 1'b0;
        end else begin
            counter <= counter + 1;
            if (counter == TS_VALUE) begin
                TS <= 1'b1;
                TLN <= 1'b0;
                TLH <= 1'b0;
            end 
            if (counter == TLN_VALUE) begin
                TLN <= 1'b1;
                TLH <= 1'b0;
                TS <= 1'b0; 
            end
            if (counter == TLH_VALUE) begin
                TLH <= 1'b1;
                counter <= 32'b1; // Reset the counter after TLN_VALUE seconds
                TS <= 1'b0; // Reset the outputs
                TLN <= 1'b0;
            end 
        end
    end

endmodule