module top_module( 
    input a, b, cin,
    output cout, sum );

    assign cout = a&cin | a&b | b&cin;
    assign sum = a ^ b ^ cin;

endmodule
