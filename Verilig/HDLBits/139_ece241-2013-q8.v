module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z );

    // State definition
    localparam S0 = 2'h0,
               S1 = 2'h1,
               S2 = 2'h2;

    reg [1:0] state, next_state;

    // State transition logic
    always @* begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S2;
            S2: next_state = x ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // State update
    always @(posedge clk, negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign z = (state == S2) & (x);

endmodule