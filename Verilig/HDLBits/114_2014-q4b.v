module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF muxdff3 (.clk(KEY[0]), .w(KEY[3]),  .E(KEY[1]), .R(SW[3]), .L(KEY[2]), .Q(LEDR[3]));
    MUXDFF muxdff2 (.clk(KEY[0]), .w(LEDR[3]), .E(KEY[1]), .R(SW[2]), .L(KEY[2]), .Q(LEDR[2]));
    MUXDFF muxdff1 (.clk(KEY[0]), .w(LEDR[2]), .E(KEY[1]), .R(SW[1]), .L(KEY[2]), .Q(LEDR[1]));
    MUXDFF muxdff0 (.clk(KEY[0]), .w(LEDR[1]), .E(KEY[1]), .R(SW[0]), .L(KEY[2]), .Q(LEDR[0]));

endmodule

module MUXDFF (
    input clk,
    input w,
    input E,
    input R,
    input L,
    output reg Q
);

    wire MUX_E_OUT, MUX_L_OUT;

    assign MUX_E_OUT = E ? w : Q;
    assign MUX_L_OUT = L ? R : MUX_E_OUT;

    always @(posedge clk) begin
        Q <= MUX_L_OUT;
    end

endmodule
