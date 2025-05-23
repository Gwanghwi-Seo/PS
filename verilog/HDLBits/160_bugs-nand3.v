module top_module (input a, input b, input c, output out);//

    wire out_and;

    andgate inst1 (out_and, a, b, c, 1, 1);

    not inst2 (out, out_and);

endmodule