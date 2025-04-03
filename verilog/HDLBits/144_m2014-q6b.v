module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    reg [5:0] next_state;

    localparam A = 6'b000001, // Y0
               B = 6'b000010, // Y1
               C = 6'b000100, // Y2
               D = 6'b001000, // Y3
               E = 6'b010000, // Y4
               F = 6'b100000; // Y5

    always @* begin
        case (y)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end

    assign Y2 = (next_state[2]);

    assign Y4 = (next_state[4]);

endmodule