module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [99:0] bcd_cout;

    genvar i;
    generate
        for (i = 0; i < 100; i=i+1) begin : loop_bcd
            if (i == 0)
                bcd_fadd bcd_adder(.a(a[0+:4]), .b(b[0+:4]), .cin(cin), .cout(bcd_cout[i]), .sum(sum[0+:4]));
            else
                bcd_fadd bcd_adder(.a(a[i*4+:4]), .b(b[i*4+:4]), .cin(bcd_cout[i-1]), .cout(bcd_cout[i]), .sum(sum[i*4+:4]));
        end
    endgenerate

    assign cout = bcd_cout[99];

endmodule
