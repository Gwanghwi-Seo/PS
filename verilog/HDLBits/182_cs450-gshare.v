module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    localparam SNT = 2'h0,
    		   WNT = 2'h1,
    		   WT  = 2'h2,
      		   ST  = 2'h3;

    reg [1:0] pht [0:127];

    wire [6:0] predict_index;
    wire [6:0] train_index;

    integer i;

    // pht
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            for (i=0; i<128; i=i+1) begin
                pht[i] <= WNT;
            end
        end
        else begin
            if (train_valid) begin
                pht[train_index] <= train_taken ? ((pht[train_index] == ST) ? ST : pht[train_index] + 1'b1) :
                ((pht[train_index] == SNT) ? SNT : pht[train_index] - 1'b1);
            end
        end
    end

    // history table
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 7'h0;
        end
        else begin
        	if (train_valid && train_mispredicted) begin
            	predict_history <= {train_history[5:0], train_taken};
        	end
        	else begin
            	if (predict_valid) begin
            		predict_history <= {predict_history[5:0], predict_taken};
                end
            end
        end
    end

    assign predict_index = predict_pc ^ predict_history;
    assign train_index = train_pc ^ train_history;

    assign predict_taken = pht[predict_index][1];
endmodule
