module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    reg [1:0] state_r, next_state_r;
    
    localparam SNT = 2'h0,
    		   WNT = 2'h1,
    		   WT  = 2'h2,
      		   ST  = 2'h3;
    
    always @* begin
        next_state_r = state_r;
        
        case (state_r)
            SNT: next_state_r = train_valid ? ((train_taken ? WNT : SNT)) : state_r;
            WNT: next_state_r = train_valid ? ((train_taken ? WT  : SNT)) : state_r;
            WT : next_state_r = train_valid ? ((train_taken ? ST  : WNT)) : state_r;
            ST: next_state_r = train_valid ? ((train_taken ? ST  : WT))  : state_r;
            default:;
        endcase        
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state_r <= WNT;
        end
        else begin
            state_r <= next_state_r;
        end
    end
    
    assign state = state_r;
    
endmodule
