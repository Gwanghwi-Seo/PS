module counter #(
    parameter COUNTER_WIDTH=4
) (
    input clk,
    input rst_n,
    input act,
    input up_dwn_n,
    output reg [COUNTER_WIDTH] count,
    output ovflw,
);

localparam IDLE = 4'b0001;
localparam CNTUP = 4'b0010;
localparam CNTDN = 4'b0100;
localparam OVFLW = 4'b1000;

reg [3:0] state, next_state;

// Combinational block
always @* begin
    case (state)
        IDLE: begin
            if (act)
                if (up_dwn_n)
                    next_state = CNTUP;
                else
                    next_state = CNTDN;
            else
                next_state = IDLE;
        end

        CNTUP: begin
            if (act)
                if (up_dwn_n)
                    if (count == (1 << COUNTER_WIDTH)-1)
                        next_state = OVFLW;
                    else
                        next_state = CNTUP;
                else
                    if (count == 4'b0000)
                        next_state = OVFLW;
                    else
                        next_state = CNTDN;
            else
                next_state = IDLE;
        end

        CNTDN: begin
            if (act)
                if (up_dwn_n)
                    if (count == (1 << COUNTER_WIDTH)-1)
                        next_state = OVFLW;
                    else
                        next_state = CNTUP;
                else
                    if (count == 'b0)
                        next_state = OVFLW;
                    else
                        next_state = CNTDN;
            else
                next_state = IDLE;
        end
        
        OVFLW: begin
            next_state = OVFLW;
        end

        default: begin
            next_state = 'bx;
            $display("%t: State machine not initialized\n", $time);
        end
    endcase
end

// Sequential block (state transition)
always @(posedge clk or negedge rst_n)
    if (!rst_n)
        state <= IDLE;
    else
        state <= next_state;

// Sequential block (counter register)
always @(posedge clk or negedge rst_n)
    if (!rst_n)
        count <= 'b0;
    else
        if (state == CNTUP)
            count <= count + 1'b1;
        else if (state == CNTDN)
            count <= count - 1'b1;
        else
            count <= 'b0;

assign ovflw = (state == OVFLW) ? 1'b1: 1'b0;
    
endmodule