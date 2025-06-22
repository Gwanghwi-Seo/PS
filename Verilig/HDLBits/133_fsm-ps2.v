module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    localparam B1 = 4'b0001,
               B2 = 4'b0010,
               B3 = 4'b0100,
             DONE = 4'b1000;

    reg [3:0] state, next_state;

    // State transition logic (combinational)
    always @* begin
        next_state = state;
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
                next_state = in[3] ? B2 : B1;
            end
            default: begin
                next_state = state;
            end
        endcase
    end

    // State flip-flops (sequential)
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            state <= B1;
        end else begin
            state <= next_state;
        end
    end
 
    // Output logic
    assign done = (state == DONE) ? 1'b1 : 1'b0;

endmodule
