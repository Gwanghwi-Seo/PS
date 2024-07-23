module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [3:0] bcd_cout;

    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin: loop_bcd
            if (i == 0)
                bcd_fadd bcd_fadd(.a(a[i*4+:4]), .b(b[i*4+:4]), .cin(cin), .cout(bcd_cout[i]), .sum(sum[i*4+:4]));
            else if (i == 3)
                bcd_fadd bcd_fadd(.a(a[i*4+:4]), .b(b[i*4+:4]), .cin(bcd_cout[i-1]), .cout(cout), .sum(sum[i*4+:4]));
            else
                bcd_fadd bcd_fadd(.a(a[i*4+:4]), .b(b[i*4+:4]), .cin(bcd_cout[i-1]), .cout(bcd_cout[i]), .sum(sum[i*4+:4]));
        end
    endgenerate

endmodule
