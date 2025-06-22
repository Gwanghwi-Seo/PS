module top_module (
    input clk,
    input reset,
    output reg [9:0] q);

    wire en_wrap_around;

    assign en_wrap_around = (q == 'd1000 - 'd1) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if (reset) begin
            q <= 'd0;
        end
        else begin
            if (en_wrap_around)
                q <= 'd0;
            else
                q <= q + 10'd1;
        end
    end

endmodule