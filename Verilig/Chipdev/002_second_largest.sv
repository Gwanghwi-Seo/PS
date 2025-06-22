module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output wire [DATA_WIDTH-1:0] dout
);

logic [DATA_WIDTH-1:0] prev_din;
logic [DATA_WIDTH-1:0] second_largest;

always @(posedge clk) begin
    if (!resetn) begin
        prev_din <= 'h0;
        second_largest <= 'h0;
    end
    else begin
        prev_din <= din;

        if ((prev_din < second_largest) && (second_largest < din)) begin
            second_largest <= prev_din;
        end
    end
end
assign dout = second_largest;

// prev_din < second_largest < din

endmodule