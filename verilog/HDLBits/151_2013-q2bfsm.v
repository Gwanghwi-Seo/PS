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
               I = 4'h8;

    reg [3:0] state, next_state;

    // State logic
    always @* begin
        case (state)
            A: next_state = B;
            B: next_state = C;
            C: next_state = x ? D : C;
            D: next_state = x ? D : E;
            E: next_state = x ? F : C;
            F: next_state = y ? H : G;
            G: next_state = y ? H : I;
            H: next_state = H;
            I: next_state = I;
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
    assign f = ((state == B));
    assign g = ((state == F) | (state == H) |(state == G)) ;

endmodule