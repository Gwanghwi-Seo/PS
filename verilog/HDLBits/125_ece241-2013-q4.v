module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 

    localparam LV0 = 4'b0001, 
               LV1 = 4'b0010,
               LV2 = 4'b0100,
               LV3 = 4'b1000;

    reg next_fr3, next_fr2, next_fr1, next_dfr;
    reg [3:0] state, next_state;

    // state transition
    always @* begin
        next_fr3 = fr3;
        next_fr2 = fr2;
        next_fr1 = fr1;
        next_dfr = dfr;
        case (state)
            LV0: begin
                next_fr3 = 1'b1;
                next_fr2 = 1'b1;
                next_fr1 = 1'b1;
                next_dfr = 1'b0;
                if (s[1]) begin
                    next_state = LV1;
                end
                else if (s[1] & s[2]) begin
                    next_state = LV2;
                end
                else if (s[1] & s[2] & s[3]) begin
                    next_state = LV3;
                end
                else begin
                    next_state = LV0;
                end
            end
            LV1: begin
                if (!(s[1] | s[2] | s[3])) begin
                    next_state = LV0;
                    next_fr3 = 1'b1;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b1;
                end
                else if (s[1] & s[2]) begin
                    next_state = LV2;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b0;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b0;
                end
                else if (s[1] & s[2] & s[3]) begin
                    next_state = LV3;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b0;
                    next_fr1 = 1'b0;
                    next_dfr = 1'b0;
                end
                else begin
                    next_state = LV1;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b0;
                end
            end
            LV2: begin
                if (!(s[1] | s[2] | s[3])) begin
                    next_state = LV0;
                    next_fr3 = 1'b1;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b1;
                end
                else if ((!s[2]) & s[1]) begin
                    next_state = LV1;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b1;
                end
                else if (s[1] & s[2] & s[3]) begin
                    next_state = LV3;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b0;
                    next_fr1 = 1'b0;
                    next_dfr = 1'b0;
                end
            end
            LV3: begin
                if (!(s[1] | s[2] | s[3])) begin
                    next_state = LV0;
                    next_fr3 = 1'b1;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b1;
                end
                else if (s[1] & ~s[2] & ~s[3]) begin
                    next_state = LV1;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b1;
                end
                else if (s[1] & s[2] & ~s[3]) begin
                    next_state = LV2;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b0;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b1;
                end
                else begin
                    next_state = LV3;
                    next_fr3 = 1'b0;
                    next_fr2 = 1'b0;
                    next_fr1 = 1'b0;
                    next_dfr = 1'b0;
                end
            end
            default: begin
                    next_state = LV0;
                    next_fr3 = 1'b1;
                    next_fr2 = 1'b1;
                    next_fr1 = 1'b1;
                    next_dfr = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= LV0;
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
        end
        else begin
            state <= next_state;
            fr3 <= next_fr3;
            fr2 <= next_fr2;
            fr1 <= next_fr1;
            dfr <= next_dfr;
        end
    end

endmodule