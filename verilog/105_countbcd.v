module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    wire carry_out;

    bcd_counter one         (.clk(clk), .reset(reset), .ena(1'b1),   .q(q[3:0]),    .carry_out(ena[1]));
    bcd_counter ten         (.clk(clk), .reset(reset), .ena(ena[1]), .q(q[7:4]),    .carry_out(ena[2]));
    bcd_counter hundred     (.clk(clk), .reset(reset), .ena(ena[2]), .q(q[11:8]),   .carry_out(ena[3]));
    bcd_counter thousand    (.clk(clk), .reset(reset), .ena(ena[3]), .q(q[15:12]),  .carry_out(carry_out));

endmodule

module bcd_counter (
    input clk,
    input reset,        // Synchronous active-high reset
    input ena,
    output reg [3:0] q,
    output carry_out);
    
    assign carry_out = (ena && (q == 4'd9));

    always @(posedge clk) begin
       if (reset) begin
            q <= 4'b0;
       end
       else if (ena) begin
            if (carry_out) begin
                q <= 4'b0;
            end else begin
                q <= q + 4'b1;
            end
       end
     end

endmodule