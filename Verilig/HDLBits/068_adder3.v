module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum);

    fa fa0(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));
    fa fa1(.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
    fa fa2(.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));

    // Array instantiation
    // fa full_adder[2:0](a, b, {cout[1:0], cin}, cout, sum)

endmodule

module fa (
    input a,
    input b,
    input cin,
    output cout,
    output sum );

assign cout = a&cin | b&cin | a&b;
assign sum = a^b^cin;

endmodule
