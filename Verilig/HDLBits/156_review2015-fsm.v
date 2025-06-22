module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    // State definition
    localparam ST_IDLE      = 3'd0,
               ST_D1        = 3'd1,
               ST_D11       = 3'd2,
               ST_D110      = 3'd3,
               ST_SHIFT_EN  = 3'd4,
               ST_COUNT     = 3'd5,
               ST_DONE      = 3'd6;

    reg [2:0] state, next_state;

    reg [2:0] cnt_shift_ena;

    always @* begin
        next_state = state;

        case(state)
            ST_IDLE:        next_state = data ? ST_D1 : ST_IDLE;
            ST_D1:          next_state = data ? ST_D11 : ST_IDLE;
            ST_D11:         next_state = data ? ST_D11 : ST_D110;
            ST_D110:        next_state = data ? ST_SHIFT_EN : ST_IDLE;
            ST_SHIFT_EN:    next_state = (cnt_shift_ena == 3) ? ST_COUNT : ST_SHIFT_EN;
            ST_COUNT:       next_state = done_counting ? ST_DONE : ST_COUNT;
            ST_DONE:        next_state = ack ? ST_IDLE: ST_DONE;
            default:;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= ST_IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    // cnt sequential logic
    always @(posedge clk) begin
        if (reset) begin
            cnt_shift_ena <= 3'd0;
        end
        else begin
            if (state == ST_IDLE)
                cnt_shift_ena <= 3'd0;

            if ((state == ST_SHIFT_EN) && (cnt_shift_ena < 4))
                cnt_shift_ena <= cnt_shift_ena + 3'd1;
        end
    end

    // output logic
    assign shift_ena = (state == ST_SHIFT_EN);
    assign counting = (state == ST_COUNT);
    assign done = (state == ST_DONE);


endmodule