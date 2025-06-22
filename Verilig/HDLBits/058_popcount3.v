module top_module( 
    input [2:0] in,
    output [1:0] out );

    wire [2:0] en_comp;

    always @* begin
        out = 2'b0;
        for (integer i = 0; i < 3; i = i+1) begin
            en_comp = (in[i] == 1'b1) ? 1'b1: 1'b0;
            if (en_comp)
                out = out + 2'b1;
            else
                out = out;
        end
    end

endmodule