module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] lower_sum_out, upper_sum_out;
    wire lower_cout, upper_cout;
    
    add16 lower_adder(.a(a[15:0]), .b(b[15:0]), .cin(0), .sum(lower_sum_out), .cout(lower_cout));
    add16 upper_adder(.a(a[31:16]), .b(b[31:16]), .cin(lower_cout), .sum(upper_sum_out), .cout(upper_cout));
    
    assign sum = {upper_sum_out, lower_sum_out};

endmodule

