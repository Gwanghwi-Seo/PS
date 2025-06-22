module top_module(
    input clk,
    input reset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            OFF: begin
                next_state = j ? ON : OFF;
            end
            ON: begin
                next_state = k ? OFF : ON;
            end
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with asynchronous reset
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == OFF) ? 1'b0 : 1'b1;

endmodule