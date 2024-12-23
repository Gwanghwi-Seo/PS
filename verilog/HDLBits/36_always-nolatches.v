// synthesis verilog_input_version verilog_2001
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 

    localparam left_arrow = 16'he06b;
    localparam down_arrow = 16'he072;
    localparam right_arrow = 16'he074;
    localparam up_arrow = 16'he075;

    always @ (*) begin
        case (scancode)
            left_arrow: begin
                left = 1'b1;
                down = 1'b0;
                right = 1'b0;
                up = 1'b0;
            end
            down_arrow: begin
                left = 1'b0;
                down = 1'b1;
                right = 1'b0;
                up = 1'b0;
            end
            right_arrow: begin 
                left = 1'b0;
                down = 1'b0;
                right = 1'b1;
                up = 1'b0;
            end
            up_arrow: begin
                left = 1'b0;
                down = 1'b0;
                right = 1'b0;
                up = 1'b1;
            end
            default: begin
                left = 1'b0;
                down = 1'b0;
                right = 1'b0;
                up = 1'b0;
            end
        endcase
    end
endmodule
