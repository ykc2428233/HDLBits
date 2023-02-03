module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    reg [5:0] next;
    
    always @(*) begin
        next[0] = y[0]&~w | y[3]&~w;
        next[1] = y[0]&w;
        next[2] = y[1]&w | y[5]&w;
        next[3] = y[1]&~w | y[2]&~w | y[4]&~w | y[5]&~w;
        next[4] = y[2]&w | y[4]&w;
        next[5] = y[3]&w;
    end
    
    assign Y1 = next[1];
    assign Y3 = next[3];
endmodule

