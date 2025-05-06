module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    // // Solution 1
    // reg [2:0] cnt_shift_ena;

    // always @* begin
    //     if (cnt_shift_ena < 4)
    //         shift_ena = 1'b1;
    //     else
    //         shift_ena = 1'b0;
    // end

    // always @(posedge clk) begin
    //     if (reset) begin
    //         cnt_shift_ena <= 'd0;
    //     end
    //     else begin
    //         if (cnt_shift_ena < 4) begin
    //             cnt_shift_ena = cnt_shift_ena + 3'd1;
    //         end
    //     end
    // end

    // Solution 2
    localparam IDLE = 3'h0,
               S0   = 3'h1,
               S1   = 3'h2,
               S2   = 3'h3,
               S3   = 3'h4;

    reg [2:0] state, next_state;

    always @* begin
        next_state = state;
        case (state)
            IDLE:   next_state = reset ? S0 : IDLE;
            S0:     next_state = reset ? S0 : S1;
            S1:     next_state = reset ? S0 : S2;
            S2:     next_state = reset ? S0 : S3;
            S3:     next_state = reset ? S0 : IDLE;
        endcase
    end

    always @(posedge clk) begin
        state <= next_state;
    end

    assign shift_ena = ~(state == IDLE);

endmodule