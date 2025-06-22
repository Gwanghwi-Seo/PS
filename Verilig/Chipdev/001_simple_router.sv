module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  input  din_en,
  input  [1:0] addr,
  output logic [DATA_WIDTH-1:0] dout0,
  output logic [DATA_WIDTH-1:0] dout1,
  output logic [DATA_WIDTH-1:0] dout2,
  output logic [DATA_WIDTH-1:0] dout3
);

// Sol. 1
// always @* begin
//     dout0 = 'd0;
//     dout1 = 'd0;
//     dout2 = 'd0;
//     dout3 = 'd0;
// 
//     case (addr)
//         2'b00: dout0 = din_en ? din : dout0;
//         2'b01: dout1 = din_en ? din : dout1;
//         2'b10: dout2 = din_en ? din : dout2;
//         2'b11: dout3 = din_en ? din : dout3;
//         default:;
//     endcase
// end

// Sol. 2
assign dout0 = din_en & (addr == 2'b00) ? din : 'd0;
assign dout1 = din_en & (addr == 2'b01) ? din : 'd0;
assign dout2 = din_en & (addr == 2'b10) ? din : 'd0;
assign dout3 = din_en & (addr == 2'b11) ? din : 'd0;

endmodule