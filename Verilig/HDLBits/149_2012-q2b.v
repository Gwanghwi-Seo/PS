module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] next_state;

assign next_state[0] = (y[0] | y[3]) & ~w;
assign next_state[1] = (y[0]) & w;
assign next_state[2] = (y[1] | y[5]) & w;
assign next_state[3] = (y[1] | y[2] | y[4] | y[5]) & ~w;
assign next_state[4] = (y[2] | y[4]) & w;
assign next_state[5] = (y[3]) & w;

assign Y1 = next_state[1];
assign Y3 = next_state[3];

endmodule