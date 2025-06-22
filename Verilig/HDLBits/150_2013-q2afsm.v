module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    // Define states
    localparam A = 4'b0001,
               B = 4'b0010,
               C = 4'b0100,
               D = 4'b1000;

    reg [3:0] state, next_state;

    // State logic
   // always @* begin
   //     next_state = state;
   //     case (state)
   //         A: begin
   //             if (~((r[1] | r[2] | r[3]))) begin
   //                 next_state = A;
   //             end
   //             else if (r[1]) begin
   //                 next_state = B;
   //             end
   //             else if (~r[1] & r[2]) begin
   //                 next_state = C;
   //             end
   //             else if (~r[1] & ~r[2] & r[3]) begin
   //                 next_state = D;
   //             end
   //         end
   //         B: begin
   //             if (r[1]) begin
   //                 next_state = B;
   //             end
   //             else if (~r[1]) begin
   //                 next_state = A;
   //             end
   //         end
   //         C: begin
   //             if (r[2]) begin
   //                 next_state = C;
   //             end
   //             else if (~r[2]) begin
   //                 next_state = A;
   //             end
   //         end
   //         D: begin
   //             if (r[3]) begin
   //                 next_state = D;
   //             end
   //             else if (~r[3]) begin
   //                 next_state = A;
   //             end
   //         end
   //     endcase
   // end

    // Ver 2
    always @* begin
        case (state)
            A: next_state = r[1] ? B :
                            r[2] ? C :
                            r[3] ? D : A;
            B: next_state = r[1] ? B : A;
            C: next_state = r[2] ? C : A;
            D: next_state = r[3] ? D : A;
            default: ;
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
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);

endmodule