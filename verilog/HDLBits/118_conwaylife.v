module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q); 

    genvar i, j;

    generate
        for (i=0; i<16; i=i+1) begin: cell_row
            for (j=0; j<16; j=j+1) begin: cell_col
                conway_cell cell_grid(
                    .clk(clk),
                    .i_data(data[i*16+j]),
                    .i_load(load),
                    .i_neighbor({
                        data[(((i-1)+16) % 16) * 16 + (((j-1)+16) % 16)],   // left upper
                        data[(((i-1)+16) % 16) * 16 + j],                   // upper
                        data[(((i-1)+16) % 16) * 16 + ((j+1) % 16)],          // right upper
                        data[i*16 + (((j-1)+16) % 16)],                       // left
                        data[i*16 + ((j+1) % 16)],                            // right
                        data[((i+1) % 16) * 16 + ((j-1)+16) % 16],          // left down
                        data[((i+1) % 16) * 16 + j],                        // down
                        data[((i+1) % 16) * 16 + ((j+1) % 16)]              // right down
                    }),
                    .o_q(q[i*16+j])
                );
            end
        end
    endgenerate

endmodule

module conway_cell(
    input clk,
    input i_data,
    input i_load,
    input [7:0] i_neighbor,
    output reg o_q
);

    reg [3:0] sum;

    always @* begin
        sum = i_neighbor[0] + i_neighbor[1] + i_neighbor[2] + 
              i_neighbor[3] + i_neighbor[4] + i_neighbor[5] + 
              i_neighbor[6] + i_neighbor[7];
    end

    always @(posedge clk) begin
        if (i_load) begin
            o_q <= i_data;
        end else begin
            case (sum)
                4'd2: o_q <= o_q;    // 상태 유지
                4'd3: o_q <= 1'b1;   // 활성화
                default: o_q <= 1'b0; // 비활성화
            endcase
        end
    end

endmodule
