module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

logic [DATA_WIDTH-1:0] prev_din;
logic [DATA_WIDTH-1:0] second_largest;
logic [DATA_WIDTH-1:0] largest;

always @(posedge clk) begin
    if (!resetn) begin
        prev_din <= 'h0;
        second_largest <= 'h0;
        largest <= 'h0;
    end
    else begin
        // if ((din > second_largest) && (din > largest)) begin
        //     largest <= din;
        //     second_largest <= largest;
        // end
        // else if (din < second_largest) begin
        //     second_largest <= din;
        // end

        // Found largest first
        if (din > largest) begin
            largest <= din;
            second_largest <= largest;
        end
        else if (second_largest < din && din < largest) begin
            second_largest <= din;
        end
    end
end
assign dout = second_largest;

endmodule