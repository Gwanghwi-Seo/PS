module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q); 

    genvar i, j;

    wire [255:0] next_q;

    generate
        for (i=0; i<16; i=i+1) begin: cell_row
            for (j=0; j<16; j=j+1) begin: cell_col
                conway_cell cell_grid(
                    .i_current(q[i*16+j]),
                    .i_neighbor({
                        q[(((i-1)+16) % 16) * 16 + (((j-1)+16) % 16)],   // left upper
                        q[(((i-1)+16) % 16) * 16 + j],                   // upper
                        q[(((i-1)+16) % 16) * 16 + ((j+1) % 16)],          // right upper
                        q[i*16 + (((j-1)+16) % 16)],                       // left
                        q[i*16 + ((j+1) % 16)],                            // right
                        q[((i+1) % 16) * 16 + ((j-1)+16) % 16],          // left down
                        q[((i+1) % 16) * 16 + j],                        // down
                        q[((i+1) % 16) * 16 + ((j+1) % 16)]              // right down
                    }),
                    .o_next_q(next_q[i*16+j])
                );
            end
        end
    endgenerate

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule

module conway_cell(
    input i_current,
    input [7:0] i_neighbor,
    output reg o_next_q 
);

    wire [2:0] sum;
    
    assign sum = {2'b00, i_neighbor[0]} +
                 {2'b00, i_neighbor[1]} +
                 {2'b00, i_neighbor[2]} +
                 {2'b00, i_neighbor[3]} +
                 {2'b00, i_neighbor[4]} +
                 {2'b00, i_neighbor[5]} +
                 {2'b00, i_neighbor[6]} +
                 {2'b00, i_neighbor[7]};

    always @* begin
        case (sum)
            3'd2: o_next_q = i_current;
            3'd3: o_next_q = 1'd1;
            default o_next_q = 1'd0;
        endcase
    end
endmodule
