module top_module #(
    parameter BIT_DATA = 4,
    parameter SUM_DATA = 5
) (
    input [BIT_DATA-1:0] x,
    input [BIT_DATA-1:0] y, 
    output [SUM_DATA-1:0] sum
);
    wire [BIT_DATA-1:0] cout;

    fa rca[BIT_DATA-1:0](x, y, {cout[BIT_DATA-2:0], 1'b0}, cout, sum[BIT_DATA-1:0]);

    assign sum[BIT_DATA] = cout[BIT_DATA-1];

endmodule

module fa (
    input a, b, cin,
    output cout, sum
);

    assign cout = a&cin | b&cin | a&b;
    assign sum = a ^ b ^ cin;
    
endmodule