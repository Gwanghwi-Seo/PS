module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    wire en_decade;

    assign en_decade = q == 4'd9;

    always @(posedge clk) begin
        if (reset)
            q <= 'b0;
        else
            if (slowena) begin
                q <= q + 4'd1;
                if (en_decade)
                    q <= 'b0;
            end
    end

endmodule
