module top_module ( input clk, input d, output q );
    wire q0, q1, q2;
    my_dff shift1(.clk(clk), .d(d), .q(q0));
    my_dff shift2(.clk(clk), .d(q0), .q(q1));
    my_dff shift3(.clk(clk), .d(q1), .q(q2));
    assign q = q2;

endmodule

