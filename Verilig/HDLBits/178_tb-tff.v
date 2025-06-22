module top_module ();
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 1;
        reset = 1;
        t = 0;
  
        @(posedge clk);
        reset = 0;
        t = 1;
        
    end
    
    tff U_DUT(.clk(clk), .reset(reset), .t(t), .q(q));

endmodule

