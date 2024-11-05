module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 'b0;
        else if (q == 4'd9)
            q <= 'b0;
        else
            q <= q + 4'd1;
    end

endmodule
