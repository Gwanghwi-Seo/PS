module top_module(
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2);

   // localparam S0 = 10'b0000000001,
   //            S1 = 10'b0000000010,
   //            S2 = 10'b0000000100,
   //            S3 = 10'b0000001000,
   //            S4 = 10'b0000010000,
   //            S5 = 10'b0000100000,
   //            S6 = 10'b0001000000,
   //            S7 = 10'b0010000000,
   //            S8 = 10'b0100000000,
   //            S9 = 10'b1000000000;

    // State transition logic
    always @* begin
        if ((state[0] & in))
            next_state[0] = 1'b1;
        else
            next_state[0] = 1'b0;

        if ((state[1]) & in)
            next_state[1] = 1'b1;
        else
            next_state[1] = 1'b0;

        if ((state[2]) & in)
            next_state[2] = 1'b1;
        else
            next_state[2] = 1'b0;

        if ((state[3]) & in)
            next_state[3] = 1'b1;
        else
            next_state[3] = 1'b0;

        if ((state[4]) & in)
            next_state[4] = 1'b1;
        else
            next_state[4] = 1'b0;

        if ((state[5]) & in)
            next_state[5] = 1'b1;
        else
            next_state[5] = 1'b0;

        if ((state[6]) & in)
            next_state[6] = 1'b1;
        else
            next_state[6] = 1'b0;

        if ((state[7]) & in)
            next_state[7] = 1'b1;
        else
            next_state[7] = 1'b0;

        if ((state[8]) & in)
            next_state[8] = 1'b1;
        else
            next_state[8] = 1'b0;

        if ((state[9]) & in)
            next_state[9] = 1'b1;
        else
            next_state[9] = 1'b0;
    end

    // output logic
    assign out1 = ((state[8]) | (state[9])) ? 1'b1 : 1'b0;
    assign out2 = ((state[7]) | (state[9])) ? 1'b1 : 1'b0;

endmodule