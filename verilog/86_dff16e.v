module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    
    always @(posedge clk)begin
        if (!resetn)
            q <= 'd0;
        else begin
            case (byteena)
                2'b00: q <= q;
                2'b01: q[7:0] <= d[7:0];
                2'b10: q[15:8] <= d[15:8];
                default: q <= d;
            endcase
        end
    end

endmodule
