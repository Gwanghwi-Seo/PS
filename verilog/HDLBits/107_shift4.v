module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    always @(posedge clk, negedge areset) begin
        if (!areset) begin
            q <= 'b0;
        end
        else begin
            if (load) begin
                q <= data;
            end
            else begin
                if (ena) begin
                    q[3] <= 'b0;
                    q[2] <= q[3];
                    q[1] <= q[2];
                    q[0] <= q[1];
                end
            end
        end
    end

endmodule