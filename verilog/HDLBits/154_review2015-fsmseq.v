module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    localparam A = 3'h0,
               B = 3'h1,
               C = 3'h2,
               D = 3'h3,
               E = 3'h4;

    reg [2:0] state, next_state;

    always @* begin
        next_state = state;

        case (state)
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = data ? C : D;
            D: next_state = data ? E : A;
            E: next_state = E;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    assign start_shifting = (state == E) ? 1'b1 : 1'b0;

endmodule