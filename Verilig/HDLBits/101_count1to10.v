module top_module (
    input clk,
    input reset,
    output reg [3:0] q);

    wire en_decade;

    assign en_decade = q == 4'd10;

    always @(posedge clk) begin
        if (reset)
            q <= 4'd1;
        else if (en_decade)
            q <= 4'd1;
        else
            q <= q + 4'd1;
    end

endmodule
