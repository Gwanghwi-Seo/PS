module top_module(
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2);

    localparam S0 = 10'b0000000001,
               S1 = 10'b0000000010,
               S2 = 10'b0000000100,
               S3 = 10'b0000001000,
               S4 = 10'b0000010000,
               S5 = 10'b0000100000,
               S6 = 10'b0001000000,
               S7 = 10'b0010000000,
               S8 = 10'b0100000000,
               S9 = 10'b1000000000;

    // State transition logic
    always @* begin
        next_state = state;
        case (state)
            S0: begin
                next_state = in ? S1 : S0;
            end
            S1: begin
                next_state = in ? S2 : S0;
            end
            S2: begin
                next_state = in ? S3 : S0;
            end
            S3: begin
                next_state = in ? S4 : S0;
            end
            S4: begin
                next_state = in ? S5 : S0;
            end
            S5: begin
                next_state = in ? S6 : S8;
            end
            S6: begin
                next_state = in ? S7 : S9;
            end
            S7: begin
                next_state = in ? S7 : S0;
            end
            S8: begin
                next_state = in ? S1 : S0;
            end
            S9: begin
                next_state = in ? S1 : S0;
            end
            default: begin
                next_state = state;
            end
        endcase
    end

    // output logic
    assign out1 = ((state == S8) | (state == S9)) ? 1'b1 : 1'b0;
    assign out2 = ((state == S7) | (state == S9)) ? 1'b1 : 1'b0;

endmodule