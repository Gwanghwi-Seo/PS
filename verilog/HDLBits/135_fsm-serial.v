module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

localparam IDLE  = 5'b00001,
           START = 5'b00010,
           DATA  = 5'b00100,
           STOP  = 5'b01000,
           ERROR = 5'b10000;

reg [4:0] state, next_state;

reg [3:0] trans_count;

// State logic
always @* begin
    next_state = state;
    case (state)
        IDLE: begin
            next_state = in ? IDLE : START;
        end
        START: begin
            next_state = DATA;
        end
        DATA: begin
            next_state = (trans_count == 7) ? (in ? STOP: ERROR) : DATA;
        end
        STOP: begin
            next_state = in ? IDLE : START;
        end
        ERROR: begin
            next_state = in ? IDLE : ERROR;
        end
        default: ;
    endcase
end

// State update
always @(posedge clk) begin
    state <= (reset) ? IDLE : next_state;
end

// State transition condition
assign done = (state == STOP) ? 1'b1: 1'b0;

reg [3:0] next_trans_count;

// Count Logic
always @* begin
    next_trans_count = trans_count;
    case (state)
        IDLE: ;

        // START: next_trans_count = trans_count + 4'd1;
        START: next_trans_count = 'd0;

        DATA: next_trans_count = trans_count + 4'd1;

        STOP: ;

        ERROR: ;
        default: ;
    endcase
end

// Count Update
always @(posedge clk) begin
    if (reset) begin
        trans_count <= 'd0;
    end else begin
        trans_count <= next_trans_count;
    end
end

endmodule