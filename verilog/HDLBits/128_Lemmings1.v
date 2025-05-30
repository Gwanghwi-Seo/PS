module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    localparam LEFT=1'b0,
               RIGHT=1'b1;

    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        case (state)
            LEFT: begin
                if (bump_left | (bump_right & bump_left))
                    next_state = ~state;
            end
            RIGHT: begin
                if (bump_right | (bump_right & bump_left))
                    next_state = ~state;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule