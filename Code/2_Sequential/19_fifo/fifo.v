module FIFO_Buffer #(parameter STACK_WIDTH = 32,
    STACK_HEIGHT = 8,
    STACK_PTR_WIDTH = 3,
    HALF_LEVEL = STACK_HEIGHT/2
    ) (
        input clk, rst, write_to_stack, 
        input [STACK_WIDTH-1:0] data_in,
        input read_from_stack,
        output stack_full, stack_half_full, stack_empty,
        output reg [STACK_WIDTH-1:0] data_out
    );

    reg [STACK_PTR_WIDTH-1:0] read_ptr, write_ptr;
    reg [STACK_PTR_WIDTH:0] ptr_gap; // Gap between the pointers
    reg [STACK_WIDTH-1:0] stack [STACK_HEIGHT-1:0];


    // stack status signals
    assign stack_full = (ptr_gap == STACK_HEIGHT);
    assign stack_half_full = (ptr_gap == HALF_LEVEL); 
    assign stack_empty = (ptr_gap == 0);

    always @ (posedge clk or posedge rst)
        if (rst == 1) begin
            data_out <= 0;
            read_ptr <= 0;
            write_ptr <= 0;
            ptr_gap <= 0; 
        end else if (write_to_stack && (!read_from_stack) && (!stack_full)) begin
            stack [write_ptr] <= data_in;
            write_ptr <= write_ptr + 1;
            ptr_gap <= ptr_gap + 1;
        end else if (read_from_stack && (!write_to_stack) && (!stack_empty)) begin
            data_out <= stack[read_ptr];
            read_ptr <= read_ptr + 1;
            ptr_gap <= ptr_gap - 1;
        end else if (write_to_stack && read_from_stack && stack_empty) begin
            stack [write_ptr] <= data_in;
            write_ptr <= write_ptr + 1;
            ptr_gap <= ptr_gap + 1;
        end else if (write_to_stack && read_from_stack && stack_full) begin
            data_out <= stack[read_ptr];
            read_ptr <= read_ptr + 1;
            ptr_gap <= ptr_gap - 1;
        end else if (write_to_stack && read_from_stack && (!stack_empty) && (!stack_full)) begin
            stack [write_ptr] <= data_in;
            data_out <= stack[read_ptr];
            write_ptr <= write_ptr + 1;
            read_ptr <= read_ptr + 1;
        end

endmodule