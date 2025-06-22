module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    // State Definition
    reg state, next_state;

    localparam LOCK = 1'b0,
               FLIP = 1'b1;

    // State transition logic
    always @* begin
        case (state)
            LOCK: next_state = x ? FLIP : LOCK;
            FLIP: next_state = FLIP;
            default: next_state = LOCK;
        endcase
    end

    // State update
    always @(posedge clk, negedge areset) begin
        if (!areset) begin
            state <= LOCK;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign z = (state == FLIP) ? (~x) : (x);


endmodule