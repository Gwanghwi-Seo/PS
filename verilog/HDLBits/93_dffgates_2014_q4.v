module top_module (
    input clk,
    input x,
    output z
); 
    reg dff1_q, dff2_q, dff3_q;
    
    always @(posedge clk) begin
        dff1_q <= x ^ dff1_q;
    	dff2_q <= x & ~dff2_q;
    	dff3_q <= x | ~dff3_q;
    end
    
    assign z = ~(dff1_q | dff2_q | dff3_q);

endmodule

