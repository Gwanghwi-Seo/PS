// priority encoder

module top_module (
    input [3:0] in,
    output reg [1:0] pos  );

    always @ (*) begin
        case (in)
            4'b0001: begin
                pos = 2'd0;
            end

            4'b0011: begin
                pos = 2'd0;
            end

            4'b0101: begin
                pos = 2'd0;
            end

            4'b0111: begin
                pos = 2'd0;
            end

            4'b1001: begin
                pos = 2'd0;
            end

            4'b1011: begin
                pos = 2'd0;
            end

            4'b1101: begin
                pos = 2'd0;
            end

            4'b1111: begin
                pos = 2'd0;
            end

            4'b0010: begin
                pos = 2'd1;
            end

            4'b0110: begin
                pos = 2'd1;
            end

            4'b1010: begin
                pos = 2'd1;
            end

            4'b1110: begin
                pos = 2'd1;
            end

            4'b0100: begin
                pos = 2'd2;
            end

            4'b1100: begin
                pos = 2'd2;
            end

            4'b1000: begin
                pos = 2'd3;
            end
        endcase
    end

endmodule
