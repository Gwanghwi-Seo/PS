module sm #(
    parameter COUNTER_WIDTH = 4
) (
    input clk,
    input rst_n,
    input act,
    input up_dwn_n,
    output reg [COUNTER_WIDTH-1:0] count,
    output reg ovflw
);

    localparam IDLE     = 4'b0001,
               CNTUP    = 4'b0010,
               CNTDN    = 4'b0100,
               OVFLW    = 4'b1000;

    reg [3:0] state, next_state;

    always @* begin
        case (state)
            IDLE: begin
                next_state = act ? (up_dwn_n ? CNTUP : CNTDN) : IDLE;
            end
            CNTUP: begin
                if (act) begin
                    if(up_dwn_n) begin
                        if (count == (1 << COUNTER_WIDTH) - 1)
                            next_state = OVFLW;
                        else
                            next_state = CNTUP;
                    end else begin
                        if (count == 4'b0000)
                            next_state = OVFLW;
                        else
                            next_state = CNTDN;
                    end
                end else begin
                    next_state = IDLE;
                end
            end
            CNTDN: begin
                if (act) begin
                    if (up_dwn_n) begin
                        if (count == (1 << COUNTER_WIDTH) - 1)
                            next_state = OVFLW;
                        else
                            next_state = CNTUP;
                    end else begin
                        if (count == 'b0)
                            next_state = OVFLW;
                        else
                            next_state = CNTDN;
                    end
                end else begin
                    next_state = IDLE;
                end
            end
            OVFLW: begin
                next_state = OVFLW;
            end
            default: begin
                next_state = state;
            end
        endcase
    end
    
endmodule