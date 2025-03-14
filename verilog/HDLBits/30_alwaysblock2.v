// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );

    // continuous assignment
    assign out_assign = a ^ b;

    // procedural blocking assignment
    always @ (*)
        out_always_comb = a ^ b;

    // procedural non-blocking assignment
    always @ (posedge clk)
        out_always_ff <= a ^ b;

endmodule