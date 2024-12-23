module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    reg buf_Q;
    
    wire mux_E, mux_L;
    
    assign mux_E = E ? w : buf_Q;
    assign mux_L = L ? R : mux_E;
    
    always @(posedge clk) begin
        buf_Q <= mux_L; 
    end
    
    assign Q = buf_Q;
	
endmodule
