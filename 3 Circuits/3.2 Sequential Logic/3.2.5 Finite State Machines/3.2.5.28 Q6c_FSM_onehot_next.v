module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    //reg [6:1] A=6'd1, B=6'd2, C=6'd4, D=6'd8, E=6'd16, F=6'd32;
    reg [6:1] next;
    
    always @(*) begin
        next[1] = y[1]&w | y[4]&w;
        next[2] = y[1]&~w;
        next[3] = y[2]&~w | y[6]&~w;
        next[4] = y[2]&w | y[3]&w | y[5]&w | y[6]&w;
        next[5] = y[3]&~w | y[5]&~w;
        next[6] = y[4]&~w;
    end
    
    assign Y2 = next[2];
    assign Y4 = next[4];
endmodule

