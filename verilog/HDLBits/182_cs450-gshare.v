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

    localparam SNT = 2'h0, // strong not taken
               WNT = 2'h1, // weat not taken  <- init
               WT  = 2'h2, // weak taken
               ST  = 2'h3; // strong taken

    reg [1:0] pht, next_pht;

    always @* begin
        next_pht = pht;

        case (pht)
            SNT: next_pht = train_valid ? (train_taken ? WNT : SNT) : pht;
            WNT: next_pht = train_valid ? (train_taken ? WT  : SNT) : pht;
            WT : next_pht = train_valid ? (train_taken ? ST  : WNT) : pht;
            ST : next_pht = train_valid ? (train_taken ? ST  : WT) : pht;
            default:;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset)
            pht <= WNT;
        else
            pht <= next_pht;
    end

    // output logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 7'h0;
        end
        else begin
            if (train_mispredicted) begin
                // predict_history <= 
            end
            else begin
                predict_history <= {predict_}
            end
  
        end
    end

    assign predict_taken = (pht == WT) | (pht == ST);

endmodule