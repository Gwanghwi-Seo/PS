module top_module (
    input clk,
    input d,
    output q
);

    reg pos_reg;
    reg neg_reg;

    always @(posedge clk)
        pos_reg <= d;

    always @(negedge clk)
        neg_reg <= d;

    assign q = clk ? pos_reg : neg_reg;

endmodule

