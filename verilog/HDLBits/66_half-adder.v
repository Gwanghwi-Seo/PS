module top_module( 
    input a, b,
    output cout, sum );

always @* begin
    cout = a & b;
    sum = a ^ b;
end

endmodule
