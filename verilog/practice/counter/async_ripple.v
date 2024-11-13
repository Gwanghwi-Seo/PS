module async_counter (
    input clk,
    input rst_n,
    input en,
    output [3:0] reg q
);

    wire j1, j2, j3;

    jkff jk00 (.clk(clk), .j(en), 

endmodule
