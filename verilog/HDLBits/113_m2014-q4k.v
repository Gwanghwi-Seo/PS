module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    reg [3:0] dff;

    always @(posedge clk) begin
        if (!resetn) begin
            dff <= 4'd0;
        end
        else begin
            dff <= {dff[2], dff[1], dff[0], in};
        end
    end

    assign out = dff[3];

endmodule
