module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output reg done
); //

    // Use FSM from Fsm_serial
localparam IDLE     = 3'h0,
           START    = 3'h1,
           DATA     = 3'h2,
           PARITY   = 3'h3,
           STOP     = 3'h4,
           ERROR    = 3'h5;

reg [2:0] state, next_state;

reg [3:0] tx_count, next_tx_count;

// State logic
always @* begin
    case (state)
        IDLE: begin
            next_state = in ? IDLE : START;
        end
        START: begin
            next_state = DATA;
        end
        DATA: begin
            next_state = (tx_count == 8) ? PARITY : DATA;
        end
        PARITY: begin
            next_state = in ? STOP : ERROR;
        end
        STOP: begin
            next_state = in ? IDLE : START;
        end
        ERROR: begin
            next_state = in ? IDLE : ERROR;
        end
        default: next_state = IDLE;
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

reg [7:0] next_out_byte;
reg next_done;

// Count, output byte Logic
always @* begin
    next_tx_count = tx_count;
    next_out_byte = out_byte;
    next_done = 'b0;
    case (next_state)
        IDLE: begin
            ;
        end
        START: begin
            next_tx_count = 4'd0;
            next_out_byte = 8'd0;
            next_done = 1'b0;
        end
        DATA: begin
            next_tx_count = tx_count + 4'd1;
            next_out_byte = {in, out_byte[7:1]};
        end
        PARITY: begin
            ;
        end
        STOP: begin
            next_done = odd;
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

// parity
wire odd;
wire reset_parity;

assign reset_parity = reset | (next_state == START);
parity parity (.clk(clk), .reset(reset_parity), .in(in), .odd(odd));

endmodule