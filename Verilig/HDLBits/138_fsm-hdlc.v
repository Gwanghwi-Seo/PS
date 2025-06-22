module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    // Defien States
    reg [3:0] state, next_state;

    localparam ZERO     = 4'h0,
               ONE      = 4'h1,
               TWO      = 4'h2,
               THREE    = 4'h3,
               FOUR     = 4'h4,
               FIVE     = 4'h5,
               SIX      = 4'h6,
               DISCARD  = 4'h7,
               FLAG     = 4'h8,
               ERROR    = 4'h9;

    // State transition logic
    always @* begin
        case (state)
            ZERO:    next_state = in ? ONE   : ZERO;
            ONE:     next_state = in ? TWO   : ZERO;
            TWO:     next_state = in ? THREE : ZERO;
            THREE:   next_state = in ? FOUR  : ZERO;
            FOUR:    next_state = in ? FIVE  : ZERO;
            FIVE:    next_state = in ? SIX   : DISCARD;
            SIX:     next_state = in ? ERROR : FLAG;
            DISCARD: next_state = in ? ONE   : ZERO;
            FLAG:    next_state = in ? ONE   : ZERO;
            ERROR:   next_state = in ? ERROR : ZERO;
            default: next_state = ZERO;
        endcase
    end

    // State update
    always @(posedge clk) begin
        if (reset) begin
            state <= ZERO;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err  = (state == ERROR);

endmodule