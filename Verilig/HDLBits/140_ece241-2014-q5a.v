module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

    // State Definition
    reg [1:0] state, next_state;

    localparam S0 = 2'h0,
               S1 = 2'h1,
               S2 = 2'h2;

    // State transition logic
    always @* begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S2 : S1;
            S2: next_state = x ? S2 : S1;
            default: next_state = S0;
        endcase
    end

    // State update
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @* begin
        case (state)
            S1: z = 1'b1;
            S2: z = 1'b0;
            default: z = 1'b0;
        endcase
    end


endmodule