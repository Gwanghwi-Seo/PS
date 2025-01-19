module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg [23:0] out_bytes,
    output done); //

    localparam B1 = 4'b0001,
               B2 = 4'b0010,
               B3 = 4'b0100,
             DONE = 4'b1000;

    reg [3:0] state, next_state;

    // FSM from fsm_ps2
    always @* begin
        case (state)
            B1: begin
                next_state = in[3] ? B2 : B1;
            end
            B2: begin
                next_state = B3;
            end
            B3: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = in[3] ? B2: B1;
            end
            default: begin
                next_state = B1;
            end
        endcase
    end

    // State update
    always @(posedge clk, posedge reset) begin
        state = reset ? B1 : next_state;
    end


    assign done = (state == DONE) ? 1'b1 : 1'b0;

    // New: Datapath to store incoming bytes.
    // Output logic
    always @(posedge clk) begin
        out_bytes <= {out_bytes[15:0], in[7:0]};
    end

endmodule
