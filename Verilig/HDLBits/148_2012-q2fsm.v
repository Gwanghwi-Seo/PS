module top_module (
    input clk,
    input reset,
    input w,
    output z);

    reg [5:0] state, next_state;

    localparam A = 6'b000001, // Y0
               B = 6'b000010, // Y1
               C = 6'b000100, // Y2
               D = 6'b001000, // Y3
               E = 6'b010000, // Y4
               F = 6'b100000; // Y5

    always @* begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    assign z = (state == E) | (state == F);

endmodule