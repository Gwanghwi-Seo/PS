module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    integer i;

    wire [3:0] neighbor [256];

    for (i=0; i<256; i=i+1) begin
        assign neighbor[i] = q[i][i] & q[i-1][i-1]
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            for (i=0; i<256; i=i+1) begin
                
            end
        end
    end

endmodule
