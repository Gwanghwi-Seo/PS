module top_module( 
    input [254:0] in,
    output [7:0] out );

reg [7:0] count;

always @* begin
    count = 'b0;
    for (integer i = 0; i < 255; i++) begin
        if (in[i] == 1'b1)
            count = count + 8'd1;  
    end
end

assign out = count;

endmodule
