module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

wire [15:0] lower_adder_sum, upper_adder_sum;
wire [31:0] ones_b;

wire lower_adder_cout, upper_adder_cout;

assign ones_b = b ^ {32{sub}};

add16 lower_adder (.a(a[15:0]), .b(ones_b[15:0]), .cin(sub), .sum(lower_adder_sum), .cout(lower_adder_cout));
add16 upper_adder (.a(a[31:16]), .b(ones_b[31:16]), .cin(lower_adder_cout), .sum(upper_adder_sum), .cout(upper_adder_cout));

assign sum = {upper_adder_sum, lower_adder_sum};

endmodule