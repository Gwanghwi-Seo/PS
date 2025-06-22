module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    localparam A = 4'b0001,
               B = 4'b0010,
               C = 4'b0100,
               D = 4'b1000;

    reg [3:0] state, next_state;

    // State transition logic
    always @* begin
        case (state)
            A: begin
                next_state = in ? B : A;
            end
            B: begin
                next_state = in ? B : C;
            end
            C: begin
                next_state = in ? D : A;
            end
            D: begin
                next_state = in ? B : C;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic

    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule