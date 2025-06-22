module tb_jkff;

    reg clk;

    reg J, K;

    wire Q, Qbar;

    jkff jk0 (.clk(clk), .j(J), .k(K), .q(Q), .qbar(Qbar));

    always #1 clk = ~clk;

    initial begin
    clk = 1'b0;
    J = 1'b0;
    K = 1'b0;

    #1;  J = 1'b0; K = 1'b0;
    #1;  J = 1'b0; K = 1'b1;
    #1;  J = 1'b1; K = 1'b0;
    #1;  J = 1'b1; K = 1'b1;

    end

endmodule
