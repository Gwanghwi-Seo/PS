module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

// State define
localparam A   = 1'b0,
           B   = 1'b1;

reg state, next_state;

reg [1:0] w_cnt, clk_cnt;

// State transition logic
always @* begin
    case (state)
        A   : next_state = s ? B : A;
        B   : next_state = B;
        default: next_state = A;
    endcase
end

// State update
always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
wire wrap_over = (clk_cnt == 2'd3) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    if (reset) begin
        w_cnt <= 2'd0;
        clk_cnt <= 2'd0;
    end else begin
        case (state)
            B: begin
                if (wrap_over) begin
                    w_cnt <= w ? 2'd1 : 2'd0;
                    clk_cnt <= 2'd1;
                end else begin
                    w_cnt <= w ? w_cnt + 2'd1 : w_cnt;
                    clk_cnt <= clk_cnt + 2'd1;
                end
            end
            default: begin
                ;
            end
        endcase
    end
end

assign z = ((state == B) & wrap_over & (w_cnt == 2'd2)) ? 1'b1 : 1'b0;

endmodule