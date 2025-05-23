module top_module();
    
    reg clk;
    reg in;
    reg [2:0] s;
    wire out;
    
	always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        in = 0;
        s = 3'd2;
        @(negedge clk);
        s = 3'd6;
        @(negedge clk);
        in = 1;
        s = 3'd2;
        @(negedge clk);
        in = 0;
        s = 3'd7;
        @(negedge clk);
        in = 1;
        s = 3'd0;
        repeat(3) @(negedge clk);
        in = 0;
    end
    
    q7 U_DUT (.clk(clk), .in(in), .s(s), .out(out));

endmodule

