`timescale 1ns / 1ps


module tb_counter;

parameter COUNTER_WIDTH = 5;

reg clk;
reg rst_n;
reg act;
reg up_dwn_n;
wire [COUTER_WIDTH-1:0] count;
wire ovflw;

counter #(COUNTER_WIDTH) DUT (
    .clk(clk), .rst_n(rst_n), .act(act),
    .up_dwn_n(up_dwn_n), .count(count), .ovflw(ovflw));

endmodule

