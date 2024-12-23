module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    
    reg [31:0] prev_in;
    
    always @(posedge clk) begin
        if (reset) begin
            prev_in <= 'b0;
            out <= 'b0;
        end else
            out <= out | (prev_in & ~in);
        
        prev_in <= in;
    end
    
endmodule
