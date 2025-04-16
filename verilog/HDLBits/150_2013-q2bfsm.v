module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    // State define
    localparam A = 4'h0,
               B = 4'h1,
               C = 4'h2,
               D = 4'h3,
               E = 4'h4,
               F = 4'h5,
               G = 4'h6,
               H = 4'h7,
               I = 4'h8,
               J = 4'h9,
               K = 4'h10;

    reg [3:0] state, next_state;

    // State logic
    always @* begin
        case (state)
            A: next_state = B;
            B: next_state = x ? C : D;
            C: next_state = x ? E : C;
            D: next_state = x ? D : G;
            E: next_state = x ? D : G;
            F: next_state = x ? E : F;
            G: next_state = x ? H : F;
            H: next_state = y ? J : I;
            I: next_state = y ? J : I;
            J: next_state = J;
            K: next_state = 
            default:;
        endcase
    end

    // State transition
    always @(posedge clk) begin
        if (!resetn) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign f = ((state == B) | (state == G));
    assign g = ((state == J)) ;

endmodule