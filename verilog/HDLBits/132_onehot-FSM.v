module top_module(
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2);

    always @(*) begin
        next_state = 0;
        if (state[0]) begin
            if (in) next_state[1] = 1;
            else next_state[0] = 1;
        end
        if (state[1]) begin
            if (in) next_state[2] = 1;
            else next_state[0] = 1;
        end
        if (state[2]) begin
            if (in) next_state[3] = 1;
            else next_state[0] = 1;
        end
        if (state[3]) begin
            if (in) next_state[4] = 1;
            else next_state[0] = 1;
        end
        if (state[4]) begin
            if (in) next_state[5] = 1;
            else next_state[0] = 1;
        end
        if (state[5]) begin
            if (in) next_state[6] = 1;
            else next_state[8] = 1;
        end
        if (state[6]) begin
            if (in) next_state[7] = 1;
            else next_state[9] = 1;
        end
        if (state[7]) begin
            if (in) next_state[7] = 1;
            else next_state[0] = 1;
        end
        if (state[8]) begin
            if (in) next_state[1] = 1;
            else next_state[0] = 1;
        end
        if (state[9]) begin
            if (in) next_state[1] = 1;
            else next_state[0] = 1;
        end
    end

    assign out2 = (state[7] | state[9]) ? 1'b1 : 1'b0;
    assign out1 = (state[8] | state[9]) ? 1'b1 : 1'b0;

    //정답이 약간 잘못된 듯 함. case로 state transition이 맞을 듯

endmodule
