module counter_fix #(
    parameter COUNTER_WIDTH=4
)(
    input clk,
    input rst_n,
    input act,
    input up_dwn_n,
    output reg [COUNTER_WIDTH] count,
    output ovflw
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
                        next_state = CNTDN;
                else
                    if (count == 4'b0000)
                        next_state = OVFLW;
                    else
                        next_state = CNTUP; 
            else
                next_state = IDLE;
        end

        OVFLW: begin
            next_state = OVFLW;
        end

        default: begin
            next_state = 'bx;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= IDLE;
    else
        state <= next_state;  
end

always @* begin
    count = next_count;
    if (state == CNTUP)
        count = count + 1;
    else if (state == CNTDN)
        count = count - 1;
end

assign en_count = (state == CNTUP) || (state == CNTDN) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    if (!rst_n)
        next_count <= 0;
    else if (en_count)
        next_count <= count;
end

    
endmodule