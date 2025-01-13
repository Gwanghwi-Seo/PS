module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    localparam LEFT     = 4'b0001,
               RIGHT    = 4'b0010,
               FALL_L   = 4'b0100,
               FALL_R   = 4'b1000;

    reg [3:0] state, next_state;

    // state transition
    always @* begin
        case (state)
            LEFT: begin
                if (ground) begin
                    next_state = bump_left ? RIGHT : LEFT;
                end
                else begin
                    next_state = FALL_L;
                end
            end
            RIGHT: begin
                if (ground) begin
                    next_state = bump_right ? LEFT : RIGHT;
                end
                else begin
                    next_state = FALL_R;
                end
            end 
            FALL_L: begin
                next_state = ground ? LEFT : FALL_L;
            end
            FALL_R: begin
                next_state = ground ? RIGHT : FALL_R;
            end
            default: begin
                next_state = state;
            end
        endcase
    end

    assign walk_left = (state == LEFT) ? 1'b1 : 1'b0;
    assign walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
    assign aaah = ((state == FALL_L) | (state == FALL_R)) ? 1'b1 : 1'b0;

    // state update
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end
endmodule