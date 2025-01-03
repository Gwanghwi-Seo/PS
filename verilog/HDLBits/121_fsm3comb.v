module top_module (
    input in,               // 1-bit input
    input [1:0] state,      // 2-bit current state
    output reg [1:0] next_state, // 2-bit next state
    output reg out          // 1-bit output
);
    parameter A=0, B=1, C=2, D=3;

    // State transition logic (next_state = f(state, in))
    always @(*) begin
        case(state)
            A : next_state = (in) ? 2'b01 : 2'b00; // State A -> B if in=1, stay at A if in=0
            B : next_state = (in) ? 2'b01 : 2'b10; // State B -> B if in=1, to C if in=0
            C : next_state = (in) ? 2'b11 : 2'b00; // State C -> D if in=1, to A if in=0
            D : next_state = (in) ? 2'b01 : 2'b10; // State D -> B if in=1, to C if in=0
            default: next_state = 2'b00; // Default case to avoid latch
        endcase
    end

    // Output logic (out = f(state) for a Moore state machine)
    always @(*) begin
        case(state)
            2'b00: out = 0;  // State A
            2'b01: out = 0;  // State B
            2'b10: out = 0;  // State C
            2'b11: out = 1;  // State D
        endcase
    end

endmodule
