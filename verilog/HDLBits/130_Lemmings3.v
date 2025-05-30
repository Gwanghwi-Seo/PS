module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    localparam LEFT     = 3'b000,
               RIGHT    = 3'b001,
               FALL_L   = 3'b010,
               FALL_R   = 3'b011,
               DIG_L    = 3'b100,
               DIG_R    = 3'b101;

    reg [2:0] state, next_state;

    // State transition
    always @* begin
        case (state)
            LEFT: begin
                if (ground) begin
                    next_state = dig        ? DIG_L :
                                 bump_left  ? RIGHT: LEFT;
                end else begin
                    next_state = FALL_L;
                end
            end
            RIGHT: begin
                if (ground) begin
                    next_state = dig        ? DIG_R :
                                 bump_right ? LEFT : RIGHT;
                end else begin
                    next_state = FALL_R;
                end
            end
            FALL_L: begin
                next_state = ground ? LEFT : FALL_L;
            end
            FALL_R: begin
                next_state = ground ? RIGHT: FALL_R;
            end
            DIG_L: begin
                next_state = ground ? DIG_L : FALL_L;
            end
            DIG_R: begin
                next_state = ground ? DIG_R : FALL_R;
            end
            default: begin
                next_state = state;
            end
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT) ? 1'b1 : 1'b0;
    assign walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
    assign aaah = ((state == FALL_L) | (state == FALL_R)) ? 1'b1 : 1'b0;
    assign digging = ((state == DIG_L) | (state == DIG_R)) ? 1'b1 : 1'b0;

    // State update
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

endmodule