module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out  ); // Problem: 1-bit

    // assign out = (sel & a) | (~sel & b); Problem: bit-wise operation with sel
    assign out = sel ? a : b;

endmodule
