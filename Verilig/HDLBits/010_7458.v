module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    wire and_p2_ab, and_p2_cd, or_p2_all;
    wire and_p1_abc, and_p1_def, or_p1_all;
    
    assign and_p2_ab = p2a & p2b;
    assign and_p2_cd = p2c & p2d;
    
    assign p2y = and_p2_ab | and_p2_cd;
    
    assign and_p1_abc = p1a & p1b & p1c;
    assign and_p1_def = p1d & p1e & p1f;
    
    assign p1y = and_p1_abc | and_p1_def;

endmodule

