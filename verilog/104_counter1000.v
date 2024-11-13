module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

    // BCD Counter outputs
    wire [3:0] q0, q1, q2;

    bcdcount counter0 (clk, reset, c_enable[0], q0);
    bcdcount counter1 (clk, reset, c_enable[1], q1);
    bcdcount counter2 (clk, reset, c_enable[2], q2);

    // Enable signals for each counter
    assign c_enable[0] = 1'd1;
    assign c_enable[1] = (q0 == 4'd9);
    assign c_enable[2] = (q1 == 4'd9) && c_enable[1];
    
    // Generate the OneHertz signal
    assign OneHertz = (q2 == 4'd9) && c_enable[2];

endmodule
