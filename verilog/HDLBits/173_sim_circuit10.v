module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state  );

    always @(posedge clk) begin
        q <= ~a | b;
        state <= a | b;
    end

endmodule