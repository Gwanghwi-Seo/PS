`timescale 1ps / 1ps

module top_module ( );
    reg clk;
    
    always #5 clk = ~clk;
    
    dut dut(.clk(clk));
    
    initial begin
        clk = 0;
    end
    
endmodule

