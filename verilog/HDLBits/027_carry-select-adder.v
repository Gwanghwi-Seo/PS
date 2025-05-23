module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] first_adder_sum, sel1_adder_sum, sel2_adder_sum;
    wire first_adder_cout, sel1_adder_cout, sel2_adder_cout;

    add16 first_adder(
        .a(a[15:0]), .b(b[15:0]), .cin(0), .sum(first_adder_sum), .cout(first_adder_cout)
    );

    add16 sel1_adder(
        .a(a[31:16]), .b(b[31:16]), .cin(0), .sum(sel1_adder_sum), .cout(sel1_adder_cout)
    );

    add16 sel2_adder(
        .a(a[31:16]), .b(b[31:16]), .cin(1), .sum(sel2_adder_sum), .cout(sel2_adder_cout)
    );

    assign sum = first_adder_cout ? {sel2_adder_sum, first_adder_sum} : {sel1_adder_sum, first_adder_sum};

endmodule