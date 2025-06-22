module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] counter;
    // reg start_decr;
    
    // 1st try code: failed
    // Reason: when counter is running, start_decr flag is always 1
    // When load is high, the previous start_decr flag affects count <= data;
    // due to a condition of second if statement is "ture" (prev start_decr)
    // always @(posedge clk) begin
    //     if (load) begin
    //         counter <= data;
    //         start_decr <= 1'd1;
    //     end
    //     
    //     if (start_decr) begin
    //         if (counter > 0)
    //             counter <= counter - 10'd1;
    //         else begin
    //             start_decr <= 1'b0;
    //         end
    //     end
    // end

    // 2nd try code: success, but not good code.
    // always @(posedge clk) begin
    //     if (load) begin
    //         counter <= data;
    //         start_decr <= 1'd1;
    //     end
    //     else
    //         if (start_decr) begin
    //             if (counter > 0)
    //                 counter <= counter - 10'd1;
    //             else begin
    //                 start_decr <= 1'b0;
    //             end
    //     end
    // end
    
    // 3rd try code:
    always @(posedge clk) begin
        if (load)
            counter <= data;
        else if (counter != 10'd0)
            counter <= counter - 10'd1;
        else
            counter <= counter;
    end
    
    assign tc = (counter == 10'd0);

endmodule
