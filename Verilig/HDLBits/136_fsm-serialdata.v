module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output reg done
); //

    // Use FSM from Fsm_serial
localparam IDLE  = 4'b0001,
           DATA  = 4'b0010,
           STOP  = 4'b0100,
           ERROR = 4'b1000;

reg [3:0] state, next_state;

reg [3:0] tx_count, next_tx_count;

// State logic
always @* begin
    next_state = state;
    case (state)
        IDLE: begin
            next_state = in ? IDLE : DATA;
        end
        DATA: begin
            next_state = (tx_count == 7) ? STOP : DATA;
        end
        STOP: begin
            next_state = in ? IDLE : ERROR;
        end
        ERROR: begin
            next_state = in ? IDLE : ERROR;
        end
        default: ;
    endcase
end

// State update
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// State transition condition
// assign done = ((state == STOP) & (in)) ? 1'b1: 1'b0;

reg [7:0] next_out_byte;
reg next_done;

// Count, output byte Logic
always @* begin
    next_tx_count = tx_count;
    next_out_byte = out_byte;
    next_done = done;
    case (state)
        IDLE: begin
            next_tx_count = 4'd0;
            next_done = 1'd0;
        end
        DATA: begin
            next_tx_count = tx_count + 4'd1;
            next_out_byte = {in, out_byte[7:1]};
        end
        STOP: begin
            next_done = ((state == STOP) & in) ? 1'b1 : 1'b0;
        end
        ERROR: begin
            ;
        end
        default: begin
            ;
        end
    endcase
end

// Count Update
always @(posedge clk) begin
    if (reset) begin
        tx_count <= 'd0;
        out_byte <= 'd0;
        done <= 'd0;
    end else begin
        tx_count <= next_tx_count;
        out_byte <= next_out_byte;
        done <= next_done;
    end
end

endmodule