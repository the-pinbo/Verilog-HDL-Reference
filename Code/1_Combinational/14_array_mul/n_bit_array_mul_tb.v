`timescale 1ns / 1ps
`include "n_bit_array_mul.v"
module n_bit_array_mul_tb;

parameter N = 8;

reg [N-1:0] data_in;
reg clk, clr_n, load_a, load_b;
wire [2*N-1:0] product;
reg [2*N-1:0] expected_product;
wire done;

// Instantiate the Unit Under Test (UUT)
n_bit_array_mul #(.N(N)) uut (
    .data_in(data_in), 
    .clk(clk), 
    .clr_n(clr_n), 
    .load_a(load_a), 
    .load_b(load_b), 
    .product(product), 
    .done(done)
);

initial begin
    // Initialize Inputs
    clk = 0;
    clr_n = 0;
    load_a = 0;
    load_b = 0;
    data_in = 0;

    // Wait for 100 ns for global reset
    #100;
    clr_n = 1;

    // Add stimulus here
    test_case(8'hAA, 8'h55);  // Example test case with operands AA and 55
    test_case(8'h03, 8'h07);  // Another test case
    // Add more test cases as needed
end

// Clock generation
always #10 clk = ~clk;

// Test case subroutine
task test_case;
    input [N-1:0] a, b;
    begin
        // Load first operand
        data_in = a;
        load_a = 1;
        #20;
        load_a = 0;
        
        // Load second operand
        data_in = b;
        load_b = 1;
        #20;
        load_b = 0;

        // Wait for the operation to complete
        wait(done);
        expected_product = a * b;

        // Check the result
        if (product != expected_product)
            $display("Test failed: %d * %d = %d (expected %d)", a, b, product, expected_product);
        else
            $display("Test passed: %d * %d = %d", a, b, product);
    end
endtask

endmodule
