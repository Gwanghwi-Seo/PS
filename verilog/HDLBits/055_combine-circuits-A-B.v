module top_module (input x, input y, output z);

wire z1, z2, z3, z4;

circuit_A IA1 (.x(x), .y(y), .z(z1));
circuit_B IB1 (.x(x), .y(y), .z(z2));

circuit_A IA2 (.x(x), .y(y), .z(z3));
circuit_B IB2 (.x(x), .y(y), .z(z4));

assign z = (z1 | z2) ^ (z3 & z4);

endmodule

module circuit_A (input x, input y, output z);

assign z = (x ^ y) & x;

endmodule


module circuit_B (input x, input y, output z);

assign z = ~(x ^ y);

endmodule
