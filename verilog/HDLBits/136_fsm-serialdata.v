module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
localparam IDLE  = 6'b000001,
           START = 6'b000010,
           DATA  = 6'b000100,
           STOP  = 6'b001000,
           DONE  = 6'b010000,
           ERROR = 6'b100000;

reg [5:0] state, next_state;

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
            next_state = (trans_count == 8) ? STOP : DATA;
        end
        STOP: begin
            next_state = in ? DONE : ERROR;
        end
        DONE: begin
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
assign done = (state == DONE) ? 1'b1: 1'b0;

reg [3:0] next_trans_count;
reg [7:0] next_out_byte;

// Count, output byte Logic
always @* begin
    next_trans_count = trans_count;
    next_out_byte = out_byte;
    case (state)
        START: begin
            next_trans_count = trans_count + 4'd1;
            next_out_byte = {in, out_byte[7:1]};
        end
        DATA: begin
            next_trans_count = trans_count + 4'd1;
            next_out_byte = {in, out_byte[7:1]};
        end
        STOP: begin
            next_trans_count = 'd0; 
            next_out_byte = out_byte;
        end
        default: begin
            next_trans_count = 'd0; 
            next_out_byte = 'd0;
        end
    endcase
end

wire en_update_out_byte;
assign en_update_out_byte = (state == STOP) ? 1'b1 : 1'b0;

// Count Update
always @(posedge clk) begin
    if (reset) begin
        trans_count <= 'd0;
        out_byte <= 'd0;
    end else begin
        trans_count <= next_trans_count;

        if (en_update_out_byte)
            out_byte <= next_out_byte;
    end
end

endmodule