# Verilog HDL hand book

## icarus-verilog

- `iverilog/bin/gtkwave.exe` to open the waveform viewer
- `iverilog/bin/iverilog.exe` to compile the verilog code
- `iverilog/bin/vvp.exe` servers as the simulation runtime engine

## Introduction to Verilog HDL

### Types of Verilog HDL code and their synthesis

There are two types of code in most HDLs:

1. Structural code: verbal description of the circuit without storage
   Example:

   ```verilog
   assign a = b & c;
   ```

2. Procedural code: description of the circuit with storage or convenient for describing conditional logic
   Example:

   ```verilog
   always @(posedge clk)
   begin
      a <= b & c;
   end
   ```

   if and case statements are also procedural code, the synthesis tool will convert them into combinational logic.

### Verilog HDL levels of abstraction

There are 4 levels of abstraction in Verilog HDL:

1. Switch level: the lowest level of abstraction, describing the circuit in terms of MOSFETs and switches
2. Gate level: describing the circuit in terms of logic gates
3. Dataflow level (RTL): describing the circuit in terms of dataflow
4. Behavioral level (Algorithmic): describing the circuit in terms of behavior

Example:

1. Switch level

   ```verilog
   module and_gate (a, b, y);
      input a, b;
      output y;
      nmos (y, a, b);
   endmodule
   ```

2. Gate level

   ```verilog
   module and_gate (a, b, y);
      input a, b;
      output y;
      and (y, a, b);
   endmodule
   ```

3. Dataflow level

   ```verilog
    module and_gate (a, b, y);
        input a, b;
        output y;
        assign y = a & b;
    endmodule
   ```

4. Behavioral level

   ```verilog
   module and_gate (a, b, s, y);
       input a, b, s;
       output y;
       always @(a or b or s)
       begin
           if(s)
               y = a;
           else
               y = b;
       end
   endmodule
   ```

## Verilog HDL lexical tokens

### Comments

```
// This is a single line comment
/* This is a multi-line comment */
```

### Numbers

Supports decimal, binary, octal, and hexadecimal numbers.

1. Decimal numbers: 0-9
2. Binary numbers: 0b or 0B followed by 0 or 1
3. Octal numbers: 0o or 0O followed by 0-7
4. Hexadecimal numbers: 0x or 0X followed by 0-9, a-f, A-F

Format:
`[size] ‘[signed] base value`

- size – size of the constant in bits
  - if size is not specified default is 32 bits
  - if size is larger – padding 0 for unsigned, msb for signed
  - if size is smaller – left most bits truncated
- signed – s or S if omitted unsigned
- base – o or O, b or B, d or D, h or H
- values of x, z and hex values a – f are _case insensitive_

  - 5 ‘O 37, 4 ‘B 1x_01, 8 ‘SH2A, 6 ‘SO71
  - 4 ‘D-4, (2+3) ‘D10, 3` B001 - incorrect

- If any bit is x or z entire result is X
- Size of result – size of the largest operand (incl target on left)
- If any one operand is unsigned all operands are converted to unsigned before any operation takes place
  - Unsigned – net, reg variable, integer in base format without S
  - Signed – integer variable, integer in decimal format, integer in base format with S, signed reg variable, signed net
  - `$signed` and `$unsigned` – system functions for conversion

Examples:

```verilog
    3'b101
    5'd30
    8'h1E
    16'b1010_1111_0000_1111
    16'o1234_5670
```

_Underscores can be used to separate digits_

### Identifiers

Identifiers are used to name modules, variables, function names, block names, instances, etc.

- Must begin with a letter or underscore
- Never begin with a number and $
- Case sensitive

## Data types

### Value set

Four value logic: 0, 1, x, z

Case insensitive X and Z

1. 0: logic zero
2. 1: logic one
3. x: unknown logic value
4. z: high impedance

### Wire

Represents a physical wire in the circuit, can be used to connect modules or gates.

_Note:_

- A value of a wire can be read but not assigned to in a procedural block or in a function.
- A wire does not store its value. Must be driven by continuous assignment statements
- Undeclared nets will default implicitly to type wire
  - Can be changed using ‘default_nettype
  - Can be set to none – for declaring explicitly

`net_kind [signed] [ [msb:lsb] ] net1, net2 …;`

```verilog
    wire w1, w2, w3;
    wire signed [7:0] prdata;
    wire [3:0] w4;
    wire [3:0] w5, w6, w7;
    assign w1 = w2 & w3;
```

### Register

All data objects on the left hand side of expressions in procedural block and functions.
Default value - x

_Note:_

- Used for latches, flip-flops and memories.
- Can be used to model combinational logic as well.

```verilog
    reg r1, r2, r3;
    reg [3:0] r4;
    reg [3:0] r5, r6, r7;
    always @(posedge clk)
    begin
        r1 <= r2 & r3;
    end
```

### Input, output ports and inout ports

Default the input and output ports are wires.
_We can configure the output port to be a register_

```verilog
    module mux2x1 (a, b, s, y);
        input a, b, s;
        output y;
        reg y;
        always @(a or b or s)
        begin
            if(s)
                y = a;
            else
                y = b;
        end
    endmodule
```

### Integer

General purpose variables.
Used mainly for loops, parameters and constants.

- _Default size 32 bit_
- _Implicitly they are reg but they store data as signed numbers however explicitly declared reg types store unsigned numbers_
- _If they hold constants, the synthesis tool will adjust them to minimum width needed at compilation_

```verilog
    integer i;
    reg [31:0] j;
    initial
    begin
        i = 32'h1234_5678;
        j = 32'h1234_5678;
        $display("i = %d", i);
        $display("j = %d", j);
    end
```

### Real

- Decimal
  - 2.0, 5.678, 0.1
  - 2., .1 - incorrect
- Scientific notation
  - 3.6e2, 5E-4
- not useful in synthesis
- implicit conversion to integer by rounding defined by language
  - 42.446, 42.45 – rounded to 42

### Time

64 bit quantity used to represent time in simulation.
`$time` returns the current simulation time.

```verilog
    initial
    time current_time;
    current_time = $time;
    $display("Current simulation time is %0t", current_time);
```

### Parameter

Parameters allow us to define constants that can be used in the code.

- Value can be changed at compile time or by specifying parameter value in module instantiation

```verilog
    parameter WIDTH = 8;
    reg [WIDTH-1:0] r;
```

#### Local parameter

- Local to module cannot be changed at compile time or
  module instantiation time.

### Arithmetic operators

1. Addition: `+`
2. Subtraction: `-`
3. Multiplication: `*`
4. Division: `/`
5. Modulus: `%`

_`+` and `-` can be unary or binary_

### Relational operators

Compare two operands and return a single bit result `0` or `1`.

_Synthesized into comparators_

Note:
_`wire` and `reg` variables are positive, thus `(-3'b111) == 3'b111`_

1. Equality: `==`
2. Inequality: `!=`
3. Greater than: `>`
4. Less than: `<`
5. Greater than or equal to: `>=`
6. Less than or equal to: `<=`
7. Case equality: `===` _includes `x` and `z`_
8. Case inequality: `!==`
9. Wildcard equality: `==?`
10. Wildcard inequality: `!=?`
11. Wildcard greater than: `>?`
12. Wildcard less than: `<?`
13. Wildcard greater than or equal to: `>=?`
14. Wildcard less than or equal to: `<=?`
15. Wildcard case equality: `===?`
16. Wildcard case inequality: `!==?`

### Bitwise operators

1. Bitwise AND: `&`
2. Bitwise OR: `|`
3. Bitwise XOR: `^`
4. Bitwise NOT: `~`
5. Bitwise NAND: `~&`
6. Bitwise NOR: `~|`
7. Bitwise XNOR: `~^`

### Logical operators

Return a single bit result `0` or `1`.

1. Logical AND: `&&`
2. Logical OR: `||`
3. Logical NOT: `!`
4. Logical NAND: `!&`
5. Logical NOR: `!|`
6. Logical XNOR: `!^`

### Shift operators

1. Left shift: `<<`
2. Right shift: `>>`

### Concatenation operator

Concatenates two or more operands into a single operand.

```verilog
    assign x = {a, b, c};
    assign y = {1'b0,a} ;
    assign {count, sum} = {count+1, sum+data};
```

### Replication operator

Makes multiple copies of a single operand.

```verilog
    assign x = {4{a}, 4{1'b0}};
    assign z = {4{a,b},2{c,3{d}}};
```

### Conditional operator

Terinary operator that returns one of two values depending on the value of a third operand.
_Always synthesized to a multiplexer_

```verilog
    assign y = (a == b) ? c : d;
```

### Precedence of operators

- +, -, !, ~, &, ~&, |, ~|, ^, ^~, ~^ (reduction)
- \*\* (power)
- \*, /, %
- +, - (binary add and subtract)
- <<, >>, <<<. >>> (shift)
- <, <=, >, >= (relational)
- ==, !=, ===, !== (equality)
- & (bit wise and)
- ^, ^~, ~^ (bitwise)
- | (bitwise or)
- && (logical and)
- || (logical or)
- ?: (conditional)
- {}, {{}} (concatenation and repetition)
- operators associate left to right except conditional right to left

### Literals

```verilog
    "time is" // string literal
    8'hFF // hexadecimal literal
    8'd255 // decimal literal
    8'o377 // octal literal
    'b1111_1111 // binary literal
```

_Note: The synthesizer can infer the bit length if we start with `'`_

### Kinds of expression

- Constant expression
  - evaluates to a constant at compile time
  - constant literals, parameter names, bit select and part select of a parameter, constant function calls
- Scalar expression
  - evaluates to a 1 bit result
  - if a scalar result is expected and expression produces vector result a non-zero vector is treated as 1
- Evaluating an expression
  - determine expression size – size of largest operand
  - determine signedness – if any operand is unsigned expression is unsigned.
  - Target does not determine signedness
  - all operands are coerced to the signedness, size of operands extended
  - expression evaluated

### wires, registers and variables

```verilog
    reg a;
    reg b;
    wire c;
    parameter n = 4;
    assign c = a + b;
    assign c = a + n;
```

### Bit select and part select

Similar to python slice.

```verilog
    wire [7:0] a;
    wire [7:0] b;
    wire c;
    assign b = a[3:0];
    assign c = a[3];
    assign b = a[3:0] + a[7:4];

    integer mark; reg [0:15] inst_code;
    inst_code[mark+:2] selects the bits mark and mark+1
    inst_code[mark-:4] selects mark, mark-1, mark-2, mark-3

    dout = data[index]; // multiplexer
    mem[addr] = Store; // decoder

```

- Indexed part select
  - `net_or_reg_vector[base_expr+:const_width_expr]`
  - `net_or_reg_vector[base_expr-:const_width_expr]`
- If range is out of bounds or evaluates to an x or z the part select value is x

### Function call

```verilog
    function [7:0] adder;
        input [7:0] a, b;
        begin
            adder = a + b;
        end
    endfunction
    wire [7:0] a;
    wire [7:0] b;
    wire [7:0] c;
    assign c = adder(a, b);
```

## Modules

### Declaration

- Principal design entry in verilog.

```verilog
    // module name and port list
    module mux2x1 (a, b, s, y);
        // input and output ports
        input a, b, s;
        output y;
        reg y;
        always @(a or b or s)
        begin
            if(s)
                y = a;
            else
                y = b;
        end
    endmodule
```

### Instantiation

- Instantiation is the process of creating an instance of a module within another module.
- The module that contains the instance is called the parent module.
- Unconnected inputs are driven to z

_Note: Modules cant be instantiated inside a procedural block_

1. Instantiate by using `.` and the port name

```verilog

module fullAdder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire carry1;
    halfAdder ha1(a,b,sum1,carry1);
    halfAdder ha2(.sum(sum),.cout(carry2),.a(sum1),.b(cin));
    // or
    //halfAdder ha2(sum.sum,carry2.carry,sum1.a,cin.b);
endmodule
```

### Parameterized modules

- Modules can be parameterized by using the `#` operator.
- Use local parameter if a parameter does not vary from one instance to another
- Positional association
  - mod2 #(5,2) u1 (a,b,c,d)
  - order must match order of parameters declared in the module
- Named association
  - mod2 #(.param1(2),.param2(2)) u1 (a,b,c,d)
  - need to specify only the parameters that have to be changed
- Can be used only to pass parameter values down one level of hierarchy
- External ports
  - list of ports visible outside need not be same as internal ports
  - module exter_p(.data(arb),.control(ctrl),.addr(byte));

```verilog
    module mux2x1 #(parameter WIDTH = 8) (a, b, s, y);
    //(port_list) #(parameter_list) module_name (port_list);
        input [WIDTH-1:0] a, b;
        input s;
        output [WIDTH-1:0] y;
        reg [WIDTH-1:0] y;
        always @(a or b or s)
        begin
            if(s)
                y = a;
            else
                y = b;
        end
    endmodule
```

```verilog
module shift_n(in,out);
    parameter n = 4; // internal parameter
    assign out = in << n;
endmodule

module shift_n_test;
    wire [7:0] a;
    wire [7:0] b;
    shift_n #(.n(3)) s1(a,b);
endmodule

module shift_n_test;
    wire [7:0] a;
    wire [7:0] b;
    shift_n #(1) s1(a,b);
endmodule

```

parameter value can be overridden by defparam

```verilog
module tb;
      // Module instantiation override
     design_ip  #(BUS_WIDTH = 64, DATA_WIDTH = 128) d0 ( [port list]);
    // Use of defparam to override
    defparam d0.FIFO_DEPTH = 128;
endmodule

```

```verilog
defparam hierpath1=value1, hierpath2 = value 2…..;
defparam u5.DELAY=5, u5.uu1.BIT=2;
```

### Macros

- Macros are used to define constants and text substitutions.
- Similar to param, good for global parameters and constants.

```verilog
`define WIDTH 8
module top;
    wire [`WIDTH-1:0] a;
    ...
endmodule
```

### Continuous assignment

- Continuous assignment statements are used to assign values to wires.
- They are executed whenever there is a change in the value of the right hand side.
- They are executed in parallel.
- They are used to model combinational logic.
- They are used only in structural code.

  _Note: in procedural module we can assign values only to a register not a wire_
  _We can assign a value to a wire during initialization or using assign key word in structural block._

```verilog
    module mux2x1 (a, b, s, y);
        input a, b, s;
        output y;
        assign y = (s == 1'b1) ? a : b;
    endmodule
```

## Behavioral modeling

- Behavioral modeling is used to model the behavior of a circuit.
- We use procedural blocks (`always` and `initial`) to model the behavior of a circuit.

### Procedural assignment

- Procedural assignment statements are used to assign values to registers and integers. The right hand side can be any data type.
- `=` is used for blocking assignment, executed in sequence written in the procedural block. Similar to software programming. Used to model combinational logic.
- `<=` is used for non-blocking assignment. Executed in parallel. Used to model sequential logic.Non blocking assignments are executed after all the blocking assignments in a procedural block.

_Note: DONOT mix `=` and `<=` in the same procedure_

```verilog
    module mux2x1 (a, b, s, y);
        input a, b, s;
        output y;
        reg y;
        always @(a or b or s)
        begin
            y = (s == 1'b1) ? a : b;
        end
    endmodule
```

```verilog
   always@(posedge clk)
   begin
        z <= a + b;
   end
```

### Loops

- Similar to software programming.

#### for loop

```verilog
    module loop;
        reg [7:0] a;
        reg [7:0] b;
        reg [7:0] c;
        integer i;
        initial
        begin
            for(i = 0; i < 8; i = i + 1)
            begin
                a = a + 1;
                b = b + 1;
                c = a + b;
            end
        end
    endmodule
```

#### while

_Not recommended for synthesis, as the number of iterations are not fixed_

```verilog
    while(!overflow)begin
        @(posedge clk);
            a = a + 1;
    end

```

#### forever loop

```verilog
    forever begin
        @(posedge clk);
            a = a + 1;
    end
```

#### repeat

_Not synthesize_

```verilog
    repeat(8)begin
        @(posedge clk);
            a = a + 1;
    end
```

### disable block

- Used to disable a procedural block.
- Similar to break in software programming.
- We can disable other blocks also.

```verilog
    begin: accumulate
    forever
        begin
            @(posedge clk);
                begin
                    a = a + 1;
                    if(a == 'b0111)
                        disable accumulate;
                end
        end
    end
```

### else if if else

- Similar to software programming

_NOTE: if all the possibilities are not specifically covered, synthesis will generate extra latches._

```verilog
    if(a == 1'b0)
        b = 1'b0;
    else if(a == 1'b1)
        b = 1'b1;
    else
        b = 1'bx;
```

_No latches generated_

```verilog
    if(a == b)
        x = 1'b1;
```

_If a the condition is false the previous value will be retained._

### case

- Similar to software programming
- Default block executes when none of the cases match
- If no default synthesizer will generate unwanted latches
- Case choices can be simple constants, expressions, comma-separated list of same type constants or expressions, or ranges.

_NOTE: Best practice to use defaults with `x` when not needed. The synthesizer will optimize for area._

```verilog
    case(a)
        2'b00: b = 1'b0;
        2'b01: b = 1'b1;
        2'b10: b = 1'bx;
        default: b = 1'bx;
    endcase
```

```verilog
    case({x,y})
        2'b00: aout = a + b;
        2'b01: aout = a - b;
        2'b10: aout = a + b;
        default: aout = 2'bxx;

    endcase
```

- `casex`: `x`, `z` and `?` are treated as don't cares. They match with any value.

```verilog
    casex({x,y})
        2'b1x: aout = a + b;
        2'b0z: aout = a - b;
        2'b1?: aout = a + b;
        default: aout = 2'bxx;

    endcase
```

- `casez`: `z` and `?` are treated as don't cares. They match with any value.

```verilog

    casez({x,y})
        2'b1x: aout = a + b; // exact match not dont care match
        2'b0z: aout = a - b;
        2'b1?: aout = a + b;
        default: aout = 2'bxx;

    endcase
```

## Timing control

### Delay control

- Intra assignment delay:delay before the `=` or `<=` operator

```verilog
    a = #10 b + c;
    a <= #10 b + c;
```

- Inter assignment delay: delay after the expression

```verilog
    #10 a = b + c;
    #10 a <= b + c;
```

### wait

- delay execution until the specified condition is true.

  ```verilog
      wait(a == 1'b1)
        a = b + c;
  ```

### event control `@`

- executes when there is a change in a variable
- change may be a
  - positive edge `posedge`
  - negative edge `negedge`
  - variable change `variable_name`
  - any change `*`

_NOTE: For synthesis we should not combine level and edge changes_

_For flip-flop and register the list contains clock and optional reset_

_For synthesizing a combination logic the list must specify only level changes and must contain all the variables appearing in the RHS of statements_

## Always block

- Statements between the begin and end execute sequentially in the order they are written.
- All of the always blocks execute in parallel.
- Infer latches, flip-flops and combinational logic.
- Procedures can be named

```verilog
// sequential logic
always @(posedge clk)
    begin: addition
        a = b + c;
        d = e + f;
    end
// combinational logic
always @(a or b)
    begin: subtraction
        g = h - i;
    end
```

### Initial block

- Similar to always block but executes only once at the beginning of the simulation. Used for test benches.
- Not synthesize

```verilog
    initial
        begin
            clk = 0;
            forever
                begin
                    #5 clk = ~clk;
                end
        end
```

### Generate block

- Elaboration time selection or replication of certain statements
  - Module and gate instantiation
  - Continuous assignment
  - Always and initial statement
- generate …. endgenerate
  - generate loop
  - generate conditional
  - generate case
  - Nested generate

#### Generate loop

```verilog
generate
    for (initial_expr; final_expr; assignment) begin: label
        statements
    end
endgenerate
```

```verilog
/*
Boolean expression for conversion of gray to binary code for n-bit :
B_n = G_n
B_n-1 = B_n XOR G_n-1 = G_n XOR G_n-1 : :
B_1 = B_2 XOR G_1 = G_n XOR ………… XOR G_1
https://www.geeksforgeeks.org/code-converters-binary-to-from-gray-code/
*/

#todo: does this synthesize multiple xor gates?
module gray2bin1(gray,bin)
    parameter SIZE=8;
    input [SIZE-1:0] gray; output [SIZE-1:0] bin;
    genvar i;
    generate
        for (i=0; i< SIZE; i=i+1)begin: bit
            assign bin[i] = ^gray[SIZE-1:i];
        end
    endgenerate
endmodule
```

**`always` block in generate loop**

```verilog
module gray2bin2(gray,bin)
    parameter SIZE=8;
    input [SIZE-1:0] gray; output reg [SIZE-1:0] bin;
    genvar i;
    generate for (i=0; i< SIZE; i=i+1) begin: bit
                always @(*)
                    bin[i] = ^gray[SIZE-1:i];
            end
    endgenerate
endmodule

```

**Conditional statements in generate loop**
_Note: the condition must be a static condition,computable at elaborate time_

```verilog
module adder_nbit(x,y,cin,sum,cout);
    parameter N=4;
    input [N-1:0] x,y; input cin;
    output [N-1:0] sum; output cout;
    genvar i;
    wire [N-2:0] c;
    generate
        for (i=0;i<N; i=i+1)
        begin : adder
            if(i==0) full_adder fa (x[i],y[i],cin,sum[i],c[i]);
            else if (i==N-1) full_adder fa (x[i],y[i],c[i-1],sum[i],cout);
            else full_adder fa (x[i],y[i],c[i-1],sum[i],c[i]);
        end
    endgenerate
endmodule
```

**Generate Case**

```verilog
module adder_nbit(x,y,cin,sum,cout);
    parameter N=4;
    input [N-1:0] x,y; input cin;
    output [N-1:0] sum; output cout;
    genvar i;
    wire [N-2:0] c;
    generate
        for (i=0;i<N; i=i+1)
        begin : adder
            case (i)
                0: assign {c[i],sum[i]} = x[i]+y[i]+cin;
                N-1: assign {cout,sum[i]} = x[i]+y[i]+c[i-1];
                default: assign {c[i],sum[i]} = x[i]+y[i]+c[i-1];
            endcase
        end
    endgenerate
end module
```

## Tasks and functions

### funtions

```verilog
function [automatic] [signed] [range_or_type] function_id ([input_declarations]);
    [other_declarations]
    procedural_statement
endfunction

```

- declared within a module
- can be called from continuous assignments, always blocks or other functions
- in continuous assignment they are evaluated when any of its declared inputs changes
- in procedure they are evaluated when invoked
- functions describe combinational logic and do not generate latches
- good way to reuse procedural code since modules cant be invoked within a procedure
- automatic – local variables are allocated new for each function call

#### declaration

```verilog
    // function return type and function name
    function [7:0] adder;
        // input variables
        input [7:0] a, b;
        // local variables
        begin
            adder = a + b;// function name is the return variable
            // at least one statement must return the function return variable
        end
    endfunction

    // function call
    wire [7:0] a;
    wire [7:0] b;
    wire [7:0] c;
    assign c = adder(a, b);
```

```verilog
module mux16to1 (W, S16, f);
    input [0:15]W;
    input [3:0] S16;
    output reg f;
    // Function that specifies a 4-to-1 multiplexer
    function mux4to1;
        input [0:3] X;
        input [1:0] S4;
        case (S4)
            0: mux4to1 = X[0];
            1: mux4to1 = X[1];
            2: mux4to1 = X[2];
            3: mux4to1 = X[3];
        endcase
    endfunction
    always @(W, S16)
        case (S16[3:2])
            0: f = mux4to1 (W[0:3], S16[1:0]);
            1: f = mux4to1 (W[4:7], S16[1:0]);
            2: f = mux4to1 (W[8:11], S16[1:0]);
            3: f = mux4to1 (W[12:15], S16[1:0]);
        endcase
endmodule
```

_Note:_

- _must contain at least one input arg_
- _cant contain any inout or output declaration_
- _cant contain any time controlled statements_
- _no recursive function_
- _cant invoke task, as tasks can contain time controlled statements_
- _function must return the value to the implicit function name register_

`parameter` value can be overridden by `defparam`
**Constant Functions**

```verilog
module example_const_fn;
    parameter vector_lsb=7, vector_msb=15;
    reg [get_largest(vector_lsb,vector_msb):0] mac_address;
    // function declaration
    function integer get_largest(input integer first, second);
        get_largest = (first > second)? first : second;
    endfunction
endmodule
```

### tasks

- similar to a function
- not synthesized
- task can contain time controlled statements like `wait`, `@` and `#`
- task can have output and input ports and does not have a return value
- a task can invoke another task or function but a function cannot invoke a task
- task can have 0 input

```verilog

    task adder;
        input [7:0] a, b;
        output [7:0] c;
        begin
            c = a + b;
        end
    endtask

    wire [7:0] a;
    wire [7:0] b;
    wire [7:0] c;
    adder(a, b, c);

```

## Component inference

### latch

- inferred when there is a missing condition in a procedural block

_NOTE: to improve readability use `if()` statement over `case` to infer a latch as it is difficult to specify the enable signal using case_

```verilog
    always @(en,din)
        begin
            if(en)
                dout <= din;
        end
```

```verilog
    always @(en,din,reset)
        begin
            if(reset)
                dout <= 'b0;
            else if(en)
                dout <= din;
        end
```

_NOTE: the sensitivity list must have only level sensitive signals to infer a latch, if we have edge sensitive list we dont have any latch inference_

### Flip-flop/registers edge sensitive

- inferred when there is a positive edge sensitive signal in the sensitivity list
- if there is an asynchronous reset, the reset signal must be in the sensitivity list which is edge sensitive

_NOTE: when we use a negative edge reset(active low reset) use `if(!reset)`_

```verilog
    always @(posedge clk)
        begin
            dout <= din;
        end
```

```verilog
    always @(posedge clk or negedge reset)
        begin
            if(!reset)
                dout <= 'b0;
            else
                dout <= din;
        end
```

- 8 bit counter

```verilog
    reg[7:0] count;
    wire enable;
    always@(posedge clk or posedge rst)
    begin
        if(rst)
            count <= 8'b0;
        else if(enable)
            count <= count + 1;
    end
```

### multiplexer

- inferred when there is a conditional statement in the procedural block
- avoid specifying every value by using `default` or `else` statement

_NOTE: latch will be inferred if a variable is not assigned for all the branch conditions_

_To improve readability use case statements for large multiplexers. if else will infer multiple cascaded 2x1 mux_

```verilog
    always @(a or b or s)
        begin
            if(s)
                y = a;
            else
                y = b;
        end
```

```verilog
    always @(a or b or s)
        begin
            if(s)
                y = a;
            else if(!s)
                y = b;
            else
                y = 'bx;
        end
```

### adder and subtractor

- inferred when there is an arithmetic operation in the procedural block
- if the operands are of different size, the smaller operand is extended to the size of the larger operand

```verilog
    always @(a or b)
        begin
            c = a + b;
        end
```

_TODO_
How does this get inferred?

```verilog
if(sel == 1)
    y = a + b;
else
    y = a - b;
```

### Tristate buffer

- inferred when there is a conditional statement in the procedural block

```verilog
    if(en)
        y = a;
    else
        y = 1'bz;
```

## FSM

1. Use a single procedural block to code present state, next state and output logic.

2. Use two procedural blocks (present and next state) another for output logic.

3. Use 3 procedural blocks present state, next state and output logic.

present state -> sequential logic
next state -> combinational logic
output logic -> combinational logic

### Define states

1. Define states using parameters

```verilog
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2;
    parameter S3 = 3;

    case(state)
        S0: next_state = S1;
        S1: next_state = S2;
        S2: next_state = S3;
        S3: next_state = S0;
```

2. Using macros

```verilog
    `define S0 2'b00
    `define S1 2'b01
    `define S2 2'b10
    `define S3 2'b11

    case(state)
        `S0: next_state = `S1;
        `S1: next_state = `S2;
        `S2: next_state = `S3;
        `S3: next_state = `S0;
```

## Array and Memories

- An array declaration in verilog can be either scalar or vector.
- An array can be declared as a wire, reg or integer.

### Array declaration

```verilog
    reg X[0:7]; // X is a scalar reg array of depth 8; each 1 bit wide
    reg [7:0] X1 [0:3]; // X1 is a vector reg array of depth 4; each 8 bit wide
    reg [7:0] X2 [0:1][0:3]; // X2 is a 2D vector reg array of depth 2*4; each 8 bit wide

    X = 1'b0; // Illegal assignment as all elements of X must be assigned
    X[1] = 1'b0; // Assign 0 to the 2nd element of X
    X1[2] = 8'bAA; // Assign AA to the 3rd element of X1
    X2[1][3] = 8'bAA; // Assign AA to the 4th element of X2

    reg [1:8] hdlc_ram[0:63], intr_ack;
    intr_ack = hdlc_ram[60];
    hdlc_ram[60][2];// - value at index 2 of 60th element
    hdlc_ram[15][2:4];// – value from index [2:4] of 15th element
    hdlc_ram[0:2];// – not allowed

    reg [7:0] sense_data [15:0][15:0];
    integer three_d [255:0][255:0][255:0];
    wire xbar [3:0][3:0];
    sense_data[2][3];// - ok
    sense_data[1][1][0];// - ok
    three_d[5][5][2];// - ok
    three_d[5][1:5][2];// – not allowed
    xbar[0][2:0];// – not allowed
```

_NOTE:_

- Two dimensional arrays can be accessed only by word.
- To get a bit one must send the output to a register or wire and select the bits from this new variable.
- To change one bit, one must read the whole word, change the bit and write the whole word back.

## Compiler directives

- Time Scale
- Macro Definitions
- Include Directives

### Time scale

- Specifies time unit and time precision
- Valid units are `s`, `ms`, `us`, `ns`, `ps`, `fs`
- Only 1, 10, 100, 1000 are valid precision values
- Also determines the time unit in display command

```verilog
    `timescale 1ns/1ps
    `timescale 1ns/100ps
```

### Include Directives

- Used to include files in the current file

```verilog
    `include "file_name.v" // contents of the file_name.v are put here
```

## System Tasks and Functions

- Used to generate input and output to the simulation
- Name begins with `$`

### Display

- display the selected variables
- `$display`, `$strobe` and `$monitor`
- `$display` and `$strobe` are similar except `$strobe` is used to display at the end of the simulation
- `$monitor` is used to display the variables whenever there is a change in the value of the variable
- format specifiers are similar to `printf` in C `%d`, `%b`, `%h`, `%t`, `%c`, `%s`, `%m`, `%0d`, `%0b`, `%0h`, `%0t`, `%0c`, `%0s`, `%0m`

```verilog
    $display("a = %b", a);
    $strobe("a = %b", a);
    $monitor("a = %b", a);
```

### Time

- `$time` 64-bit quantity
- `$stime` 32-bit unsigned integer, if the simulation time is greater than 32-bit it return the lower 32-bit value
- `$realtime` real time

### Stop,Reset and Finish

- `$stop` stops the simulation and puts the simulation in interactive mode where the user can interact with commands
- `$reset` resets the simulation to time 0
- `$finish` stops the simulation and exits the simulator

#### Arguments

- Default argument is 1
- 0 -> no messages
- 1 -> simulation time and location
- 2 -> simulation time, location and CPU time used in simulation

### Deposit

- `$deposit` used to change the value of a variable (forced value)
- `$deposit("variable_name", value);`

### Random

- `$random` generates a random number
- `$random(seed)` generates a random number with the given seed

### Dump

- `$dumpfile` used to dump the simulation data to a file
- `$dumpvars` used to dump the variables to a file
- `$dumpall` used to dump all the variables to a file

## Test bench

- All the input variables are registers
- All the output variables are wires
- Initial block is used to initialize the input variables
- Always block is used to generate the clock
- Always block is used to display the output variables
