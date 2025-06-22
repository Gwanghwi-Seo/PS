module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );

    // out_both: On if a current bit, and left neighbor is 1'b1;
    // out_any: On if a current bit, and right neighbor is 1'b1;
    // out_different: On if a left bit is different with left bit,
    //              and consider wrapping arounded neighbour

    assign out_both = {in[3]&in[2], in[2]&in[1], in[1]&in[0]};
    assign out_any = {in[3]|in[2], in[2]|in[1], in[1]|in[0]};
    assign out_different = {in[3]^in[0], in[3]^in[2], in[2]^in[1], in[1]^in[0]};
endmodule
